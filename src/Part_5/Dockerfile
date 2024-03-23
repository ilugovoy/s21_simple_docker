FROM nginx:latest

COPY /nginx/nginx.conf /etc/nginx/
COPY server.c /app/server.c

WORKDIR /app

RUN apt-get update && \
    apt-get install -y gcc make libfcgi-dev spawn-fcgi && \
	gcc -o my_server server.c -lfcgi && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Создание пользователя в контейнере
RUN useradd --create-home fungusgr && \
    chown -R fungusgr /app
USER fungusgr

HEALTHCHECK CMD curl -f http://localhost:8080/ || exit 1
# curl -f http://localhost:8080/: использует curl для попытки выполнения запроса к http://localhost:8080/
# -f означает, что запрос неудачен в случае получения ответа с кодом ошибки
# exit 1: если возвращается код ошибки, это приведет к завершению команды со статусом выхода 1, указывающим на проблему с проверкой состояния контейнера

CMD spawn-fcgi -p 8080 /app/my_server && nginx -g 'daemon off;'
