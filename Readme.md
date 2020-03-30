## Pour Rasbian/Debian : Procedure d'installation d'un Stick 3G Huawei.

1. Mise à jour.

	sudo apt update  
	sudo apt upgrade

2. Installer usb-modeswitch

	apt-get install ppp usb-modeswitch usb-modeswitch-data

3. Creer un fichier nomé "12d1:1f01" dans /etc/usb_modeswitch.d

	sudo nano 12d1:1f01

y coller le contenu suivant:
plusieurs modes sont disponnibles, seul le dernier nous interesse.


#Huawei E3531i-2 switch mode vers 12d1:1001 (mode GSM modem, 3 ports)  
#TargetVendor=0x12d1  
#Targetproduct=0x1f01  
#DefaultVendor= 0x12d1  
#DefaultProduct=0x157d  
#MessageContent="55534243123456780000000000000011062000000100000000000000000000"  
#NoDriverLoading=1  

#Huawei E3531i-2 switch mode vers WWAN mode 12d1:155e  
#TargetVendor=0x12d1  
#TargetProduct=0x155e  
#DefaultVendor= 0x12d1  
#DefaultProduct=0x157d  
#MessageContent="55534243123456780000000000000011063000000100010000000000000000"  

#Broadband modem mode 12d1:1442  
#TargetProduct=0x1442  
#MessageContent="55534243000000000000000000000011060000000000000000000000000000"  
#"ethernet" mode  

#Huawei E3531 mode internet  
DefaultVendor= 0x12d1  
DefaultProduct=0x157d  
TargetVendor=0x12d1  
TargetProductList="14db,14dc"  
HuaweiNewMode=1  


4. Pour basculer la clef 
* manuellement: 

	usb_modeswitch -c /etc/usb_modeswitch.d/12d1:1f01

* automatiquement a l'aide du script:

	start_huawei.sh  (le rendre executable avant si besoin "sudo chmod +x start_huawei.sh")

5. Pour l'executer au demarrage:

 
	cd /etc/xdg/lxsession/LXDE-pi/

	sudo nano autostart

ajouter:

	@/home/pi/start_huawei.sh (adapter le chemin a la config)

6. Pour verifier que la clef a bien changé de mode:

	lsusb

=> Bus 001 Device 015: ID 12d1:14dc Huawei Technologies Co., Ltd.HSPA +, USB, HSUPA, Edge/GPRS, Modem/Networkcard

-----------------

## Enoyer des sms:

1. Configurer la clef USB Huawei 3531 en mode ethernet.

	telecharger sendSMS.sh, token.sh, session.sh (a conserver ensemble)

2. Utilisation:

	sudo ./sendSMS "Numero de tel" "message"

