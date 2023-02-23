source common.sh

print_head  "configure Nodejs repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >>${log_file}
status_check $?

print_head  "create roboshop user"
 id roboshop  >>${log_file}

 if [ $? -ne 0 ]; then
 useradd roboshop >>${log_file}
 fi
 status_check $?

print_head  "create application directory"
if [ ! -d /app ]; then
mkdir /app >>${log_file}
fi
status_check $?

print_head  "delete old content"
rm -rf /app/* >>${log_file}
status_check $?

print_head  "downloading app content"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip >>${log_file}
status_check $?
cd /app

print_head  "extracting app content"
unzip /tmp/user.zip >>${log_file}

cd /app >>${log_file}
status_check $?

print_head  "installing Nodejs dependencies"
npm install >>${log_file}
status_check $?

print_head  "copy systemd service file"
cp ${code_dir}/configs/user.service /etc/systemd/system/user.service &>>${log_file}
status_check $?

print_head  "reload systemd"
systemctl daemon-reload &>>${log_file}
status_check $?

print_head  "enable catalogue  service"
systemctl enable catalogue >>${log_file}
status_check $?

print_head  "start catalogue  service"
systemctl restart catalogue >>${log_file}
status_check $?

