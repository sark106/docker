# Sage Full Installation
#
# VERSION               0.2

FROM centos:centos7
MAINTAINER Volker Braun <vbraun.name@gmail.com>

COPY install_requirements.sh /root/install_requirements.sh
RUN chmod 755 /root/install_requirements.sh
RUN /root/install_requirements.sh 
RUN rm /root/install_requirements.sh 

RUN useradd --comment "Sage Math" --user-group --groups wheel --create-home sage
RUN echo 'sage ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/sage

# Install updates late so we can cache the previous steps
RUN yum -y update

COPY sage-6.4.tar.gz /home/sage/sage.tar.gz

COPY install_sage.sh /home/sage/install_sage.sh
RUN chmod 755 /home/sage/install_sage.sh
RUN su sage -c /home/sage/install_sage.sh
RUN rm /home/sage/install_sage.sh

COPY sage_launcher.py /home/sage/launcher.py
RUN chmod 755 /home/sage/launcher.py

EXPOSE 22
EXPOSE 8080

CMD ["/home/sage/launcher.py"]
