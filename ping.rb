# thanks https://github.com/meew0/discordrb

require 'json'

json = File.read('data/auth.json')
obj = JSON.parse(json)
bot_token = obj['Bot_Token']

require 'discordrb'

require_relative 'input'
include Input
require_relative 'screenshot'
include Screenshot
require_relative 'visual_boy'
include VisualBoy

# setup
def setup()
  Screenshot.deletePreviousImages
  VisualBoy.start(Config.getConfigVal('ROM_Loc') + '/' + Config.getConfigVal('ROM_Name'))
end

setup

bot = Discordrb::Bot.new token: bot_token

bot.message(start_with: ';pokemon') do |event|
  args = event.message.content.sub(';pokemon ', '').chomp(' ')
  if args == ';pokemon'
    # error msg - print appropriate strings
    sendSS(event)
  elsif args == 'help'
    event.respond 'Use ";pokemon a | b | up | down | left | right | start | select"!'
  elsif args == 'exit'
    VisualBoy.exit
  else
    puts args
    Input.putCmdIntoVBAM(args)
    sleep(0.8)
    sendSS(event)
  end
end

def sendSS(event)
  Screenshot.takeScreenshot
    file = Screenshot.getLatestScreenshot
    event.send_file(file)
    sleep(0.5)
    #file.close()
    Screenshot.increaseScreenshotNo
end

# connect bot to discord
bot.run