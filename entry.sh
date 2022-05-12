#!/bin/bash

# update server files as necessary
bash ${HOMEDIR}/update.sh

${STEAMAPPDIR}/ShooterGame/Binaries/Linux/ShooterGameServer TheIsland?listen?PvEAllowStructuresAtSupplyDrops=True?RCONEnabled=True?RCONPort=${ARKRCONPORT}?Port=${ARKGAMEPORT}?QueryPort=${ARKQUERYPORT}?SessionName="${ARKSERVERNAME}"?ServerPassword="${ARKSERVERPASS}"?ServerAdminPassword="${ARKSERVERADMINPASS}" -log -NoBattlEye
