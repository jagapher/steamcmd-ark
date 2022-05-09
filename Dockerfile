FROM docker.io/cm2network/steamcmd:latest

RUN ./steamcmd.sh +force_install_dir ark +login anonymous +app_update 376030 validate +exit
