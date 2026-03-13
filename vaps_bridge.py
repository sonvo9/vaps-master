from flask import Flask, request, jsonify, send_file
import subprocess
import os

app = Flask(__name__)

# BỘ PHẬN 1: HIỂN THỊ GIAO DIỆN WEB
@app.route('/')
def home():
    # Kiểm tra xem anh Sơn đã upload file HTML chưa
    if not os.path.exists('admin-master.html'):
        return "<h1>LỖI RỒI ANH SƠN ƠI!</h1><p>Em chưa thấy file <b>admin-master.html</b> trên Cloud Shell. Anh nhớ bấm vào dấu 3 chấm góc phải phía trên màn hình để Upload nó lên nhé!</p>"
    
    return send_file('admin-master.html')

# BỘ PHẬN 2: NHẬN LỆNH TỪ AI CLI
@app.route('/run-command', methods=['POST'])
def run_command():
    data = request.get_json()
    command = data.get('command')
    
    if not command:
        return jsonify({"stderr": "Lỗi: Không có lệnh nào được gửi lên."})

    try:
        result = subprocess.run(
            command, 
            shell=True, 
            capture_output=True, 
            text=True,
            timeout=30 
        )
        return jsonify({
            "stdout": result.stdout,
            "stderr": result.stderr
        })
    except Exception as e:
        return jsonify({"stderr": str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9999)
