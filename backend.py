from flask import Flask, request, jsonify

app = Flask(__name__)

import json

FEEDBACK_FILE = 'feedbacks.json'

def read_feedbacks():
    try:
        with open(FEEDBACK_FILE, 'r') as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return []

def write_feedbacks(feedbacks):
    with open(FEEDBACK_FILE, 'w') as f:
        json.dump(feedbacks, f, indent=2)

@app.route('/api/posts', methods=['GET'])
def get_posts():
    return jsonify(read_feedbacks())

@app.route('/api/post', methods=['POST'])
def add_post():
    post = request.get_json()
    feedbacks = read_feedbacks()
    feedbacks.append(post)
    write_feedbacks(feedbacks)
    return jsonify(post), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
