# Dockerfile
FROM webdevops/php-apache:7.4
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq ; apt-get upgrade ; \
    apt-get install -y gridengine-client ; \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#
ADD setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

ARG USER=tool
ARG UID=2002
ARG GID=2002
# default password for user
ARG PW=dummy
# Option1: Using unencrypted password/ specifying password
RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PW}" | \
      chpasswd
# Option2: Using the same encrypted password as host
#COPY /etc/group /etc/group 
#COPY /etc/passwd /etc/passwd
#COPY /etc/shadow /etc/shadow
# Setup default user, when enter docker container
USER ${UID}:${GID}
#RUN useradd -m dummy
#RUN echo "dummy:dummy" | chpasswd
#
#ENTRYPOINT ["/opt/docker/bin/entrypoint.sh"]
CMD sleep 45 && /usr/local/bin/setup.sh && echo "hostname ; date" | qsub -o /tmp/a.txt


#add cleaning step adjusting the document + sistema de cues
#chmod u+x scripts/maintainance/cleanUsersData.php
#crontab -e
