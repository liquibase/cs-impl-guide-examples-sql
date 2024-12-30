echo 
echo "*** Attempt to drop postgres-dev, postgres-qa and postgres-prod containers ... ok to fail if these did not previously exists."
docker rm -f postgres-dev
docker rm -f postgres-qa
docker rm -f postgres-prod

echo
echo "*** Pull latest docker images for postgres ..."
docker pull postgres

echo
echo "*** Starting postgres-dev ... "
docker run \
    --name postgres-dev \
    -p 5433:5432 \
    -e POSTGRES_PASSWORD=secret \
    -d postgres

echo "*** Starting postgres-qa ... "
docker run \
    --name postgres-qa \
    -p 5434:5432 \
    -e POSTGRES_PASSWORD=secret \
    -d postgres

echo "*** Starting postgres-prod ... "
docker run \
    --name postgres-prod \
    -p 5435:5432 \
    -e POSTGRES_PASSWORD=secret \
    -d postgres

echo
echo "*** Sleeping for 20 seconds ... before postgres databases starts up."
echo "*** May need to sleep longer if you receive this error: \"connection to server on socket\""
sleep 20


# docker exec \
#     -it \
#     postgres-dev \
#     /bin/bash -c "psql -U postgres -a -c 'CREATE SCHEMA dvdrental AUTHORIZATION postgres;'"

echo
echo "*** Setting up dvdrental schema on postgres-dev ... "
docker exec \
    -it \
    postgres-dev \
    /bin/bash -c "psql -U postgres -a -c 'CREATE SCHEMA dvdrental AUTHORIZATION postgres;'"

echo "*** Setting up dvdrental schema on postgres-qa ... "
docker exec \
    -it \
    postgres-qa \
    /bin/bash -c "psql -U postgres -a -c 'CREATE SCHEMA dvdrental AUTHORIZATION postgres;'"

echo "*** Setting up dvdrental schema on postgres-prod ... "
docker exec \
    -it \
    postgres-prod \
    /bin/bash -c "psql -U postgres -a -c 'CREATE SCHEMA dvdrental AUTHORIZATION postgres;'"

