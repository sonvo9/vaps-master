#!/bin/bash
echo "Đang thiết lập Pháo đài VAPS Master..."
sudo apt update
sudo apt install python3-pip -y
pip install flask flask-cors
echo "Khởi động server..."
nohup python3 vaps_bridge.py > vaps.log 2>&1 &
echo "Xong! Anh Sơn truy cập vào cổng 9999 nhé."
