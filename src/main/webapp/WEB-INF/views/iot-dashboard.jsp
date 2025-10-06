<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord IoT</title>
</head>
<body>
<h1>Tableau de Bord IoT</h1>

<h2>Ajouter une lecture</h2>
<form action="${pageContext.request.contextPath}/iot-dashboard" method="post">
    <label>Sensor ID: <input type="text" name="sensorId" required></label><br>
    <label>Sensor Type: <input type="text" name="sensorType" required></label><br>
    <label>Valeur: <input type="number" step="any" name="value" required></label><br>
    <label>Unité: <input type="text" name="unit"></label><br>
    <label>Emplacement: <input type="text" name="location"></label><br>
    <button type="submit">Ajouter</button>
</form>

<h2>Lectures de capteurs</h2>
<c:if test="${empty readings}">
    <p>Aucune lecture enregistrée.</p>
</c:if>

<c:forEach var="reading" items="${readings}">
    <p>
        Capteur: ${reading.sensorId} (${reading.sensorType}),
        Valeur: ${reading.value} ${reading.unit},
        Lieu: ${reading.location},
        Timestamp: ${reading.timestamp}
    </p>
</c:forEach>
</body>
</html>
