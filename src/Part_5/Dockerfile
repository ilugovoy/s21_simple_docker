FROM nginx:alpine AS build
WORKDIR /app

# Установка зависимостей
RUN apt-get update && \
    apt-get install -y gcc make libfcgi-dev spawn-fcgi && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Копируем файл сервера
COPY server.c /app/server.c

# Сборка сервера
RUN gcc -o my_server server.c -lfcgi


# Финальный образ
FROM nginx:alpine
WORKDIR /app

# Создание пользователя в контейнере
RUN useradd --create-home fungusgr && \
    chown -R fungusgr /app
USER fungusgr

# Копируем скомпилированное приложение и конфигурацию
COPY /nginx/nginx.conf /etc/nginx/
COPY --from=build /app/my_server /usr/local/bin/my_server

EXPOSE 8080

HEALTHCHECK CMD curl -f http://localhost:8080/ || exit 1
# curl -f http://localhost:8080/: использует curl для попытки выполнения запроса к http://localhost:8080/
# -f означает, что запрос неудачен в случае получения ответа с кодом ошибки
# exit 1: если возвращается код ошибки, это приведет к завершению команды со статусом выхода 1, указывающим на проблему с проверкой состояния контейнера

CMD spawn-fcgi -p 8080 /app/my_server && nginx -g 'daemon off;'
