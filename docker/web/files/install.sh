FILE_PATH=$1

NGINX_CONF=${FILE_PATH}/default.conf

#各種必要なものをインスコする
# amazonlinuxだとyumを連結するとコケることがあるので分割する
yum -y install tar
yum -y install gcc-c++
yum -y install make
yum -y install zlib
yum -y install curl-devel
yum -y install expat-devel
yum -y install gettext-devel
yum -y install openssl-devel
yum -y install perl-devel
yum -y install zlib-devel
yum -y install sudo

#php7.2
amazon-linux-extras install php7.2
yum -y install php
yum -y install php-devel
yum -y install php-mbstring
yum -y install php-pdo
yum -y install php-xml
yum -y install php-pear
yum -y install php-session
yum -y install php-zip
yum -y install php-fpm

#node.js12.x
curl -sL https://rpm.nodesource.com/setup_12.x |  bash -
yum -y install nodejs
npm install -g yarn

# mysql8.0.XX
rpm -ivh https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
### mysqlクライアントだけあればよし、サーバーもほしいときは以下を変更 ###
yum -y install mysql-community-client --enablerepo=mysql80-community
#yum -y install mysql-community-server --enablerepo=mysql80-community
#mysqld --initialaize
#grep password /var/log/mysqld.log > ~/mysql_temporary_root_passwd.txt
#chown -R mysql:mysql /var/lib/mysql

#nginx
cp ${FILE_PATH}/nginx.repo /etc/yum.repos.d/nginx.repo
yum -y install nginx

# composer
mkdir /root/composer
cd /root/composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
cd /root

# php.ini
# post_maxやuplodad_maxは適宜変更するべし
sed -i -e 's/;date\.timezone =/date\.timezone = "Asia\/Tokyo"/' /etc/php.ini
sed -i -e 's/post_max_size = 8M/post_max_size = 32M/' /etc/php.ini
sed -i -e 's/upload_max_filesize = 2M/upload_max_filesize = 32M/' /etc/php.ini

#php-fpmの設定
sed -i -e 's/user = apache/user = nginx/' /etc/php-fpm.d/www.conf
sed -i -e 's/group = apache/group = nginx/' /etc/php-fpm.d/www.conf
sed -i -e 's/;listen.owner = nobody/listen.owner = nginx/' /etc/php-fpm.d/www.conf
sed -i -e 's/;listen.group = nobody/listen.group = nginx/' /etc/php-fpm.d/www.conf
sed -i -e 's/listen.acl_users = apache,nginx/;listen.acl_users = /' /etc/php-fpm.d/www.conf

cp ${NGINX_CONF} /etc/nginx/conf.d/default.conf
cp ${FILE_PATH}/startup.sh /root/startup.sh
