source common.sh
echo -e "\e[33m install software \e[0m"

if [ -z "$1" ];then
  echo "Please enter passwd"
  exit
fi

sql_passwd=$1
dnf module disable mysql -y &>>$my_log
status_check

echo -e "\e[34m copy conf file \e[0m"
cp repo /etc/yum.repos.d/mysql.repo &>>$my_log

echo -e "\e[31m installing mysql \e[0m"
dnf install mysql-community-server -y &>>$my_log
status_check

echo -e "\e[35m start mysql \e[0m"
systemctl enable mysqld &>>$my_log
systemctl start mysqld &>>$my_log
mysql_secure_installation --set-root-pass ${sql_passwd} &>>$my_log
status_check