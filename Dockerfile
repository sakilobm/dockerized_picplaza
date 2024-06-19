FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt update \
    && apt upgrade -y \
    && apt install -y apache2 \
    && apt install -y php libapache2-mod-php php-mysql nano git \
    && apt install -y php8.3-mysql mysql-server openssh-client

# Enable mod_rewrite
RUN a2enmod rewrite

# Create .ssh directory and copy SSH key
RUN mkdir -p /root/.ssh
COPY ssh/id_ed25519_sb /root/.ssh/id_ed25519
COPY ssh/id_ed25519_sb.pub /root/.ssh/id_ed25519.pub

# Copy and configure SSH key
RUN chmod 600 /root/.ssh/id_ed25519 && \
    chmod 644 /root/.ssh/id_ed25519.pub && \
    ssh-keyscan git.selfmade.ninja >> /root/.ssh/known_hosts

    # Debug: Display SSH key and known_hosts to verify setup
RUN ls -la /root/.ssh && cat /root/.ssh/id_ed25519.pub && cat /root/.ssh/known_hosts

# Debug: Test SSH connection to the Git server
RUN ssh -T git@git.selfmade.ninja || true

# Clone or pull the latest changes from your project repository
RUN if [ -d /var/www/html/newPicPlaza ]; then \
        cd /var/www/html/newPicPlaza && git pull; \
    else \
        git clone git@git.selfmade.ninja:sowbharath/own_web_framework.git /var/www/html/newPicPlaza; \
    fi

# Copy specific files or directories
COPY config/appleconfig.json /var/www/html/newPicPlaza/project

# Update PHP configuration
RUN sed -i "s/short_open_tag = .*/short_open_tag = on/" /etc/php/8.3/apache2/php.ini

# Update Apache configuration to allow .htaccess and set new DocumentRoot
RUN sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf \
    && sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/newPicPlaza\/htdocs/g" /etc/apache2/sites-available/000-default.conf \
    && sed -i "s/<Directory \/var\/www\/html>/<Directory \/var\/www\/html\/newPicPlaza\/htdocs>/g" /etc/apache2/sites-available/000-default.conf

# Remove default index.html if it exists
RUN rm -f /var/www/html/index.html

# Expose port 80 (not 8080 because Apache uses 80 by default)
EXPOSE 80

# Use a volume for /var/www/html
VOLUME ["/var/www/html"]

# Start Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]
