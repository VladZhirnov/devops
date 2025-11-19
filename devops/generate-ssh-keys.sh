echo "Генерация SSH ключей для GitHub Actions..."

# Генерируем SSH ключи
ssh-keygen -t rsa -C "github-actions" -f ~/.ssh/github_actions -N ""

# Добавляем публичный ключ в authorized_keys
cat ~/.ssh/github_actions.pub >> ~/.ssh/authorized_keys

echo "Публичный ключ добавлен в authorized_keys"
echo ""
echo "=== ПРИВАТНЫЙ КЛЮЧ (скопируйте для GitHub Secrets) ==="
cat ~/.ssh/github_actions
echo "=== КОНЕЦ ПРИВАТНОГО КЛЮЧА ==="
