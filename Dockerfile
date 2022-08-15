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

# copy entry script
COPY ["entry.sh", "${HOMEDIR}/"]

# change working directory for some reason
WORKDIR ${HOMEDIR}

RUN set -x \
	&& mkdir -p ${STEAMAPPDIR} \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}"

USER ${USER}

# expose our ports!
EXPOSE ${ARKQUERYPORT}/UDP
EXPOSE ${ARKGAMEPORT}/UDP
EXPOSE ${ARKRAWPORT}/UDP
EXPOSE ${ARKRCONPORT}/TCP

# finish off with the entry.sh CMD
CMD ["bash","entry.sh"]
