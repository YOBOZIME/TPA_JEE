package com.example.iotplatform.scheduler;

import com.example.iotplatform.service.IoTSensorManagerService;
import jakarta.ejb.Schedule;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import jakarta.inject.Inject;

@Singleton
@Startup
public class ApiScheduler {

    @Inject
    private IoTSensorManagerService iotService;

    // Run every 30 seconds
    @Schedule(hour = "*", minute = "*", second = "*/30", persistent = false)
    public void autoFetch() {
        System.out.println("⏰ Fetching external API data for Fès...");
        iotService.fetchAndStoreFromApi("fes"); // ✅ fixed city for scheduler
    }
}
