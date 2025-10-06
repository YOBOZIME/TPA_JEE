<%--
  Created by IntelliJ IDEA.
  User: abdelali
  Date: 06/10/2025
  Time: 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
    <title>Tableau de Bord IoT</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #f5f7fa;
        }
        h1 {
            color: #2c3e50;
            text-align: center;
        }
        form {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            width: 60%;
            margin: 20px auto;
        }
        form input, form button {
            display: block;
            margin: 10px 0;
            width: 100%;
            padding: 8px;
        }
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #3498db;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .no-data {
            text-align: center;
            color: gray;
        }
    </style>
</head>

<body>
<h1>Tableau de Bord IoT</h1>

<!-- Formulaire pour ajouter une nouvelle lecture -->
<form action="${pageContext.request.contextPath}/iot-dashboard" method="post">
    <h3>Ajouter une nouvelle lecture</h3>
    <input type="text" name="sensorId" placeholder="Identifiant du Capteur" required>
    <input type="text" name="sensorType" placeholder="Type de Capteur" required>
    <input type="number" step="any" name="value" placeholder="Valeur" required>
    <input type="text" name="unit" placeholder="Unité de mesure" required>
    <input type="text" name="location" placeholder="Lieu" required>
    <button type="submit">Enregistrer</button>
</form>

<!-- Affichage des lectures -->
<h2 style="text-align:center;">Lectures des Capteurs</h2>

<c:choose>
    <c:when test="${not empty readings}">
        <table>
            <thead>
            <tr>
                <th>ID Lecture</th>
                <th>Capteur</th>
                <th>Type</th>
                <th>Valeur</th>
                <th>Unité</th>
                <th>Lieu</th>
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
                    <td>${reading.timestamp}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <p class="no-data">Aucune lecture disponible pour le moment.</p>
    </c:otherwise>
</c:choose>

</body>
</html>

