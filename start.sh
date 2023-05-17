#!/bin/bash

# Define the cron schedule based on the SCHEDULE environment variable
case "$SCHEDULE" in
  "daily")
    CRON_EXPRESSION="0 1 * * *"
    ;;
  "weekly")
    CRON_EXPRESSION="0 1 * * 1"
    ;;
  "monthly")
    CRON_EXPRESSION="0 1 1 * *"
    ;;
  *)
    CRON_EXPRESSION="$SCHEDULE"
    ;;
esac

# Set the cron schedule and command
CRON_JOB="$CRON_EXPRESSION /usr/loxone_scheduler/loxone_backup.sh"

# Write the cron job to a temporary file
echo "$CRON_JOB" > /tmp/cron_job

# Load the cron job from the temporary file
crontab /tmp/cron_job

# Remove the temporary file
rm /tmp/cron_job

# Start cron in the foreground
echo "[$(date +"%a %b %d %T %Y")] Starting cron..."
exec crond -f
