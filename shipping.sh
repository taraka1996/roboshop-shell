source common.sh

mysql_root_password=$1

if [ "${mysql_root_password}" == "mysql" ]; then
  echo -e "\e[31mmissing mysql root password\e[0m"
  exit 1
  fi

component=shipping
schem_type="mysql"
java