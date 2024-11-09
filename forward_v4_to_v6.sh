apt install -y socat
nohup socat -d  TCP4-LISTEN:31180,fork,su=nobody TCP6:[2a01:4f8:201:2063::1946:4d7c]:33180 &
