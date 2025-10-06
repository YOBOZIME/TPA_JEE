package com.example.iotplatform.model;

import java.time.LocalDateTime;

public class SensorReading {
    private String readingId;
    private String sensorId;
    private String sensorType;
    private double value;
    private LocalDateTime timestamp;

    public SensorReading() {}

    public SensorReading(String readingId, String sensorId, String sensorType, double value, LocalDateTime timestamp) {
        this.readingId = readingId;
        this.sensorId = sensorId;
        this.sensorType = sensorType;
        this.value = value;
        this.timestamp = timestamp;
    }

    public String getReadingId() { return readingId; }
    public void setReadingId(String readingId) { this.readingId = readingId; }

    public String getSensorId() { return sensorId; }
    public void setSensorId(String sensorId) { this.sensorId = sensorId; }

    public String getSensorType() { return sensorType; }
    public void setSensorType(String sensorType) { this.sensorType = sensorType; }

    public double getValue() { return value; }
    public void setValue(double value) { this.value = value; }

    public LocalDateTime getTimestamp() { return timestamp; }
    public void setTimestamp(LocalDateTime timestamp) { this.timestamp = timestamp; }
}
