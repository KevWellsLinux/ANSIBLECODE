
#!/bin/bash

# rsyncdrives.sh



# PRIMARY  DRIVE is WD 
# SECONDARY DRIVE is INTENSO  



set -x 

PRIMARY_MEDIA="/media/kevin/PRIMARY_MEDIA/MEDIA"

SECONDARY_MEDIA="/media/kevin/SECONDARY_MEDIA/MEDIA"

#mount  -t ext4 /dev/sdc1  /media/kevin/SECONDARY_MEDIA

##mount /dev/sdd1 -t ext4 -o rw,x-mount.mkdir /media/kevin/SECONDARY_MEDIA
 
PRIMARY_BACKUP="/media/kevin/PRIMARY_BACKUP"

SECONDARY_BACKUP="/media/kevin/SECONDARY_MEDIA/SECONDARY_BACKUP"

LOGFILE=/var/log/rsyncdrives.log


echo " . " > $LOGFILE
echo "#####################################################" >> $LOGFILE 
date >> $LOGFILE
echo "rsyncdrives.sh"					     >> $LOGFILE 
echo "#####################################################" >> $LOGFILE 
echo " . " >> $LOGFILE


exec >> $LOGFILE 
exec 2>&1

	
rsync -av   $PRIMARY_MEDIA/    $SECONDARY_MEDIA/   

rsync -av   $PRIMARY_BACKUP/   $SECONDARY_BACKUP   

rm  $SECONDARY_MEDIA/THIS_IS_PRIMARY_MEDIA


echo "end of rsyncdrives.sh" >> $LOGFILE
date >> $LOGFILE


# finally, clear up the processes:


pkill -9 rsync
pkill -9 rsync
echo "end of script execution" >> $LOGFILE
date >> $LOGFILE

# file end


