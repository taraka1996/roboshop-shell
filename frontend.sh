code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f

print_head()  {
  echo -e "\e[35m$1\e[0m"

}

print_head "INSTALLING NGINX"
yum install nginx -y >>${log_file}

print_head "removing old content "
rm -rf /usr/share/nginx/html/* >>${log_file}

print_head "DOWNLOADING FRONTEND CONTENT "
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip >>${log_file}

print_head "EXTRACTING DOWNLOADED FRONTEND "
cd /usr/share/nginx/html
unzip /tmp/frontend.zip >>${log_file}

 print_head "COPYING NGINX CONFIG FOR ROBOSHOP "
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf >>${log_file}

 print_head "ENABLING NGINX "
systemctl enable nginx >>${log_file}

 print_head "STARTING NGINX "
systemctl restart nginx >>${log_file}



