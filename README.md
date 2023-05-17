
# Loxone Backup

A docker image for creating and archiving daily backups of your Loxone Miniserver with added MQTT notifications.



## Usage

Pulling  `docker pull jereminius/loxonebackup:latest` should retrieve the correct image for your architecture.

Supported architectures:

| Architecture | Available |
| :----: | :----: | 
| amd64 | ✅ |
| arm64 | ✅ | 
| armv6 | ✅ |
| armv7 | ✅ |

### Environment variables

This image uses environment variables for configuration.

|Available variables     |Default value        |Required  |Description                                         |
|------------------------|---------------------|---------------------|----------------------------------------------------|
|`TZ`    |ETC           |no    |Your timezone|
|`LOXONE_ADDRESS`    |no default          |yes     |The IP address of your Loxone Miniserver|
|`LOXONE_USER`    |no default          |yes     |Your Loxone username |
|`LOXONE_PASSWORD` |no default|yes    |Your Loxone password|
|`DELETE_OLD`   |0       |no     |Number of newest archives kept. 0 = keep all archives|
|`SCHEDULE`   |weekly       |no     |CRON schedule. Accepted values: `daily`, `weekly`, `monthly` and CRON expressions (e.g., "0 1 * * *")|

Definition of the schedule values: 

`daily` - "0 1 * * *" - run every day at 01:00

`weekly` - "0 1 * * 1" - run every monday at 01:00

`monthly` - "0 1 1 * *" - run on 1st day of month at 01:00

For custom CRON expressions, you can use https://crontab.guru 
##
### Enviroment variables for configuring the MQTT message sender:

#### If you leave the `MQTT_BROKER_ADDRESS` empty, MQTT messaging will be disabled.

|Available variables     |Default value        |Required  |Description                                         |
|------------------------|---------------------|---------------------|----------------------------------------------------|
|`MQTT_BROKER_ADDRESS`    |no default           |no    |MQTT broker address|
|`MQTT_BROKER_PORT`    |1883          |no     |MQTT broker port|
|`MQTT_BROKER_USERNAME`    |no default          |no     |MQTT broker username |
|`MQTT_BROKER_PASSWORD` |no default|no    |MQTT broker password|
|`MQTT_TOPIC`   |no default       |no     |MQTT broker topic (e.g., backup/loxone)|


## Examples

### Docker run

```bash
docker run --d \
    --name loxonebackup \
    -v /path/to/backup:/backups \
    -e TZ=your_timezone \
    -e LOXONE_ADDRESS=your_loxone_miniserver_ip \
    -e LOXONE_USER=your_loxone_username \
    -e LOXONE_PASSWORD=your_loxone_password \
    -e DELETE_OLD=days_to_keep_archives \
    --restart=unless-stopped \
    jereminius/loxonebackup:latest

```
### Docker compose

```yaml
---
version: "2.1"
services:
  loxonebackup:
    image: jereminius/loxonebackup:latest
    container_name: loxonebackup
    environment:
      - TZ=your_timezone
      - LOXONE_ADDRESS=your_loxone_miniserver_ip
      - LOXONE_USER=your_loxone_username
      - LOXONE_PASSWORD=your_loxone_password
      - DELETE_OLD=days_to_keep_archives
    volumes:
      - /path/to/backup:/backups
    restart: unless-stopped
```
