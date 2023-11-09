#!/bin/bash
password_file="passwords.txt"

echo "パスワードマネージャーへようこそ！"
echo "サービス名を入力してください："
read service
echo "ユーザー名を入力してください："
read name
echo "パスワードを入力してください："
read password

echo "$service:$name:$password" >> password_file

echo "Thank you!"

