#!/bin/bash
# Script: /usr/local/bin/kevwells.com_db_replication.sh
# Date Created: 19.4.2022
# Last Modifled 28.11.2022
# Author: Kevin Wells
# Purpose: export wordpress database for kevwells.com website from NFS share on kevinvm1vpn to laptop
#          and modify database domain url from http://kevwells.com to http://localhost
# How called:  via crontab. Can also be called manually
# Requires: mysql/mariadb, mysqladmin, mysql client, ssh, ssh keys installed on server for passwordless remote command execution 
#           /root/.my.cnf  containing mysql password for root, gzip/gunzip on both machines 
# Location: asus laptop /usr/local/bin 


set -x 

# first, make sure the wordpress cache is flushed to disk:
ssh  root@kevinvm1vpn  "wp  cache flush --path=/var/www/wordpress  --allow-root "

# first delete the old .sql database file from last time:
ssh root@kevinvm1vpn  runuser -l  kevin  -c 'rm -f  /media/kevin/KEVINVM1VPN/DATAVOLUME/KEVWELLS.COM/all_databases.sql' 

#rm -f  /media/kevin/KEVINVM1VPN/DATAVOLUME/DATA/KEVWELLS.COM/all_databases.sql
 

# create the database export from server kevwells.com:

#ssh -i /root/KevinVM1.pem ubuntu@kevinvm1vpn "mysqldump   --all-databases  >   /home/kevin/DATAVOLUME/KEVWELLS.COM/all_databases.sql"

ssh root@kevinvm1vpn  "mysqldump   --all-databases  >   /home/kevin/DATAVOLUME/KEVWELLS.COM/all_databases.sql"


#ssh root@kevinvm1vpn runuser -l  kevin  -c '"mysqldump   --all-databases  >   /home/kevin/DATAVOLUME/KEVWELLS.COM/all_databases.sql"'


# next import the databases into the laptop mysql:
# no username or password needed as this is defined in the /root/.my.cnf file:

mysql <    /home/kevin/DATAVOLUME/KEVWELLS.COM/all_databases.sql

# should not be necessary, but to be on safe side:
chown  -R mysql.mysql /var/lib/mysql/kevwells

/usr/bin/mysql  -e "USE kevwells ; UPDATE wp_options SET option_value = replace(option_value, 'http://kevwells.com', 'http://localhost') WHERE option_name = 'home' OR option_name = 'siteurl'; UPDATE wp_posts SET guid = replace(guid, 'http://kevwells.com','http://localhost');  UPDATE wp_posts SET post_content = replace(post_content, 'http://kevwells.com', 'http://localhost');  UPDATE wp_postmeta SET meta_value = replace(meta_value,'http://kevwells.com','http://localhost'); FLUSH PRIVILEGES;"


/usr/local/bin/wp cache flush --path=/var/www/wordpress  --allow-root 

# then execute mysqladmin flush-privileges so the laptop mysql server reloads the grant table info:

mysqladmin flush-privileges


# finally, we can reset the permalinks to plain, we do this using the wordpress wp-cli tool:


#wp option get permalink_structure --path=/var/www/wordpress --allow-root
#this should return the following output - or similar tag category:
#/%postname%/


#wp option update permalink_structure " " --path=/var/www/wordpress --allow-root


/usr/bin/php -f /usr/local/bin/wp option update permalink_structure ' '  --path=/var/www/wordpress --allow-root

#/usr/local/bin/wp option update permalink_structure ' ' --path=/var/www/wordpress --allow-root


#this should return the following output:
#Success: Updated 'permalink_structure' option.

# wp option get permalink_structure --path=/var/www/wordpress --allow-root
#this should return the following output: (ie empty line)


# END OF SCRIPT

