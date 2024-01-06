# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.10-slim

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Copy in requirements.txt
COPY requirements.txt ./

# Install requirements
RUN pip install -r requirements.txt

# Copy in everything else
COPY . ./

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD gunicorn --bind 0.0.0.0:${PORT-8000} optics.wsgi