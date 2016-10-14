# docker build --rm -t eubiosteo-oneclient .

FROM indigodatacloud/ubuntu-sshd:14.04

MAINTAINER Miguel Caballer (UPV) <micafer1@upv.es>

LABEL description="Container image to run Eubiosteo with Oneclient"

COPY ["playbook.yaml", "/"]

RUN ansible-galaxy install indigo-dc.oneclient indigo-dc.eubiosteo

RUN echo "localhost" > /etc/ansible/hosts

RUN ansible-playbook /etc/ansible/roles/indigo-dc.oneclient/tests/test.yml && \
    ansible-playbook /playbook.yaml

EXPOSE 22

# CMD /etc/init.d/vmcontext start; /usr/sbin/sshd -D
