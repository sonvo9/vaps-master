import time
import zipfile
import itertools
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager

# === CAU HINH ===
TARGET_URL = "https://bicoi.com"
SO_LAN = 1000  # Số lần muốn chạy

# Đọc danh sách proxy từ file proxies.txt
with open("proxies.txt", "r") as f:
    danh_sach_proxy = [line.strip() for line in f if line.strip()]

# Tạo vòng lặp tuần tự (Round Robin)
proxy_cycle = itertools.cycle(danh_sach_proxy)

def tao_extension_proxy(host, port, user, password):
    plugin_path = 'proxy_auth_plugin.zip'
    manifest_json = """
    {
        "version": "1.0.0",
        "manifest_version": 2,
        "name": "Chrome Proxy",
        "permissions": [
            "proxy", "tabs", "unlimitedStorage", "storage",
            "<all_urls>", "webRequest", "webRequestBlocking"
        ],
        "background": {"scripts": ["background.js"]},
        "minimum_chrome_version":"22.0.0"
    }
    """
    background_js = f"""
    var config = {{
            mode: "fixed_servers",
            rules: {{
              singleProxy: {{scheme: "http", host: "{host}", port: parseInt({port})}},
              bypassList: ["localhost"]
            }}
          }};
    chrome.proxy.settings.set({{value: config, scope: "regular"}}, function() {{}});
    function callbackFn(details) {{
        return {{authCredentials: {{username: "{user}", password: "{password}"}}}};
    }}
    chrome.webRequest.onAuthRequired.addListener(
            callbackFn, {{urls: ["<all_urls>"]}}, ['blocking']
    );
    """
    with zipfile.ZipFile(plugin_path, 'w') as zp:
        zp.writestr("manifest.json", manifest_json)
        zp.writestr("background.js", background_js)
    return plugin_path

def run_test():
    tong_proxy = len(danh_sach_proxy)
    print(f">>> ĐÃ TẢI {tong_proxy} PROXY. KHOI DONG BOT CHẠY {SO_LAN} LẦN...")

    service = Service(ChromeDriverManager().install())

    for i in range(SO_LAN):
        print(f"\n--- [Lượt {i+1}/{SO_LAN}] ---")

        # Lấy proxy tuần tự
        proxy_chon = next(proxy_cycle)
        try:
            proxy_parts = proxy_chon.split(':')
            PROXY_HOST = proxy_parts[0]
            PROXY_PORT = proxy_parts[1]
            PROXY_USER = proxy_parts[2]
            PROXY_PASS = proxy_parts[3]
        except Exception as e:
            print(f"❌ Proxy sai định dạng, bỏ qua: {proxy_chon}")
            continue

        print(f"-> Đang dùng Proxy: {PROXY_HOST}:{PROXY_PORT}")

        proxy_plugin = tao_extension_proxy(PROXY_HOST, PROXY_PORT, PROXY_USER, PROXY_PASS)

        opts = Options()
        opts.add_argument("--headless=new")
        opts.add_argument("--no-sandbox")
        opts.add_argument("--disable-dev-shm-usage")
        opts.add_argument("--window-size=1920,1080")
        opts.add_extension(proxy_plugin)

        driver = None
        try:
            driver = webdriver.Chrome(service=service, options=opts)
            driver.set_page_load_timeout(30)

            print("   * Đang kiểm tra IP...")
            driver.get("http://icanhazip.com")
            ip_hien_tai = driver.find_element("tag name", "body").text.strip()
            print(f"   ✅ IP hiện tại: {ip_hien_tai}")

            print(f"   * Truy cập {TARGET_URL}...")
            driver.get(TARGET_URL)
            print(f"   ✅ Đã vào trang: {driver.title}")

            driver.execute_script("window.scrollTo(0, document.body.scrollHeight/2);")
            time.sleep(5)
            print("🎉 HOÀN TẤT LƯỢT NÀY!")

        except Exception as e:
            print(f"❌ Lỗi mạng hoặc proxy die: {e}")
        finally:
            if driver:
                driver.quit()
                print("--- Đã đóng trình duyệt ---")

if __name__ == "__main__":
    run_test()