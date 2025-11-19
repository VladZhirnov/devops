#!/bin/bash

echo "🧪 Запуск CI тестов для HTML-страниц..."

WEBSITE_DIR="../static-website-example"

if [ ! -d "$WEBSITE_DIR" ]; then
    echo "❌ Директория $WEBSITE_DIR не найдена"
    echo "Текущая директория: $(pwd)"
    echo "Содержимое родительской директории:"
    ls -la ..
    exit 1
fi

# Находим все HTML файлы
HTML_FILES=$(find "$WEBSITE_DIR" -name "*.html" -type f)

if [ -z "$HTML_FILES" ]; then
    echo "❌ Не найдено HTML файлов!"
    exit 1
fi

echo "📄 Найдены файлы:"
echo "$HTML_FILES"

# Проверяем каждый файл
for file in $HTML_FILES; do
    filename=$(basename "$file")
    echo "🔍 Проверка $filename..."
    
    # Проверка что файл не пустой
    if [ ! -s "$file" ]; then
        echo "❌ $filename: файл пустой"
        exit 1
    fi
    
    # Проверка HTML структуры
    if ! grep -q -E "<!DOCTYPE HTML>|<!doctype html>" "$file"; then
        echo "❌ $filename: отсутствует DOCTYPE"
        exit 1
    fi
    
    # Проверка базовой HTML структуры
    if ! grep -q -E "<html|</html>" "$file"; then
        echo "❌ $filename: отсутствует HTML структура"
        exit 1
    fi
    
    echo "✅ $filename: OK"
done

echo "🎉 Все HTML-страницы прошли проверки!"
