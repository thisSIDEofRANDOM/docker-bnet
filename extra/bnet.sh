#!/bin/bash
do_winecfg=false
while [ -n "${1:-}" ]; do
   case "${1:-}" in
     --winecfg)
        do_winecfg=true
        ;;
   esac
   shift
done

trap "exit" INT

$do_winecfg && (winecfg ; wineserver -kw; sleep 1)

if [ -f "${HOME}/.wine/drive_c/Program Files/Battle.net/Battle.net Launcher.exe" ]; then
    wine "${HOME}/.wine/drive_c/Program Files/Battle.net/Battle.net Launcher.exe"
else
    wine /opt/bnet/bnet.exe
fi
started=0;
s=1
cnt=0
while :; do
    sleep $s
    pidof "Battle.net Helper.exe" >/dev/null
    r=$?
    if [ $started -eq 0 ] && [ $r -eq 0 ]; then
        echo "====== bnet.exe has started."
        started=1
        s=3
    elif [ $started -eq 1 ] && [ $r -eq 1 ]; then
        echo "====== shuting down"
        wineserver -kw
        exit
    fi

    if [ $started -eq 0 ] && [ $r -eq 1 ]; then
	((cnt+=1))
	echo "Waiting for ${cnt} seconds..."
	if [ $cnt -gt 5 ]; then
	    echo "====== took more than 5s to start, exiting"
	    wineserver -kw
	    exit
        fi
    fi
done
