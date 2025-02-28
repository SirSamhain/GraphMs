FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get install -y python3-pip python-dev gunicorn

# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip3 install -r requirements.txt

COPY . /app
WORKDIR /app/src
RUN ls

EXPOSE 8000
CMD [ "gunicorn", "--config", "./gunicorn_config.py", "app:app" ]