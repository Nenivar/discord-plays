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

Store token in auth.json:
```json
{
    "Client_ID" : "",
    "Bot_Token" : ""
}
```
Change stuff in config.json

Load (legally obtained) ROM -> VBA-M

```
bundle exec ruby ping.rb
```

## Todo
* [ ] More error handling/messages
* [ ] Delete screenshots automatically
* [ ] Detect next screenshot no. automatically
* [ ] Better method for detecting window
* [ ] General json module (singleton class?)
* [ ] Auto start/shutdown after time
* [ ] Saving states


* [ ] Record gif & send?
* [ ] Democracy mode
* [ ] Drawing over image
* [ ] Play music in discord channel

## Why did you do this in Ruby?
I wanted to learn the language

## Feedback/your code sucks
Please tell me, I have no idea what I'm doing

## Credit
Inspiration: https://github.com/TheBlackParrot/discord-plays-pokemon
Discord integration: https://github.com/meew0/discordrb/
Support: Rowan