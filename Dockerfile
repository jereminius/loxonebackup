FROM alpine:3.17

# Install required packages
RUN apk add --update --no-cache bash dos2unix   \
        wget  \
        tzdata
RUN apk update

WORKDIR /usr/loxone_scheduler

ENV TZ=UTC
ENV LOXONE_ADDRESS=
ENV LOXONE_USER=
ENV LOXONE_PASSWORD=
ENV DELETE_OLD=

# Copy files
COPY crontab .
COPY start.sh .
COPY loxone_backup.sh .

# Fix line endings && execute permissions
RUN dos2unix crontab \
    && \
    find . -type f -iname "*.sh" -exec chmod +x {} \;

# create cron.log file
RUN touch /var/log/cron.log

# Run cron on container startup
CMD ["./start.sh"]
