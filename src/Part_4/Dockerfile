FROM nginx:latest AS build

# Установка зависимостей
RUN apt-get update && \
    apt-get install -y gcc make libfcgi-dev spawn-fcgi && \
    apt-get clean

COPY server.c /app/server.c
WORKDIR /app

# Сборка сервера
RUN gcc -o my_server server.c -lfcgi

# Финальный образ
FROM nginx:latest

# Копируем конфиги и скомпилированное приложение
COPY /nginx/nginx.conf /etc/nginx/
COPY --from=build /app/my_server /usr/local/bin/my_server

# Запуск приложения и Nginx
CMD spawn-fcgi -p 8080 /usr/local/bin/my_server && nginx -g 'daemon off;'
