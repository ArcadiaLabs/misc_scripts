#!/bin/bash

####### Script de sauvegarde virtualbox en ligne de commande #######

### Dependances ###
# virtualbox
# vboxmanage

### liste des VM a sauvegarder separees par un espace ###
VBOXLIST='webserver proxyserver ts3server'
### dossier de sauvegarde (slash en debut et fin) ###
EXPORT_DIR='/media/usb/backups/VirtualBox/'

echo "Liste des machines virtuelles a exporter : ${VBOXLIST}"
for VBOX in ${VBOXLIST}; do
        OVF_FILE="${EXPORT_DIR}${VBOX}.ovf"
        VMDK_FILE="${EXPORT_DIR}${VBOX}.vmdk"

        if [ -f "${OVF_FILE}" ]; then
                echo "Suppression du fichier : ${OVF_FILE}"
                rm "${OVF_FILE}"
        fi

        if [ -f "${VMDK_FILE}" ]; then
                echo "Suppression du fichier : ${VMDK_FILE}"
		fi
        echo "Arręt de la machine ${VBOX}"
        vboxmanage controlvm "${VBOX}" acpipowerbutton
        until $(VBoxManage showvminfo --machinereadable "${VBOX}" | grep -q ^VM$
        do
                sleep 1
        done
        echo "Export de la machine ${VBOX} vers ${OVF_FILE}"
        vboxmanage export "${VBOX}" -o "${OVF_FILE}"
        echo "Redémarrage de la machine ${VBOX}"
        vboxmanage startvm "${VBOX}" --type headless

done
