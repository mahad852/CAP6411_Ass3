git clone https://github.com/facebookresearch/detr.git

module load anaconda/anaconda3

srun conda create --name detr_fb -c conda-forge python=3.9 --yes

source /apps/anaconda/anaconda3/etc/profile.d/conda.sh

conda activate detr_fb

srun conda install -c conda-forge libstdcxx-ng --yes

srun conda install -c conda-forge gcc=8.5.0 --yes

srun conda install gxx_linux-64 --yes

conda deactivate

cd detr

mkdir -p DATASET/coco
cd DATASET/coco
wget http://images.cocodataset.org/zips/val2017.zip
unzip val2017.zip
wget http://images.cocodataset.org/annotations/annotations_trainval2017.zip
unzip annotations_trainval2017.zip

cd ../../..
