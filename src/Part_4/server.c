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
