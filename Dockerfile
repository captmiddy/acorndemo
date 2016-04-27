FROM bailey86/ubuntu1404-lamp
MAINTAINER "Anthony Moulen <amoulen@g.harvard.edu>"

RUN useradd -ms /bin/bash acornadm
ADD http://ec2-52-91-103-185.compute-1.amazonaws.com/acorn.tar.gz /home
ADD http://ec2-52-91-103-185.compute-1.amazonaws.com/acorn.demo.sql.gz /root
RUN gunzip /root/acorn.demo.sql.gz
RUN cd /home ; tar zxvf acorn.tar.gz
RUN rm /home/acorn.tar.gz
RUN sed -i '/mysqladmin/ i mysql -uroot < /root/acorn.demo.sql' /create_mysql_admin_user.sh
RUN sed -i '/mysqladmin/ i echo "Acorn Account: acorndemo Password: acorndemopw"' /create_mysql_admin_user.sh
ADD http://ec2-52-91-103-185.compute-1.amazonaws.com/default.vhost /etc/apache2/sites-enabled/000-default.conf
