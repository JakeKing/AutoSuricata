#SuriKill - kill a suricata process quickly and efficiently.
#run as sudo!
#Ubuntu 12.04 - but should run on anything with /var/run/$process.pid
PIDFILE=/var/run/suricata.pid
PID=$(cat $PIDFILE)
kill -9 $PID
