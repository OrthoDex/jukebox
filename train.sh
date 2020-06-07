read -p "Enter wandb project" PROJECT

read -p "Enter wandb entity" ENTITY

echo $PROJECT

read -p "Enter wandb run name" RUN_NAME

echo $RUN_NAME

read -p "Enter path to train audio files" TRAIN_DIR

export WANDB=True

python jukebox/train.py --hps=small_vqvae \
  --name=small_vqvae --sample_length=256 --bs=4 \
  --audio_files_dir=$TRAIN_DIR --labels=False --train \
  --aug_shift --aug_blend --port=29406

## sync tensorboard once done
wandb sync logs -p $PROJECT -e $ENTITY