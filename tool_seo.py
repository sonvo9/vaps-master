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
