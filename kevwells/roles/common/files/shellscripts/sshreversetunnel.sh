# /usr/local/bin/sshreversetunnel.sh
##  use this command to start the sshreversetunnel between asus laptop and linux server gemini:
# using port 8080 as entry port on kevwells.com  and 8081 as entry ie linked forward port on asus.
# this means traffic to and from 8080 on gemini gets forwarded to 8081 on asus 
# #
# NOTE: to use this with http you must first start apache2 and mariadb:

# systemctl start apache2  
# systemctl start mariadb
#
#these two services are disabled in systemd to save  processor overhead and battery charge on the laptop.
# ssh must of course also be running on both machines (it usually is enabled and running by default)
#
#  to close down the tunnel, exit the ssh session, and also stop the apache2 and mariadb on asus (NOT on gemini!) 


 ssh -R 8080:127.0.0.1:8081  kevin@kevwells.com
 
#ssh -R 80:127.0.0.1:8081  kevin@kevwells.com
