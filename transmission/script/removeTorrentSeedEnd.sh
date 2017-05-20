#!/bin/sh
# remove torrent from the list and from the disk

. /etc/transmission/environment-variables.sh

transmission_username=$(head -1 $TRANSMISSION_PASSWD_FILE)
transmission_passwd=$(tail -1 $TRANSMISSION_PASSWD_FILE)

#Test if present in cloud
transmission-remote -n "$transmission_username:$transmission_passwd" -t $TR_TORRENT_HASH --remove-and-delete

