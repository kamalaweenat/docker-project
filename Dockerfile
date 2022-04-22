# it's the output path that python script will log to it 
ARG ALPINE_VER=3.15.0
FROM alpine:$ALPINE_VER

RUN apk add --update --no-cache python3
RUN apk add --update --no-cache git
