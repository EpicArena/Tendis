# 需将编译好的tendisplus拷至tendis-2.2.2/bin/目录

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

COPY tendis-2.2.2 /data1/tendis-2.2.2/

RUN ln -fs tendis-2.2.2 tendis

EXPOSE 51002

ENV CLUSTER=no REDIS_PASSWORD=

CMD ["/bin/sh", "-c", "cd /data1/tendis/scripts && ./start.sh && tail -f /data1/tendis/51002/tendisplus.conf"]

