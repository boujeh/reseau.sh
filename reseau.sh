#!/bin/sh

#creation d'un fichier interface
clear
while true;
do
read -p " voulez-vous crée une interface statique ou dynamique ? (s/d)" choix0 ;
case $choix0 in 
	d*|D* ) 
        read -p "donner le nom de l'interface (périphérique): " interface ;
        NEW_NAME=/etc/sysconfig/network-scripts/ifcfg-$interface ;
        echo " le chem1 de votre interface est: $NEW_NAME" ;
        touch $NEW_NAME ;
        echo "# Nom du périphérique" >> $NEW_NAME ;
        echo "DEVICE=$interface" >>$NEW_NAME ;
        while true ; 
        do
          echo "Voulez-vous activer au démarage ? (y/n)";
          read -p "Votre choix: " choix1 ;
          case $choix1 in 
        	    y*|Y*|o*|O* ) echo "#Activation au démarage" >> $NEW_NAME ;
		                        echo "ONBOOT=yes" >> $NEW_NAME ; break;;
	            n*|N* ) echo "#Activation au démarage" >> $NEW_NAME ;
		                  echo "ONBOOT=no" >> $NEW_NAME ; break;;
	            * ) echo "Votre choix n'est pas valide "   ;;
          esac
          done

          while true ; 
          do
          echo "c'est une interface LAN ou WAN ? (l/w) ";
          read -p "Votre choix: " choix2 ;
          case $choix2 in
	          l*|L* ) echo "#Non de l'interface" >> $NEW_NAME ;
		                echo "NAME=lan" >> $NEW_NAME ; break;;
          	w*|W* ) echo "#Nom de l'interface" >> $NEW_NAME ;
		                echo "NAME=wan" >> $NEW_NAME ; break;;
          	* ) echo "Votre choix n'est pas valide "  ;;
          esac
          done
          echo "votre adresse MAC est: "ifconfig | grep eth[0-9] | awk '{ print $NF}';
          echo "#Adresse MAC de l'interface" >> $NEW_NAME ;
          ifconfig | grep eth[0-9] | awk '{ print $NF}' >> $NEW_NAME ; 

          echo "#Activation du DHCP" >> $NEW_NAME ;
          echo "BOOTPROTO=dhcp" >> $NEW_NAME ;
          echo " Le protocole DHCP a été activer";
          sleep 2;
          while true;
          do
          read -p " voulez vous ajouter une adresse de routeur (Gateway) ?(y/n)" choix4
          case $choix4 in
            	y*|Y*|o*|O* ) echo "#Adresse du Gateway" >> $NEW_NAME ;
	                        	read -p "votre adresse de gateway: " adresse ;
		                        echo "GATEWAY=$adresse" >> $NEW_NAME ; break ;;
	            n*|N* ) echo "pas d'adresse de gateway" ; break ;;
	            * ) echo "Votre choix n'est pas valide " ;;
          esac
          done
          #activation de l'interface
          while true; 
          do
          read -p "voulez vous activer votre nouvelle interface ? (y/n)" activer
          case $activer in
          	y*|Y*|o*|O* ) ifup $interface ;
                    			dhclient; break ;;
          	n*|N* ) echo "votre interface et ajouter mais n'est pas activer";
	                	echo "le chemain du votre config interface est: $NEW_NAME"; break ;;
          	* ) echo "Votre choix n'est pas valide "  ;;
           esac
          done
          #cat $NEW_NAME ;
          echo "le chemain du votre config interface est $NEW_NAME";
          echo "Merci !! et a bientôt. "; break ;;
         #configuration d'une interface statique 
      	s*|S* ) read -p "donner le nom de l'interface (périphérique): " interface ;
                NEW_NAME=/etc/sysconfig/network-scripts/ifcfg-$interface
                echo " le chem1 de votre interface est: $NEW_NAME" ;
                touch $NEW_NAME ;
                echo "# Nom du périphérique" >> $NEW_NAME ;
                echo "DEVICE=$interface" >>$NEW_NAME ;
                while true ; 
                do
                echo "Voulez-vous activer au démarage ? (y/n)";
                read -p "Votre choix: " choix1 ;
                case $choix1 in 
                  	y*|Y*|o*|O* ) echo "#Activation au démarage" >> $NEW_NAME ;
	                        	      echo "ONBOOT=yes" >> $NEW_NAME ; break;;
                  	n*|N* ) echo "#Activation au démarage" >> $NEW_NAME ;
                        		echo "ONBOOT=no" >> $NEW_NAME ; break;;
                  	* ) echo "Votre choix n'est pas valide "   ;;
                esac
                done
                while true ; 
                do
                echo "c'est une interface LAN ou WAN ? (l/w) ";
                read -p "Votre choix: " choix2 ;
                case $choix2 in
                  	l*|L* ) echo "#Non de l'interface" >> $NEW_NAME ;
	                        	echo "NAME=lan" >> $NEW_NAME ; break;;
                  	w*|W* ) echo "#Nom de l'interface" >> $NEW_NAME ;
                        		echo "NAME=wan" >> $NEW_NAME ; break;;
                  	* ) echo "Votre choix n'est pas valide "  ;;
                esac
                done
                echo "votre adresse MAC est: "ifconfig | grep eth[0-9] | awk '{ print $NF}';
                echo "#Adresse MAC de l'interface" >> $NEW_NAME ;
                ifconfig | grep eth[0-9] | awk '{ print $NF}' >> $NEW_NAME ; 
                #l'adresse ip de votre interface
                read -p "donnez l'adresse ip de votre interface" ip
                echo "#IP de linterface" >> $NEW_NAME ;
                echo "IPADDR=$ip" >> $NEW_NAME ;
                #le masque de sous réseau
                read -p "donnez le masque de sous réseau" mask
                echo "#Masque de sous réseau" >> $NEW_NAME ;
                echo "NETMASK=$mask" >> $NEW_NAME ;
                #l'adresse ip de réseau
                read -p "donnez l'adresse ip de réseau " ipr
                echo "#IP de réseau" >> $NEW_NAME ;
                echo "NETWORK=$ipr" >> $NEW_NAME ;
                #l'adresse ip Broadcast
                read -p "donnez l'adresse ip Broadcast " ipb
                echo "#IP de Broadcast" >> $NEW_NAME ;
                echo "BROADCAST=$ipb" >> $NEW_NAME ;
                #l'adresse ip passerelle
                read -p "donnez l'adresse ip passerelle " ipp
                echo "#IP de passerelle" >> $NEW_NAME ;
                echo "GATEWAY=$ipp" >> $NEW_NAME ;
                #activation de l'interface
                while true; 
                do
                read -p "voulez vous activer votre nouvelle interface ? (y/n)" activer
                case $activer in
                  	y*|Y*|o*|O* ) ifup $interface ; break ;;
                  	n*|N* ) echo "votre interface et ajouter mais n'est pas activer";
                        		echo "le chemain du votre config interface est: $NEW_NAME"; break ;;
                  	* ) echo "Votre choix n'est pas valide "  ;;
                esac
                done
                cat $NEW_NAME ;
                echo "Merci !! et a bientôt. "; break ;;
        	*) echo "votre choix n'est valide" ;;
esac
done
exit 0
