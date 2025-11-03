      #!/bin/bash
      # Actualizamos los repositorios e instalamos apache php y github
      apt-get update
      apt-get install -y apache2 php libapache2-mod-php php-mysql git

      # Clonamos el repositorio de github
      git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /var/www/html/iaw-practica-lamp

      # Gestionamos los permisos necesarios
      sudo chown -R www-data:www-data /var/www/html/iaw-practica-lamp

      # Configuramos apache 
      sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/usuariosapp.conf

      sudo sed -i 's/DocumentRoot .*/DocumentRoot \\\/var\\\/www\\\/html\\\/iaw-practica-lamp\\\/src/' /etc/apache2/sites-available/usuariosapp.conf
      # Habilitamos modwrite y el site de la app

      a2enmod rewrite
      a2ensite usuariosapp.conf
      a2dissite 000-default.conf

      # Reiniciamos apache
      sudo systemctl restart apache2

      # Configuramos config.php
      sudo sed -i "s|'localhost'|'192.168.30.11'|g; s|'database_name_here'|'iawdb'|g; s|'username_here'|'iawuser'|g; s|'password_here'|'iawpass'|g" /var/www/html/iaw-practica-lamp/src/config.php