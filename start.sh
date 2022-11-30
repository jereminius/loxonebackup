#!/bin/bash

# Select the crontab file based on the environment
CRON_FILE="crontab"

echo "Loading crontab file: $CRON_FILE"

# Load the crontab file
crontab $CRON_FILE

echo "Starting cron..."

# Start cron
crond -f
