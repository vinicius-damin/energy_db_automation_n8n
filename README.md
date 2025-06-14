# energy_db_automation_n8n
N8N with Postgres to automate processes with data


# n8n with PostgreSQL

Starts n8n with PostgreSQL as database.

## Start

To start n8n with PostgreSQL simply start docker-compose by executing the following
command in the current folder.

**IMPORTANT:** But before you do that change the default users and passwords in the [`.env`](.env) file!

```
docker-compose up -d
```

To stop it execute:

```
docker-compose stop
```

or, if you want to delete it to start all over, you must also delete the volumes

```
docker-compose down -v
```

## Configuration

The default name of the database, user and password for PostgreSQL can be changed in the [`.env`](.env) file in the current directory.