FROM centos:8

ADD /installer/fspd.rpm /fspd.rpm
RUN rpm -i fspd.rpm
ENTRYPOINT ["fspd", "-X"]
