#!/bin/bash
# Script: /usr/local/bin/megabackup_data.sh 
# Date Created: 30.7.2020
# Last Modifled 20.12.2022
# Author: Kevin Wells
# Purpose: Backup to mega.nz from aws kevinvm1 using mega-backup command
# How called:  via crontab. Can also be called manually
# Requires: mega-cmd-server utility suite from mega.nz 
# Location: kevinvm1 aws ec2 linux server

LOGFILE=/var/log/megabackup_data.log

date  > $LOGFILE



# create a backup every day at 4am, and keep the last 2 backup instances:

#mega-backup /home/kevin/DATA/ /Root/MEGASync/DATA --period="0 0 4 * * *" --num-backups=2

#mega-sync  /home/kevin/BACKUP/DATA  /MEGAsync/DATA
# note mega.nz enforces amax 2gb per day transfer quota for free accounts!

# does not work, still asks for password at command prompt, so instead we use .megarc file:

#megacopy  --local /home/kevin/DATAVOLUME  --remote /Root/MEGASync/DATAVOLUME  -u kevrwells@gmail.com  -p T-iLBCwnc1

#    megacopy syncs remote and local directories. No files are ever overwritten or removed.

megacopy --config=/root/.megarc  --local=/media/kevin/STORAGEVOLUMELUKS/DATAVOLUME     --remote=/Root/MEGASync/DATAVOLUME 
megacopy --config=/root/.megarc  --local=/media/kevin/STORAGEVOLUMELUKS/ARCHIVEVOLUME  --remote=/Root/MEGASync/ARCHIVEVOLUME 






echo "megabackup.sh completed at " >> $LOGFILE

date >> $LOGFILE

#echo "now killing mega-cmd-server process..." >> $LOGFILE
#pkill  -9  mega-cmd-server
# date >> $LOGFILE



# Scriptende




