#!/bin/bash
#SBATCH --nodes=1 # Get one node
#SBATCH --cpus-per-task=2 # Two cores per task
#SBATCH --ntasks=1 # But only one task
#SBATCH --gres=gpu:1 # And two GPUs
#SBATCH --gres-flags=enforce-binding # Insist on good CPU/GPU alignment
#SBATCH --time=23:59:59 # Run for 1 day, at most
#SBATCH --job-name=GLIP  # Name the job so I can see it in squeue
#SBATCH --mail-type=BEGIN,END,FAIL # Send me email for various states
#SBATCH --mail-user ma649596@ucf.edu # Use this address

# Load modules
module load anaconda/anaconda3

source /apps/anaconda/anaconda3/etc/profile.d/conda.sh
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/apps/anaconda/anaconda3/lib
export LD_LIBRARY_PATH=$HOME/my-envs/glip_ass/lib:$LD_LIBRARY_PATH
export LD_PRELOAD=$HOME/my-envs/glip_ass/lib/libstdc++.so.6


source activate glip_ass

python --version

export PYTHONNOUSERSITE=1

echo "include-system-site-packages=false" >> $CONDA_PREFIX/pyvenv.cfg
export PYTHONPATH=${PYTHONPATH}:${HOME}/.local/lib/python3.7/site-packages

#conda install -c intel mkl_fft

python -m pip install torch==1.9.0+cu102 torchvision==0.10.0+cu102 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html

module load cuda/cuda-10.2
echo $CUDA_HOME


python -m pip install einops shapely timm yacs tensorboardX ftfy prettytable pymongo pycocotools scipy opencv-python
python -m pip install transformers 

cd GLIP

python setup.py build develop --user


# zero-shot glip-a-t
# python tools/test_grounding_net.py --config-file configs/pretrain/glip_A_Swin_T_O365.yaml --weight checkpoints/glip-a-t/glip_a_tiny_o365.pth \
#        TEST.IMS_PER_BATCH 1 \
#        MODEL.DYHEAD.SCORE_AGG "MEAN" \
#        TEST.EVAL_TASK detection \
#        MODEL.DYHEAD.FUSE_CONFIG.MLM_LOSS False \
#        OUTPUT_DIR outputs/glip-a-t/zeroshot


# zero-shot glip-b-t
#python tools/test_grounding_net.py --config-file configs/pretrain/glip_Swin_T_O365.yaml --weight checkpoints/glip-b-t/glip_tiny_model_o365.pth \
#        TEST.IMS_PER_BATCH 1 \
#        MODEL.DYHEAD.SCORE_AGG "MEAN" \
#        TEST.EVAL_TASK detection \
#        MODEL.DYHEAD.FUSE_CONFIG.MLM_LOSS False \
#        OUTPUT_DIR outputs/glip-b-t/zeroshot


# zero-shot glip-c-t
python tools/test_grounding_net.py --config-file configs/pretrain/glip_Swin_T_O365_GoldG.yaml --weight checkpoints/glip-c-t/glip_tiny_model_o365_goldg.pth \
        TEST.IMS_PER_BATCH 1 \
        MODEL.DYHEAD.SCORE_AGG "MEAN" \
        TEST.EVAL_TASK detection \
        MODEL.DYHEAD.FUSE_CONFIG.MLM_LOSS False \
        OUTPUT_DIR outputs/glip-c-t/zeroshot


cd ..
