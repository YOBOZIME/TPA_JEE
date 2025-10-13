<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord IoT</title>

    <style>
        body {
            font-family: 'Segoe UI', Roboto, sans-serif;
            background-color: #f5f7fa;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #0078d7;
            margin-bottom: 10px;
        }

        h2 {
            color: #444;
            border-left: 4px solid #0078d7;
            padding-left: 10px;
            margin-top: 30px;
        }

        .control-bar {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            margin: 20px 0 30px 0;
        }

        select, input[type="text"], input[type="number"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 6px;
            outline: none;
            transition: 0.3s;
        }

        select:focus, input:focus {
            border-color: #0078d7;
            box-shadow: 0 0 4px rgba(0,120,215,0.4);
        }

        button {
            background-color: #0078d7;
            border: none;
            color: white;
            padding: 10px 16px;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background-color: #005fa3;
        }

        .cards {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 20px;
            width: 250px;
            text-align: center;
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 4px 14px rgba(0,0,0,0.15);
        }

        .card h3 {
            color: #0078d7;
            margin-bottom: 5px;
        }

        .card .value {
            font-size: 2em;
            font-weight: bold;
            color: #222;
        }

        .card .unit {
            font-size: 1.1em;
            color: #555;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-top: 20px;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #0078d7;
            color: white;
            font-weight: 500;
        }

        tr:hover {
            background-color: #f1f9ff;
        }

        form.manual-input {
            background-color: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-top: 20px;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        label {
            display: block;
            margin-top: 10px;
            font-weight: 500;
        }

        .filter-bar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
            margin: 10px 0;
        }

        .footer {
            text-align: center;
            margin-top: 40px;
            font-size: 0.9em;
            color: #777;
        }
    </style>
</head>

<body>
<h1>Tableau de Bord IoT</h1>

<!-- ========= BARRE DE CONTROLE ========= -->
<div class="control-bar">
    <form action="${pageContext.request.contextPath}/fetch-api" method="get" style="display:flex; align-items:center; gap:10px;">
        <label for="city" style="font-weight:600;">Ville :</label>
        <select name="city" id="city">
            <option value="fes" ${selectedCity eq 'fes' ? 'selected' : ''}>Fès</option>
            <option value="rabat" ${selectedCity eq 'rabat' ? 'selected' : ''}>Rabat</option>
            <option value="casablanca" ${selectedCity eq 'casablanca' ? 'selected' : ''}>Casablanca</option>
            <option value="marrakech" ${selectedCity eq 'marrakech' ? 'selected' : ''}>Marrakech</option>
            <option value="tanger" ${selectedCity eq 'tanger' ? 'selected' : ''}>Tanger</option>
        </select>
        <button type="submit">🔄 Récupérer les données</button>
    </form>

    <button onclick="window.location.reload();">⟳ Rafraîchir la page</button>
</div>

<c:set var="selectedCity" value="${param.city != null ? param.city : 'fes'}" />

<!-- ========= CARTES ========= -->
<div class="cards">
    <c:set var="latestTemperature" value="${null}" />
    <c:set var="latestHumidity" value="${null}" />
    <c:set var="latestPressure" value="${null}" />

    <c:forEach var="reading" items="${readings}">
        <c:if test="${fn:containsIgnoreCase(reading.location, selectedCity)}">
            <c:choose>
                <c:when test="${reading.sensorType eq 'TEMPERATURE'}">
                    <c:set var="latestTemperature" value="${reading}" />
                </c:when>
                <c:when test="${reading.sensorType eq 'HUMIDITY'}">
                    <c:set var="latestHumidity" value="${reading}" />
                </c:when>
                <c:when test="${reading.sensorType eq 'PRESSURE'}">
                    <c:set var="latestPressure" value="${reading}" />
                </c:when>
            </c:choose>
        </c:if>
    </c:forEach>

    <c:if test="${not empty latestTemperature}">
        <div class="card" style="border-top: 4px solid #ff7f50;">
            <h3>🌡️ Température (${selectedCity})</h3>
            <div class="value">${latestTemperature.value}</div>
            <div class="unit">${latestTemperature.unit}</div>
        </div>
    </c:if>

    <c:if test="${not empty latestHumidity}">
        <div class="card" style="border-top: 4px solid #00bfff;">
            <h3>💧 Humidité (${selectedCity})</h3>
            <div class="value">${latestHumidity.value}</div>
            <div class="unit">${latestHumidity.unit}</div>
        </div>
    </c:if>

    <c:if test="${not empty latestPressure}">
        <div class="card" style="border-top: 4px solid #20b2aa;">
            <h3>🌬️ Pression (${selectedCity})</h3>
            <div class="value">${latestPressure.value}</div>
            <div class="unit">${latestPressure.unit}</div>
        </div>
    </c:if>
