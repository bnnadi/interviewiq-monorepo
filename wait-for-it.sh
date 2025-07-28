#!/bin/bash
# wait-for-it.sh script to wait for services to be ready

set -e

host="$1"
shift
cmd="$@"

until curl -f "$host"; do
  >&2 echo "Service is unavailable - sleeping"
  sleep 1
done

>&2 echo "Service is up - executing command"
exec $cmd 