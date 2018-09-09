module Screenshot
    require_relative 'config'
    include Config
    require_relative 'input'
    include Input
    require 'fileutils'

    @currentSc = 1

    # takes screenshot through VBA-M
    def takeScreenshot
        Input.putCmdIntoVBAM('screenshot')
    end

    # (relative) file path to an image
    def getImagePath(image_name)
        Config.getConfigVal('Screenshot_Loc') + '/' + name
    end

    # so it is 01 -> 09, 10, 11...
    def getLatestScreenshotPrefix
        @currentSc > 9 ? '' : '0'
    end

    # returns latest taken screenshot
    def getLatestScreenshot
        File.open(getImagePath(Config.getConfigVal('Screenshot_Name') + getLatestScreenshotPrefix + @currentSc, 'r'))
    end
    
    # deletes screenshot folder
    # and makes it again
    def deletePreviousImages
        deleteAllFiles(Config.getConfigVal('Screenshot_Loc'))
        Dir.mkdir(Config.getConfigVal('Screenshot_Loc'))
    end
    
    # removes all files in a folder
    def deleteAllFiles(dir)
        FileUtils.remove_dir(dir) if File.exists? dir
    end
end