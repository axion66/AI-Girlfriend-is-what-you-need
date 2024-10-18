from g4f.client import Client
from g4f.Provider import Bing
from g4f.cookies import set_cookies
import argparse
import json


parser = argparse.ArgumentParser()
parser.add_argument("-a", "--chat_history")
parser.add_argument("-b", "--date")
args = parser.parse_args()
chat_history = json.loads(args.chat_history)
date = args.date


conversation = [{"role": "user" if (chat['user'] == "true" or chat['user'] == True) else 'assistant', "content": chat['conversation'] if chat['conversation'] != chat_history[0]['conversation'] else f"{chat['conversation']} 현재 시간은 {date}네"} for chat in chat_history]


client = Client()
response = client.chat.completions.create(
    model="gpt-4o",
    messages=conversation,
    temperature=0.5,
    max_tokens=200,
    top_p=1,
    frequency_penalty=0,
    presence_penalty=0.6,
)
print(response.choices[0].message.content) # print is stdout
