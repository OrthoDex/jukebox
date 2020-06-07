read -p "Enter wandb project" PROJECT

read -p "Enter wandb entity" ENTITY

echo $PROJECT

read -p "Enter wandb run name" RUN_NAME

echo $RUN_NAME

read -p "Enter path to sample audio file (comma separated if multiple)" SAMPLE_FILES

export WANDB=True

python jukebox/sample.py \
  --model=1b_lyrics \
  --name=sample_5b_prompted \
  --levels=3 --mode=primed \
  --audio_file=SAMPLE_FILES \
  --prompt_length_in_seconds=12 --port=29406 \
  --sample_length_in_seconds=20 \
  --total_sample_length_in_seconds=180 \
  --sr=44100 --n_samples=6 --hop_fraction=0.5,0.5,0.125