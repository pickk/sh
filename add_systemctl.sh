sudo vim /etc/systemd/system/my-script.service
[Unit]
Description=My Custom Script Service
After=network.target

[Service]
ExecStart=/path/to/your-script.sh

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl start my-script.service
sudo systemctl status my-script.service

