# SQL Final
### Netology Data Science
This repo contains dockerfile and docker-compose file for postgres db (host and client) and SQL queries.

To start - export data from archive to ./data folder and run:
```bash
docker-compose up -d
docker-compose exec client sh
./load_data.sh (inside container)
```
You will find queries in /home/queries of client container