#!/bin/sh
# wait-for-postgres.sh

set -e

cmd="$@"

until pg_isready -U "$XNAT_DATASOURCE_USERNAME" -d "$XNAT_DATASOURCE_DATABASE" -h "$XNAT_DATASOURCE_HOST"; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 5
done

>&2 echo "Postgres is up - executing command \"$cmd\""
exec $cmd