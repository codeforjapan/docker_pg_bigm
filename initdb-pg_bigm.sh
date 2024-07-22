#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the 'template_pg_bigm' template db
"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE template_pg_bigm IS_TEMPLATE true;
EOSQL

# Load pg_bigm into both template_database and $POSTGRES_DB
for DB in template_pg_bigm "$POSTGRES_DB"; do
	echo "Loading pg_bigm extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION IF NOT EXISTS pg_bigm;
EOSQL
done
