# Python Hello World (Docker + Jenkins)

A minimal example showing how to write a tiny Python "Hello World" script, containerize it with Docker, and run it locally. This repository contains the Jenkins pipeline configuration used to build and publish the image.

Project structure

```
.
├── Dockerfile
└── helloworld.py
```

Quick start — commands

1) Clone the example project

```
git clone https://github.com/assign-stone/pythonhelloworld.git
cd pythonhelloworld
```

2) Create the Python script (if not present)

```
touch helloworld.py
# edit and add:
# print("Hello, World from Dockerized Python App!")
cat helloworld.py
python3 --version
python3 helloworld.py
```

3) Create a Dockerfile

```
touch Dockerfile
# Dockerfile contents example:
# FROM python:3.12-slim
# WORKDIR /app
# COPY helloworld.py .
# CMD ["python", "helloworld.py"]
ls -la
```

4) Build the Docker image

```
docker build -t assign-stone/pythonhelloworld .
docker images
```

5) Push the image to Docker Hub (login required)

```
docker login
docker push assign-stone/pythonhelloworld
```

6) Pull and run the image (from another host)

```
docker pull assign-stone/pythonhelloworld
docker run --rm assign-stone/pythonhelloworld
docker ps -a
```

Expected output

```
Hello, World from Dockerized Python App!
```

Notes

- Replace "assign-stone" in the image name with your Docker Hub username if you want to publish under a different account.
- This README shows the essential commands; adapt the Dockerfile, tags, and CI pipeline to match your needs.