#!/bin/bash

nginx -g "daemon off;"
uwsgi --ini /app/uwsgi.ini
