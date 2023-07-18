#!/bin/bash
# Script: /usr/local/bin/megabackup_nextcloud.sh 
# Date Created: 30.7.2020
# Last Modifled  9.1.2022
# Author: Kevin Wells
# Purpose: Backup to mega.nz from gemini using mega-backup command
# How called:  via crontab. Can also be called manually
# Requires: mega-cmd-server utility suite from mega.nz 
# Location: gemini linux server

LOGFILE=/var/log/megabackup_nextcloud.log

date  > $LOGFILE



# create a backup every day at 4am, and keep the last 2 backup instances:

#mega-backup /home/kevin/DATA/ /Root/MEGASync/DATA --period="0 0 4 * * *" --num-backups=2

#mega-sync  /home/kevin/BACKUP/DATA  /MEGAsync/DATA
# note mega.nz enforces amax 2gb per day transfer quota for free accounts!

megacopy  --local /var/www/nextcloud/data/KevCloudWells/files/NEXTCLOUD  --remote /Root/MEGASync/NEXTCLOUD   -u kevrwells@gmail.com  -p T-iLBCwnc1

echo "megabackup.sh completed at " >> $LOGFILE

date >> $LOGFILE

#echo "now killing mega-cmd-server process..." >> $LOGFILE
#pkill  -9  mega-cmd-server
# date >> $LOGFILE



# Scriptende




