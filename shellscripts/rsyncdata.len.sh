
#!/bin/bash

# rsyncdata.len.sh


PRIMARY_MEDIA="/NFSSHARE/DATA/"

SECONDARY_MEDIA="/LOCAL/"


LOGFILE=/var/log/rsyncdata.len.log


echo " . " > $LOGFILE
echo "#####################################################" >> $LOGFILE 
date >> $LOGFILE
echo "rsyncdata.len.sh"					     >> $LOGFILE 
echo "#####################################################" >> $LOGFILE 
echo " . " >> $LOGFILE


exec >> $LOGFILE 
exec 2>&1

mountall
	
rsync -auv   $PRIMARY_MEDIA    $SECONDARY_MEDIA 


#rsync -auv   $SECONDARY_MEDIA    $PRIMARY_MEDIA 



echo "end of rsyncdata.len.sh" >> $LOGFILE
date >> $LOGFILE


# finally, clear up the processes:


pkill -9 rsync
pkill -9 rsync
echo "end of script execution" >> $LOGFILE
date >> $LOGFILE

# file end


