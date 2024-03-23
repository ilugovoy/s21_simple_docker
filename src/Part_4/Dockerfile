FROM nginx:latest

COPY /nginx/nginx.conf /etc/nginx/
COPY server.c /app/server.c

WORKDIR /app

RUN apt-get update && \
    apt-get install -y gcc make libfcgi-dev spawn-fcgi && \
	gcc -o my_server server.c -lfcgi && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# apt-get clean: удаляет все локальные копии пакетов из папки /var/cache/apt/archives, которые больше не могут быть загружены и использованы
# rm -rf /var/lib/apt/lists/*: удаляет списки пакетов, полученные в результате обновления и установки пакетов. 
# Это помогает уменьшить количество места, занимаемое неиспользуемыми и устаревшими списками 

CMD spawn-fcgi -p 8080 /app/my_server && nginx -g 'daemon off;'
