#!/bin/bash

# Установите пароль root
ROOT_PASSWORD=$1

# Выполните команды для настройки MySQL
mysql -u root <<EOF
-- Установить пароль для root
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';

-- Удалить анонимных пользователей
DELETE FROM mysql.user WHERE User='';

-- Запретить удаленный доступ для root
DELETE FROM mysql.user WHERE User='root' AND Host!='localhost';

-- Удалить тестовую базу данных
DROP DATABASE IF EXISTS test;

-- Применить изменения
FLUSH PRIVILEGES;
EOF

