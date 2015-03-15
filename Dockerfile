# Sage Full Installation
#
# VERSION               0.4

FROM centos:centos7
MAINTAINER Volker Braun <vbraun.name@gmail.com>

ENV SAGE_VERSION 6.5


COPY install_requirements.sh /root/install_requirements.sh
RUN /root/install_requirements.sh && rm /root/install_requirements.sh 

RUN useradd --comment "Sage Math" --user-group --groups wheel --create-home sage
RUN echo 'sage ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/sage

# Install updates late so we can cache the previous steps
RUN yum -y update

COPY sage-${SAGE_VERSION}.tar.gz /opt/sage-${SAGE_VERSION}.tar.gz
COPY install_sage.sh /opt/install_sage.sh
COPY sage_launcher /opt/sage_launcher
COPY sage_profile.sh /etc/profile.d/sage_profile.sh

RUN chown --recursive sage.sage /opt

# Everything from now on runs as user "sage"
USER sage

RUN /opt/install_sage.sh && rm /opt/install_sage.sh

EXPOSE 8080

ENTRYPOINT ["/opt/sage_launcher"]

