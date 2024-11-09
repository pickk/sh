apt update
apt install -y  wireguard
apt install -y wget
apt install -y resolvconf
wget https://github.com/ViRb3/wgcf/releases/download/v2.2.23/wgcf_2.2.23_linux_386
mv wgcf_2.2.23_linux_386 wgcf
chmod +x wgcf
./wgcf register
./wgcf generate
sed -i 's/0\.0\.0\.0\/0//g' wgcf-profile.conf
sed -i 's/,//g' wgcf-profile.conf
cp wgcf-profile.conf /etc/wireguard/wgcf.conf
systemctl start wg-quick@wgcf
systemctl enable wg-quick@wgcf