python NAT_Test.py --dataset=MNIST --adv_ratio=0.3 --clip_max=0.3 --eps_mu=0 --eps_sigma=50
python NAT_Test.py --dataset=CIFAR10 --adv_ratio=0.3 --clip_max=0.1 --eps_mu=0 --eps_sigma=15
python EAT_Test.py --dataset=MNIST --train_externals=True --eps=0.3 --alpha=0.05
python EAT_Test.py --dataset=CIFAR10 --train_externals=True --eps=0.0625 --alpha=0.03125
python PAT_Test.py --dataset=MNIST --eps=0.3 --step_num=40 --step_size=0.01
python PAT_Test.py --dataset=CIFAR10 --eps=0.03137 --step_num=7 --step_size=0.007843
python DD_Test.py --dataset=MNIST --initial=False --temp=50
python DD_Test.py --dataset=CIFAR10 --initial=False --temp=50
python IGR_Test.py --dataset=MNIST --lambda_r=316
python IGR_Test.py --dataset=CIFAR10 --lambda_r=10
python EIT_Test.py --dataset=MNIST --crop_size=26 --lambda_tv=0.03 --JPEG_quality=85 --bit_depth=4
python EIT_Test.py --dataset=CIFAR10 --crop_size=30 --lambda_tv=0.03 --JPEG_quality=85 --bit_depth=4
python RT_Test.py --dataset=MNIST --resize=31
python RT_Test.py --dataset=CIFAR10 --resize=36
python PD_Test.py --dataset=MNIST --epsilon=0.3
python PD_Test.py --dataset=CIFAR10 --epsilon=0.0627
python TE_Test.py --dataset=MNIST --level=16 --steps=40 --attack_eps=0.3 --attack_step_size=0.01
python TE_Test.py --dataset=CIFAR10 --level=16 --steps=7 --attack_eps=0.031 --attack_step_size=0.01
python RC_Test.py --dataset=MNIST --search=True --radius_min=0 --radius_max=0.3 --radius_step=0.01 --num_points=1000
python RC_Test.py --dataset=CIFAR10 --gpu_index=2 --search=True --radius_min=0.0 --radius_max=0.1 --radius_step=0.01 --num_points=1000