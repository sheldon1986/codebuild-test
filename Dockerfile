FROM ubuntu:16.04
MAINTAINER sheldon <sheldon@code-post.com>

RUN apt-get update -qq && apt-get install -y \
    syslog-ng \
    wget \
    vim

EXPOSE 514/udp
