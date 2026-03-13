sudo apt update
sudo apt install nodejs npm -y
# --- BUOC 1: XOA FILE CU ---
rm -f chay_ngay.sh tool_seo.py
# --- BUOC 2: TAO FILE MOI (CO TICH HOP TOR) ---
cat << 'EOF' > chay_ngay.sh
#!/bin/bash

echo ">>> 1. DANG CAI DAT MANG TOR (DE DOI IP MIEN PHI)..."
sudo apt-get update -y
sudo apt-get install -y tor
sudo service tor start

# Kiem tra xem Tor chay chua
if ps ax | grep -v grep | grep tor > /dev/null
then
    echo "   -> Mang Tor da hoat dong tot!"
else
    echo "   -> Dang khoi dong lai Tor..."
    sudo service tor restart
fi

echo ">>> 2. DANG CAI THU VIEN..."
sudo apt-get install -y python3-pip python3-venv libxi6 libgconf-2-4
# Cai Chrome neu chua co
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install -y ./google-chrome-stable_current_amd64.deb --fix-missing

# Tao moi truong ao
rm -rf my_seo_env
python3 -m venv my_seo_env
source my_seo_env/bin/activate

# Cai thu vien Python
pip install selenium webdriver-manager fake-useragent pysocks

echo ">>> 3. TAO TOOL PYTHON (SUPPER FAKE IP)..."
cat <<PY_SCRIPT > tool_seo.py
import time
import random
import os
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from fake_useragent import UserAgent

# === CAU HINH ===
URL = "https://bicoi.com" 
SO_LAN = 1000
PROXY_TOR = "socks5://127.0.0.1:9050" # Cong mac dinh cua Tor
# ================

def run():
    print(f">>> BAT DAU CAY VIEW QUA MANG TOR (IP NUOC NGOAI)...")
    
    for i in range(SO_LAN):
        print(f"\n--- [Luot {i+1}] Dang fake IP va vao web... ---")
        
        # 1. Doi IP cua Tor (Reset mach)
        os.system("sudo service tor reload") 
        time.sleep(3) # Cho Tor doi IP moi
        
        ua = UserAgent()
        user_agent = ua.random
        
        opts = Options()
        opts.add_argument("--headless")
        opts.add_argument(f"user-agent={user_agent}")
        opts.add_argument(f"--proxy-server={PROXY_TOR}") # QUAN TRONG: Di qua Tor
        opts.add_argument("--no-sandbox")
        opts.add_argument("--disable-dev-shm-usage")
        opts.add_argument("--window-size=1920,1080")
        
        # Giam thieu viec bi phat hien
        opts.add_argument("--disable-blink-features=AutomationControlled")
        opts.add_experimental_option("excludeSwitches", ["enable-automation"])
        opts.add_experimental_option('useAutomationExtension', False)

        driver = None
        try:
            service = Service(ChromeDriverManager().install())
            driver = webdriver.Chrome(service=service, options=opts)
            
            # Kiem tra IP hien tai (De ban thay no da doi)
            try:
                driver.set_page_load_timeout(30)
                driver.get("http://icanhazip.com")
                ip_moi = driver.find_element("tag name", "body").text.strip()
                print(f"   -> IP Hien tai: {ip_moi}")
            except:
                print("   -> (Khong check duoc IP nhung van dang dung Tor)")

            # --- CHUYEN SANG ORGANIC SEARCH ---
            # 1. Truy cap vao Google truoc de lay Referer
            driver.get("https://www.google.com")
            time.sleep(random.randint(2, 4)) # Cho Google tai xong va mo phong thoi gian nghi
            
            print("   -> Dang tao click tu Google (Organic Search)...")
            
            # 2. Dung Javascript tao mot duong link an tren trang Google roi click vao no
            js_tao_click = f"""
            var link = document.createElement('a');
            link.href = '{URL}';
            document.body.appendChild(link);
            link.click();
            """
            driver.execute_script(js_tao_click)
            
            # 3. Cho trang web cua ban tai xong
            time.sleep(3)
            print(f"   -> Da vao web thanh cong: {driver.title}")
            # -----------------------------------
            
            # Luot web
            driver.execute_script("window.scrollTo(0, document.body.scrollHeight/2);")
            time.sleep(random.randint(5, 10))
            
        except Exception as e:
            print(f"   -> Loi ket noi (Do mang Tor cham hoac ngat quang): {e}")
            
        finally:
            if driver:
                driver.quit()
                print("   -> Da xong luot nay.")

if __name__ == "__main__":
    run()
PY_SCRIPT

