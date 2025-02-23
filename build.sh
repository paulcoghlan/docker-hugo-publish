#!/bin/bash

# Server command 
# hugo server -D --bind 0.0.0.0 --source=/source --renderStaticToDisk --baseURL=$BASE_URL --appendPort=false
#
# Build command
#
hugo --source=/source  --templateMetrics --templateMetricsHints
