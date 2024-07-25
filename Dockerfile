FROM tiangolo/uwsgi-nginx:python3.11

ENV UWSGI_INI /app/uwsgi.ini

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


# 启动nginx和uwsgi，这里一定要加上-g，主要目的就是设置pid=1。因为docker 容器默认会把容器内部第一个进程，也就是pid=1的程序作为docker容器是否正在运行的依据，如果pid=1的程序挂了，那容器就挂了。
# ENTRYPOINT nginx -g "daemon off;" && uwsgi --ini uwsgi.ini
# CMD ["sh", "-c", "nginx ; uwsgi --ini /app/uwsgi.ini"]

# CMD ["python", "manage.py", "runserver", "0.0.0.0:8001"]
CMD ["nginx","-g","daemon off;"]

# COPY start.sh /start.sh
# RUN chmod +x /start.sh
# CMD ["sh", "-c", "nginx -g 'daemon off;'"]
# ENTRYPOINT ["/start.sh"]
