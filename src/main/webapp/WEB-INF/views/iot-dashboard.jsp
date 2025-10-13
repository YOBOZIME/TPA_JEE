<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IoT Dashboard - Monitoring Intelligent</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        /* ===== VARIABLES & RESET ===== */
        :root {
            --primary: #0078d7;
            --primary-dark: #005fa3;
            --secondary: #6c757d;
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffc107;
            --info: #17a2b8;
            --light: #f8f9fa;
            --dark: #343a40;
            --gradient: linear-gradient(135deg, #0078d7, #005fa3);
            --shadow: 0 4px 20px rgba(0,0,0,0.08);
            --shadow-hover: 0 8px 30px rgba(0,0,0,0.12);
            --radius: 12px;
            --transition: all 0.3s ease;
        }

        /* ===== GENERAL IMPROVEMENTS ===== */
        body {
            font-family: 'Segoe UI', 'Inter', Roboto, sans-serif;
            background: linear-gradient(135deg, #f0f4f8 0%, #e8eff5 100%);
            color: #2d3748;
            margin: 0;
            padding: 20px;
            line-height: 1.6;
        }

        .app-container {
            max-width: 1400px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
        }

        h1 {
            text-align: center;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
            font-size: 2.5em;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .header p {
            text-align: center;
            color: var(--secondary);
            font-size: 1.1em;
            margin-bottom: 30px;
        }

        h2 {
            color: var(--dark);
            border-left: 4px solid var(--primary);
            padding-left: 15px;
            margin-top: 40px;
            margin-bottom: 20px;
            font-size: 1.5em;
            font-weight: 600;
        }

        /* ===== CONTROL BAR IMPROVEMENTS ===== */
        .control-bar {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            margin: 30px 0 40px 0;
            flex-wrap: wrap;
            background: white;
            padding: 20px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        .city-selector {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 500;
        }

        select, input[type="text"], input[type="number"] {
            padding: 10px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            outline: none;
            transition: var(--transition);
            min-width: 140px;
            font-size: 0.95em;
            background: white;
        }

        select:focus, input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(0, 120, 215, 0.1);
            transform: translateY(-1px);
        }

        button {
            background: var(--gradient);
            border: none;
            color: white;
            padding: 12px 24px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.95em;
        }

        button:hover {
            background: linear-gradient(135deg, var(--primary-dark), #004a7a);
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        /* ===== CARDS IMPROVEMENTS ===== */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .card {
            background: white;
            border-radius: 16px;
            box-shadow: var(--shadow);
            padding: 25px;
            text-align: center;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient);
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-hover);
        }

        .card-icon {
            font-size: 2.5em;
            margin-bottom: 15px;
        }

        .card-title {
            font-size: 1em;
            color: var(--secondary);
            margin-bottom: 10px;
            font-weight: 500;
        }

        .card-value {
            font-size: 2.5em;
            font-weight: 700;
            color: var(--dark);
            margin: 10px 0;
        }

        .card-unit {
            font-size: 1.1em;
            color: var(--secondary);
            margin-bottom: 10px;
        }

        .card-city {
            background: var(--light);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            color: var(--secondary);
            display: inline-block;
        }

        /* Specific card colors */
        .temperature::before { background: linear-gradient(135deg, #ff6b6b, #ee5a24); }
        .humidity::before { background: linear-gradient(135deg, #4ecdc4, #00b894); }
        .pressure::before { background: linear-gradient(135deg, #74b9ff, #0984e3); }

        /* ===== TABLE IMPROVEMENTS ===== */
        .table-container {
            background: white;
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95em;
        }

        th {
            background: var(--gradient);
            color: white;
            font-weight: 600;
            padding: 16px 20px;
            text-align: left;
            position: sticky;
            top: 0;
        }

        td {
            padding: 14px 20px;
            border-bottom: 1px solid #f1f3f4;
        }

        tr {
            transition: var(--transition);
        }

        tr:not(:last-child) td {
            border-bottom: 1px solid #f1f3f4;
        }

        tr:hover {
            background: #f8fbff;
            transform: scale(1.01);
        }

        /* ===== FORM IMPROVEMENTS ===== */
        .form-section {
            background: white;
            padding: 30px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            margin-top: 30px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--dark);
        }

        /* ===== FILTER BAR IMPROVEMENTS ===== */
        .filters {
            display: flex;
            gap: 15px;
            margin: 20px 0;
            flex-wrap: wrap;
        }

        .filters input {
            flex: 1;
            min-width: 200px;
        }

        /* ===== FOOTER IMPROVEMENTS ===== */
        .footer {
            text-align: center;
            margin-top: 50px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
            color: var(--secondary);
            font-size: 0.9em;
        }

        /* ===== RESPONSIVE IMPROVEMENTS ===== */
        @media (max-width: 768px) {
            .app-container {
                padding: 20px;
                border-radius: 15px;
            }

            .cards-grid {
                grid-template-columns: 1fr;
            }

            .control-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            h1 {
                font-size: 2em;
            }
        }

        /* ===== ANIMATIONS ===== */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card, .form-section, .table-container {
            animation: fadeIn 0.6s ease-out;
        }

        /* ===== LOADING STATES ===== */
        button:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none !important;
        }

        /* ===== STATUS INDICATORS ===== */
        .status-indicator {
            display: inline-block;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            margin-right: 8px;
        }

        .status-online { background: var(--success); }
        .status-offline { background: var(--danger); }
        .status-warning { background: var(--warning); }
    </style>

</head>
<body>
<div class="app-container">
    <!-- Header -->
    <div class="header">
        <h1><i class="fas fa-chart-network"></i> Tableau de Bord IoT</h1>
        <p>Surveillance et analyse des données de capteurs en temps réel</p>
    </div>

    <!-- Control Bar -->
    <form action="${pageContext.request.contextPath}/fetch-api" method="get" class="control-bar" id="cityForm">
        <div class="city-selector">
            <label for="city"><i class="fas fa-map-marker-alt"></i> Ville :</label>
            <select class="form-control" name="city" id="city" style="width: 150px;">
                <option value="fes" ${selectedCity eq 'fes' ? 'selected' : ''}>Fès</option>
                <option value="rabat" ${selectedCity eq 'rabat' ? 'selected' : ''}>Rabat</option>
                <option value="casablanca" ${selectedCity eq 'casablanca' ? 'selected' : ''}>Casablanca</option>
                <option value="marrakech" ${selectedCity eq 'marrakech' ? 'selected' : ''}>Marrakech</option>
                <option value="tanger" ${selectedCity eq 'tanger' ? 'selected' : ''}>Tanger</option>
            </select>
            <input type="hidden" name="cityHidden" id="cityHidden" value="${selectedCity}">
        </div>
        <div style="display: flex; gap: 10px;">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-sync-alt"></i> Actualiser
            </button>
            <button type="button" class="btn btn-secondary" id="refreshBtn">
                <i class="fas fa-redo"></i> Rafraîchir
            </button>
        </div>
    </form>

    <!-- Cards Grid -->
    <div class="cards-grid">
        <c:set var="latestTemperature" value="${null}" />
        <c:set var="latestHumidity" value="${null}" />
        <c:set var="latestPressure" value="${null}" />
        <c:forEach var="reading" items="${readings}">
            <c:if test="${fn:containsIgnoreCase(reading.location, selectedCity)}">
                <c:choose>
                    <c:when test="${reading.sensorType eq 'TEMPERATURE'}"><c:set var="latestTemperature" value="${reading}" /></c:when>
                    <c:when test="${reading.sensorType eq 'HUMIDITY'}"><c:set var="latestHumidity" value="${reading}" /></c:when>
                    <c:when test="${reading.sensorType eq 'PRESSURE'}"><c:set var="latestPressure" value="${reading}" /></c:when>
                </c:choose>
            </c:if>
        </c:forEach>

        <!-- Temperature Card -->
        <div class="card temperature">
            <div class="card-icon">🌡️</div>
            <div class="card-title">Température</div>
            <div class="card-value">
                <c:choose>
                    <c:when test="${not empty latestTemperature}">${latestTemperature.value}</c:when>
                    <c:otherwise>--</c:otherwise>
                </c:choose>
            </div>
            <div class="card-unit">
                <c:if test="${not empty latestTemperature}">${latestTemperature.unit}</c:if>
            </div>
            <div class="card-city">${selectedCity}</div>
        </div>

        <!-- Humidity Card -->
        <div class="card humidity">
            <div class="card-icon">💧</div>
            <div class="card-title">Humidité</div>
            <div class="card-value">
                <c:choose>
                    <c:when test="${not empty latestHumidity}">${latestHumidity.value}</c:when>
                    <c:otherwise>--</c:otherwise>
                </c:choose>
            </div>
            <div class="card-unit">
                <c:if test="${not empty latestHumidity}">${latestHumidity.unit}</c:if>
            </div>
            <div class="card-city">${selectedCity}</div>
        </div>

        <!-- Pressure Card -->
        <div class="card pressure">
            <div class="card-icon">🌬️</div>
            <div class="card-title">Pression</div>
            <div class="card-value">
                <c:choose>
                    <c:when test="${not empty latestPressure}">${latestPressure.value}</c:when>
                    <c:otherwise>--</c:otherwise>
                </c:choose>
            </div>
            <div class="card-unit">
                <c:if test="${not empty latestPressure}">${latestPressure.unit}</c:if>
            </div>
            <div class="card-city">${selectedCity}</div>
        </div>
    </div>

    <!-- Manual Input Form -->
    <div class="form-section">
        <h2 class="section-title"><i class="fas fa-plus-circle"></i> Ajouter une Lecture Manuelle</h2>
        <form id="manualForm">
            <div class="form-grid">
                <div class="form-group">
                    <label for="sensorId">ID du Capteur</label>
                    <input type="text" id="sensorId" name="sensorId" class="form-control" required placeholder="ex: SENSOR-001">
                </div>
                <div class="form-group">
                    <label for="sensorType">Type de Capteur</label>
                    <select id="sensorType" name="sensorType" class="form-control" required>
                        <option value="">Sélectionnez un type</option>
                        <option value="TEMPERATURE">🌡️ Température</option>
                        <option value="HUMIDITY">💧 Humidité</option>
                        <option value="PRESSURE">🌬️ Pression</option>
                        <option value="MOTION">🚶 Mouvement</option>
                        <option value="LIGHT">💡 Lumière</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="value">Valeur</label>
                    <input type="number" step="any" id="value" name="value" class="form-control" required placeholder="ex: 25.5">
                </div>
                <div class="form-group">
                    <label for="unit">Unité</label>
                    <input type="text" id="unit" name="unit" class="form-control" placeholder="ex: °C, %, hPa">
                </div>
                <div class="form-group">
                    <label for="location">Emplacement</label>
                    <input type="text" id="location" name="location" class="form-control" placeholder="ex: ${selectedCity} Bâtiment A">
                </div>
            </div>
            <button type="submit" class="btn btn-primary" style="margin-top:20px;">
                <i class="fas fa-paper-plane"></i> Envoyer la Lecture
            </button>
        </form>
    </div>

    <!-- Readings Table -->
    <div class="form-section">
        <div class="table-header">
            <h2 class="section-title" style="margin:0;"><i class="fas fa-table"></i> Historique des Lectures</h2>
        </div>

        <c:if test="${empty readings}">
            <div style="text-align:center; padding:60px; color: var(--gray-600);">
                <i class="fas fa-inbox" style="font-size:3rem; margin-bottom:20px; opacity:0.5;"></i>
                <h3 style="margin-bottom:10px;">Aucune donnée disponible</h3>
                <p>Ajoutez votre première lecture pour commencer la surveillance</p>
            </div>
        </c:if>

        <c:if test="${not empty readings}">
            <div class="filters">
                <input type="text" id="filterType" class="form-control" placeholder="Filtrer par type...">
                <input type="text" id="filterCity" class="form-control" placeholder="Filtrer par ville...">
            </div>

            <div class="table-container">
                <table class="data-table" id="readingsTable">
                    <thead>
                    <tr>
                        <th>Capteur</th>
                        <th>Type</th>
                        <th>Valeur</th>
                        <th>Unité</th>
                        <th>Date</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="reading" items="${readings}">
                        <tr>
                            <td>${reading.sensorId}</td>
                            <td>${reading.sensorType}</td>
                            <td>${reading.value}</td>
                            <td>${reading.unit}</td>
                            <td>${reading.location}</td>
                            <td><fmt:formatDate value="${reading.timestamp}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>

    <div class="footer">
        &copy; ${pageContext.request.serverName} | Tableau de Bord IoT
    </div>
</div>

<!-- JS -->
<script>
    const citySelect = document.getElementById('city');
    const cityHidden = document.getElementById('cityHidden');
    const cityForm = document.getElementById('cityForm');
    const refreshBtn = document.getElementById('refreshBtn');
    const filterType = document.getElementById('filterType');
    const filterCity = document.getElementById('filterCity');
    const table = document.getElementById('readingsTable');
    const manualForm = document.getElementById('manualForm');
    const sensorType = document.getElementById('sensorType');
    const unit = document.getElementById('unit');
    const locationField = document.getElementById('location');

    // City selector auto-submit
    citySelect.addEventListener('change', () => {
        cityHidden.value = citySelect.value;
        cityForm.submit();
    });

    // Refresh button
    refreshBtn.addEventListener('click', () => window.location.reload());

    // Table filters
    function applyFilters() {
        const typeVal = filterType?.value?.toLowerCase() || "";
        const cityVal = filterCity?.value?.toLowerCase() || "";

        table.querySelectorAll("tbody tr").forEach(row => {
            const type = row.cells[1].textContent.toLowerCase();
            const city = row.cells[4].textContent.toLowerCase();
            row.style.display = (type.includes(typeVal) && city.includes(cityVal)) ? "" : "none";
        });
    }
    filterType?.addEventListener("input", applyFilters);
    filterCity?.addEventListener("input", applyFilters);

    // Auto-fill unit & location
    sensorType.addEventListener('change', function() {
        const unitMap = {
            'TEMPERATURE': '°C',
            'HUMIDITY': '%',
            'PRESSURE': 'hPa',
            'LIGHT': 'lux',
            'MOTION': 'detected'
        };
        unit.value = unitMap[this.value] || '';
        if (this.value && !locationField.value) locationField.value = citySelect.value + ' ';
    });

    // Submit manual form via AJAX
    manualForm.addEventListener('submit', async function(e){
        e.preventDefault();
        const formData = new FormData(manualForm);
        try {
            const res = await fetch('${pageContext.request.contextPath}/add-reading', {
                method: 'POST',
                body: formData
            });
            if(res.ok){
                alert('Lecture ajoutée avec succès !');
                manualForm.reset();
                location.reload(); // optional: reload to update table
            } else {
                alert('Erreur lors de l\'ajout.');
            }
        } catch(err){
            console.error(err);
            alert('Erreur réseau.');
        }
    });
</script>
</body>
</html>
