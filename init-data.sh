# This file is executed by the entrypoint of Postgres in the first time the volume is created
#!/bin/bash

# ----------------------------- For linux -----------------------------
# set -e;

# if [ -n "${POSTGRES_NON_ROOT_USER:-}" ] && [ -n "${POSTGRES_NON_ROOT_PASSWORD:-}" ]; then
# 	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
# 		CREATE USER ${POSTGRES_NON_ROOT_USER} WITH PASSWORD '${POSTGRES_NON_ROOT_PASSWORD}';
# 		GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_DB} TO ${POSTGRES_NON_ROOT_USER};
# 		GRANT CREATE ON SCHEMA public TO ${POSTGRES_NON_ROOT_USER};
# 	EOSQL
# else
# 	echo "SETUP INFO: No Environment variables given!"
# fi
# ---------------------------------------------------------------------------------------


# ----------------------------- For Windows with Docker Desktop -----------------------------
# Save this file to LF and save
# Explanation: Postgres entrypoint executes only scripts with the shebang #!/bin/bash is pure LF
set -e

if [[ -n "${POSTGRES_NON_ROOT_USER}" && -n "${POSTGRES_NON_ROOT_PASSWORD}" ]]; then
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Identificadores entre aspas para permitir nomes que começam por número
    CREATE USER "${POSTGRES_NON_ROOT_USER}" WITH PASSWORD '${POSTGRES_NON_ROOT_PASSWORD}';
    GRANT ALL PRIVILEGES ON DATABASE "${POSTGRES_DB}" TO "${POSTGRES_NON_ROOT_USER}";
    GRANT CREATE ON SCHEMA public TO "${POSTGRES_NON_ROOT_USER}";
EOSQL
else
  echo "SETUP INFO: Environment variables POSTGRES_NON_ROOT_* not defined!"
fi
# ---------------------------------------------------------------------------------------