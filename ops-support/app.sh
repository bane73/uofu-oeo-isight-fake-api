#! /bin/sh

### BEGIN INIT INFO
# Provides: app.rb
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: iSight-OEO app.rb
# Description: This file starts and stops app.rb daemon
# 
### END INIT INFO

case "$1" in
  start)	
    cd ~/workspace
    rvm use ruby-2.5.1    
    nohup ruby src/app.rb >> ~/ops/isight-app.log &
		#nohup java -jar ~/ops/cabinporn-parse.jar 'loop=true' 'sleepTimeMs=60000' 'pageDepthToSearch=5' 'searchWords=Brandon, Gresham, Norm, Dawn, Smith, Montana, Fortine, Lincoln, 1985' >> ~/ops/cabinporn-parse.log &
		;;
  stop)
		;;
  restart)
		;;
  *)
		echo "Oops!" >&2
		exit3
		;;
esac