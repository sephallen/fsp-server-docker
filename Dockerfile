FROM rockylinux:9-minimal
RUN microdnf -y install wget chkconfig
RUN wget -nv -O /tmp/fspd.rpm https://sourceforge.net/projects/fsp/files/fsp/2.8.1b29/fspd-2.8.1b29-2.el7.x86_64.rpm/download
RUN rpm -i /tmp/fspd.rpm
RUN rm /tmp/fspd.rpm
RUN microdnf clean all
ENTRYPOINT ["fspd", "-X"]
