require_relative 'config'
include Config

# runs cmd w/ xdotool on shell
# & returns
def xdotoolCmd(args)
    puts args
    `xdotool #{args}`
end

# makes system press given key name
# thruogh xdotool
def pressSysKey(key_name, args='')
    xdotoolCmd('key ' + args + key_name)
end

# returns search of window w/ name
# through xdotool
def searchWindowId(window_name)
    xdotoolCmd('search --name ' + window_name)
end

# returns window id of VBAM if it is open
def getVBAMWindowId()
    windowId = searchWindowId('"Pokemon"').chomp
    raise 'VBAM not open!' if windowId == ''
    return windowId
end

require 'json'
json = File.read('cmds.json')
@cmds = JSON.parse(json)

# gets xdotool key for given string cmd
def getKeyForCmd(cmd)
    key = @cmds[cmd]
    raise 'Cannot find key for cmd "' + cmd  + '"!' if key.nil?
    return key
end

# finds window for VBAM
# and puts command into it
def putCmdIntoVBAM(cmd)
    key = getKeyForCmd(cmd)
    windowId = getVBAMWindowId
    pressSysKey(key, '--window ' + windowId + ' ')
end

puts Config.getConfigVal('Window_Name')