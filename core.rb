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

bot = Discordrb::Bot.new token: bot_token

bot.message(start_with: ';pokemon') do |event|
  args = event.message.content.sub(';pokemon ', '').chomp(' ')

  if VisualBoy.isPlaying
    if args != 'begin'
      if args == ';pokemon'
        # error msg - print appropriate strings
        sendSS(event)
      elsif args == 'help'
        event.respond 'Use ";pokemon a | b | up | down | left | right | start | select"!'
      elsif args == 'save'
        VisualBoy.saveState
      elsif args == 'exit'
        endGame
      elsif args == 'restart'
        restartGame
      else
        puts args
        Input.putCmdIntoVBAM(args)
        sleep(0.8)
        sendSS(event)
      end
    else
      puts 'Tried to use command ' + args + ' but game is already open!'
    end
  else
    if args == 'begin'
      beginGame
      event.respond 'Started game!'
    else
      puts 'Tried to use command ' + args + ' but game is not open!'
      event.respond 'Use ";pokemon begin" to open up the game!'
    end
  end
end

def beginGame
  Screenshot.deletePreviousImages
  Screenshot.resetScreenshotCount
  VisualBoy.start(Config.getConfigVal('ROM_Loc') + '/' + Config.getConfigVal('ROM_Name'))
end

def endGame
  VisualBoy.saveState
  VisualBoy.exit
end

def restartGame
  endGame
  sleep(10)
  beginGame
end

def sendSS(event)
  Screenshot.takeScreenshot
  sleep(0.1)
  file = Screenshot.getLatestScreenshot
  event.send_file(file)
  file.close()
  Screenshot.incrScreenshotCount
end

# connect bot to discord
bot.run