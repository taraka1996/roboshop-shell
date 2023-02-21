cp configs/mongodb.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y
systemctl enable mongod
systemctl start mongod


