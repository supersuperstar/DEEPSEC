#!/usr/bin/env python
# -*- coding: utf-8 -*-
# **************************************
# @Time    : 2018/10/16 19:28
# @Author  : Xiang Ling
# @Lab     : nesa.zju.edu.cn
# @File    : RLLC_Generation.py 
# **************************************

import argparse
import os
import random
import sys

import numpy as np
import torch

sys.path.append('%s/../' % os.path.dirname(os.path.realpath(__file__)))
from Attacks.AttackMethods.RLLC import RLLCAttack
from Attacks.Generation import Generation
from Attacks.AttackMethods.AttackUtils import predict


class RLLCGeneration(Generation):
    def __init__(self, dataset, attack_name, targeted, raw_model_location, clean_data_location, adv_examples_dir, device,
                 attack_batch_size, eps, alpha):
        super(RLLCGeneration, self).__init__(dataset, attack_name, targeted, raw_model_location, clean_data_location, adv_examples_dir, device)
        self.attack_batch_size = attack_batch_size

        self.epsilon = eps
        self.alpha = alpha

    def generate(self):
        attacker = RLLCAttack(model=self.raw_model, epsilon=self.epsilon, alpha=self.alpha)

        # prepare the Least Likely Class labels
        llc_labels = np.argmax(self.targets_samples, 1)
        # generating
        adv_samples = attacker.batch_perturbation(xs=self.nature_samples, ys_target=llc_labels, batch_size=self.attack_batch_size,
                                                  device=self.device)

        adv_labels = predict(model=self.raw_model, samples=adv_samples, device=self.device)
        adv_labels = torch.max(adv_labels, 1)[1]
        adv_labels = adv_labels.cpu().numpy()

        np.save('{}{}_AdvExamples.npy'.format(self.adv_examples_dir, self.attack_name), adv_samples)
        np.save('{}{}_AdvLabels.npy'.format(self.adv_examples_dir, self.attack_name), adv_labels)
        np.save('{}{}_TrueLabels.npy'.format(self.adv_examples_dir, self.attack_name), self.labels_samples)

        mis_target = 0
        for i in range(len(adv_samples)):
            if llc_labels[i] == adv_labels[i]:
                mis_target += 1
        print('\nFor the **{}** (targeted attack) on **{}**, the misclassified rate = {}/{} = {:.1f}%\n'.format(
            self.attack_name, self.dataset, mis_target, len(adv_samples), mis_target / len(adv_samples) * 100))


def main(args):
    # Device configuration
    os.environ['CUDA_VISIBLE_DEVICES'] = args.gpu_index
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    # Set the random seed manually for reproducibility.
    torch.backends.cudnn.deterministic = True
    torch.backends.cudnn.benchmark = False
    torch.manual_seed(args.seed)
    if torch.cuda.is_available():
        torch.cuda.manual_seed(args.seed)
    np.random.seed(args.seed)
    random.seed(args.seed)

    name = 'RLLC'
    targeted = True

    rllc = RLLCGeneration(dataset=args.dataset, attack_name=name, targeted=targeted, raw_model_location=args.modelDir,
                          clean_data_location=args.cleanDir, adv_examples_dir=args.adv_saver, device=device,
                          eps=args.epsilon, alpha=args.alpha, attack_batch_size=args.attack_batch_size)
    rllc.generate()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='The RLLC Attack Generation')

    # common arguments
    parser.add_argument('--dataset', type=str, default='CIFAR10', help='the dataset should be MNIST or CIFAR10')
    parser.add_argument('--modelDir', type=str, default='../RawModels/', help='the directory for the raw model')
    parser.add_argument('--cleanDir', type=str, default='../CleanDatasets/', help='the directory for the clean dataset that will be attacked')
    parser.add_argument('--adv_saver', type=str, default='../AdversarialExampleDatasets/',
                        help='the directory used to save the generated adversarial examples')
    parser.add_argument('--seed', type=int, default=100, help='the default random seed for numpy and torch')
    parser.add_argument('--gpu_index', type=str, default='0', help="gpu index to use")

    # arguments for the particular attack
    parser.add_argument('--epsilon', type=float, default=0.1, help='the epsilon value of RLLC')
    parser.add_argument('--alpha', type=float, default=0.5, help='the alpha value of RLLC')
    parser.add_argument('--attack_batch_size', type=int, default=100, help='the default batch size for adversarial example generation')

    arguments = parser.parse_args()
    main(arguments)
