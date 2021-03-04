#!/bin/bash
set -e
CONFIG_FILE=$PGDATA/postgresql.conf
sed -r -i "s/[#]*\s*(shared_preload_libraries)\s*=\s*'(.*)'/\1 = 'decoderbufs,wal2json,\2'/;s/,'/'/" $CONFIG_FILE
echo "wal_level = logical" >> $CONFIG_FILE
echo "max_wal_senders = 4" >> $CONFIG_FILE
echo "max_replication_slots = 4" >> $CONFIG_FILE

