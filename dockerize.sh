#!/bin/bash

echo "Esperando o banco ficar disponível..."

while ! nc -z db 3306; do
  sleep 1
done

echo "Banco está pronto. Iniciando Django..."

exec "$@"
