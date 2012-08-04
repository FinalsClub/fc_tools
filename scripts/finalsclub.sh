#!/bin/bash

# Finalsclub start/stop script Alpha 0.01.
#
# Copyright (C) 2012  Robert Call <bob@finalsclub.org>
# Copyright (c) 2012 Finalsclub Foundation

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

start() {

	echo "starting Finals Club..."
	cd /var/www/FinalsClub/etherpad-lite/node
	forever server.js &> log.txt &
	cd /var/www/FinalsClub/
	if [ "$(id -u)" != "0" ]; then
        ## note: start as root, pass env vars to sudo param, this app will downgrade itself onc$
        	sudo -E forever app.js &> log.txt &
		else
        	forever app.js &> log.txt &
	fi

}

kill_prod() {
	killall node
}

case "$1" in
        start)
                echo "Starting production..."
		start
                ;;

	stop)
		echo "Killing prod server..."
		kill_prod
		;;
	*)

		echo "djkarma (start|stop|beta|stop_beta)"
		;;
esac

