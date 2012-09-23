#!/bin/bash

# DjKarma start / stop script. This script should be run as NON-ROOT! unless you are
# STOPPING !!!!
SRC_ROOT=/var/www/djKarma
GU_LOGS=/var/log/gunicorn/error.log
GU_ACCESS_LOGS=/var/log/gunicorn/access.log
GU_PID=/var/run/gunicorn/run.pid
WORKER_PS=3
WORKER_TYPE=sync
LOCAL_ADDRESS=127.0.0.1:7000

start()
{
	cd $SRC_ROOT
	./manage.py run_gunicorn -b $LOCAL_ADDRESS -w $WORKER_PS -k $WORKER_TYPE -t 30 -p $GU_PID --access-logfile $GU_ACCESS_LOGS --log-file $GU_LOGS
}
stop()
{
	if [ "$(id -u)" = "0" ]; then
   		echo "This must be run as Sudo / Root! You are killing a process!" 1>&2
   		exit 1
	fi
	kill -9 $GU_PID
	rm -fr $GU_PID
}

case "$1" in
    start)
        start
    ;;

    stop)
        stop
    ;;
esac
