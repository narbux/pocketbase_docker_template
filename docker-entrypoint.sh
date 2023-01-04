#!/usr/bin/sh

set -e

/app/pocketbase serve --http=0.0.0.0:8080 &

nginx -g 'daemon off;'