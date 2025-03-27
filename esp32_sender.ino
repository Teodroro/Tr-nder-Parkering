#include <WiFi.h>
#include <HTTPClient.h>

const char* ssid = "Ditt_WiFi"; 
const char* password = "Ditt_Passord";
const char* serverUrl = "http://raspberrypi.local:5000/data"; // Flask-server på RPi

void setup() {
  Serial.begin(115200);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Kobler til WiFi...");
  }
}

void loop() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(serverUrl);
    http.addHeader("Content-Type", "application/json");

    int sensorValue = analogRead(34);
    String jsonPayload = "{\"sensor\":" + String(sensorValue) + "}";

    int httpResponseCode = http.POST(jsonPayload);
    Serial.println(httpResponseCode);
    http.end();
  }
  delay(5000);
}
