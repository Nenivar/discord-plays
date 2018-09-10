require_relative 'config'
include Config
require_relative 'input'
include Input

module VisualBoy
    playing = false

    def start(rom_path)
        pid = spawn("visualboyadvance-m #{rom_path} </dev/null &>/dev/null &")
        Process.detach(pid)

        playing = true
    end

    def exit
        puts 'Exiting VBA-M...'
        Input.putCmdIntoVBAM('exit')
    end

    def isPlaying
        return playing
    end
end