FROM bailey86/ubuntu1404-lamp
MAINTAINER "Anthony Moulen <amoulen@g.harvard.edu>"
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get install -y git build-essential software-properties-common
RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer wget unzip tar && \
  rm -rf /var/lib/apt-lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

RUN useradd -ms /bin/bash acornadm
ADD http://midnight.moulen.org/tmp/acorn.tar.gz /home
ADD http://midnight.moulen.org/tmp/acorn.demo.sql.gz /root
RUN mv /root/acorn.demo.sql.gz /root/acorn.demo.sql
RUN gunzip /root/acorn.demo.sql ; exit 0
RUN gunzip /home/acorn.tar.gz ; mv /home/acorn.tar.gz /home/acorn.tar ; exit 0
RUN cd /home ; tar xf acorn.tar
RUN rm /home/acorn.tar*
RUN sed -i '/mysqladmin/ i mysql -uroot < /root/acorn.demo.sql' /create_mysql_admin_user.sh
RUN sed -i '/mysqladmin/ i echo "Acorn Account: acorndemo Password: acorndemopw"' /create_mysql_admin_user.sh
ADD http://midnight.moulen.org/tmp/default.vhost /etc/apache2/sites-enabled/000-default.conf
