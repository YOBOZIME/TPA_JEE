package com.example.iotplatform.controller;

import com.example.iotplatform.service.IoTSensorManagerService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/fetch-api")
public class FetchApiServlet extends HttpServlet {

    @Inject
    private IoTSensorManagerService service;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get city parameter or use Fès by default
        String city = req.getParameter("city");
        if (city == null || city.isBlank()) {
            city = "fes";
        }

        service.fetchAndStoreFromApi(city); // 👈 Pass city to service
        resp.sendRedirect(req.getContextPath() + "/iot-dashboard?city=" + city);
    }
}
