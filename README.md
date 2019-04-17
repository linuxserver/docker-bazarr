[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!

# [linuxserver/bazarr](https://github.com/linuxserver/docker-bazarr)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/bazarr.svg)](https://microbadger.com/images/linuxserver/bazarr "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/bazarr.svg)](https://microbadger.com/images/linuxserver/bazarr "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/bazarr.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/bazarr.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-bazarr/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-bazarr/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/bazarr/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/bazarr/latest/index.html)

[Bazarr](https://www.bazarr.media/) is a companion application to Sonarr and Radarr. It can manage and download subtitles based on your requirements. You define your preferences by TV show or movie and Bazarr takes care of everything for you.

[![bazarr](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/bazarr.png)](https://www.bazarr.media/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/bazarr` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=bazarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 6767:6767 \
  -v </path/to/bazarr/config>:/config \
  -v </path/to/movies>:/movies \
  -v </path/to/tv>:/tv \
  --restart unless-stopped \
  linuxserver/bazarr
```

You can choose between ,using tags, various branch versions of bazarr, no tag is required to remain on the main branch.
Add one of the tags,  if required,  to the linuxserver/bazarr line of the run/create command in the following format, linuxserver/bazarr:development
The development tag will be the latest commit in the development branch of bazarr.
HOWEVER , USE THE DEVELOPMENT BRANCH AT YOUR OWN PERIL !!!!!!!!!


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  bazarr:
    image: linuxserver/bazarr
    container_name: bazarr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - </path/to/bazarr/config>:/config
      - </path/to/movies>:/movies
      - </path/to/tv>:/tv
    ports:
      - 6767:6767
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 6767` | Allows HTTP access to the internal webserver. |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London |
| `-v /config` | Bazarr data |
| `-v /movies` | Location of your movies |
| `-v /tv` | Location of your TV Shows |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

- Once running the URL will be `http://<host-ip>:6767`.
- You must complete all the setup parameters in the webui before you can save the config.



## Support Info

* Shell access whilst the container is running: `docker exec -it bazarr /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f bazarr`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' bazarr`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/bazarr`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/bazarr`
* Stop the running container: `docker stop bazarr`
* Delete the container: `docker rm bazarr`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start bazarr`
* You can also remove the old dangling images: `docker image prune`

### Via Taisun auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one shot:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock taisun/updater \
  --oneshot bazarr
  ```
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull bazarr`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d bazarr`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **17.04.19:** - Add default UTC timezone if user does not set it.
* **23.03.19:** - Switching to new Base images, shift to arm32v7 tag.
* **22.02.19:** - Rebasing to alpine 3.9.
* **11.09.18:** - Initial release.
