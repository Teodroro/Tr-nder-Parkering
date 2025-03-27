from flask import Flask, request, jsonify
app = Flask(__name__)
sensor_data = 0

@app.route('/data', methods=['POST'])
def receive_data():
    global sensor_data
    data = request.get_json()
    sensor_data = data["sensor"]
    return jsonify({"message": "Data mottatt!"})

@app.route('/')
def web_display():
    return f"<h1>Sensorverdi: {sensor_data}</h1>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
