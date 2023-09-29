module load anaconda/anaconda3

srun conda create --name detectron2 -c conda-forge python=3.9 --yes

source /apps/anaconda/anaconda3/etc/profile.d/conda.sh

conda activate detectron2

srun conda install -c conda-forge libstdcxx-ng --yes

srun conda install -c conda-forge gcc=8.5.0 --yes

srun conda install gxx_linux-64 --yes

conda deactivate

mkdir detectron2
cd detectron2

mkdir -p DATASET/coco
cd DATASET/coco
wget http://images.cocodataset.org/zips/val2017.zip
unzip val2017.zip
wget http://images.cocodataset.org/annotations/annotations_trainval2017.zip
unzip annotations_trainval2017.zip

cd ../..


mkdir checkpoints
cd checkpoints

mkdir r50_fpn
cd r50_fpn
wget https://dl.fbaipublicfiles.com/detectron2/COCO-Detection/faster_rcnn_R_50_FPN_3x/137849458/model_final_280758.pkl
cd ..

mkdir r50_dc5
cd r50_dc5
wget https://dl.fbaipublicfiles.com/detectron2/COCO-Detection/faster_rcnn_R_50_DC5_3x/137849425/model_final_68d202.pkl
cd ..

mkdir r101_fpn
cd r101_fpn
wget https://dl.fbaipublicfiles.com/detectron2/COCO-Detection/faster_rcnn_R_101_FPN_3x/137851257/model_final_f6e8b1.pkl
cd ..

mkdir r101_dc5
cd r101_dc5
wget https://dl.fbaipublicfiles.com/detectron2/COCO-Detection/faster_rcnn_R_101_DC5_3x/138204841/model_final_3e0943.pkl
cd ..

cd ../..
