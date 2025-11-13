#!/bin/bash

echo "🧪 Запуск автоматических тестов для всех HTML-страниц..."

BASE_URL="http://localhost:8181"
WEBSITE_DIR="/home/ubuntu/devops/static-website-example"

# Находим все HTML файлы
HTML_FILES=$(find "$WEBSITE_DIR" -name "*.html" -type f)

if [ -z "$HTML_FILES" ]; then
    echo "❌ Не найдено HTML файлов!"
    exit 1
fi

echo "📄 Найдены файлы: $(echo $HTML_FILES | xargs -n1 basename)"

# Тестируем каждый файл
for file in $HTML_FILES; do
    filename=$(basename "$file")
    echo "🔍 Проверка $filename..."
    
    # Проверка доступности
    if ! curl -s -I "$BASE_URL/$filename" | grep -q "200 OK"; then
        echo "❌ $filename: недоступен (не 200 OK)"
        exit 1
    fi
    
    # Проверка HTML структуры
    if ! curl -s "$BASE_URL/$filename" | grep -q -E "<!DOCTYPE HTML>|<!doctype html>"; then
        echo "❌ $filename: отсутствует DOCTYPE"
        exit 1
    fi
    
    # Проверка что страница не пустая
    content_length=$(curl -s "$BASE_URL/$filename" | wc -c)
    if [ "$content_length" -lt 50 ]; then
        echo "❌ $filename: страница слишком короткая (возможно пустая)"
        exit 1
    fi
    
    echo "✅ $filename: OK"
done

echo "🎉 Все HTML-страницы прошли проверки!"
