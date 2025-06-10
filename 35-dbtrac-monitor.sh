#!/bin/bash

####
# Monitor which look for files in /dbtrac and if found load them and restart the nginx
####

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

service nginx restart

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