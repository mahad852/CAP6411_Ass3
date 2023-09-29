#!/bin/bash
#SBATCH --nodes=1 # Get one node
#SBATCH --cpus-per-task=2 # Two cores per task
#SBATCH --ntasks=1 # But only one task
#SBATCH --gres=gpu:2 # And two GPUs
#SBATCH --gres-flags=enforce-binding # Insist on good CPU/GPU alignment
#SBATCH --time=23:59:59 # Run for 1 day, at most
#SBATCH --job-name=Detectron2 # Name the job so I can see it in squeue
#SBATCH --mail-type=BEGIN,END,FAIL # Send me email for various states
#SBATCH --mail-user ma649596@ucf.edu # Use this address

# Load modules
module load anaconda/anaconda3
# module load cuda/cuda-11.6

source /apps/anaconda/anaconda3/etc/profile.d/conda.sh

source activate detectron2

#conda install -c conda-forge libstdcxx-ng --yes
#conda install -c conda-forge gcc=8.5.0 --yes
#conda install gxx_linux-64 --yes

export LD_LIBRARY_PATH=$HOME/my-envs/detectron2/lib:$LD_LIBRARY_PATH
export LD_PRELOAD=$HOME/my-envs/detectron2/lib/libstdc++.so.6

export PYTHONNOUSERSITE=1

echo "include-system-site-packages=false" >> $CONDA_PREFIX/pyvenv.cfg
export PYTHONPATH="${PYTHONPATH}:${HOME}/.local/lib/python3.9/site-packages"

python -m pip install torch==2.0.1+cu118 torchvision==0.15.2+cu118 --index-url https://download.pytorch.org/whl/cu118


echo $CUDA_HOME

python -m pip install einops shapely timm yacs tensorboardX ftfy prettytable pymongo pycocotools scipy opencv-python
python -m pip install transformers 

cd detectron2

if [ ! -d "detectron2" ]; then
    python -m pip install 'git+https://github.com/facebookresearch/detectron2.git'
    # (add --user if you don't have permission)

    # Or, to install it from a local clone:
    git clone https://github.com/facebookresearch/detectron2.git
    python -m pip install -e detectron2
fi

export DETECTRON2_DATASETS=$PWD/DATASET

cd detectron2/tools

python train_net.py --resume \
  --config-file ../configs/COCO-Detection/faster_rcnn_R_50_FPN_3x.yaml \
  --eval-only MODEL.WEIGHTS ../checkpoints/r50_fpn_3/model_final_280758.pkl \
  DATALOADER.NUM_WORKERS 2

