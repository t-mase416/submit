#!/bin/bash


password_file="passwords.txt.gpg"

while true; do
    echo "パスワードマネージャーへようこそ！"
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
    read -r choice  
    choice="${choice,,}" 

    case "$choice" in
        "add password")
            echo "サービス名を入力してください:"
            read service
            echo "ユーザー名を入力してください:"
            read username
            echo "パスワードを入力してください:"
            read -s password  

            gpg -d "$password_file" > decrypted_passwords.txt
            
            echo "$service:$username:$password" >> decrypted_passwords.txt
            
            gpg -ea -r tkym6140@gmail.com -o "$password_file" decrypted_passwords.txt
            
            rm decrypted_passwords.txt

            echo "パスワードの追加は成功しました。"
            ;;
        "get password")
            if [ ! -f "$password_file" ]; then
                echo "パスワードファイルが存在しません。最初にパスワードを追加してください。"
            else
                gpg -d "$password_file" > decrypted_passwords.txt  
                echo "サービス名を入力してください:"
                read service
                found="false"
                while IFS=: read -r saved_service saved_username saved_password; do
                    if [ "$service" == "$saved_service" ]; then
                        found="true"
                        echo "サービス名: $saved_service"
                        echo "ユーザー名: $saved_username"
                        echo "パスワード: $saved_password"
                        break
                    fi
                done < decrypted_passwords.txt
                if [ "$found" == "false" ]; then
                    echo "そのサービスは登録されていません。"
                fi
                rm decrypted_passwords.txt  
            fi
            ;;
        "exit")
            echo "Thank you!"
            exit 0
            ;;
        *)
            echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
            ;;
    esac
done
