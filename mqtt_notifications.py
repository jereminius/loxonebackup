#!/usr/bin/env python3

import os
import sys
import datetime
import paho.mqtt.publish as publish

# Get from ENV variables
mqtt_broker_address = os.getenv("MQTT_BROKER_ADDRESS")
mqtt_broker_port = os.getenv("MQTT_BROKER_PORT")
mqtt_broker_username = os.getenv("MQTT_BROKER_USERNAME")
mqtt_broker_password = os.getenv("MQTT_BROKER_PASSWORD")
mqtt_topic = os.getenv("MQTT_TOPIC")

# Check if MQTT broker address is defined - else disable
if mqtt_broker_address and mqtt_topic:
    mqtt_credentials = None
    if mqtt_broker_username and mqtt_broker_password:
        mqtt_credentials = {'username': mqtt_broker_username, 'password': mqtt_broker_password}

    # Publish MQTT message
    current_datetime = datetime.datetime.now().strftime("%a %b %d %H:%M:%S %Y")
    message_datetime = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    backup_status = sys.argv[1]
    message = f"[{current_datetime}] Backup {backup_status} at: {current_datetime}"

    try:
        publish.single(mqtt_topic, message, hostname=mqtt_broker_address, port=int(mqtt_broker_port),
                       auth=mqtt_credentials)
        print(f"[{current_datetime}] MQTT message sent successfully")
    except Exception as e:
        print(f"[{current_datetime}] Error sending MQTT message: {str(e)}")
else:
    print(f"[{current_datetime}] MQTT broker address not defined. Skipping MQTT notification.")
