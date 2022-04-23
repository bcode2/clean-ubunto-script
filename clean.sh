#!/bin/bash
sudo apt-get autoremove;
sudo apt-get autoclean;
sudo apt-get clean;

# Delete files with 0 size
sudo find ./  -empty -type f -delete;

# Delete empty directories 
sudo find ./  -empty -type d -delete;

# delete journal files
sudo journalctl --vacuum-time=1d;
rm -rf ~/.cache/thumbnails/* 

# Empty all logs files
# Reference: https://computingforgeeks.com/how-to-empty-truncate-log-files-in-linux/
find /var/log -type f -iname '*.log' -print0 | xargs -0 truncate -s0

# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done

