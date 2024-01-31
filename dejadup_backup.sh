#!/bin/bash

function check_online
{   
    # try pinging my home network
    if ping -q -c 1 -W 1 192.168.0.11 >/dev/null; then
        IS_ONLINE=1
    fi
}

# Initial check to see if we are online
IS_ONLINE=0
check_online
# echo $IS_ONLINE

# How many times we should check if we're online - this prevents infinite looping
MAX_CHECKS=5
# Initial starting value for checks
CHECKS=0

# Loop while we're not online.
while [ $IS_ONLINE -eq 0 ]; do
    # We're offline. Sleep for a bit, then check again

    sleep 10;
    check_online

    CHECKS=$[ $CHECKS + 1 ]
    if [ $CHECKS -gt $MAX_CHECKS ]; then
        break
    fi
done

if [ $IS_ONLINE -eq 0 ]; then
    # We never were able to get online. Kill script.
    exit 1
fi

# Now we enter our normal code here. The above was just for online checking
sudo mount /dejadup_backup_ubuntu
deja-dup --backup
