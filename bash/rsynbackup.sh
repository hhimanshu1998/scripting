#!/bin/sh
#Sample script to mirror data to anothe drive

#Replace excludefoldername and maindrive
storage=($(ls -I excludefoldername /maindrive/ | sort -f))
number=($(ls -I excludefoldername /maindrive/ | sort -f| wc -l))

#Replace serverip with your file server's ip
for ((i = 0; i <= ${number}; i++)); do
	rsync -uarz root@serverip[]:/maindrive/${storage[i]}/ /backupdrive/${storage[i]}/
	chmod -R 775 /backupdrive/${backupstorage[i]}
done
