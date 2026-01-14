# app.py
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({"message": "Hello, Flask!"})

@app.route('/user/<username>')
def get_user(username):
    return jsonify({"username": username})

# 新增：健康监测端点
@app.route('/health')
def health_check():
    return jsonify({"status": "healthy", "code": 200}), 200

if __name__ == '__main__':
    app.run(debug=True)