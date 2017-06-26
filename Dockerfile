FROM debian:stretch
MAINTAINER Jordi Miguel <neoandroid@kaledoniah.net>

ENV DEBIAN_FRONTEND noninteractive
ENV uid 1000
ENV gid 1000
ENV PULSE_SERVER unix:/run/user/1000/pulse/native

RUN useradd -m cvlc

RUN apt-get update && apt-get --no-install-recommends install -y vlc
RUN apt-get install -y alsa-utils

COPY start-cvlc.sh /
COPY sound.wav /home/cvlc

ENTRYPOINT ["/start-cvlc.sh"]
CMD ["/home/cvlc/sound.wav"]
