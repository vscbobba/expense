source common.sh
echo -e "\e[33m install software \e[0m"

dnf install nginx -y &>$my_log
status_check

rm -rf /usr/share/nginx/html/*
cp conf /etc/nginx/default.d/expense.conf

echo -e "\e[36m download frontend software \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$my_log
status_check

cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$my_log
status_check

echo -e "\e[34m enable and start nginx \e[0m"
systemctl enable nginx &>>$my_log
systemctl start nginx &>>$my_log






