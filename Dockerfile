# Use official Python base image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Copy local code to the container
COPY helloworld.py .

# Command to run the app
CMD ["python", "helloworld.py"]
