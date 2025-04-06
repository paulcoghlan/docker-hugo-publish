#!/bin/bash

if [ "$HUGO_ACTION" = "serve" ]; then
    hugo server -D --bind 0.0.0.0 --source=/source --renderStaticToDisk --baseURL=$BASE_URL --appendPort=false
elif [ "$HUGO_ACTION" = "build" ]; then
    hugo server --source=/source --appendPort=false  
    # Copy over new JPG:
    gsutil -m rsync -d -r -i ./public gs://www.pixse1.com
    # Copy over HTML/CSS:
    gsutil -m rsync -d -r -x ".*\.jpg|.*\.JPG" ./public/ gs://www.pixse1.com
else
    echo "Error: HUGO_ACTION must be set to either 'serve' or 'build'"
    exit 1
fi

# Debug
# hugo --source=/source --templateMetrics --templateMetricsHints
