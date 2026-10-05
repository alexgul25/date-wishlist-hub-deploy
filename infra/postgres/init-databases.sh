#!/bin/bash
# Создаёт пользователя и базу данных для каждого сервиса проекта.
#
# Официальный образ PostgreSQL выполняет скрипты из /docker-entrypoint-initdb.d
# один раз: при первом запуске с пустым каталогом данных. Чтобы выполнить
# скрипт заново, удалите том с данными: docker compose down -v

set -euo pipefail

# create_db <имя пользователя и базы> <пароль>
create_db() {
  local name="$1"
  local password="$2"

  echo "Создание пользователя и базы данных: ${name}"

  # Значения передаются как переменные psql: подстановки :"name" и :'password'
  # сами экранируют спецсимволы, поэтому в пароле допустимы любые символы.
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" \
    --set=name="$name" --set=password="$password" <<'EOSQL'
CREATE USER :"name" WITH PASSWORD :'password';
CREATE DATABASE :"name" OWNER :"name";
EOSQL
}

create_db user_svc "$USER_DB_PASSWORD"
create_db place_svc "$PLACE_DB_PASSWORD"
create_db notify_svc "$NOTIFY_DB_PASSWORD"