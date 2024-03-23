#!/bin/bash

# Обновление списка пакетов в контейнере
apt-get update

# Установка необходимых пакетов для компиляции и работы с FastCGI
apt-get install -y gcc make libfcgi-dev spawn-fcgi

# Создание директории для исходного кода веб-сервера и переход в нее
mkdir /app
cd /app

# Содержимое исходного кода веб-сервера
echo '
#include <fcgi_stdio.h> /// упрощает работу с операциями ввода-вывода с интерфейсом, как в stdio.h
#include <fcgiapp.h> /// набор функций для работы с запросами, управления параметрами, заголовками и тд

/**
* @file main.c
* @brief Мини-веб сервер на основе FastCGI
* 
* Мини-веб сервер на FastCGI с возможностью обработки веб-запросов и возвращения HTML-страницы
*/

int main(void) {
   while (FCGI_Accept() >= 0) {
       printf("Content-type: text/html\r\n\r\n"); // Указание типа контента для HTML страницы
       printf("<html><head><title>Hello, World!</title></head><body>"); // Открытие HTML тегов для формирования страницы
       printf("<h1>Hello, World!</h1>"); // Отображение заголовка "Hello, World!"
       printf("</body></html>"); // Закрытие HTML тегов
   }
   return 0;
}
' > server.c

# Компиляция исходного кода веб-сервера на C с FastCGI
gcc -o my_server server.c -lfcgi

# Запуск FastCGI-сервера в фоновом режиме
spawn-fcgi -p 8080 /app/my_server
