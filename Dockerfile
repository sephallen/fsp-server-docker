FROM rockylinux:9
RUN dnf -y install wget chkconfig
RUN wget -O /tmp/fspd.rpm https://sourceforge.net/projects/fsp/files/fsp/2.8.1b29/fspd-2.8.1b29-2.el7.x86_64.rpm/download
RUN rpm -i /tmp/fspd.rpm
RUN rm /tmp/fspd.rpm
ENTRYPOINT ["fspd", "-X"]
