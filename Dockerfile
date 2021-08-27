FROM php:7.4-fpm-alpine

# Apk install
RUN apk --no-cache update && \
    apk --no-cache add bash git sudo

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" &&  \
    sudo mv composer.phar /usr/local/bin/composer

# Install Symfony Cli
RUN wget https://get.symfony.com/cli/installer -O - | bash && \
    mv /root/.symfony/bin/symfony /usr/local/bin/symfony

# User and permissions
RUN adduser -D user \
    && echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user \
    && chmod 0440 /etc/sudoers.d/user
USER user

# Config git
RUN git config --global user.email "aymerick.demay@outlook.com" && \
    git config --global user.name "AymerickD"

WORKDIR /var/www/html