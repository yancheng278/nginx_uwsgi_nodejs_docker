FROM tiangolo/uwsgi-nginx:python3.11

VOLUME ["/app","/var/www"]
WORKDIR /app

COPY ./requirements.txt /app/requirements.txt
RUN curl -sSLk https://deb.nodesource.com/setup_current.x | bash - \
 && apt-get -y update \ 
 && apt-get -y install nodejs \
 && apt-get clean all \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && echo 'Asia/Shanghai' >/etc/timezone \
 && pip install --no-cache-dir --upgrade -r /app/requirements.txt

CMD nginx ; uwsgi --ini /app/uwsgi.ini
