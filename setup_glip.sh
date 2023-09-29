git clone https://github.com/microsoft/GLIP.git

module load anaconda/anaconda3

srun conda create --name glip_ass -c conda-forge python=3.7 --yes

source /apps/anaconda/anaconda3/etc/profile.d/conda.sh

conda activate glip_ass

srun conda install -c conda-forge libstdcxx-ng --yes

srun conda install -c conda-forge gcc=8.5.0 --yes

srun conda install gxx_linux-64 --yes

conda deactivate

cd GLIP

mkdir checkpoints/


mkdir checkpoints/glip-a-t
cd checkpoints/glip-a-t
wget https://huggingface.co/GLIPModel/GLIP/resolve/main/glip_a_tiny_o365.pth
cd ..

mkdir glip-b-t
cd glip-b-t
wget https://huggingface.co/GLIPModel/GLIP/resolve/main/glip_tiny_model_o365.pth
cd ..

mkdir glip-c-t
cd glip-c-t
wget https://huggingface.co/GLIPModel/GLIP/resolve/main/glip_tiny_model_o365_goldg.pth
cd ..

mkdir glip-t
cd glip-t
wget https://huggingface.co/GLIPModel/GLIP/resolve/main/glip_tiny_model_o365_goldg_cc_sbu.pth
cd ..

mkdir glip-l
cd glip-l
wget https://huggingface.co/GLIPModel/GLIP/resolve/main/glip_large_model.pth
cd ..

cd ..

mkdir -p DATASET/coco
cd DATASET/coco
wget http://images.cocodataset.org/zips/val2017.zip
unzip val2017.zip
wget http://images.cocodataset.org/annotations/annotations_trainval2017.zip
unzip annotations_trainval2017.zip

cd ..
cd ..


mkdir -p outputs/glip-a-t/zeroshot
mkdir -p outputs/glip-b-t/zeroshot
mkdir -p outputs/glip-c-t/zeroshot
mkdir -p outputs/glip-t/zeroshot
mkdir -p outputs/glip-l/zeroshot
