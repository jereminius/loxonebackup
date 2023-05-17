FROM alpine:3.18

RUN apk add --update --no-cache bash wget tzdata

# Install python/pip
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools paho-mqtt

WORKDIR /usr/loxone_scheduler

# Loxone backup configuration
ENV TZ=UTC
ENV LOXONE_ADDRESS=
ENV LOXONE_USER=
ENV LOXONE_PASSWORD=
ENV DELETE_OLD=0
ENV SCHEDULE=weekly

# MQTT Broker configuration
ENV MQTT_BROKER_ADDRESS=
ENV MQTT_BROKER_PORT=1883
ENV MQTT_BROKER_USERNAME=
ENV MQTT_BROKER_PASSWORD=
ENV MQTT_TOPIC=

# Copy necessary files
COPY start.sh .
COPY loxone_backup.sh .
COPY mqtt_notifications.py .

RUN chmod +x start.sh loxone_backup.sh mqtt_notifications.py

RUN mkdir -p /usr/loxone_scheduler/backups

# Create cron.log file
RUN touch /var/log/cron.log

# Run cron on container startup
CMD ["/bin/sh", "./start.sh"]
