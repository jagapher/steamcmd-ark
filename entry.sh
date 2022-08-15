#!/bin/bash

mkdir -p "${STEAMAPPDIR}" || true

# update server files as necessary
bash ${STEAMCMDDIR}/steamcmd.sh +force_install_dir ${STEAMAPPDIR} +login anonymous +app_update ${STEAMAPPID} validate +exit

${STEAMAPPDIR}/ShooterGame/Binaries/Linux/ShooterGameServer TheIsland?listen?PvEAllowStructuresAtSupplyDrops=True?RCONEnabled=True?RCONPort=${ARKRCONPORT}?Port=${ARKGAMEPORT}?QueryPort=${ARKQUERYPORT}?SessionName="${ARKSERVERNAME}"?ServerPassword="${ARKSERVERPASS}"?ServerAdminPassword="${ARKSERVERADMINPASS}" -log -NoBattlEye
