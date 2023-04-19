@echo off
python FGSM_Generation.py --dataset=MNIST --epsilon=0.3
python FGSM_Generation.py --dataset=CIFAR10 --epsilon=0.1
python RFGSM_Generation.py --dataset=MNIST --epsilon=0.3 --alpha=0.5
python RFGSM_Generation.py --dataset=CIFAR10 --epsilon=0.1 --alpha=0.5
python BIM_Generation.py --dataset=MNIST --epsilon=0.3 --epsilon_iter=0.05 --num_steps=15
python BIM_Generation.py --dataset=CIFAR10  --epsilon=0.1 --epsilon_iter=0.01 --num_steps=15
python PGD_Generation.py --dataset=MNIST --epsilon=0.3 --epsilon_iter=0.05
python PGD_Generation.py --dataset=CIFAR10 --epsilon=0.1 --epsilon_iter=0.01
python UMIFGSM_Generation.py --dataset=MNIST --epsilon=0.3 --epsilon_iter=0.05
python UMIFGSM_Generation.py --dataset=CIFAR10 --epsilon=0.1 --epsilon_iter=0.01
python UAP_Generation.py --dataset=MNIST --fool_rate=0.35 --epsilon=0.3
python UAP_Generation.py --dataset=CIFAR10 --fool_rate=0.9 --epsilon=0.1
python DeepFool_Generation.py --dataset=MNIST --max_iters=50 --overshoot=0.02
python DeepFool_Generation.py --dataset=CIFAR10 --max_iters=50 --overshoot=0.02
python OM_Generation.py --dataset=MNIST --initial_const=0.02 --learning_rate=0.2 --noise_count=20 --noise_mag=0.3
python OM_Generation.py --dataset=CIFAR10 --initial_const=1 --learning_rate=0.02 --noise_count=20 --noise_mag=0.03137255
python LLC_Generation.py --dataset=MNIST --epsilon=0.3
python LLC_Generation.py --dataset=CIFAR10 --epsilon=0.1
python RLLC_Generation.py --dataset=MNIST --epsilon=0.3 --alpha=0.5
python RLLC_Generation.py --dataset=CIFAR10 --epsilon=0.1 --alpha=0.5
python ILLC_Generation.py --dataset=MNIST --epsilon=0.3 --epsilon_iter=0.05
python ILLC_Generation.py --dataset=CIFAR10 --epsilon=0.1 --epsilon_iter=0.01
python TMIFGSM_Generation.py --dataset=MNIST --epsilon=0.3 --epsilon_iter=0.05
python TMIFGSM_Generation.py --dataset=CIFAR10 --epsilon=0.1 --epsilon_iter=0.01
python JSMA_Generation.py --dataset=MNIST --theta=1.0 --gamma=0.1
python JSMA_Generation.py --dataset=CIFAR10 --theta=1.0 --gamma=0.1
python BLB_Generation.py --dataset=MNIST
python BLB_Generation.py --dataset=CIFAR10
python CW2_Generation.py --dataset=MNIST --confidence=0 --initial_const=0.001
python CW2_Generation.py --dataset=CIFAR10 --confidence=0 --initial_const=0.001
python EAD_Generation.py --dataset=MNIST --confidence=0 --beta=0.001 --EN=True
python EAD_Generation.py --dataset=CIFAR10 --confidence=0 --beta=0.001 --EN=True