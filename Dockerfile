FROM python:3.12-slim

WORKDIR /app

# Install Flask
RUN pip install --no-cache-dir flask

COPY helloworld.py .

# Expose Flask port
EXPOSE 5000

CMD ["python", "helloworld.py"]
