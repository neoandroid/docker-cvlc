#!/bin/bash - 
#===============================================================================
#
#          FILE: start-cvlc.sh
# 
#         USAGE: ./start-cvlc.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jordi Miguel (neoandroid@kaledoniah.net), 
#  ORGANIZATION: 
#       CREATED: 26/06/17 15:42:15 CEST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

FILE=$1
ARGS='--intf rc --play-and-exit'

uid=${USER_ID:-1000}
gid=${GROUP_ID:-1000}

# Change user id and/or group id to match with local user
# Needed to share PulseAudio socket
if [ $gid -ne 1000 ]; then
	echo "Changing group id"
	echo "$uid $gid"
	groupmod -g $gid cvlc
	usermod -u $uid -g $gid cvlc
fi
if [ $uid -ne 1000 ]; then
	echo "Changing user id"
	echo "$uid $gid"
	usermod -u $uid -g $gid cvlc
fi

# Add user to the audio group
adduser --quiet cvlc audio >/dev/null

if [ -d /home/cvlc/.config ]; then
	chown -R cvlc:cvlc /home/cvlc/.config
fi

echo "PulseAudio server: $PULSE_SERVER"
echo "Playing... $FILE"
exec su -ls "/bin/bash" -c "export PULSE_SERVER=$PULSE_SERVER; mkdir -p /home/cvlc/.local/share; /usr/bin/cvlc $ARGS $FILE" cvlc
