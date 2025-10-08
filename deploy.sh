#!/bin/bash

# deploy.sh - скрипт для деплоя на сервере

set -e  # Остановиться при любой ошибке

echo "Starting deployment..."

# Переходим в директорию проекта
cd ~/apps/my-app

# Pull последние изменения (если используем git на сервере)
# git pull origin main

# Устанавливаем зависимости
echo "Installing dependencies..."
npm install --production

# Строим приложение (если нужно)
echo "Building application..."
npm run build

# Останавливаем предыдущую версию приложения
echo "Stopping previous version..."
pm2 stop my-app || true

# Запускаем приложение с помощью PM2
echo "Starting application..."
pm2 start npm --name "my-app" -- start
pm2 save

# Настраиваем автозапуск PM2 при загрузке системы
pm2 startup | tail -1 | sh

echo "Deployment completed successfully!"
