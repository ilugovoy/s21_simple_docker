FROM nginx:alpine AS build

# Установка зависимостей
RUN apt-get update && \
    apt-get install -y gcc make libfcgi-dev spawn-fcgi && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копируем файл сервера
COPY server.c /app/server.c

# Сборка сервера
RUN gcc -o my_server server.c -lfcgi


# Финальный образ
FROM nginx:alpine

# Копируем скомпилированное приложение и конфигурацию
COPY /nginx/nginx.conf /etc/nginx/
COPY --from=build /app/my_server /usr/local/bin/my_server

EXPOSE 8080

# Запуск приложения и Nginx
CMD spawn-fcgi -p 8080 /usr/local/bin/my_server && nginx -g 'daemon off;'
