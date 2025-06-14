# energy_db_automation_n8n
Aplication that runs N8N with Postgres to automate processes with energy data.

This project is meant to run 3 containers, one for N8N, one for the internal database of N8N (to store workflows) and one for the client's actual data.

All the N8N workflows are included in the folder **nun_work_flows**.
## Start

To start n8n with PostgreSQL (internal) and PostgreSQL (clients data) simply start **docker-compose by executing the following
command in the root folder of this repository**.

**IMPORTANT:** Before you do that change the default users and passwords in the [`.env`](.env) file! (Use the .env.dev as an example)

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

Done! You are ready to use N8N to work with your data! You can access it in **http://localhost:5678/**. To see what you can do inside N8N go to the section "Using N8N"

To stop it execute:

```
docker-compose stop
```
Note: **use this when testing workflows**. It does not delete the workflows in n8n and the data in the clients energy database

Or, if you want to **DELETE ALL DATA** to start all over, you must also delete the volumes (-v)

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
The default name of the database, user and password for both PostgreSQLs can be changed in the [`.env`](.env) file in the current directory.

## Testing conection to Client's Energy DB - DEV
If the Docker compose was used there will be a Postgres instance running on port 5432 of the `postgres_energy` container. The host (localhost, your machine) exposes the port 5433 and redirects it to 5432 of the `postgres_energy` container.

### Testing Outside N8N
- Host: localhost
- Database: (POSTGRES_ENERGY_DB_NAME)
- Username: (POSTGRES_ENERGY_DB_USER)
- Password: (POSTGRES_ENERGY_DB_PASSWORD)
- Port: 5433

### Testing Inside N8N
In the credentials of N8N the DB must point to the postgres_enery container, NOT localhost.
- Host: postgres_energy
- Database: (POSTGRES_ENERGY_DB_NAME)
- Username: (POSTGRES_ENERGY_DB_USER)
- Password: (POSTGRES_ENERGY_DB_PASSWORD)
- Port: 5432

# Using N8N
After you started all the containers
1. Go to **http://localhost:5678/** and set up the owner account
2. Create the credential for the Client's Postgres DB (the one that has the energy info). See the section "Testing Inside N8N"
3. Go to "Create workflow", select "Import from file" and select the workflows inside the folder **n8n_work_flows**. Do this for all Workflows
4. Done!

All the relevant information about how to test the application is **inside the workflows**! They must be executed in order for you to test the whole aplication, so look at the names in the folder **n8n_work_flows**:
1. Start with the "0___Use_after_starting_the_project__Creates_tables_and_relations.json"
2. Then run "1___Use_after_starting_the_project__Test_INSERT__SELECT_and_DELETE_into_tables.json"
3. Then ...

