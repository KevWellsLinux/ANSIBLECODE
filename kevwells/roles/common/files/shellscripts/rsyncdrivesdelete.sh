
#!/bin/bash

# rsyncdrives.sh


#PRIMARY DRIVE is INTENSO
#SECONDARY DRIVE is TOSHIBA 



PRIMARY_MEDIA="/PRIMARY_MEDIA/"

SECONDARY_MEDIA="/media/kevin/SECONDARY_MEDIA/"


LOGFILE=/var/log/rsyncdrivesdelete.log


echo " . " > $LOGFILE
echo "#####################################################" >> $LOGFILE 
echo  " RSYNCDRIVESDELETE "   >> $LOGFILE 

date >> $LOGFILE
echo "#####################################################" >> $LOGFILE 
echo " . " >> $LOGFILE


exec >> $LOGFILE 
exec 2>&1


	
rsync -av   $PRIMARY_MEDIA  $SECONDARY_MEDIA   --delete-before   --ignore-errors



echo "end of rsyncdrives.sh" >> $LOGFILE
date >> $LOGFILE


# finally, clear up the processes:


echo "end of script execution" >> $LOGFILE
date >> $LOGFILE

# file end


