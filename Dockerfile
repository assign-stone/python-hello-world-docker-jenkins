FROM python:3.12-slim

WORKDIR /app

COPY helloworld.py .

RUN pip install flask

CMD ["python", "helloworld.py"]

