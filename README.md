# twitter-bot-randimg

Twitter bot that posts a random image periodically.

## Introduction

This is a super simple Twitter bot made just for fun, using [twurl](https://github.com/twitter/twurl) for accessing Twitter API via a bash script, and automation with systemd timers.

I always wanted to create a Twitter bot, and this particular idea came up when I saw Twitter accounts that post random frames from a TV show every 30 minutes (for example, [@simpscreens](https://twitter.com/simpscreens)), so I decided to make something similar with [JoJo's Bizarre Adventure Part 4: Diamond is Unbreakable](https://myanimelist.net/anime/31933/JoJo_no_Kimyou_na_Bouken_Part_4__Diamond_wa_Kudakenai), a popular anime TV show.

### Currently running bots using twitter-bot-randimg and created by me

- [@jojo_frames](https://twitter.com/jojo_frames)

## Usage

### Create Twitter account and Twitter App

First of all, [create a Twitter account](https://twitter.com/i/flow/signup) for your bot and then [a Twitter App](https://developer.twitter.com/en/portal/apps/new).

Give your app right permissions (from its settings): at least Read and Write.

Save your API Consumer key & secret, which are generated upon the creation of the app and can be regenerated at any time. You will need them later for accessing Twitter API.

### Server

This bot was tested and works perfectly in a Raspberry Pi 4 as a server running [Arch Linux ARM](https://archlinuxarm.org/), but it should work in any systemd-based GNU/Linux distribution.

#### Dependencies

- bash, findutils, coreutils
- systemd
- [twurl](https://github.com/twitter/twurl): if you are using Arch Linux, just install [ruby-twurl](https://aur.archlinux.org/packages/ruby-twurl/), a package I sent to the AUR, else follow official installation instructions (either make sure ```twurl``` binary is in root's ```$PATH``` or modify ```tweet-randimg``` script so it uses full path).
- [jshon](http://kmkeen.com/jshon/): available in most distro repos.

#### Prepare your image files

Store your image files in a directory inside your server. It can be either locally or remotely stored. If the latter is the case, it has to be mounted in your server's filesystem. Image files can be organized in subdirectories.

For my use case, I extracted frames from video files using ffmpeg and saved them organized with a subdirectory for each episode.

#### Configure twurl

You need to configure twurl in order to be able to post tweets to your account. Run (**as root**)

```
# twurl authorize --consumer-key XXX --consumer-secret XXX
```

replacing ```XXX``` with actual values.

#### Copy files

Rename files if you plan to run several bots in the same server.

First, copy ```tweet-randimg```, a bash script that chooses a random image and posts it to your Twitter account, to a directory found in root's ```$PATH``` (e. g. ```/usr/local/bin```) and edit this file following the instructions in the comments.

Then, copy ```tweet-randimg.service``` and ```tweet-randimg.timer```, the systemd timer that will run the script every 30 minutes and its corresponding service unit, to ```/etc/systemd/system```. Read the comments and modify them to your needs.

#### Test

To make sure everything works fine, run

```
# tweet-randimg
```

and, if it works, first run

```
# systemctl daemon-reload
```

and then try the systemd service:

```
# systemctl start tweet-randimg.service
```

If this, again, works as intended, you are ready for the final step.

#### Set up timer

Set up the systemd timer so tweets are posted periodically:

```
# systemctl enable --now tweet-randimg.timer
```

## Ideas for future versions

- Switch from jshon to [jq](https://stedolan.github.io/jq/).
- Remove images from server after being posted (as an option).
- Include help message and options in bash script.
- Add instructions for cron instead of systemd.timer.

Any suggestions are appreciated!
