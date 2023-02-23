# shellcheck disable=SC1036
 code_dir=$(pwd)
 log_file=/tmp/roboshop.log
 rm -f ${log_file}

 print_head() {
   echo -e "\e[36m$1\e[0m"
 }

 status_check() {
   if [ $1 -eq 0 ]; then
     echo success
     else
     echo failure
     fi
 }

 NODEJS(){
   print_head "Setup NodeJS repos"
   curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> $log_file
   status_check $log_file

   print_head "Install NodeJS"
   yum install nodejs -y &>> $log_file
   status_check $log_file

   APP_PREREQ

   print_head "Downloading and installing dependencies"
   cd /app
   npm install &>> $log_file
   status_check $log_file

   SYSTEMD_SETUP
   LOAD_SCHEMA
 }