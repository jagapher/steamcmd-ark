FROM docker.io/cm2network/steamcmd:root

# environment variables for both the Dockerfile and the entry script
ENV STEAMCMDDIR="${HOMEDIR}/steamcmd"
ENV STEAMAPPID=376030
ENV STEAMAPP="ark"
ENV STEAMAPPDIR="${HOMEDIR}/${STEAMAPP}-dedicated"
ENV ARKQUERYPORT=37015
ENV ARKGAMEPORT=7777
ENV ARKRAWPORT=7778
ENV ARKRCONPORT=17777
ENV ARKSERVERNAME="Change me"
ENV ARKSERVERPASS="Change me"
ENV ARKSERVERADMINPASS="Change me"

# copy update script
COPY --chmod=777 ["update.sh", "${HOMEDIR}/"]

# run update.sh as a layer because that will create a base image with the server files installed
RUN ${HOMEDIR}/update.sh

# copy entry script
COPY --chmod=777 ["entry.sh", "${HOMEDIR}/"]

# add volume connector to the saved game folder
VOLUME "${STEAMAPPDIR}/ShooterGame/Saved"

# change working directory for some reason
WORKDIR ${HOMEDIR}

# expose our ports!
EXPOSE ${ARKQUERYPORT}/UDP
EXPOSE ${ARKGAMEPORT}/UDP
EXPOSE ${ARKRAWPORT}/UDP
EXPOSE ${ARKRCONPORT}/TCP

# finish off with the entry.sh CMD
CMD ["bash","entry.sh"]
