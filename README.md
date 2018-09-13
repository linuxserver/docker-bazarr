[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://github.com/morpheus65535/bazarr
[hub]: https://hub.docker.com/r/linuxserver/bazarr/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/bazarr

[Bazarr][appurl] is a companion application to Sonarr and Radarr. It can manage and download subtitles based on your requirements. You define your preferences by TV show or movie and Bazarr takes care of everything for you.  

[![bazarr](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/bazarr.png)][appurl]

## Usage

```
docker create \
  --name=bazarr \
	-v <path to data>:/config \
	-v <path to data>:/movies \
	-v <path to data>:/tv \
	-e PGID=<gid> -e PUID=<uid>  \
	-p 6767:6767 \
  linuxserver/bazarr
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 6767` - the port(s)
* `-v /config` - Bazarr Application Data
* `-v /movies` - Movies Folder
* `-v /tv` - TV Folder
* `-e PGID` for for GroupID - see below for explanation
* `-e PUID` for for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it bazarr /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Access the webui at `<your-ip>:6767`, for more information check out [bazarr][appurl].

## Info

* Shell access whilst the container is running: `docker exec -it bazarr /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f bazarr`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' bazarr`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/bazarr`

## Versions

+ **11.09.18:** Initial Release.