# --- BUOC 3: CHAY TOOL ---
echo ">>> XONG! BAT DAU CHAY..."
python3 tool_seo.py
EOF

# --- CAP QUYEN VA CHAY ---
chmod +x chay_ngay.sh
bash chay_ngay.sh
# --- BUOC 1: XOA FILE CU ---
rm -f chay_ngay.sh tool_seo.py
# --- BUOC 2: TAO FILE MOI (CO TICH HOP TOR) ---
cat << 'EOF' > chay_ngay.sh
#!/bin/bash

echo ">>> 1. DANG CAI DAT MANG TOR (DE DOI IP MIEN PHI)..."
sudo apt-get update -y
sudo apt-get install -y tor
sudo service tor start

# Kiem tra xem Tor chay chua
if ps ax | grep -v grep | grep tor > /dev/null
then
    echo "   -> Mang Tor da hoat dong tot!"
else
    echo "   -> Dang khoi dong lai Tor..."
    sudo service tor restart
fi

echo ">>> 2. DANG CAI THU VIEN..."
sudo apt-get install -y python3-pip python3-venv libxi6 libgconf-2-4
# Cai Chrome neu chua co
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install -y ./google-chrome-stable_current_amd64.deb --fix-missing

# Tao moi truong ao
rm -rf my_seo_env
python3 -m venv my_seo_env
source my_seo_env/bin/activate

# Cai thu vien Python
pip install selenium webdriver-manager fake-useragent pysocks

echo ">>> 3. TAO TOOL PYTHON (SUPPER FAKE IP)..."
cat <<PY_SCRIPT > tool_seo.py
import time
import random
import os
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from fake_useragent import UserAgent

# === CAU HINH ===
URL = "https://bicoi.com" 
SO_LAN = 1000
PROXY_TOR = "socks5://127.0.0.1:9050" # Cong mac dinh cua Tor
# ================

def run():
    print(f">>> BAT DAU CAY VIEW QUA MANG TOR (IP NUOC NGOAI)...")
    
    for i in range(SO_LAN):
        print(f"\n--- [Luot {i+1}] Dang fake IP va vao web... ---")
        
        # 1. Doi IP cua Tor (Reset mach)
        os.system("sudo service tor reload") 
        time.sleep(3) # Cho Tor doi IP moi
        
        ua = UserAgent()
        user_agent = ua.random
        
        opts = Options()
        opts.add_argument("--headless")
        opts.add_argument(f"user-agent={user_agent}")
        opts.add_argument(f"--proxy-server={PROXY_TOR}") # QUAN TRONG: Di qua Tor
        opts.add_argument("--no-sandbox")
        opts.add_argument("--disable-dev-shm-usage")
        opts.add_argument("--window-size=1920,1080")
        
        # Giam thieu viec bi phat hien
        opts.add_argument("--disable-blink-features=AutomationControlled")
        opts.add_experimental_option("excludeSwitches", ["enable-automation"])
        opts.add_experimental_option('useAutomationExtension', False)

        driver = None
        try:
            service = Service(ChromeDriverManager().install())
            driver = webdriver.Chrome(service=service, options=opts)
            
            # Kiem tra IP hien tai (De ban thay no da doi)
            try:
                driver.set_page_load_timeout(30)
                driver.get("http://icanhazip.com")
                ip_moi = driver.find_element("tag name", "body").text.strip()
                print(f"   -> IP Hien tai: {ip_moi}")
            except:
                print("   -> (Khong check duoc IP nhung van dang dung Tor)")

            # Vao web chinh
            driver.get(URL)
            print(f"   -> Da vao web: {driver.title}")
            
            # Luot web
            driver.execute_script("window.scrollTo(0, document.body.scrollHeight/2);")
            time.sleep(random.randint(5, 10))
            
        except Exception as e:
            print(f"   -> Loi ket noi (Do mang Tor cham): {e}")
            
        finally:
            if driver:
                driver.quit()
                print("   -> Da xong luot nay.")

if __name__ == "__main__":
    run()
PY_SCRIPT

# --- BUOC 3: CHAY TOOL ---
echo ">>> XONG! BAT DAU CHAY..."
python tool_seo.py
EOF

# --- CAP QUYEN VA CHAY ---
chmod +x chay_ngay.sh
bash chay_ngay.sh
source my_seo_env/bin/activate
sudo apt update && sudo apt install -y python3-venv python3-pip
python3 -m venv my_seo_env
source my_seo_env/bin/activate
pip install selenium webdriver-manager fake-useragent pysocks
python3 tool_seo.py
rm -f chay_ngay.sh tool_seo.py
# --- BUOC 2: TAO FILE MOI (TICH HOP VPN LOCAL) ---
cat << 'EOF' > chay_ngay.sh
#!/bin/bash

