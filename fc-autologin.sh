#! /bin/sh

auto_ssh() {
    host=192.168.50.6
    id=root
    pass=$3
    scripts="~/var/log/scripts/"

    expect -c "
    set timeout 10
    spawn bash -c \"ssh ${id}@${host} | tee ${scripts}`whoami`_`date '+%Y%m%d%H%M%S'`.log bash\"
    expect \"Are you sure you want to continue connecting (yse/no)?\" {
        send \"yes\n\"
        expect \"${id}@${host}'s password:\"
        send \"${pass}\n\"
    } \"${id}@${host}'s password:\" {
        send \"${pass}\n\"
    }
    interact
    "
}
