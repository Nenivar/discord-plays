# discord-plays
Play pokemon over discord with commands

# Installation
Requires:
* Linux (probably)
* xdotool
```
apt-get install xdotool
```
* VisualBoyAdvance-M
```
https://code.launchpad.net/%7Esergio-br2/+archive/ubuntu/vbam-trunk
```

# Running
Store token in auth.json:
```json
{
    "Client_ID" : "",
    "Bot_Token" : ""
}
```
Change stuff in config.json

Change keybinds in VBA-M to what is in config
Make VBA-M load newest save on startup

```
bundle exec ruby ping.rb
```
or
```
chmod +x /start.sh
./start.sh
```

## Todo
### Required
* [x] Saving states
* [x] Rate limiting
* [x] Permission levels
### Should
* [x] Delete screenshots automatically
* [x] Detect next screenshot no. automatically
* [ ] Delete save states automatically
* [ ] More error handling/messages
* [ ] Better method for detecting window
* [ ] General json module (singleton class?)
* [ ] Auto start/shutdown after time
* [ ] PM user rate limit msg
### Stretch
* [ ] Record gif & send? Experiment
* [ ] Democracy mode
* [ ] Drawing over image
* [ ] Play music in discord channel

## Why did you do this in Ruby?
I wanted to learn the language

## Feedback/your code sucks
Please tell me, I have no idea what I'm doing

## Thanks
* Inspiration: https://github.com/TheBlackParrot/discord-plays-pokemon
* Discord integration: https://github.com/meew0/discordrb/
* Support: Rowan