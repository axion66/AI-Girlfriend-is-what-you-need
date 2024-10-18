import ChatTTS
from IPython.display import Audio
import argparse
import torchaudio
import torch


parser = argparse.ArgumentParser()
parser.add_argument("-a", "--text")
parser.add_argument("-b", "--voicetype")
#TODO:depend on the ai characters
args = parser.parse_args()
text = args.text
voice_type = args.voicetype



chat = ChatTTS.Chat()
chat.load_models(compile=True)

texts = [text]

wav = chat.infer(texts)[0]

torchaudio.save("voice.wav", torch.from_numpy(wav), 24000) # want to hear AI girlfriend's voice?