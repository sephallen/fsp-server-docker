# FSP Server Docker

## Table of Contents
- [FSP Server Docker](#fsp-server-docker)
  - [Table of Contents](#table-of-contents)
  - [Purpose](#purpose)
    - [Requirements](#requirements)
    - [Usage](#usage)
  - [Configuration](#configuration)
    - [fspd.conf](#fspdconf)
      - [Packet size](#packet-size)
    - [docker-compose.yml](#docker-composeyml)
      - [Port](#port)
      - [Share (home directory)](#share-home-directory)
  - [Acknowledgements](#acknowledgements)

## Purpose
To easily spin up an FSP share for all your GameCube game images (.iso, .gcz) to be played via [Swiss](https://github.com/emukidid/swiss-gc).

### Requirements
- x86-64 machine (tested on Linux, though it should work on Windows and MacOS)
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/) - not strictly necessary, but it will make things much easier
- [Nintendo GameCube Broadband Adapter (DOL-015) aka BBA](https://en.wikipedia.org/wiki/GameCube_online_functionality)
- A GameCube which is able to run [Swiss](https://github.com/emukidid/swiss-gc).
- Some GameCube game disc images

### Usage
1. Clone this repo or [download latest master branch](https://github.com/sephallen/fsp-server-docker/archive/master.zip) and extract its contents.
2. Download your desired version of the [FSP](http://fsp.sourceforge.net/) daemon in its non debug, RPM form. The latest version as of writing can be downloaded [here](https://sourceforge.net/projects/fsp/files/fsp/2.8.1b29/fspd-2.8.1b29-2.el7.x86_64.rpm/download).
3. Rename the isntaller to `fspd.rpm` and place it into the `installer` directory.
4. Place your game images in the `share` directory. This path can be changed in the [docker-compose.yml](#docker-compose.yml) file if you wish.
5. Run `docker-compose build` within the project directory to confirm everything is set up correctly.
6. Run `docker-compose up -d` within the project directory to run the server as a background process. You can omit the `-d` if you wish to see a log from the container in your terminal.
7. In Swiss, connect to your container via the host machine's local IP address and port number `7717`. By default, no password is set, so you can leave this blank.

Note: If you run into stablilty issues, you may need to adjust your packet size, see [Configuration](#packet-size).

Note: If you wish to add or remove games from your share, there is no need to rebuild or restart the container.

## Configuration
### fspd.conf
Most of the settings here are left as default and probably will not need to be changed. If you wish to change settings such as the port or home directory, it would be simpler to change them in the [docker-compose.yml](#docker-compose.yml) file.

#### Packet size
Supposedly, the best packet size for Swiss is `packetsize 1990` (this has already been set in the `fspd.conf`). However, it is possible that this could cause issues on some machines. If you run into problems, you could try `packetsize 1440` or comment out this setting `#packetsize 1990` to use the default value.

### docker-compose.yml
#### Port
To change the external port number of the FSP server, you can map it to the port you would like to use while keeping the internal port the same in the `docker-compose.yml` file.
For example, if you wanted to change the port Swiss connects via to `8080`, change this line:
`- "7717:21/udp"` to `- "8080:21/udp"`.

#### Share (home directory)
It is quite likely that you already have a directory set up for your game images. To change your default share, change this line:
`- ./share:/var/ftp` and replace the first part with your desire share location, for example: `- /mnt/user/games:/var/ftp`.

## Acknowledgements
Thank you to all the very helpful people in the `#modification-station` channel on the [GameCube Online discord](https://discord.gg/M2hbYsr).
