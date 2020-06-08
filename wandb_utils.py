import wandb
import os

ENTITY = os.getenv('ENTITY')
PROJECT = os.getenv('PROJECT')
TRACKING_ACTIVE = os.getenv('WANDB')
RUN_NAME = os.getenv('RUN_NAME')

assert PROJECT != None, "Project needs to be specified in the PROJECT variable"

def log_audio_file(audio_file_path, sample_rate):
  try:
    wandb.log("audio-sample", wandb.Audio(
      audio_file_path
    ))
  except:
    return

def watch_model(model):
  if TRACKING_ACTIVE is None:
    pass
  wandb.watch(model)

def log_hyperparams(hps):
  if TRACKING_ACTIVE is not None:
    wandb.config.update(hps)

def setup_wandb():
  if TRACKING_ACTIVE is not None:
    wandb.init(entity=ENTITY, project=PROJECT, name=RUN_NAME)
    wandb.tensorboard.patch(save=True, tensorboardX=True, pytorch=True)
  else:
    print('Wandb inactive.')

if __name__ == "__main__":
  print(f'Tracking active: {TRACKING_ACTIVE or False}')
