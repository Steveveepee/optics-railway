#!/usr/bin/env bash
mkdir /tmp/pg_data
cd /tmp/pg_data

echo "Dumping external db to temp file"
PGPASSWORD=${RAILWAY_PGPASSWORD} pg_dump -d postgresql://${RAILWAY_PGUSER}@${RAILWAY_PGHOST}:${RAILWAY_PGPORT}/${RAILWAY_PGDATABASE} -v -f External_data.tar -F t
echo 
echo "Recreating the external db on local postgres server"
pg_restore -d postgresql://${LOCAL_PGUSER}@${LOCAL_PGHOST}:${LOCAL_PGPORT} -C -c -v  External_data.tar

cd /workspaces
rm -rf /tmp/pg_data

# testing and other variations on a theme
# https://simplebackups.com/blog/postgresql-pgdump-and-pgrestore-guide-examples/#the-postgresql-pg_dumpall-command

#psql --set ON_ERROR_STOP=on -v -U ${LOCAL_PGUSER} -h ${LOCAL_PGHOST} -p ${LOCAL_PGPORT}  -f External_data.sql postgres -1
#psql -h localhost -p 5432 template1 -c 'drop database railway'
# to connect to db in local container: psql -U postgres -h localhost -p 5432
# pg_restore -c -U ${LOCAL_PGUSER} -h ${LOCAL_PGHOST} -p ${LOCAL_PGPORT} External_data.tar
#PGPASSWORD=${RAILWAY_PGPASSWORD} pg_dumpall -v -f External_data.sql -d postgresql://${RAILWAY_PGUSER}@${RAILWAY_PGHOST}:${RAILWAY_PGPORT}