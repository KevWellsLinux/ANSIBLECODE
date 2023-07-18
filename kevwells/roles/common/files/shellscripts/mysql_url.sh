
#!/bin/bash
# Script: /usr/local/bin/kevwells.com_db_replication.sh
# Date Created: 19.4.2022
# Last Modifled 19.04.2022
# Author: Kevin Wells
# Purpose: export wordpress database for kevwells.com website from NFS share on gemini to laptop
#          and modify database domain url from http://kevwells.com to http://localhost
# How called:  via crontab. Can also be called manually
# Requires: mysql/mariadb, mysqladmin, mysql client, ssh, ssh keys installed on server for passwordless remote command execution 
#           /root/.my.cnf  containing mysql password for root, gzip/gunzip on both machines 
# Location: asus laptop /usr/local/bin 


set -x 

# first, make sure the wordpress cache is flushed to disk:

##ssh root@geminivpn  "wp  cache flush --path=/var/www/wordpress  --allow-root "


# create the database export from server kevwells.com:



##ssh root@geminivpn   "mysqldump --defaults-file=/root/.my.cnf  --quick kevwells  | gzip >  /home/kevin/DATA/KEVWELLS.COM/kevwells.sql.gz"

##ssh root@geminivpn   "mysqldump --defaults-file=/root/.my.cnf  --quick mysql     | gzip >  /home/kevin/DATA/KEVWELLS.COM/mysql.sql.gz"

# next import the databases into the laptop mysql:


##rm /home/kevin/DATA/KEVWELLS.COM/kevwells.sql
##rm /home/kevin/DATA/KEVWELLS.COM/mysql.sql
 

##mysqlimport kevwells |  gunzip  /home/kevin/DATA/KEVWELLS.COM/kevwells.sql.gz

##mysqlimport mysql    |  gunzip  /home/kevin/DATA/KEVWELLS.COM/mysql.sql.gz
 

# then execute mysqladmin flush-privileges so the laptop mysql server reloads the grant table info:

#mysqladmin flush-privileges



##chown  -R mysql.mysql /var/lib/mysql/kevwells


 /usr/bin/mysql --defaults-file=/root/.my.cnf -e "USE kevwells ; UPDATE wp_options SET option_value = replace(option_value, 'http://kevwells.com', 'http://localhost') WHERE option_name = 'home' OR option_name = 'siteurl'; UPDATE wp_posts SET guid = replace(guid, 'http://kevwells.com','http://localhost');  UPDATE wp_posts SET post_content = replace(post_content, 'http://kevwells.com', 'http://localhost');  UPDATE wp_postmeta SET meta_value = replace(meta_value,'http://kevwells.com','http://localhost'); FLUSH PRIVILEGES;"

/usr/bin/mysql --defaults-file=/root/.my.cnf -e "USE kevwells ; UPDATE wp_options SET option_value = replace(option_value, 'http://kevwells.com', 'http://localhost') WHERE option_name = 'home' OR option_name = 'siteurl'; " 

/usr/bin/mysql --defaults-file=/root/.my.cnf -e "USE kevwells ; UPDATE wp_posts SET guid = replace(guid, 'http://kevwells.com','http://localhost'); "

/usr/bin/mysql --defaults-file=/root/.my.cnf -e "USE kevwells ; UPDATE wp_posts SET post_content = replace(post_content, 'http://kevwells.com', 'http://localhost');  " 

/usr/bin/mysql --defaults-file=/root/.my.cnf -e "USE kevwells ; UPDATE wp_postmeta SET meta_value = replace(meta_value,'http://kevwells.com','http://localhost'); "

/usr/bin/mysql --defaults-file=/root/.my.cnf -e "USE kevwells ; FLUSH PRIVILEGES;"



wp  cache flush --path=/var/www/wordpress  --allow-root 


mysqladmin flush-privileges



# END OF SCRIPT

