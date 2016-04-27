FROM bailey86/ubuntu1404-lamp
MAINTAINER "Anthony Moulen <amoulen@g.harvard.edu>"

RUN useradd -ms /bin/bash acornadm
ADD http://midnight.moulen.org/tmp/acorn.tar.gz /home
ADD http://midnight.moulen.org/tmp/acorn.demo.sql.gz /root
RUN head /root/acorn.demo.sql.gz
RUN ls -al /root
RUN gunzip -q /root/acorn.demo.sql.gz
RUN cd /home ; tar zxvf acorn.tar.gz
RUN rm /home/acorn.tar.gz
RUN sed -i '/mysqladmin/ i mysql -uroot < /root/acorn.demo.sql' /create_mysql_admin_user.sh
RUN sed -i '/mysqladmin/ i echo "Acorn Account: acorndemo Password: acorndemopw"' /create_mysql_admin_user.sh
ADD http://midnight.moulen.org/tmp/default.vhost /etc/apache2/sites-enabled/000-default.conf
