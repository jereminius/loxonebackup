# Loxone Backup

It is a tool for making and archiving daily backups of your Loxone Miniserver.

# How to use?
## Docker
```console
docker run --d \
    -v /path/to/backup:/backups \
    -e LOXONE_ADDRESS=your_loxone_miniserver_ip \
    -e LOXONE_USER=your_loxone_username \
    -e LOXONE_PASSWORD=your_loxone_password \
    -e DELETE_OLD=days_to_keep_archives \
    --restart=unless-stopped \
    --name loxonebackup \
     jereminius/loxonebackup:latest
```
## Environment variables

This image uses environment variables for configuration.

|Available variables     |Default value        |Description                                         |
|------------------------|---------------------|----------------------------------------------------|
|`LOXONE_ADDRESS`    |no default           |The IP address of your Loxone Miniserver|
|`LOXONE_USER`    |no default           |Your Loxone username |
|`LOXONE_PASSWORD` |no default|Your Loxone password|
|`DELETE_OLD`   |no default           |Number of newest archives kept. 0 = keep all archives|

# Additional Information

The backup runs every day at 01:00, you can change the schedule by modifying the `crontab` file.
