#!/bin/bash
#  script name: rsync_gemini.sh 
#  Script to rsync DATA from laptop to gemini server nightly
#  called from root crontab 
#  runs on laptop len from /usr/local/bin


LOGFILE="/var/log/rsync_gemini.log"
echo $LOGFILE
set -x 

echo " . " > $LOGFILE
echo "#####################################################" >> $LOGFILE 
date 							     >> $LOGFILE
echo "rsync_gemini.sh"					     >> $LOGFILE 
echo "#####################################################" >> $LOGFILE 
echo "   " 						     >> $LOGFILE



rsync -rvz -e 'ssh -p 443' --progress --partial  /media/kevin/DATA  kevin@gemini:/home/kevin/BACKUP/   >> $LOGFILE 

echo "rsync_gemini.sh completed at "                         >> $LOGFILE
date                                                         >> $LOGFILE


######################################## SCRIPT END ######################################



