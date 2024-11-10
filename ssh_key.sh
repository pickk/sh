# 1. 生成 SSH 密钥对
ssh-keygen

# 2. 进入 .ssh 目录
cd ~/.ssh

# 3. 将公钥添加到 authorized_keys 文件
cat id_rsa.pub >> authorized_keys

# 4. 设置文件权限
chmod 600 authorized_keys
chmod 700 ~/.ssh

# 5. 修改 /etc/ssh/sshd_config 文件，启用公钥认证
sed -i '/^PubkeyAuthentication/d' /etc/ssh/sshd_config
  echo 'PubkeyAuthentication yes' | tee -a /etc/ssh/sshd_config

sed -i '/^RSAAuthentication/d' /etc/ssh/sshd_config
echo 'RSAAuthentication yes' | tee -a /etc/ssh/sshd_config

# 如果上面 sed 命令没有成功，可以手动追加以下内容：
# echo 'PubkeyAuthentication yes' | tee -a /etc/ssh/sshd_config
# echo 'RSAAuthentication yes' | tee -a /etc/ssh/sshd_config

# 6. 重启 SSH 服务以应用更改
systemctl restart sshd
