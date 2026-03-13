import requests
import itertools
import time

# Đọc danh sách proxy từ file
with open("proxies.txt", "r") as f:
    proxy_list = [line.strip() for line in f if line.strip()]

# Tạo vòng lặp xoay tuần tự (Round Robin)
proxy_cycle = itertools.cycle(proxy_list)

def format_proxy(proxy_str):
    ip, port, user, pwd = proxy_str.split(":")
    return {
        "http": f"http://{user}:{pwd}@{ip}:{port}",
        "https": f"http://{user}:{pwd}@{ip}:{port}"
    }

url = "http://icanhazip.com"

for i in range(20):  # số lần thử
    proxy_str = next(proxy_cycle)  # lấy proxy tuần tự
    proxy = format_proxy(proxy_str)
    print(f"Đang dùng proxy: {proxy_str}")
    try:
        response = requests.get(url, proxies=proxy, timeout=10)
        print("IP Public:", response.text.strip())
    except Exception as e:
        print("Proxy lỗi:", e)
    time.sleep(3)