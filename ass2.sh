#!/bin/bash
# yum list installed |  awk '{print $1}'  > packages.txt

env_setup(){
	apt list --installed |  awk '{print $1}'  > packages.txt
	systemctl list-units --type=service --all | head -n -7  | awk '{print $1}' | egrep -v '[^.a-zA-Z0-9.-]' > services.txt

	sudo apt-get install net-tools -y


	netstat -tulpn | grep LISTEN  > ports.txt
	arp -an | awk '{print $4}'  > aprovedmacs.txt
}
while true; do
	
    read -p "Do you wish to run the environment set up program(y or n)? (If you run this at first time, press y) : " yn
    case $yn in
        [Yy]* ) env_setup ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done


readarray -t packagesArrFi < packages.txt
readarray -t servicesArrFi < services.txt
readarray -t portsArrFi  <  ports.txt

#mapfile -t packageAr  < <( yum list installed |  awk '{print $1}'  )
mapfile -t packageAr  < <(  apt list --installed |  awk '{print $1}'  > packages.txt   )
mapfile -t servicesAr  < <( systemctl list-units --type=service --all | head -n -7  | awk '{print $1}' | egrep -v '[^.a-zA-Z0-9.-]'  )
mapfile -t portsAr < <(netstat -tulpn | grep LISTEN  )

for i in "${packageAr[@]}"
do
        if printf '%s\0' "${packagesArrFi[@]}" | grep -Fqxz "$i"
        then
          continue
        else
          echo 'suspecious package found :'  $i
        fi
done

for i in "${servicesAr[@]}"
do
        if printf '%s\0' "${servicesArrFi[@]}" | grep -Fqxz "$i"
        then
          continue
        else
          echo 'suspecious service found : '  $i
        fi

done

for i in "${portsAr[@]}"
do
        if printf '%s\0' "${portsArrFi[@]}" | grep -Fqxz "$i"
        then
          continue
        else
          echo 'suspecious ports found : '  $i
        fi

done

#!/bin/bash

readarray -t packagesArrFi < packages.txt
readarray -t servicesArrFi < services.txt
readarray -t portsArrFi  <  ports.txt

#	mapfile -t packageAr  < <( yum list installed |  awk '{print $1}'  )
mapfile -t packageAr  < <(  apt list --installed |  awk '{print $1}'  > packages.txt   )
mapfile -t servicesAr  < <( systemctl list-units --type=service --all | head -n -7  | awk '{print $1}' | egrep -v '[^.a-zA-Z0-9.-]'  )
mapfile -t portsAr < <(netstat -tulpn | grep LISTEN  )

for i in "${packageAr[@]}"
do
        if printf '%s\0' "${packagesArrFi[@]}" | grep -Fqxz "$i"
        then
          continue
        else
          echo 'suspecious package found :'  $i
        fi
done

for i in "${servicesAr[@]}"
do
        if printf '%s\0' "${servicesArrFi[@]}" | grep -Fqxz "$i"
        then
          continue
        else
          echo 'suspecious service found : '  $i
        fi

done

for i in "${portsAr[@]}"
do
        if printf '%s\0' "${portsArrFi[@]}" | grep -Fqxz "$i"
        then
          continue
        else
          echo 'suspecious ports found : '  $i
        fi

done

# 4th question 
curl "http://dev.virtualearth.net/REST/v1/Imagery/Map/Road/-16.9206560000013,145.777730700002/15?mapSize=500,500&key=AlYOKsYd2-Kn51Hnnws3Ua_3TMbDjlO85lMbpdi9aT92DZe8NRyteXVvhzJOlViG" > htmlmap.png

#fifth question
readarray -t arArrpFi < aprovedmacs.txt
mapfile -t arpArr  < <(   arp -an | awk '{print $4}'   )

for i in "${arpArr[@]}"
do
        if printf '%s\0' "${arArrpFi[@]}" | grep -Fqxz "$i"
        then
          continue
        else
          echo 'unaproved max is joined   : '  $i
        fi

done



