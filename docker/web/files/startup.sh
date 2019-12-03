if [ ! -e /var/www/html/.env ]; then
    cp .env.example .env
    cd /var/www/html
    php artisan key:generate
    composer install
fi

cd /var/www/html
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

chmod -R 777 /var/www/html
chmod -R 755 /root/files/log
php-fpm && nginx -g "daemon off;"
