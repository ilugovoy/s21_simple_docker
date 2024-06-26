## Модуль ngx_http_stub_status_module

Модуль ngx_http_stub_status_module предоставляет доступ к основной информации о состоянии сервера.

Этот модуль по умолчанию не собирается, его сборку необходимо включить, используя параметр конфигурации *--with-http_stub_status_module*.

Пример конфигурации:
```nginx
location = /basic_status {
   stub_status;
}
```

В этой конфигурации создается простая веб-страница с базовой информацией о состоянии, которая может выглядеть так:
```c
Active connections: 291
server accepts handled requests
 16630948 16630948 31070465
Reading: 6 Writing: 179 Waiting: 106
```

```c
Активные соединения: 291
сервер принял обработал запросы
 16630948 16630948 31070465
Чтение: 6 Запись: 179 Ожидание: 106
```