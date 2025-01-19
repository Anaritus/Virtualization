# Решение второй домашки

## Условие

<img src = "../dist/Задание 2/Задание 2.jpg">

## Решение

### Сборка сервиса:

Выбран был микросервис фронтенда, так как его код написан на Go: языке, про который я ничего не знаю. Сборка:

<img src = "../dist/Задание 2/docker build.png">

Для запуска потребовалось добавлять файл окружения, в который надо было по
одному добавлять переменную-заглушку, пока контейнер не запустился успешно(для
данного проекта их потребовалось 8). С одной стороны, очевидно не всегда имеет
смысл заставлять разработчиков задавать значения по умолчанию для переменных
окружения. С другой стороны, когда переменных десятки, очень неудобно добавлять
их по одному каждый раз запуская образ заново. Жду не дождусь узнать хорошие
способы это делать))

<img src = "../dist/Задание 2/docker run.png">

При запуске указывается файл окружения, и пробрасывается порт. Результат можно наблюдать по адресу `http://localhost:8080/`:

<img src = "../dist/Задание 2/frontend.png">

### Вытаскиваем содержимое файла

Будем вытаскивать файл `ad.html` который копируется в результате выполнения команды:

```Dockerfile
COPY ./templates ./templates
```

Первый способ: `docker cp`

<img src = "../dist/Задание 2/docker cp.png">

Второй способ: `docker export`

<img src = "../dist/Задание 2/docker export.png">

Третий способ, не работющий в данном случае: `docker exec`

Данный случай не работает, тк продакшн таргет собирается `FROM scratch`, так
что никакие команды типа `sh, cat, head`, e.t.c. не работают.

Последний способ, который здесь не включается, это изменения докерфайла
напрямую. В данном случае можно было бы добавить промежуточный таргет с базовым
линуксом, поддерживающим (в тч интерактивно) `sh`.

Не включаю данный способ здесь, тк он не подходит для уже запущенного
контейнера.