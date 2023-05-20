
#!/bin/bash

# localrsync.sh

# syncs DATA and JOURNAL from  fuji laptop to len laptop

# 1.12.2017 modified to sync the  veracrypt volume DATA from fuji to len, note that the JOURNAL veracrypt volunme 1GB is contained WITHIN the DATA volume!4
# so you have to mounbt the DATA volume using veracrypt first, and then you can access the JOURNAL veracrypt file from inside the DATA volume.


# 4.1.18 have modified this script to  backup from PRIMARY_MEDIA VERACRYPTVOLUME



# PRIMARY_MEDIA="/NFSSHARE/VERACRYPTVOLUME"

PRIMARY_MEDIA="/NFSSHARE/PRIMARY_MEDIA/VERACRYPTVOLUME"


SECONDARY_MEDIA="/LOCAL"

LOGFILE=/var/log/localrsync.log


echo " . " > $LOGFILE
echo "#####################################################" >> $LOGFILE 
date >> $LOGFILE
echo "localrsync.sh"					     >> $LOGFILE 
echo "#####################################################" >> $LOGFILE 
echo " . " >> $LOGFILE


exec >> $LOGFILE 
exec 2>&1

mountall
	
mountdrives

rsync -av   $PRIMARY_MEDIA/    $SECONDARY_MEDIA 



echo "end of localrsync.sh" >> $LOGFILE
date >> $LOGFILE


# finally, clear up the processes:


pkill -9 rsync
pkill -9 rsync
echo "end of script execution" >> $LOGFILE
date >> $LOGFILE

# file end