echo ">>> 1. DANG CAI DAT OPENVPN..."
sudo apt-get update -y
sudo apt-get install -y openvpn python3-pip python3-venv wget

echo ">>> 2. DANG CAI TRINH DUYET CHROME..."
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install -y ./google-chrome-stable_current_amd64.deb --fix-missing

# Tao moi truong ao
rm -rf my_seo_env
python3 -m venv my_seo_env
source my_seo_env/bin/activate

# Cai thu vien Python
pip install selenium webdriver-manager fake-useragent

echo ">>> 3. TAO TOOL PYTHON (ROTATION VPN)..."
cat <<PY_SCRIPT > tool_seo.py
import time
import random
import os
import subprocess
import glob
bash chay_ngay.sh


sudo systemctl restart proxybot
sudo systemctl daemon-reload
sudo systemctl restart proxybot
sudo systemctl status proxybot
sudo chmod +x /root/rotate_proxy.py
# --- XOA FILE CU CHO SACH SE ---
rm -f chay_ngay.sh tool_seo.py proxy_auth_plugin*.zip
# --- TAO FILE HOAN CHINH ---
cat << 'EOF' > chay_ngay.sh
#!/bin/bash

echo ">>> TAO TOOL PYTHON (WEBSHARE EXTENSION DA LUONG)..."
cat << 'PY_SCRIPT' > tool_seo.py
import time
import random
import os
import zipfile
import requests
import concurrent.futures
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from fake_useragent import UserAgent

# === CAU HINH ===
TARGET_URL = "https://bicoi.com"
WEBSHARE_URL = "https://proxy.webshare.io/api/v2/proxy/list/download/xhyvcpkvpsfavfwzqeysypigzbfrwhsmpgknptnn/-/any/username/direct/-/?plan_id=12848988"
SO_LUONG_LUONG = 5 

DANH_SACH_BOT = [
    ("BOT 1", "https://www.google.com/search?q=BICOI+UPDATE&sca_esv=99a15385a3b5aa7c&rlz=1C1HKFL_viVN1199VN1199&sxsrf=ANbL-n7-KRPtYYSXy3SYVqzLq84JN0ylpw%3A1771563278661&ei=DumXaZ6TKO2fseMP7r7w0QI&biw=1920&bih=911&ved=0ahUKEwie0q-_o-eSAxXtT2wGHW4fPCoQ4dUDCBM&uact=5&oq=BICOI+UPDATE"),
    ("BOT 2", "https://www.google.com/search?q=BICOI+TODAY&sca_esv=99a15385a3b5aa7c&rlz=1C1HKFL_viVN1199VN1199&biw=1920&bih=911&sxsrf=ANbL-n7zgop4K4sJnBJh6Sm1_PmOpv7nVQ%3A1771563287525&ei=F-mXaYzmH8qdseMPjJTXmAc"),
    ("BOT 3", "https://www.google.com/search?q=Bicoi+Market+Data+-+Crypto+Insights&rlz=1C1HKFL_viVN1199VN1199&sourceid=chrome&ie=UTF-8"),
    ("BOT 4", "https://www.google.com/search?q=Bicoi+Crypto+Insights&sca_esv=99a15385a3b5aa7c&rlz=1C1HKFL_viVN1199VN1199&sxsrf=ANbL-n4kkttgn6Pt4Q5ctidXGygeUHaA6g%3A1771563429788&ei=pemXac3mL-igseMP_5ShyQY")
]

try:
    CHROME_SERVICE = Service(ChromeDriverManager().install())
except:
    print("Loi tai ChromeDriver"); exit()

def lay_danh_sach_proxy():
    print(">>> Dang ket noi den Webshare tai danh sach Proxy...")
    response = requests.get(WEBSHARE_URL, timeout=15)
    return [line.strip() for line in response.text.strip().split('\n') if line.strip()]

def tao_extension_proxy(host, port, user, password, bot_id):
    """Tuyet chieu tao Extension tang hinh cho tung BOT"""
    plugin_path = f'proxy_auth_plugin_{bot_id}.zip'
    manifest_json = """
    {
        "version": "1.0.0",
        "manifest_version": 2,
        "name": "Chrome Proxy",
        "permissions": ["proxy", "tabs", "unlimitedStorage", "storage", "<all_urls>", "webRequest", "webRequestBlocking"],
        "background": {"scripts": ["background.js"]},
        "minimum_chrome_version":"22.0.0"
    }
    """
    background_js = f"""
    var config = {{ mode: "fixed_servers", rules: {{ singleProxy: {{scheme: "http", host: "{host}", port: parseInt({port})}}, bypassList: ["localhost"] }} }};
    chrome.proxy.settings.set({{value: config, scope: "regular"}}, function() {{}});
    function callbackFn(details) {{ return {{authCredentials: {{username: "{user}", password: "{password}"}}}}; }}
    chrome.webRequest.onAuthRequired.addListener(callbackFn, {{urls: ["<all_urls>"]}}, ['blocking']);
    """
    with zipfile.ZipFile(plugin_path, 'w') as zp:
        zp.writestr("manifest.json", manifest_json)
        zp.writestr("background.js", background_js)
    return plugin_path

