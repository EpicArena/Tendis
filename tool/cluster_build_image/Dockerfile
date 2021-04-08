FROM docker.91act.com:5000/centos:latest
LABEL maintainer "liaobinhong@91act.com"
USER root
ENV USER root

RUN \
    rpm -ivh https://yum.91act.com/act/act-release-1.0-1.el7.x86_64.rpm && \
    yum -y install net-tools.x86_64 && \
    yum-config-manager --disable 91act > /dev/null && \
    yum clean all

WORKDIR /data1/

COPY build /data1/build/

CMD ["/bin/sh", "-c", "cd /data1/build && ./build.sh"]

