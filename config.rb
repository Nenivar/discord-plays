module Config
    require 'json'
    json = File.read('config.json')
    @config = JSON.parse(json)

    def getConfigVal(key)
        val = @config['key']
        raise 'No config value for ' + key + '!'  if val == nil
        return val
    end
end