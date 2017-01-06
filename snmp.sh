





yum install net-snmp net-snmp-utils

mv /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.bak && touch snmpd.conf

vim /etc/snmp/snmpd.conf
	#statements



	#statements

com2sec notConfigUser  default       fc_monitor_snmp
group   notConfigGroup v1            notConfigUser
group   notConfigGroup v2c           notConfigUser
view    all            included   .1        80
access  notConfigGroup ""         any       noauth    prefix all all all
rouser prtg auth
createUser prtg MD5 @Ce671209


service snmpd restart && service snmpd stop && net-snmp-create-v3-user -ro -A MD5 -a wj062jo4ck6yji4 snmpv3 && service snmpd start


-A INPUT -s 172.246.236.18/32 -p tcp --dport 80 -j ACCEPT
-A INPUT -s 118.163.154.49/32 -p tcp --dport 80 -j ACCEPT