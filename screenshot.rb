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

    def incrScreenshotCount
        syncScreenshotCount if @currentSc % Config.getConfigVal('Screenshot_Limit') == 0
        @currentSc += 1
    end

    def resetScreenshotCount
        @currentSc = 1
    end

    def syncScreenshotCount
        @currentSc = findBiggestImageNo
        deletePreviousImages()
    end

    def findBiggestImageNo()
        d = Dir.open(Config.getConfigVal('Screenshot_Loc'))
        biggest =  d.max
        biggest = biggest.sub(Config.getConfigVal('Screenshot_Name'), '')
        biggest = biggest.sub('.png', '')
        return biggest.to_i
    end

    # (relative) file path to an image
    def getImagePath(image_name)
        Config.getConfigVal('Screenshot_Loc') + '/' + image_name
    end

    # so it is 01 -> 09, 10, 11...
    def getLatestScreenshotPrefix
        @currentSc > 9 ? '' : '0'
    end

    # path of latest taken screenshot
    def getLatestScreenshotPath
        return getImagePath(Config.getConfigVal('Screenshot_Name') + getLatestScreenshotPrefix + @currentSc.to_s + '.png')
    end

    # file of latest taken screenshot
    # remember to close after!
    def getLatestScreenshot
        File.open(getLatestScreenshotPath, 'r')
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