#!/bin/bash

RESULT="1"
CONNECT=true
TEMPO=30
TEMPO2=20
LOOP=1

while $CONNECT; do
PING=$(ping 192.168.8.100 -c 1 | grep -E -o '[0-9]+ received' | cut -f1 -d' ')
if [ "$RESULT" == "$PING" ]
then
    echo "Clef 3G prete"
    CONNECT=false
else
    LOOP=1
    echo "Configuration de la clef 3G en cours..."
    sleep $(($TEMPO)); echo "raspberry" | sudo  usb_modeswitch -c /etc/usb_modeswitch.d/12d1:1f01  #> /dev/null
    clear
    echo "Verification de  la connexion..."
    echo "Patienter..."
    while (("$LOOP"<=5)); do
    sleep $(($TEMPO2));
    #ping de la page de configuration du stick pour verifier la dispo du reseau.
    PING=$(ping 192.168.8.100 -c 1 | grep -E -o '[0-9]+ received' | cut -f1 -d' ')
    if  [ "$RESULT" == "$PING" ]
    then
        LOOP=6
    else
        ((LOOP+=1))
    fi
    done
    TEMPO=5
fi
done
sleep $(($TEMPO2))



