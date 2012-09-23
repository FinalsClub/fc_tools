#!/bin/bash
# Karma Notes / Finals Club Backup Scrip (alpha v.001b
# Copyright (C) 2012  FinalsClub Foundation
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.



# usage "backup.sh [Database flag ( -m = mongodb; -p = postgres)
# Please note that "AWS_ACCESS_KEY_ID" and "AWS_SECRET_ACCESS_KEY"
# Need to be exported before running this script. Also s3cmd need to
# be configured and installed.
BUCKET=knotes_backup
DATE=`date +%Y-%m-%d`
BKUP_DIR=/var/www/uploads
TMP_DIR=/tmp/fc_bkup_stage
PKG_NAME=knotes-$DATE.tar.gz
TARGET_FILE=$TMP_DIR/djkarma-$DATE.sql
export PGPASSWORD=Beard0
export AWS_ACCESS_KEY_ID=AKIAIPJWII4LERI4ES5Q
export AWS_SECRET_ACCESS_KEY=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


# Future Script will me 100% generic.

init_env() {
	mkdir $TMP_DIR
}

copy_content() {
	
	cd $TMP_DIR
	cp -r $BKUP_DIR .
}

postgres_dump_db() {
	cd $TMP_DIR
	echo "Dumpling database...."
	pg_dumpall > $TARGET_FILE
}

pkg_up() {
	cd $TMP_DIR
	tar fczv /tmp/$PKG_NAME .

}

clean_up() {
	rm -fr $TMP_DIR
	rm -fr /tmp/*.tar.gz
}
s3_push() {
	cd $TMP_DIR
	s3cmd put /tmp/$PKG_NAME s3://$BUCKET
}

init_env
copy_content
postgres_dump_db
pkg_up
s3_push
clean_up
