FROM alpine:3.6
ENTRYPOINT ["/bin/sh"]

# для корректной версии psql
RUN apk update &&  apk add 	postgresql-client

#RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list
#RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
#
#RUN apt-get update && apt-get install -y  postgresql-client-10 curl vim

# Копируем в контейнер скрипт для создания таблиц
COPY src /home/
WORKDIR /home
RUN chmod +x load_data.sh