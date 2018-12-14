# Base RHEL 7 with nginx
# Includes epel repo for local build

FROM rhel:latest

MAINTAINER Joel Adams <jadams111686 4t gmail.com>

# You can edit the repo file and uncomment the lines below
# in order to use a local CentOS-Base mirror (if you have one).
# This is HIGHLY recommended if you plan to build
# images locally.

# ADD CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo

# Disabling the fastest mirror plugin is also a good
# idea if you have a local mirror.

# RUN sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf

RUN yum update -y && yum install net-tools tar wget unzip -y && yum clean all && \
    yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum repolist && \
    yum install pwgen nginx -y && \
    yum clean all

COPY ./nginx.conf /etc/nginx/
COPY ./conf.d/server_names_hash_bucket_size.conf /etc/nginx/conf.d/
RUN mkdir /etc/nginx/ssl.d
COPY ./ssl.d/ssl-params.conf /etc/nginx/ssl.d/
COPY ./ssl.d/ssl-hostcertfiles.conf /etc/nginx/ssl.d/

COPY ./conf.d/proxy.conf /etc/nginx/conf.d/
RUN mkdir -p /etc/pki/nginx/private
COPY ./certs/dh.pem /etc/ssl/certs/
COPY ./certs/server1.crt /etc/pki/nginx/
COPY ./certs/server1.key /etc/pki/nginx/private/

RUN mkdir /etc/nginx/sites-enabled

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
