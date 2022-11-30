#!/bin/sh

cd /backups

## http://stackoverflow.com/questions/113886/how-to-recursively-download-a-folder-via-ftp-on-linux 
##mirror FTP to Loxone.dum folder
echo "Starting Loxone backup"
wget --tries=2 -r -N -l inf -o wget.log ftp://$LOXONE_USER:$LOXONE_PASSWORD@$LOXONE_ADDRESS

##compress backup
echo "Compressing backup directory"
tar czf archives/dump-$(date +"%Y%m%d_%H%M%S").tar.gz $LOXONE_ADDRESS/

if [ $DELETE_OLD = 0 ]; then
	echo "Keeping all backup archives without deleting old"
else
	cd archives
	echo "Keeping $delete_old newest archives, deleting older"
	ls -tr | head -n -$DELETE_OLD | xargs --no-run-if-empty rm
fi
