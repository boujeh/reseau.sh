#!/bin/sh

#creation of an interface file
clear
while true;
do
read -p "Do you want to create a static or dynamic interface? (s/d)" choix0 ;
case $choix0 in 
	d*|D* ) 
        read -p "Give the name of the interface ( device) :" interface ;
        NEW_NAME=/etc/sysconfig/network-scripts/ifcfg-$interface ;
        echo "The way your config interface: $NEW_NAME" ;
        touch $NEW_NAME ;
        echo "# Device Name" >> $NEW_NAME ;
        echo "DEVICE=$interface" >>$NEW_NAME ;
        while true ; 
        do
          echo "Do you want to activate at startup ? (y/n)";
          read -p "Your choice: " choix1 ;
          case $choix1 in 
        	    y*|Y*|o*|O* ) echo "#Activate at startup" >> $NEW_NAME ;
		                        echo "ONBOOT=yes" >> $NEW_NAME ; break;;
	            n*|N* ) echo "#Activate at startup" >> $NEW_NAME ;
		                  echo "ONBOOT=no" >> $NEW_NAME ; break;;
	            * ) echo "Your choice is invalid"   ;;
          esac
          done

          while true ; 
          do
          echo "It is a LAN or WAN interface? (l/w)";
          read -p "Your choice: " choix2 ;
          case $choix2 in
	          l*|L* ) echo "#Interface Name" >> $NEW_NAME ;
		                echo "NAME=lan" >> $NEW_NAME ; break;;
          	w*|W* ) echo "#Interface Name" >> $NEW_NAME ;
		                echo "NAME=wan" >> $NEW_NAME ; break;;
          	* ) echo "Your choice is invalid"  ;;
          esac
          done
          echo "Your MAC address is: "ifconfig | grep eth[0-9] | awk '{ print $NF}';
          echo "#Your MAC address is" >> $NEW_NAME ;
          ifconfig | grep eth[0-9] | awk '{ print $NF}' >> $NEW_NAME ; 

          echo "#Activating DHCP" >> $NEW_NAME ;
          echo "BOOTPROTO=dhcp" >> $NEW_NAME ;
          echo " DHCP was activate";
          sleep 2;
          while true;
          do
          read -p "You want to add a router address ( Gateway ) ? (y/n)" choix4
          case $choix4 in
            	y*|Y*|o*|O* ) echo "#Gateway Address" >> $NEW_NAME ;
	                        	read -p "Your Gateway Address is: " adresse ;
		                        echo "GATEWAY=$adresse" >> $NEW_NAME ; break ;;
	            n*|N* ) echo "No gateway address" ; break ;;
	            * ) echo "Your choice is invalid" ;;
          esac
          done
          #Interface activation
          while true; 
          do
          read -p "You want to activate your new interface? ( y / n)" activer
          case $activer in
          	y*|Y*|o*|O* ) ifup $interface ;
                    			dhclient; break ;;
          	n*|N* ) echo "Your interface and add but is not activate";
	                	echo "The way your config interface: $NEW_NAME"; break ;;
          	* ) echo "Your choice is invalid"  ;;
           esac
          done
          #cat $NEW_NAME ;
          echo "The way of your config interface is: $NEW_NAME";
          echo "Thank you !! and soon . "; break ;;
         #configuring a static interface 
      	s*|S* ) read -p "Give the name of the interface ( device) :" interface ;
                NEW_NAME=/etc/sysconfig/network-scripts/ifcfg-$interface
                echo "The way of your config interface is: $NEW_NAME" ;
                touch $NEW_NAME ;
                echo "#Device Name" >> $NEW_NAME ;
                echo "DEVICE=$interface" >>$NEW_NAME ;
                while true ; 
                do
                echo "Do you want to activate at startup ? (y/n)";
                read -p "Your choice: " choix1 ;
                case $choix1 in 
                  	y*|Y*|o*|O* ) echo "#Activate at startup" >> $NEW_NAME ;
	                        	      echo "ONBOOT=yes" >> $NEW_NAME ; break;;
                  	n*|N* ) echo "#Activate at startup" >> $NEW_NAME ;
                        		echo "ONBOOT=no" >> $NEW_NAME ; break;;
                  	* ) echo "Your choice is invalid"   ;;
                esac
                done
                while true ; 
                do
                echo "It's a LAN or WAN interface? (l/w) ";
                read -p "Your choice: " choix2 ;
                case $choix2 in
                  	l*|L* ) echo "#Device Name" >> $NEW_NAME ;
	                        	echo "NAME=lan" >> $NEW_NAME ; break;;
                  	w*|W* ) echo "#Device Name" >> $NEW_NAME ;
                        		echo "NAME=wan" >> $NEW_NAME ; break;;
                  	* ) echo "Your choice is invalid"   ;;
                esac
                done
                echo "Your MAC address is : "ifconfig | grep eth[0-9] | awk '{ print $NF}';
                echo "#Your MAC address is" >> $NEW_NAME ;
                ifconfig | grep eth[0-9] | awk '{ print $NF}' >> $NEW_NAME ; 
                #The IP address of your interface
                read -p "Give the IP address of your interface" ip
                echo "#IP interface" >> $NEW_NAME ;
                echo "IPADDR=$ip" >> $NEW_NAME ;
                #the subnet mask
                read -p "Give the subnet mask" mask
                echo "#Subnet Mask" >> $NEW_NAME ;
                echo "NETMASK=$mask" >> $NEW_NAME ;
                #ip address network
                read -p "Give the ip address network" ipr
                echo "#IP network" >> $NEW_NAME ;
                echo "NETWORK=$ipr" >> $NEW_NAME ;
                #Broadcast IP address
                read -p "Give the IP address Broadcast " ipb
                echo "#IP Broadcast" >> $NEW_NAME ;
                echo "BROADCAST=$ipb" >> $NEW_NAME ;
                #the gateway IP address
                read -p "give the gateway ip address " ipp
                echo "#the gateway ip address" >> $NEW_NAME ;
                echo "GATEWAY=$ipp" >> $NEW_NAME ;
                #activation de l'interface
                while true; 
                do
                read -p "You want to activate your new interface? ( y / n)" activer
                case $activer in
                  	y*|Y*|o*|O* ) ifup $interface ; break ;;
                  	n*|N* ) echo "Your interface and add but is not activate";
                        		echo "The chemain of your config interface: $NEW_NAME"; break ;;
                  	* ) echo "Your choice is invalid "  ;;
                esac
                done
                cat $NEW_NAME ;
                echo "Thank you !! and soon . "; break ;;
        	*) echo "Your choice is invalid " ;;
esac
done
exit 0
