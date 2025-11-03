      #!/bin/bash
      # Actualizamos los repositorios e intalamos mariadb y github
      apt-get update
      apt-get upgrade -y
      apt-get install -y mariadb-server git

      # Clonamos el repositorio de git
      git clone https://github.com/josejuansanchez/iaw-practica-lamp.git
      sudo sed -i "s|bind-address\s*=.*|bind-address = 0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf
      
      # Reiniciamos mariadb
      sudo systemctl restart mariadb
      
      # Creamos la base de datos y usuarios
      mysql -u root -e"
      CREATE DATABASE IF NOT EXISTS iawdb;
      CREATE USER IF NOT EXISTS 'iawuser'@'192.168.30.%' IDENTIFIED BY 'iawpass';
      GRANT SELECT, INSERT, DELETE, UPDATE ON iawdb.* TO 'iawuser'@'192.168.30.%';
      FLUSH PRIVILEGES;
      "
      #Provisionamos la base de datos
      mysql -u root iawdb < iaw-practica-lamp/db/database.sql

      # Deshabilitamos la puerta de enlace para que el equipo no tenga salida a internet
      sudo ip route del default