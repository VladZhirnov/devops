#!/bin/bash

echo "🚀 Начинаем развертывание демо-сайта..."

SITE_SOURCE="/home/ubuntu/devops/static-website-example"

echo "📁 Используем локальную папку: $SITE_SOURCE"

# Проверяем существование папки
if [ ! -d "$SITE_SOURCE" ]; then
    echo "❌ Папка $SITE_SOURCE не существует"
    exit 1
fi

# Проверяем что папка не пустая
if [ -z "$(ls -A "$SITE_SOURCE")" ]; then
    echo "❌ Папка $SITE_SOURCE пустая"
    exit 1
fi

# Проверяем, установлен ли nginx
if ! command -v nginx &> /dev/null; then
    echo "❌ nginx не установлен."
    exit 1
fi

# Создаем директорию для сайта
sudo mkdir -p /var/www/demo

# Копируем файлы
echo "📁 Копируем файлы сайта..."
sudo cp -r "$SITE_SOURCE"/* /var/www/demo/
echo "✅ Файлы сайта скопированы"

# Копируем конфигурацию nginx
echo "⚙️  Применяем конфигурацию nginx..."
sudo cp "/home/ubuntu/devops/devops/nginx.conf" /etc/nginx/sites-available/demo-site
sudo ln -sf /etc/nginx/sites-available/demo-site /etc/nginx/sites-enabled/

# Проверяем конфигурацию
echo "🔍 Проверяем конфигурацию nginx..."
sudo nginx -t

if [ $? -eq 0 ]; then
    # Перезапускаем nginx
    echo "🔄 Перезапускаем nginx..."
    sudo systemctl reload nginx
    
    echo "✅ Развертывание завершено успешно!"
    echo "🌐 Сайт доступен по адресу: http://localhost:8181"
else
    echo "❌ Ошибка в конфигурации nginx"
    exit 1
fi
