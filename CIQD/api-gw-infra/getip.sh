/sbin/ifconfig wlp9s0 | grep 'inet addr' | awk '{print $2}'| cut -f2 -d:
