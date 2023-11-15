echo -e "\e[33m install software \e[0m"
my_log="/tmp/error.log"

dnf module disable mysql -y &>> my_log

echo -e "\e[34m copy conf file \e[0m"

cp repo /etc/yum.repos.d/mysql.repo &>> my_log

echo -e "\e[31m installing mysql \e[0m"
dnf install mysql-community-server -y &>> my_log


echo -e "\e[35m start mysql \e[0m"

systemctl enable mysqld &>> my_log
systemctl start mysqld &>> my_log
mysql_secure_installation --set-root-pass ExpenseApp@1 &>> my_log