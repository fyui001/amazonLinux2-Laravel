if [ ! -e /var/www/html/.env ]; then
    cp .env.example .env
    cd /var/www/html
    php artisan key:generate
    composer install
    php artisan migrate
    yarn
fi

cd /var/www/html
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear
# webpackのビルドモード、適宜変更
yarn dev
#yarn prodp

#パーミッションまわり
chown -R nginx:nginx /var/www/html/storage
chown -R nginx:nginx /var/www/html/bootstrap/cache
chmod -R 755 /var/www/html
chmod -R 766 /var/www/html/storage
chmod -R 766 /var/www/html/bootstrap/cache
php-fpm && nginx -g "daemon off;"
