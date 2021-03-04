# Debezium-TimescaleDB docker-compose playground

A docker-compose setup that is based on the [debezium tutorial repo](https://github.com/debezium/debezium-examples/tree/master/tutorial) postgres example, but replaces the postgres with postgres+timescaledb.
Has PostGIS too :P


## How to use
```
docker-compose up

# make a request to kafka-connect to create the connector

curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-postgres.json

#=> 201 Created for "inventory-connector"

# consume the kafka messages
docker-compose exec kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --property print.key=true \
    --topic dbserver1.inventory.customers

# Create a record

# Delete the connector if you want
curl -i -X DELETE -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/inventory-connector
```

The postgres container should already have timescaledb extension installed, but you can verify it:
```
postgres=# create extension if not exists timescaledb;
NOTICE:  extension "timescaledb" already exists, skipping
CREATE EXTENSION
```

Check out the debezium tutorial data (non timescale data) (it's loaded by inventory.sql)
```
```


## Tweaking postgres conf

```
docker-compose exec postgres bash
cd $PGDATA
vi postgresql.conf
```
