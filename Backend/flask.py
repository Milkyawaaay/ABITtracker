from flask import Flask, request, jsonify
import sqlite3
import json

app = Flask(__name__)

@app.route('/')
def home():
    return "ABITtracker - Авторизация"

@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    
    conn = sqlite3.connect('abitracker.db')
    cursor = conn.cursor()
    
    # Проверяем email
    cursor.execute("SELECT id FROM users WHERE email = ?", (data['email'],))
    if cursor.fetchone():
        conn.close()
        return jsonify({"error": "Email уже занят"}), 400

    cursor.execute(
        "INSERT INTO users (full_name, email, password) VALUES (?, ?, ?)",
        (data['name'], data['email'], data['password'])
    )
    conn.commit()
    user_id = cursor.lastrowid
    conn.close()
    
    return jsonify({
        "message": "Регистрация успешна!",
        "user_id": user_id
    })
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    
    conn = sqlite3.connect('abitracker.db')
    cursor = conn.cursor()
    
    cursor.execute(
        "SELECT id, full_name, email FROM users WHERE email = ? AND password = ?",
        (data['email'], data['password'])
    )
    user = cursor.fetchone()
    conn.close()
    
    if user:
        return jsonify({
            "message": "Вход успешен!",
            "user": {
                "id": user[0],
                "name": user[1],
                "email": user[2]
            }
        })
    else:
        return jsonify({"error": "Неверный email или пароль"}), 401
