FROM alpine:3.10

LABEL maintainer="Juri Strumpflohner <info@juristr.com>"

ENV HUGO_VERSION=0.53 \
    HUGO_SITE=/srv/hugo
ENV HUGO_BINARY=hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz

ENV GLIBC_VERSION 2.28-r0

RUN set -x && \
    apk add --update wget ca-certificates libstdc++

# Install glibc
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    &&  wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-$GLIBC_VERSION.apk \
    &&  apk --no-cache add glibc-$GLIBC_VERSION.apk \
    &&  rm glibc-$GLIBC_VERSION.apk \
    &&  wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-bin-$GLIBC_VERSION.apk \
    &&  apk --no-cache add glibc-bin-$GLIBC_VERSION.apk \
    &&  rm glibc-bin-$GLIBC_VERSION.apk \
    &&  wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-i18n-$GLIBC_VERSION.apk \
    &&  apk --no-cache add glibc-i18n-$GLIBC_VERSION.apk \
    &&  rm glibc-i18n-$GLIBC_VERSION.apk

RUN apk --no-cache add git

RUN apk add --update nodejs nodejs-npm

# Install HUGO
RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
    tar xzf ${HUGO_BINARY} && \
    rm -r ${HUGO_BINARY} && \
    mv hugo /usr/bin && \
    apk del wget ca-certificates && \
    rm /var/cache/apk/*

WORKDIR ${HUGO_SITE}`
EXPOSE 1313