</div>

<!-- ========= FORMULAIRE MANUEL ========= -->
<h2>Ajouter une lecture manuelle</h2>
<form class="manual-input" action="${pageContext.request.contextPath}/iot-dashboard" method="post">
    <label>Sensor ID: <input type="text" name="sensorId" required></label>
    <label>Sensor Type: <input type="text" name="sensorType" required></label>
    <label>Valeur: <input type="number" step="any" name="value" required></label>
    <label>Unité: <input type="text" name="unit"></label>
    <label>Emplacement: <input type="text" name="location"></label>
    <button type="submit">Ajouter</button>
</form>

<!-- ========= TABLEAU AVEC FILTRES ========= -->
<h2>Lectures de capteurs</h2>

<div class="filter-bar">
    <label for="filterType">Type :</label>
    <input type="text" id="filterType" placeholder="ex: temperature...">
    <label for="filterCity">Ville :</label>
    <input type="text" id="filterCity" placeholder="ex: rabat...">
</div>

<c:if test="${empty readings}">
    <p style="text-align:center; color:#888;">Aucune lecture enregistrée.</p>
</c:if>

<c:if test="${not empty readings}">
    <table id="readingsTable">
        <thead>
        <tr>
            <th>Sensor ID</th>
            <th>Type</th>
            <th>Valeur</th>
            <th>Unité</th>
            <th>Emplacement</th>
            <th>Horodatage</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="reading" items="${readings}">
            <tr>
                <td>${reading.sensorId}</td>
                <td>${reading.sensorType}</td>
                <td>${reading.value}</td>
                <td>${reading.unit}</td>
                <td>${fn:substringBefore(reading.location, ' ')}</td>
                <td><fmt:formatDate value="${reading.timestampAsDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</c:if>

<!-- ========= JS ========= -->
<script>
    const REFRESH_INTERVAL = 60000;
    let userIsTyping = false;

    document.querySelectorAll("input, select, textarea").forEach(el => {
        el.addEventListener("focus", () => userIsTyping = true);
        el.addEventListener("blur", () => userIsTyping = false);
    });

    setInterval(() => {
        if (!userIsTyping) window.location.reload();
    }, REFRESH_INTERVAL);

    // 🔎 Filtres dynamiques
    const filterType = document.getElementById("filterType");
    const filterCity = document.getElementById("filterCity");

    function applyFilters() {
        const typeVal = filterType.value.toLowerCase();
        const cityVal = filterCity.value.toLowerCase();
        document.querySelectorAll("#readingsTable tbody tr").forEach(row => {
            const type = row.cells[1].textContent.toLowerCase();
            const city = row.cells[4].textContent.toLowerCase();
            row.style.display = (type.includes(typeVal) && city.includes(cityVal)) ? "" : "none";
        });
    }

    filterType.addEventListener("keyup", applyFilters);
    filterCity.addEventListener("keyup", applyFilters);
</script>

<div class="footer">
    &copy; 2025 IoT Platform — Données mises à jour automatiquement
</div>
</body>
</html>
