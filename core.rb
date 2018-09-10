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

bot = Discordrb::Commands::CommandBot.new token: bot_token, prefix: Config.getConfigVal('Discord_Cmd_Name')

# bucket for rate limiting
bot.bucket :general, limit: 6, time_span: 60, delay: 1

bot.command(:help) do |event|
  'Use ";pokemon a | b | up | down | left | right | start | select"!'
end

# VBA-M commands
bot.command([:up, :down, :left, :right, :a, :b, :start, :select], bucket: :general, rate_limit_message: 'You can control next in %time% seconds!') do |event|
  if VisualBoy.isPlaying
    input = event.command.name
    Input.putCmdIntoVBAM(input.to_s)
    sleep(0.7)
    sendSS(event)
    nil
  else
    'VBA-M is not open! Use ";pokemon begin"'
  end
end

# admin commands
bot.command(:begin, required_permissions: [:administrator]) do |event|
  if VisualBoy.isPlaying
    puts 'Tried to use command ' + args + ' but game is already open!'
    'Game is already open!'
  else
    beginGame
    'Started game!'
  end
end

bot.command(:exit, required_permissions: [:administrator]) do |event|
  if VisualBoy.isPlaying
    endGame
    'Exiting game...'
  else
    'Game is not open!'
  end
end

bot.command(:restart, required_permissions: [:administrator]) do |event|
  if VisualBoy.isPlaying
    restartGame
    'Restarting game...'
  else
    'Game is not open!'
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
  sleep(5)
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