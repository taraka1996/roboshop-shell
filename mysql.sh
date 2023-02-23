source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password=$1}" ]; then
  echo "\e[31mmissing mysql root password\e[0m"
  exit 1
  fi

print_head  "disabling MYSQL  8 version"
dnf module disable mysql -y &>>${log_file}
status_check $?

print_head  "copy systemd service file"
cp ${code_dir}/configs/mysql.repo /etc/systemd/system/mysql.repo &>>${log_file}
status_check $?

print_head "installing MYSQL server"
yum install mysql-community-server -y &>>${log_file}
status_check $?

print_head "enable MYSQL service"
systemctl enable mysql &>>${log_file}
status_check $?

print_head "start MYSQL server"
systemctl start mysql &>>${log_file}
status_check $?

print_head "set root password"
echo show database | mysql -uroot -p${mysql_root_password}  &>>${log_file}
mysql_secure_installation --set-root-pass &{mysql_root_password}  &>>${log_file}
fi
status_check $?