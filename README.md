# Python Hello World — Docker + Jenkins

A complete, friendly, and practical README for a tiny example project that demonstrates how to write a minimal Python "Hello World" application, containerize it with Docker, and automate builds and publishing with Jenkins. This repository is intentionally small so you can learn the core steps end-to-end and adapt them to your own projects.

Why this repository exists

- Teach the basics of containerizing a Python app.
- Show a minimal Dockerfile and how to build/run images locally.
- Provide a sample Jenkins pipeline to automate image builds and pushes to Docker Hub.
- Serve as a starting point for CI/CD experiments.

What you'll find here

- helloworld.py — a one-line Python app that prints a greeting.
- Dockerfile — a small Dockerfile that packages helloworld.py into a minimal image.
- Jenkinsfile (optional) — an example Declarative Pipeline that builds and pushes the image.

Project structure

```
.
├── Dockerfile
├── Jenkinsfile     # example pipeline (optional)
└── helloworld.py
```

Getting started — local workflow

Follow these steps to run the app locally and inside Docker. Commands use your Docker Hub username assign-stone in image names; replace it if you publish under a different account.

1. Clone the repository

```
git clone https://github.com/assign-stone/python-hello-world-docker-jenkins.git
cd python-hello-world-docker-jenkins
```

2. Inspect or create the Python script

The app is intentionally tiny — a single print statement.

```
# create or overwrite helloworld.py with the one-liner
cat > helloworld.py <<'PY'
print("Hello, World from Dockerized Python App!")
PY

# verify and run locally
cat helloworld.py
python3 --version || python --version
python3 helloworld.py || python helloworld.py
```

3. Create or review the Dockerfile

A simple, efficient Dockerfile using Python slim images:

```
# Dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY helloworld.py .
CMD ["python", "helloworld.py"]
```

Build and list the image:

```
docker build -t assign-stone/pythonhelloworld:latest .
docker images | grep pythonhelloworld || true
```

4. Run the container locally

```
docker run --rm assign-stone/pythonhelloworld:latest
```

You should see:

```
Hello, World from Dockerized Python App!
```

Publishing to Docker Hub

1. Log in to Docker Hub

```
docker login
```

2. Tag and push the image (tagging is optional if you used the full name above)

```
docker tag assign-stone/pythonhelloworld:latest assign-stone/pythonhelloworld:latest
docker push assign-stone/pythonhelloworld:latest
```

3. Pull / run from another host

```
docker pull assign-stone/pythonhelloworld:latest
docker run --rm assign-stone/pythonhelloworld:latest
```

Jenkins CI — example pipeline

This repository can be built and published by Jenkins. The example Jenkinsfile below shows a minimal Declarative Pipeline that:

- checks out the repo,
- builds a Docker image and tags it with the Jenkins BUILD_NUMBER,
- pushes the image and a latest tag to Docker Hub using credentials stored in Jenkins.

Place this Jenkinsfile at the repository root so Jenkins (Multibranch Pipeline or Pipeline from SCM) can pick it up.

```groovy
pipeline {
  agent any

  environment {
    IMAGE = "assign-stone/pythonhelloworld"
    TAG   = "${env.BUILD_NUMBER}"
  }

  stages {
    stage('Checkout') { steps { checkout scm } }

    stage('Build Image') {
      steps {
        script {
          dockerImage = docker.build("${IMAGE}:${TAG}")
        }
      }
    }

    stage('Push Image') {
      steps {
        script {
          // dockerhub is a Jenkins username/password credential
          docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
            dockerImage.push()
            dockerImage.push('latest')
          }
        }
      }
    }
  }

  post {
    always { cleanWs() }
    success { echo "Image pushed: ${IMAGE}:${TAG}" }
    failure { echo 'Build or push failed' }
  }
}
```

Jenkins setup notes

- Create a Jenkins credential (Kind: Username with password) containing your Docker Hub username and password and set its ID to dockerhub.
- Ensure the Jenkins agent that runs the pipeline has Docker available (or use a Docker-enabled Jenkins agent).
- For multi-branch pipelines, enable scanning so branches with a Jenkinsfile are built automatically.

Troubleshooting tips

- If docker.build fails, ensure the agent can run Docker commands and has access to the Docker daemon.
- If docker.push fails with authentication errors, double-check the Jenkins credential ID and that it contains valid Docker Hub credentials.

Contributing

This repository is meant as an educational example. If you want to improve the README, add tests, or provide a more complete CI example (promotions, image scanning, etc.), please open a PR.

License

This example is provided under the MIT License — feel free to reuse and adapt.

Notes

- The README section above is intentionally compact and command-focused as you requested — not a full rewrite of the project description.
