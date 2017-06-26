# Supported tags and respective `Dockerfile` links
- [`2.2.6`, `2.2`, `latest` (*2.2/Dockerfile*)](https://github.com/neoandroid/docker-cvlc/blob/master/Dockerfile) 


# What is VLC?
VLC media player (commonly known as VLC) is a free and open-source software, a
portable and cross-platform media player and streaming media server written by
the VideoLAN project.

VLC media player supports many audio and video compression methods and file
formats, including DVD-Video, video CD and streaming protocols. It is able to
stream media over computer networks and to transcode multimedia files.

The default distribution of VLC includes a large number of free decoding and
encoding libraries, avoiding the need for finding/calibrating proprietary
plugins. The libavcodec library from the FFmpeg project provides many of VLC's
codecs, but the player mainly uses its own muxers, and demuxers. It also has its
own protocol implementations. It also gained distinction as the first player to
support playback of encrypted DVDs on Linux and macOS by using the libdvdcss DVD
decryption library.


# How to use this image
This image is tested with two output audio modules: PulseAudio and ALSA. The
default output is PulseAudio but will fallback to ALSA if the system cannot find
an PulseAudio server to connect to.

To start the image with PulseAudio audio output:
```console
docker run --rm -it -v /dev/shm:/dev/shm -v /etc/machine-id:/etc/machine-id -v /run/user/1000/pulse:/run/user/1000/pulse -v /var/lib/dbus:/var/lib/dbus -v ~/.pulse:/home/cvlc/.pulse neoandroid/cvlc
docker run --rm -it --env PULSE_SERVER=unix:/run/user/1000/pulse/native -v /dev/shm:/dev/shm -v /etc/machine-id:/etc/machine-id -v /run/user/1000/pulse:/run/user/1000/pulse -v /var/lib/dbus:/var/lib/dbus -v ~/.pulse:/home/cvlc/.pulse neoandroid/cvlc
docker run --rm -it --env USER_ID=1000 --env GROUP_ID=1000 -v /dev/shm:/dev/shm -v /etc/machine-id:/etc/machine-id -v /run/user/1000/pulse:/run/user/1000/pulse -v /var/lib/dbus:/var/lib/dbus -v ~/.pulse:/home/cvlc/.pulse neoandroid/cvlc
```

To start the image with ALSA audio output:
```console
docker run --rm -it --device /dev/snd:/dev/snd neoandroid/cvlc
```

You can pass an optional `[COMMAND]` on the `docker run` command line to
customize arguments and/or audio source. For example, to listen to a stream:
```console
docker run --rm -it --device /dev/snd:/dev/snd neoandroid/cvlc 'http://cdn.twit.tv/audio/floss/floss0436/floss0436.mp3'
```


## Environment Variables
When you start the `cvlc` image, you can adjust the configuration for PulseAudio
by passing one or more environment variables on the `docker run` command line.

### `PULSE_SERVER`
This variable is optional and allows you to set the server string specifying the
server to connect to when a client asks for a sound server connection and
doesn't explicitly ask for a specific server. The server string is a list of
server addresses separated by whitespace which are tried in turn. A server
address consists of an optional address type specifier (unix:, tcp:, tcp4:,
tcp6:), followed by a path or host address. A host address may include an
optional port number. A server address may be prefixed by a string enclosed in
{}. In this case the following server address is ignored unless the prefix
string equals the local hostname or the machine id (/etc/machine-id).

Default value is:`unix:/run/user/1000/pulse/native`

### `USER_ID`
This variable is optional and allows you to set the user ID of the user who runs
the cvlc command inside the container to match the user ID of a user on the host
system that has access to the PulseAudio server.

Default value is: `1000`

### `GROUP_ID`
This variable is optional and allows you to set the group ID of the user who runs
the cvlc command inside the container to match the group ID of a user on the host
system that has access to the PulseAudio server.

Default value is: `1000`


# Attribution
For testing purposes the image uses the sound from:
http://freesound.org/people/umwelt/sounds/67760/

