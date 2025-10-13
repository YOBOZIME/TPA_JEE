package com.example.iotplatform.service;

import com.example.iotplatform.dao.SensorReadingDAO;
import com.example.iotplatform.model.SensorReading;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class IoTSensorManagerService {

    @Inject
    private SensorReadingDAO sensorReadingDAO;

    // --- Existing methods ---
    public void ingestSensorReading(SensorReading reading) {
        sensorReadingDAO.addReading(reading);
    }

    public List<SensorReading> retrieveAllSensorReadings() {
        return sensorReadingDAO.getAllReadings();
    }

    public SensorReading findReadingById(String readingId) {
        return sensorReadingDAO.getReadingById(readingId);
    }

    public List<SensorReading> filterReadingsBySensorType(String sensorType) {
        return sensorReadingDAO.getReadingsBySensorType(sensorType);
    }

    public List<SensorReading> getLatestReadings(int limit) {
        return sensorReadingDAO.getAllReadings().stream()
                .sorted(Comparator.comparing(SensorReading::getTimestamp).reversed())
                .limit(limit)
                .collect(Collectors.toList());
    }

    // --- NEW: fetch external API and store result ---
    public void fetchAndStoreFromApi(String city) {
        try {
            // 🔹 Default coordinates (Fès)
            double latitude = 34.033;
            double longitude = -5.000;
            String displayName = "Fès";

            // 🔹 Choose coordinates based on selected city
            switch (city.toLowerCase()) {
                case "rabat":
                    latitude = 34.0209;
                    longitude = -6.8416;
                    displayName = "Rabat";
                    break;
                case "casablanca":
                    latitude = 33.5731;
                    longitude = -7.5898;
                    displayName = "Casablanca";
                    break;
                case "marrakech":
                    latitude = 31.6295;
                    longitude = -7.9811;
                    displayName = "Marrakech";
                    break;
                case "tanger":
                    latitude = 35.7595;
                    longitude = -5.8339;
                    displayName = "Tanger";
                    break;
                default:
                    displayName = "Fès";
            }

            // 🔹 Build the API URL dynamically
            URL url = new URL(
                    "https://api.open-meteo.com/v1/forecast?latitude=" + latitude +
                            "&longitude=" + longitude +
                            "&current=temperature_2m,relative_humidity_2m,pressure_msl"
            );

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");

            if (conn.getResponseCode() != 200)
                throw new RuntimeException("HTTP error: " + conn.getResponseCode());

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) response.append(line);
            conn.disconnect();

            // 🔹 Parse the JSON
            JSONObject json = new JSONObject(response.toString());
            JSONObject current = json.getJSONObject("current");

            // 🔹 Create sensor readings
            SensorReading temperature = new SensorReading(
                    UUID.randomUUID().toString(),
                    "API_SENSOR_TEMP",
                    "TEMPERATURE",
                    current.getDouble("temperature_2m"),
                    "°C",
                    System.currentTimeMillis(),
                    displayName + " - External API"
            );

            SensorReading humidity = new SensorReading(
                    UUID.randomUUID().toString(),
                    "API_SENSOR_HUM",
                    "HUMIDITY",
                    current.getDouble("relative_humidity_2m"),
                    "%",
                    System.currentTimeMillis(),
                    displayName + " - External API"
            );

            SensorReading pressure = new SensorReading(
                    UUID.randomUUID().toString(),
                    "API_SENSOR_PRESS",
                    "PRESSURE",
                    current.getDouble("pressure_msl"),
                    "hPa",
                    System.currentTimeMillis(),
                    displayName + " - External API"
            );

            // 🔹 Store all readings
            ingestSensorReading(temperature);
            ingestSensorReading(humidity);
            ingestSensorReading(pressure);

            System.out.println("✅ API data fetched for " + displayName + " and stored.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
