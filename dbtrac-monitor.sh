#!/bin/bash

####
# Daemon which would check if the /etc/nginx/snippets/lb.change exists and if so, remove and reload nginx config
# The script should be placed at /usr/local/bin/dbtrac-monitor.sh
####

while true
do
    if [ -f /etc/nginx/snippets/lb.change ]; then
        # Remove the triggering file
        rm /etc/nginx/snippets/lb.change
        # Restart the server
        service nginx reload
    fi
    sleep 5
done