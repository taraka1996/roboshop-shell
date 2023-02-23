source common.sh

mysql_root_password=$1
if [-z "${mysql_root_password=$1}" ]; then
  echo "\e[31mmissing MYSQL argument\e[0m"
  exit 1
  fi


 print_head  "disabling MYSQL  8 version"
dnf module disable mysql -y
status_check $?

print_head "installing MYSQL server"
yum install mysql-community-server -y
status_check $?

print_head "enable MYSQL service"
systemctl enable mysqld
status_check $?

print_head "start MYSQL server"
systemctl start mysqld
status_check $?

print_head "set root password"
mysql_secure_installation --set-root-pass &{mysql_root_password}
status_check $?