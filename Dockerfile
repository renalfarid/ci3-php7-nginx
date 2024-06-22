# Use Alpine Linux 3.13 as the base image
FROM alpine:3.13

# Add community repository and install PHP 7.4
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.13/community" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache nginx php7 php7-fpm php7-mysqli php7-json php7-opcache php7-mbstring php7-xml php7-phar php7-zlib php7-curl php7-session php7-iconv php7-gd php7-ctype php7-openssl php7-dom php7-tokenizer php7-pdo

# Install Composer
RUN apk add --no-cache curl && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Remove default server definition
RUN rm /etc/nginx/conf.d/default.conf

# Create necessary directories and set permissions
RUN mkdir -p /run/nginx && \
    chown -R nginx:nginx /run/nginx

# Copy your Nginx server block configuration
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Copy your PHP-FPM pool configuration
COPY ./www.conf /etc/php7/php-fpm.d/www.conf

# Copy your PHP application
COPY ./html /var/www/html

# Set file ownership and permissions
RUN chown -R nginx:nginx /var/www/html

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx and PHP-FPM services
CMD ["sh", "-c", "cd /var/www/html && composer install && php-fpm7 && nginx -g 'daemon off;'"]
