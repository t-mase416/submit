#!/bin/bash

password_file="passwords.txt"
echo "パスワードマネージャーへようこそ！"

while true; do
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
    read choice
    
    case "$choice" in
        "Add Password")
            echo "サービス名を入力してください："
            read service
            echo "ユーザー名を入力してください："
            read username
            echo "パスワードを入力してください："
            read -s password
            echo "$service:$username:$password" >> password_file
            echo -e "\nパスワードの追加は成功しました。"
            ;;
        "Get Password")
            echo "サービス名を入力してください："
            read service
            found="false"
            while IFS=: read -r saved_service saved_username saved_password; do
                if [ "$service" = "$saved_service" ]; then
                    found="true"
                    echo "サービス名: $saved_service"
                    echo "ユーザー名: $saved_username"
                    echo "パスワード: $saved_password"
                    break
                fi
            done < password_file
            if [ "$found" = "false" ]; then
                echo "そのサービスは登録されていません。"
            fi
            ;;
        "Exit")
            echo "Thank you!"
            exit 0
            ;;
        *)
            echo "入力が間違えています。Add Password/Get Password/Exitから入力してください。"
            ;;
    esac 
done