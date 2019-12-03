FILE_PATH=$1

NGINX_CONF=${FILE_PATH}/default.conf

amazon-linux-extras install php7.2
cp ${FILE_PATH}/nginx.repo /etc/yum.repos.d/nginx.repo

# amazonlinuxだとyumを連結するとコケることがあるので分割する
yum -y install nginx
yum -y install php-fpm
yum -y install php
yum -y install php-devel
yum -y install php-mbstring
yum -y install php-pdo
yum -y install php-xml
yum -y install php-paer
yum -y install php-sesstion
yum -y install php-zip
yum -y install zlib

mkdir /root/composer
cd /root/composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
cd /root

# php.ini #
sed -i -e "s/;date\.timezone =/date\.timezone = "Asia\/Tokyo"/" /etc/php.ini
sed -i -e "s/post_max_size = 8M/post_max_size = 32M/" /etc/php.ini
sed -i -e "s/upload_max_filesize = 2M/upload_max_filesize = 32M/" /etc/php.ini

# php-fpm #
sed -i -e "s/user = apache/user = nginx/" /etc/php-fpm.d/www.conf
sed -i -e "s/group = apache/group = nginx/" /etc/php-fpm.d/www.conf
sed -i -e "s/;listen.owner = nobody/listen.owner = nginx/" /etc/php-fpm.d/www.conf
sed -i -e "s/;listen.group = nobody/listen.group = nginx/" /etc/php-fpm.d/www.conf
sed -i -e "s/listen.acl_users = apache,nginx/;listen.acl_users = /" /etc/php-fpm.d/www.conf

cp ${NGINX_CONF} /etc/nginx/conf.d/default.conf
cp ${FILE_PATH}/startup.sh /root/startup.sh
