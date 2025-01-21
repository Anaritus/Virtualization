# Решение 4 задания по виртуализации

Если все настроено правильно, то настроенные в процессе решения `actions`
должны триггериться только при коммитах в этой ветке.

# Условие

<img src = "./dist/Задание 4.jpg">

# Решение

## Первая часть, image + compose с volume

Из документации, команда для запуска образа JupyterHub достаточно данной
команды
`❯ docker run -d -p 8000:8000 --name jupyterhub quay.io/jupyterhub/jupyterhub jupyterhub`

Эта команда запустит образ `quay.io/jupyterhub/jupyterhub` (скачает если не
найдет локально), и в контейнере, вместо стандартной команды, которая в нем
прописана, выполнит `jupyterhub`. Эту информацию можно использовать для
построения простейшего докерфайла.

В команде можно указывать опции конфигурации без использования файла, так и
сделаем. Итоговый образ можно запустить так

`❯ docker run -d -p 8000:8000 -e DIRECTORY='app' som38/jupyterhub:config`

Сам образ загружен и доступен по [ссылке](https://hub.docker.com/repository/docker/som38/jupyterhub/tags/config/sha256-fc3a047477d0758ecde0d012c5ef4fba16cb06788ce48593a18233f879a51c2b).

Далее описан `compose.yml`. В нем все стадартно, отметим два момента.

Переменная `DIRECTORY` прописывается в окружении и автоматическа подтягивается
из файла `.env` --- фишка `compose`. Хотелось подключить `volume` не абы как, а
с сохранением всех данных при повторном запуске. Особенно хорошо, если
получится сохранить всех пользователей. Покопавшись в полном конфигурационном
файле было обнаружено, что директория для всех данных по умолчанию
`/user/local/share/jupyterhub`, так что подключение volume к ней и дало
желаемый результат.

Проверить работоспособность можно командой `docker compose up`, выполненной из
текущей директории. Хочу отметить, что докер иногда лукавит, когда говорит, что
успешно остановил контейнер. Так как если развернуть почти сразу после
остановки вылетатет, из за того что httpproxy служба все еще занята

## CI pipeline

Далее был реализован CI пайплайн, который чекаутит, логинится, собирает,
"тестит" (просто делает `run echo "Tests passed lol"`, даже не отдельным
файлом) и пушит в репозиторий. Action настроен тригерриться только при
пушах в ветку task4.
