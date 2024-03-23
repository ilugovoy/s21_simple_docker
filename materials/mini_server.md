## Запуск **C** кода с использованием **FastCGI** и **nginx**

Путем использования API, предоставленного заголовочным файлом <fcgiapp.h>, можно указать данные о сокете, которые создаются внешними средствами.

Дескриптор файла TCP-сокет можно получить следующим образом:
```c
`int sockfd = FCGX_OpenSocket("127.0.0.1:9000", 100);`

...или с использованием Unix-сокетов:
`int sockfd = FCGX_OpenSocket("/var/run/fcgi.sock", 100);`
```

С этим сокетом затем можно провести запись:
```c
FCGX_Request req;
FCGX_InitRequest(&req, sockfd, 0);

while (FCGX_Accept_r(&req) >= 0) {
FCGX_FPrintF(req.out, "Content-Type: text/html\n\n");
FCGX_FPrintF(req.out, "hello world");
FCGX_Finish_r(&req);
}
```

После компиляции, исполняемый файл можно запустить непосредственно, без использования *spawn-fcgi* или *cgi-fcgi*.
