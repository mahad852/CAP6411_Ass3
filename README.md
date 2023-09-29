# CAP6411_Ass3
Assignment 3 of the course CAP6411 - Computer Vision Systems - at UCF

# GLIP
Run this command to clone the GLIP repo, create a conda environment, setup the env, download the datasets, and download the weights.

```
bash setup_glip.sh
```

The file glip_script.slurm is the slurm script for running GLIP models. Check the file out, as well as the github repo, for commands to run the GLIP models. Example command(s) are provided at the end slurm file. If you wanna run commands for your own evaluation, make sure you place the commands at the end of the file.

```
sbatch glip_script.slurm
```

# DETR
Run this command to clone the DETR repo, create a conda environment, setup the env, and download the dataset.

```
bash setup_detr.sh
```

Now open the following file path using the editor of your choice:
```
$HOME/my-envs/detr_fb/lib/python3.9/site-packages/pycocotools/cocoeval.py
```

And replace all instances of "np.float" with "float". Not the ideal solution, but it works.

The file detr_script.slurm is the slurm script for running DETR models. Check the file out, as well as the github repo, for commands to run the DETR models. Example command(s) are provided at the end slurm file. If you wanna run commands for your own evaluation, make sure you place the commands at the end of the file.

```
sbatch detr_script.slurm
```


# Detectron 2
Run this command to create a detectron2 directory, create a conda environment, setup the env, download the dataset, and downlaod the model checkpoints.

```
bash setup_detectron2.sh
```

The file detectron2_script.slurm is the slurm script for running detectron2 models. Check the file out, as well as the github repo, for commands to run the detectron2 models. Example command(s) are provided at the end slurm file. If you wanna run commands for your own evaluation, make sure you place the commands at the end of the file.

```
sbatch detectron2_script.slurm
```


