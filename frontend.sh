code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f

echo -e "\e[35mINSTALLING NGINX \e[0m"
yum install nginx -y >>${log_file}
echo -e "\e[35mremoving old content \e[0m"
rm -rf /usr/share/nginx/html/* >>${log_file}

echo -e "\e[35mDOWNLOADING FRONTEND CONTENT \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip >>${log_file}

echo -e "\e[35mEXTRACTING DOWNLOADED FRONTEND \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip >>${log_file}

echo -e "\e[35mCOPYING NGINX CONFIG FOR ROBOSHOP \e[0m"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf >>${log_file}

echo -e "\e[35mENABLING NGINX \e[0m"
systemctl enable nginx >>${log_file}

echo -e "\e[35mSTARTING NGINX \e[0m"
systemctl restart nginx >>${log_file}



