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

# Port where the Django app runs
EXPOSE 8000

# Populate database and start server
CMD python3 manage.py migrate; python3 manage.py collectstatic --no-input; python3 manage.py loaddata website/fixtures/initial.json; gunicorn mywebsite.wsgi --bind 0.0.0.0:8000