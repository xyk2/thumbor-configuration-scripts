#! /bin/bash


# set default thumbor config
# thumbor-config > /etc/thumbor.conf
gsutil cp gs://startup-scripts-and-packages/thumbor.conf /etc/thumbor.conf


echo """
/var/log/nginx/access_log {
    rotate 7
    size 5k
    dateext
    dateformat -%Y-%m-%d
    missingok
    compress
    sharedscripts
    postrotate
        test -r /var/run/nginx.pid && kill -USR1 `cat /var/run/nginx.pid`
    endscript
}
""" > /etc/logrotate.d/nginx

echo """
[supervisord]
logfile=/tmp/supervisord.log ; (main log file;default $CWD/supervisord.log)
logfile_maxbytes=50MB        ; (max main logfile bytes b4 rotation;default 50MB)
logfile_backups=10           ; (num of main logfile rotation backups;default 10)
loglevel=info                ; (log level;default info; others: debug,warn,trace)
pidfile=/tmp/supervisord.pid ; (supervisord pidfile;default supervisord.pid)
nodaemon=false               ; (start in foreground if true;default false)
minfds=1024                  ; (min. avail startup file descriptors;default 1024)
minprocs=200                 ; (min. avail process descriptors;default 200)

[supervisorctl]
serverurl=unix:///tmp/supervisor.sock ; use a unix:// URL  for a unix socket

[program:thumbor]
; The following command uses a different thumbor config file for each
; processes, however we want the same setup for each so that isn't necessary
; command=thumbor --ip=127.0.0.1 --port=800%(process_num)s --conf=/etc/thumbor800%(process_num)s.conf
; Instead we'll use this command to use just the one conf file
command=/usr/local/bin/thumbor --ip=127.0.0.1 --port=800%(process_num)s --conf=/etc/thumbor.conf
process_name=thumbor800%(process_num)s
numprocs=4
autostart=true
autorestart=true
startretries=3
stopsignal=TERM
; Output logs for each of our processes
stdout_logfile=/var/log/thumbor.stdout.log
stdout_logfile_maxbytes=1MB
stdout_logfile_backups=10
stderr_logfile=/var/log/thumbor.stderr.log
stderr_logfile_maxbytes=1MB
stderr_logfile_backups=10
""" > /etc/supervisord.conf


echo """
upstream thumbor  {
    server 127.0.0.1:8000;
    server 127.0.0.1:8001;
    server 127.0.0.1:8002;
    server 127.0.0.1:8003;
}

server {
    listen       80 default_server;
    listen       [::]:80 default_server ipv6only=on;
    client_max_body_size 10M;
    merge_slashes off;

    location / {
        rewrite  ^/images/(.*) /\$1 break;

        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header HOST \$http_host;
        proxy_set_header X-NginX-Proxy true;

        proxy_pass http://thumbor/;
        proxy_redirect off;
    }
}
""" > /etc/nginx/conf.d/thumbor.conf

supervisord -c /etc/supervisord.conf
rm /etc/nginx/sites-enabled/default
/etc/init.d/nginx restart
sudo service nginx restart

