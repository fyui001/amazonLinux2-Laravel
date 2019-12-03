cd /var/www/html

composer install
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

chmod -R 777 /var/www/html
chmod -R 755 /root/files/log
php-fpm && nginx -g "daemon off;"

