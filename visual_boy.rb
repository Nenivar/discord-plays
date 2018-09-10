require_relative 'config'
include Config
require_relative 'input'
include Input

module VisualBoy
    @playing = false

    def start(rom_path)
        pid = spawn("visualboyadvance-m #{rom_path} </dev/null &>/dev/null &")
        Process.detach(pid)

        @playing = true
    end

    def exit
        puts 'Exiting VBA-M...'
        Input.putCmdIntoVBAM('exit')

        @playing = false
    end

    def isPlaying
        return @playing
    end

    def saveState()
        if isPlaying
            puts 'Saving state...'
            Input.putCmdIntoVBAM('save')
        end
    end
end