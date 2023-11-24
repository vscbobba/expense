source common.sh
echo -e "\e[33m install software \e[0m"

if [ -z "$1"];then
  echo "enter passwd"
  exit
fi

sql_passwd=$1

dnf module disable nodejs -y &>$my_log
dnf module enable nodejs:18 -y &>>$my_log
dnf install nodejs -y &>>$my_log
status_check
dnf install mysql -y &>>$my_log
status_check

echo -e "\e[38m copy service file \e[0m"
cp service /etc/systemd/system/backend.service

echo -e "\e[31m adduser and download backend \e[0m"
useradd expense &>>$my_log
mkdir -p /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$my_log
status_check
cd /app
unzip /tmp/backend.zip &>>$my_log

echo -e "\e[34m npm install \e[0m"
cd /app
npm install &>>$my_log
status_check

echo -e "\e[39m restart backend and install mysql \e[0m"
systemctl daemon-reload &>>$my_log
systemctl enable backend &>>$my_log
systemctl start backend &>>$my_log
mysql -h db-dev.bobbascloud.online -uroot -p{$sql_passwd} < /app/schema/backend.sql &>>$my_log
status_check

systemctl restart backend &>>$my_log
status_check
