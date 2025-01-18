FROM python:3

WORKDIR /app

COPY ./src/hello.py hello.py

CMD ["python", "./hello.py"]
