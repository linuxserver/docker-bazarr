FROM lsiobase/alpine.python:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="chbmb"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	libffi-dev \
	python-dev \
	zlib-dev && \
 echo "**** install bazarr ****" && \
 BAZARR_VER=$(curl -sX GET "https://api.github.com/repos/morpheus65535/bazarr/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
 /tmp/bazarr.tar.gz -L \
	"https://github.com/morpheus65535/bazarr/archive/${BAZARR_VER}.tar.gz" && \
 mkdir -p \
	/app/bazarr && \
 tar xf \
 /tmp/bazarr.tar.gz -C \
	/app/bazarr --strip-components=1 && \
 pip install -r /app/bazarr/requirements.txt && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 6767
VOLUME /config /movies /tv
