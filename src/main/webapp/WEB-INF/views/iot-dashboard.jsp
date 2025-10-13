<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord IoT</title>
</head>
<body>
<h1>Tableau de Bord IoT</h1>

<h2>Ajouter une lecture manuelle</h2>
<form action="${pageContext.request.contextPath}/iot-dashboard" method="post">
    <label>Sensor ID: <input type="text" name="sensorId" required></label><br>
    <label>Sensor Type: <input type="text" name="sensorType" required></label><br>
    <label>Valeur: <input type="number" step="any" name="value" required></label><br>
    <label>Unité: <input type="text" name="unit"></label><br>
    <label>Emplacement: <input type="text" name="location"></label><br>
    <button type="submit">Ajouter</button>
</form>

<h2>Données météo en temps réel</h2>

<form action="${pageContext.request.contextPath}/fetch-api" method="get" style="display:inline-block; margin-bottom: 10px;">
    <label for="city">Ville :</label>
    <select name="city" id="city">
        <option value="fes" selected>Fès</option>
        <option value="rabat">Rabat</option>
        <option value="casablanca">Casablanca</option>
        <option value="marrakech">Marrakech</option>
        <option value="tanger">Tanger</option>
    </select>

    <button type="submit">🔄 Récupérer les données</button>
</form>


<h2>Lectures de capteurs</h2>

<c:if test="${empty readings}">
    <p>Aucune lecture enregistrée.</p>
</c:if>

<c:if test="${not empty readings}">
    <table border="1" cellpadding="8" cellspacing="0">
        <thead>
        <tr>
            <th>ID Lecture</th>
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
                <td>${reading.readingId}</td>
                <td>${reading.sensorId}</td>
                <td>${reading.sensorType}</td>
                <td>${reading.value}</td>
                <td>${reading.unit}</td>
                <td>${reading.location}</td>
                <td>
                    <fmt:formatDate value="${reading.timestampAsDate}" pattern="yyyy-MM-dd HH:mm:ss"/>

                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</c:if>

</body>
</html>
