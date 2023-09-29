#!/bin/bash
#SBATCH --nodes=1 # Get one node
#SBATCH --cpus-per-task=2 # Two cores per task
#SBATCH --ntasks=1 # But only one task
#SBATCH --gres=gpu:2 # And two GPUs
#SBATCH --gres-flags=enforce-binding # Insist on good CPU/GPU alignment
#SBATCH --time=23:59:59 # Run for 1 day, at most
#SBATCH --job-name=DETR # Name the job so I can see it in squeue
#SBATCH --mail-type=BEGIN,END,FAIL # Send me email for various states
#SBATCH --mail-user ma649596@ucf.edu # Use this address

# Load modules
module load anaconda/anaconda3

source /apps/anaconda/anaconda3/etc/profile.d/conda.sh

export LD_LIBRARY_PATH=$HOME/my-envs/detr_fb/lib:$LD_LIBRARY_PATH
export LD_PRELOAD=$HOME/my-envs/detr_fb/lib/libstdc++.so.6


source activate detr_fb

python --version

export PYTHONNOUSERSITE=1
echo "include-system-site-packages=false" >> $CONDA_PREFIX/pyvenv.cfg

#export PYTHONPATH="${PYTHONPATH}:${HOME}/.local/lib/python3.9/site-packages"

#conda install -c intel mkl_fft

#python -m pip install torch==1.9.0+cu102 torchvision==0.10.0+cu102 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
python -m pip install torch torchvision
python -m pip install -U 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI'

# module load cuda/cuda-10.2
echo $CUDA_HOME


python -m pip install cython
python -m pip install einops shapely timm yacs tensorboardX ftfy prettytable pymongo pycocotools scipy opencv-python
python -m pip install transformers 


which torchrun

cd detr

#r50
# torchrun main.py --batch_size 2 --no_aux_loss --eval --resume https://dl.fbaipublicfiles.com/detr/detr-r50-e632da11.pth --coco_path DATASET/coco

#dc5
#torchrun main.py --no_aux_loss --eval \
#    --batch_size 1 --dilation \
#    --resume https://dl.fbaipublicfiles.com/detr/detr-r50-dc5-f0fb7ef5.pth \
#    --coco_path DATASET/coco

#r101
#torchrun main.py --batch_size 2 --no_aux_loss --eval \
#    --backbone resnet101 \
#    --resume https://dl.fbaipublicfiles.com/detr/detr-r101-2c7b67e5.pth \
#    --coco_path DATASET/coco

#dc5 - r101
torchrun main.py --no_aux_loss --eval \
    --backbone resnet101 \
    --batch_size 1 --dilation \
    --resume https://dl.fbaipublicfiles.com/detr/detr-r101-dc5-a2e86def.pth \
    --coco_path DATASET/coco
