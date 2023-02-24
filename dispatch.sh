
source common.sh

if [ -z ne0 "$roboshop_rabbitmq_password" ]; then
  echo "Variable roboshop_rabbitmq_password is missing"
  exit 1
fi

component="dispatch"
schema="true"
GOLANG