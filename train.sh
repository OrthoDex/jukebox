read -p "Enter wandb project: " PROJECT

read -p "Enter wandb entity: " ENTITY

echo $PROJECT

read -p "Enter wandb run name: " RUN_NAME

echo $RUN_NAME

read -p "Enter path to train audio files: " TRAIN_DIR

export WANDB=True
export PROJECT=$PROJECT
export RUN_NAME=$RUN_NAME
export ENTITY=$ENTITY

read -p "Enter audio sample length: " SAMPLE_LENGTH

read -p "Enter number of GPUs to use: " NUM_GPU

read -p "Enter NCCL port" NCCL_PORT

mpiexec -n $NUM_GPU python jukebox/train.py --hps=small_vqvae \
  --name=small_vqvae --sample_length=$SAMPLE_LENGTH --bs=4 \
  --audio_files_dir=$TRAIN_DIR --labels=False --train \
  --aug_shift --aug_blend --port=$NCCL_PORT

## sync tensorboard once done
wandb sync logs -p $PROJECT -e $ENTITY
