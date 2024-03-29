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
- [jq](https://stedolan.github.io/jq/): available in most distro repos.

#### Prepare your image files

Store your image files in a directory inside your server. It can be either locally or remotely stored. If the latter is the case, it has to be mounted in your server's filesystem. Image files can be organized in subdirectories.

For my use case, I extracted frames from video files using ffmpeg and saved them organized with a subdirectory for each episode.

#### Configure twurl

You need to configure twurl in order to be able to post tweets to your account. Run (**as root**)

```
twurl authorize --consumer-key XXX --consumer-secret XXX
```

replacing ```XXX``` with actual values.

#### Install script

Clone the repository:

```
git clone https://github.com/albertored11/twitter-bot-randimg.git
```

change working directory to ```twitter-bot-randimg```:

```
cd twitter-bot-randimg
```

and finally install using Makefile (**as root**):

```
make install
```

You can uninstall the script running (**as root**) ```make uninstall```.

systemd unit files will be installed too. Read the comments and modify them to your needs. It is necessary to specify mandatory arguments for the script (```--image-dir```).

#### Test

To make sure everything works fine, run (**as root**)

```
tweet-randimg --image-dir <image_dir> [--user <user>]
```

**Tip:** if you want the image file to be removed after posting, use option ```-r``` or ```--remove-image```.

and, if it works, first run (**as root**)

```
systemctl daemon-reload
```

and then try the systemd service (**as root**):

```
systemctl start tweet-randimg.service
```

If this, again, works as intended, you are ready for the final step.

#### Set up timer

Set up the systemd timer so tweets are posted periodically (**as root**):

```
systemctl enable --now tweet-randimg.timer
```

## Ideas for future versions

- [x] Switch from jshon to [jq](https://stedolan.github.io/jq/).
- [x] Remove images from server after being posted (as an option).
- [x] Include help message and options in bash script.
- [ ] Add instructions for cron instead of systemd.timer.
- [ ] Add option for generating systemd files.
- [x] Create makefile.
- [x] Make ```--user``` argument optional (if not provided, use default twurl user).
- [x] Check that chosen directory exists!
- [ ] Run everything as unprivileged user.
- [ ] Modify ```--remove-image``` option so it moves the file to another directory instead of removing it.
- [ ] Create two separate scripts: one that posts an image to Twitter, and another one, user-made (with an example provided), that chooses an image file somehow and calls the first script.

Any suggestions are appreciated!