def chay_mot_bot(thong_tin_bot, proxy_host, proxy_port, proxy_user, proxy_pass, luong_id):
    bot_name, search_url = thong_tin_bot
    plugin_path = tao_extension_proxy(proxy_host, proxy_port, proxy_user, proxy_pass, luong_id)
    
    opts = Options()
    opts.add_argument("--headless=new") # Dùng headless xịn để nạp Extension
    opts.add_extension(plugin_path) # NẠP PROXY KÈM MẬT KHẨU VÀO ĐÂY
    opts.add_argument(f"user-agent={UserAgent().random}")
    opts.add_argument("--no-sandbox")
    opts.add_argument("--disable-dev-shm-usage")
    opts.add_argument("--window-size=1920,1080")
    opts.add_argument("--disable-blink-features=AutomationControlled")

    driver = None
    try:
        driver = webdriver.Chrome(service=CHROME_SERVICE, options=opts)
        driver.set_page_load_timeout(45)
        
        # Test IP truoc khi cay view
        driver.get("http://icanhazip.com")
        ip_moi = driver.find_element("tag name", "body").text.strip()
        
        # Kiem tra neu trung mang Viettel thi dung lai ngay
        if ip_moi.startswith("42.118") or ip_moi == "42.118.228.100":
             print(f"   [{bot_name}] ❌ THAT BAI: Lo IP goc. Huy luot.")
             return
             
        print(f"   [{bot_name}] ✅ Bọc IP an toàn: {ip_moi}")
        
        driver.get(search_url)
        time.sleep(3) 
        driver.execute_script(f"var link=document.createElement('a');link.href='{TARGET_URL}';document.body.appendChild(link);link.click();")
        
        time.sleep(5) 
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight/2);")
        time.sleep(random.randint(6, 10)) 
        print(f"   [{bot_name}] 🎉 Keo Traffic thanh cong!")
        
    except Exception as e:
        pass
        
    finally:
        if driver:
            driver.quit()
        if os.path.exists(plugin_path):
            os.remove(plugin_path)

def chay_vong_lap():
    danh_sach_proxy = lay_danh_sach_proxy()
    vong = 1
    while True:
        print(f"\n===================================================")
        print(f">>> VONG LAP {vong}: BAT DAU CAY VIEW <<<")
        print(f"===================================================")
        
        for i in range(0, len(DANH_SACH_BOT), SO_LUONG_LUONG):
            nhom_bot = DANH_SACH_BOT[i:i+SO_LUONG_LUONG]
            with concurrent.futures.ThreadPoolExecutor(max_workers=SO_LUONG_LUONG) as executor:
                futures = []
                for idx, bot in enumerate(nhom_bot):
                    # Moi luong se lay ngau nhien 1 proxy tu Webshare de chay
                    proxy_chon = random.choice(danh_sach_proxy)
                    try: p_host, p_port, p_user, p_pw = proxy_chon.split(':')
                    except: continue
                    
                    futures.append(executor.submit(chay_mot_bot, bot, p_host, p_port, p_user, p_pw, idx))
                concurrent.futures.wait(futures)
                
        time.sleep(10)
        vong += 1

if __name__ == "__main__":
    chay_vong_lap()
PY_SCRIPT

echo ">>> KICH HOAT HE THONG..."
./my_seo_env/bin/python tool_seo.py
EOF

chmod +x chay_ngay.sh
bash chay_ngay.sh
# --- BUOC 1: XOA FILE CU ---
rm -f chay_ngay.sh tool_seo.py
# --- BUOC 2: TAO FILE MOI ---
cat << 'EOF' > chay_ngay.sh
#!/bin/bash

# Kich hoat moi truong ao
source my_seo_env/bin/activate 2>/dev/null || {
    echo ">>> Dang khoi tao moi truong lan dau..."
    python3 -m venv my_seo_env
    source my_seo_env/bin/activate
}

pip install selenium webdriver-manager fake-useragent --quiet

