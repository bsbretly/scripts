#!/bin/bash

# Autostart Configuration: There's an autostart desktop entry for your script located at /home/brett/.config/autostart/dejadup_backup.sh.desktop. 
# This means the script is set to run when the graphical desktop environment starts.

LOGFILE="/home/brett/utilities/scripts/backup_script.log"  # Define the log file
echo "$(date): Script started." > $LOGFILE  # Overwrite log file at the start of each run

HOME_NETWORK_IP="192.168.4.121"

function check_online {   
    # try pinging the home network
    if ping -q -c 1 -W 1 $HOME_NETWORK_IP >/dev/null; then
        IS_ONLINE=1
        echo "$(date): Connected to home network ($HOME_NETWORK_IP)." >> $LOGFILE
    else
        IS_ONLINE=0
        echo "$(date): Unable to connect to home network ($HOME_NETWORK_IP)." >> $LOGFILE
    fi
}

function mount_backup_drive {
    MOUNT_POINT="/dejadup_backup_ubuntu"
    # Try to mount the drive
    sudo mount $MOUNT_POINT
    if mount | grep -q " $MOUNT_POINT "; then
        echo "$(date): Successfully mounted $MOUNT_POINT." >> $LOGFILE
        return 0  # Success
    else
        echo "$(date): Failed to mount $MOUNT_POINT." >> $LOGFILE
        return 1  # Failure
    fi
}

# Initial check to see if we are online
IS_ONLINE=0
check_online

# How many times we should check if we're online - prevents infinite looping
MAX_CHECKS=5
# Initial starting value for checks
CHECKS=0

# Loop while we're not online.
while [ $IS_ONLINE -eq 0 ]; do
    # We're offline. Sleep for a bit, then check again
    sleep 10
    check_online

    CHECKS=$((CHECKS + 1))
    if [ $CHECKS -gt $MAX_CHECKS ]; then
        echo "$(date): Exceeded maximum checks. Script exiting." >> $LOGFILE
        exit 1
    fi
done

if [ $IS_ONLINE -eq 0 ]; then
    echo "$(date): Unable to get online. Exiting script." >> $LOGFILE
    exit 1
fi

# Try to ensure the backup drive is mounted
MAX_MOUNT_ATTEMPTS=3
MOUNT_ATTEMPTS=0
DRIVE_MOUNTED=0

while [ $MOUNT_ATTEMPTS -lt $MAX_MOUNT_ATTEMPTS ] && [ $DRIVE_MOUNTED -eq 0 ]; do
    if mount_backup_drive; then
        DRIVE_MOUNTED=1
    else
        MOUNT_ATTEMPTS=$((MOUNT_ATTEMPTS + 1))
        sleep 5  # Wait a bit before trying again
    fi
done

if [ $DRIVE_MOUNTED -eq 0 ]; then
    echo "$(date): Failed to mount backup drive after $MAX_MOUNT_ATTEMPTS attempts. Aborting backup." >> $LOGFILE
    exit 1
fi

# Proceed with backup if the drive is mounted
echo "$(date): Starting backup process." >> $LOGFILE
if deja-dup --backup; then
    echo "$(date): Backup completed successfully." >> $LOGFILE
else
    echo "$(date): Backup failed." >> $LOGFILE
    exit 1
fi

