#!/bin/sh

cd /usr/loxone_scheduler/backups

# Start Loxone backup
echo "[$(date +"%a %b %d %T %Y")] Starting Loxone backup"
wget --tries=2 -r -N -l inf -o wget.log ftp://$LOXONE_USER:$LOXONE_PASSWORD@$LOXONE_ADDRESS

# Check the exit status
if [ $? -eq 0 ]; then
    # Backup completed successfully
    
    echo "[$(date +"%a %b %d %T %Y")] Loxone backup completed successfully"

    # Compress backup
    echo "[$(date +"%a %b %d %T %Y")] Compressing backup directory"
    mkdir -p archives
    tar czf archives/dump-$(date +"%Y%m%d_%H%M%S").tar.gz $LOXONE_ADDRESS/

    if [ $DELETE_OLD = 0 ]; then
        echo "[$(date +"%a %b %d %T %Y")] Keeping all backup archives without deleting old"
    else
        cd archives
        echo "[$(date +"%a %b %d %T %Y")] Keeping $DELETE_OLD newest archives, deleting older"
        ls -tr | head -n -$DELETE_OLD | xargs --no-run-if-empty rm
    fi

    # Check if MQTT enabled
    if [ -n "$MQTT_BROKER_ADDRESS" ]; then
        # Send completed message
        python3 /usr/loxone_scheduler/mqtt_notifications.py "completed successfully"
    fi
else
    # Backup failed
    echo "[$(date +"%a %b %d %T %Y")] Loxone backup failed"

    # Check if MQTT enabled
    if [ -n "$MQTT_BROKER_ADDRESS" ]; then
        # Send failed message
        python3 /usr/loxone_scheduler/mqtt_notifications.py "failed"
    fi
fi
