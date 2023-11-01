dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y
dnf install mysql -y
useradd expense
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip
cd /app
npm install
cp service /etc/systemd/system/backend.service
systemctl daemon-reload
systemctl enable backend 
systemctl start backend
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pExpenseApp@1 < /app/schema/backend.sql