echo ">>> DANG KHOI CHAY TOOL SEO (CHAY 10 TU KHOA - LAP LAI LIEN TUC)..."
cat <<PY_SCRIPT > tool_seo.py
import time
import random
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from webdriver_manager.chrome import ChromeDriverManager
from fake_useragent import UserAgent

DATA_LIST = [
  {"kw": "bicoi today bitcoin guide", "link": "https://bicoi.com/Bitcoin/definitive-guide-bitcoin-exchanges-trading-security.html"},
    {"kw": "bicoi new", "link": "https://bicoi.com/Bitcoin/definitive-guide-bitcoin-exchanges-trading-security.html"},
    {"kw": "bicoi bingx bitcoin", "link": "https://bicoi.com/Bitcoin/definitive-guide-bitcoin-exchanges-trading-security.html"},
    {"kw": "bicoi today bitcoin", "link": "https://bicoi.com/Bitcoin/definitive-guide-bitcoin-exchanges-trading-security.html"},
    {"kw": "bicoi & bingx today", "link": "https://bicoi.com/Bitcoin/definitive-guide-bitcoin-exchanges-trading-security.html"},
    {"kw": "bicoi update crypto", "link": "https://bicoi.com/Bitcoin/definitive-guide-bitcoin-exchanges-trading-security.html"},
    {"kw": "bicoi today crypto", "link": "https://bicoi.com/Bitcoin/definitive-guide-bitcoin-exchanges-trading-security.html"},
    {"kw": "bicoi & bitcoin", "link": "https://bicoi.com/Bitcoin/definitive-guide-bitcoin-exchanges-trading-security.html"},
    {"kw": "bicoi picre bitcoin", "link": "https://bicoi.com/Bitcoin/definitive-guide-bitcoin-exchanges-trading-security.html"},
    {"kw": "bicoi new bitcoin", "link": "https://bicoi.com/Bitcoin/definitive-guide-bitcoin-exchanges-trading-security.html"}
]

def run_seo():
    ua = UserAgent()
    vong_lap = 1
    
    while True:  # Chay vinh vien
        print(f"\n========== BAT DAU VONG LAP THU {vong_lap} ==========")
        
        for idx, item in enumerate(DATA_LIST):
            print(f"\n[Luot {idx+1}/10] Tu khoa: {item['kw']}")
            
            opts = Options()
            opts.add_argument("--headless")
            opts.add_argument(f"user-agent={ua.random}")
            opts.add_argument("--no-sandbox")
            opts.add_argument("--disable-dev-shm-usage")
            opts.add_argument("--disable-blink-features=AutomationControlled")
            
            driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=opts)
            
            try:
                # [A] Google
                driver.get("https://www.google.com")
                time.sleep(random.randint(3, 5))

                # [B] Go chu (Gia lap go cham)
                search_box = driver.find_element(By.NAME, "q")
                for char in item['kw']:
                    search_box.send_keys(char)
                    time.sleep(random.uniform(0.1, 0.3))
                
                # [C] Enter
                search_box.send_keys(Keys.ENTER)
                time.sleep(random.randint(5, 7))

                # [D] Tim link
                found = False
                # Quet tat ca cac link co trong trang ket qua
                all_links = driver.find_elements(By.TAG_NAME, "a")
                for link in all_links:
                    try:
                        href = link.get_attribute("href")
                        if href and item['link'] in href:
                            driver.execute_script("arguments[0].scrollIntoView();", link)
                            time.sleep(1)
                            driver.execute_script("arguments[0].click();", link)
                            print(f"   => DA THAY VA CLICK: {item['link']}")
                            found = True
                            break
                    except:
                        continue
                
                if not found:
                    print("   => Khong thay tren trang 1, vao truc tiep de giu view...")
                    driver.get(item['link'])

                # [E] O lai 2 phut (120s)
                print(f"   => Dang xem trang trong 2 phut...")
                for s in range(4):
                    time.sleep(30) # 120 / 4
                    driver.execute_script(f"window.scrollBy(0, {random.randint(300, 600)});")
                    print(f"      ... da xem { (s+1)*25 }% thoi gian")

            except Exception as e:
                print(f"   => Loi: {e}")
            finally:
                driver.quit()
                # Nghi ngan giua cac luot de doi IP (neu VPS co xoay IP)
                time.sleep(random.randint(5, 10))
        
        vong_lap += 1
        print("\n>>> DA XONG 1 LUOT 10 TU KHOA. NGHI 30s TRUOC KHI LAP LAI...")
        time.sleep(30)

if __name__ == "__main__":
    run_seo()
PY_SCRIPT

python3 tool_seo.py
EOF

# Chay
bash chay_ngay.sh
