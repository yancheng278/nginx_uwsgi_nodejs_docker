FROM tiangolo/uwsgi-nginx:python3.11

ENV NGINX_MAX_UPLOAD 1m
ENV LISTEN_PORT 8080
# ENV UWSGI_INI /app/uwsgi.ini

VOLUME ["/app","/var/www"]
WORKDIR /app

COPY ./requirements.txt /app/requirements.txt
RUN curl -sSLk https://deb.nodesource.com/setup_current.x | bash - \
 && apt-get -y update \ 
 && apt-get -y install nodejs \
 && apt-get clean all \
 && pip install --no-cache-dir --upgrade -r /app/requirements.txt


EXPOSE 8080

CMD ["python", "manage.py", "runserver", "0.0.0.0:8001"]
