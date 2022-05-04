# Dockerfile
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq ; apt-get upgrade ; \
    apt-get install -y gridengine-client ; \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update
RUN apt-get install -y git python3-pip python3-venv
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR "/vre_template_tool"
RUN apt install -y python3.8-venv
RUN python3 -m venv venv

# set bash as current shell
RUN chsh -s /bin/bash
SHELL ["/bin/bash", "-c"]
RUN source venv/bin/activate 
RUN pwd

WORKDIR /vre_template_tool
COPY ./vre_template_tool /vre_template_tool
RUN ls
RUN source venv/bin/activate  
RUN pip3 install --upgrade wheel
RUN pip3 install -r requirements.txt
RUN pwd
RUN alias python=/usr/bin/python3
#RUN ln -s /usr/bin/python3 /usr/bin/python
#ENV PYTHONPATH "${PYTHONPATH}:/vre_template_tool"
#

ADD setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh
#ARG USER=tool
#ARG UID=2002
#ARG GID=2002
# default password for user
#ARG PW=dummy
# Option1: Using unencrypted password/ specifying password
#RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PW}" | \
#      chpasswd
#USER ${UID}:${GID}
#USER 2002:2002
RUN useradd -m tool
RUN echo "tool:tool" | chpasswd
#RUN su - tool
#
#USER 2002:2002
#ENTRYPOINT ["/opt/docker/bin/entrypoint.sh"]
#CMD sleep 45 && /usr/local/bin/setup.sh && echo "hostname ; date" | qsub -o /tmp/a.txt
CMD source venv/bin/activate && pip3 install -q -r requirements.txt && ./VRE_RUNNER --config tests/basic/config.json --in_metadata tests/basic/in_metadata.json --out_metadata out_metadata.json --log_file VRE_RUNNER.log

#add cleaning step adjusting the document + sistema de cues
#chmod u+x scripts/maintainance/cleanUsersData.php
#crontab -e
