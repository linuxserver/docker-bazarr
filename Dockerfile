FROM ghcr.io/linuxserver/baseimage-alpine:3.16

# set version label
ARG UNRAR_VERSION=6.1.7
ARG BUILD_DATE
ARG VERSION
ARG BAZARR_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="chbmb"
# hard set UTC in case the user does not define it
ENV TZ="Etc/UTC"

RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    build-base \
    cargo \
    g++ \
    gcc \
    jq \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    make \
    python3-dev && \
  echo "**** install packages ****" && \
  apk add --no-cache \
    ffmpeg \
    libxml2 \
    libxslt \
    py3-pip \
    python3 \
    unzip && \
  echo "**** install unrar from source ****" && \
  mkdir /tmp/unrar && \
  curl -o \
    /tmp/unrar.tar.gz -L \
    "https://www.rarlab.com/rar/unrarsrc-${UNRAR_VERSION}.tar.gz" && \  
  tar xf \
    /tmp/unrar.tar.gz -C \
    /tmp/unrar --strip-components=1 && \
  cd /tmp/unrar && \
  make && \
  install -v -m755 unrar /usr/local/bin && \
  echo "**** install bazarr ****" && \
  if [ -z ${BAZARR_VERSION+x} ]; then \
    BAZARR_VERSION=$(curl -sX GET https://api.github.com/repos/morpheus65535/bazarr/releases \
    | jq -r '.[0] | .tag_name'); \
  fi && \
  curl -o \
    /tmp/bazarr.zip -L \
    "https://github.com/morpheus65535/bazarr/releases/download/${BAZARR_VERSION}/bazarr.zip" && \
  mkdir -p \
    /app/bazarr/bin && \
  unzip \
    /tmp/bazarr.zip -d \
    /app/bazarr/bin && \
  rm -Rf /app/bazarr/bin/bin && \
  echo "UpdateMethod=docker\nBranch=development\nPackageVersion=${VERSION}\nPackageAuthor=linuxserver.io" > /app/bazarr/package_info && \
  echo "**** Install requirements ****" && \
  pip3 install -U --no-cache-dir pip && \
  pip install -U --no-cache-dir --find-links https://wheel-index.linuxserver.io/alpine-3.16/  -r \
    /app/bazarr/bin/requirements.txt && \
  echo "**** clean up ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /root/.cache \
    /root/.cargo \
    /tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 6767

VOLUME /config
