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

You must see in the terminal
```
[+] Running 7/7
 ✔ Network energy_db_automation_n8n_default              Created                                                                                                                            0.1s 
 ✔ Volume "energy_db_automation_n8n_n8n_storage"         Created                                                                                                                            0.0s 
 ✔ Volume "energy_db_automation_n8n_energy_db_storage"   Created                                                                                                                            0.0s 
 ✔ Volume "energy_db_automation_n8n_db_storage"          Created                                                                                                                            0.0s 
 ✔ Container energy_db_automation_n8n-postgres_energy-1  Started                                                                                                                            0.7s 
 ✔ Container energy_db_automation_n8n-postgres-1         Healthy                                                                                                                            6.3s 
 ✔ Container energy_db_automation_n8n-n8n-1              Started  
```

To stop it execute:

```
docker-compose stop
```
Note: **use this when testing workflows**. It does not delete the workflows in n8n and the data in the clients energy database

Or, if you want to delete ALL DATA it to start all over, you must also delete the volumes (-v)

```
docker-compose down -v
```
Note: **never use this in production**. It deletes the Databases!

and with the comand above you must see
```
[+] Running 7/7
 ✔ Container energy_db_automation_n8n-n8n-1              Removed                                                                                                                            0.6s 
 ✔ Container energy_db_automation_n8n-postgres_energy-1  Removed                                                                                                                            0.6s 
 ✔ Container energy_db_automation_n8n-postgres-1         Removed                                                                                                                            0.4s 
 ✔ Volume energy_db_automation_n8n_db_storage            Removed                                                                                                                            0.1s 
 ✔ Volume energy_db_automation_n8n_n8n_storage           Removed                                                                                                                            0.1s 
 ✔ Volume energy_db_automation_n8n_energy_db_storage     Removed                                                                                                                            0.1s 
 ✔ Network energy_db_automation_n8n_default              Removed 
```


## Configuration

The default name of the database, user and password for PostgreSQL can be changed in the [`.env`](.env) file in the current directory.

## Testing conection to Client's Energy DB - DEV
If the Docker compose was used there will be a Postgres instance running on port 5432 of the `postgres_energy` container. The host (localhost) exposes the port 5433 and redirects it to 5432 of the `postgres_energy` container.

### Outside N8N
Host: localhost
Database: (POSTGRES_ENERGY_DB_NAME)
Username: (POSTGRES_ENERGY_DB_USER)
Password: (POSTGRES_ENERGY_DB_PASSWORD)
Port: 5433

### Inside N8N
In the credentials of N8N the DB must point to the postgres_enery container, NOT localhost.
Host: postgres_energy
Database: (POSTGRES_ENERGY_DB_NAME)
Username: (POSTGRES_ENERGY_DB_USER)
Password: (POSTGRES_ENERGY_DB_PASSWORD)
Port: 5432



