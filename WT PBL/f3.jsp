<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reservation</title>
</head>
<body>
<%
    // Get request parameters
    String location = request.getParameter("location");
    String date = request.getParameter("date");
    String session = request.getParameter("session");
    String time = request.getParameter("time");

    // Validate that all required fields are provided
    if (location == null || date == null || session == null || time == null ||
        location.trim().isEmpty() || date.trim().isEmpty() || session.trim().isEmpty() || time.trim().isEmpty()) {
        out.print("<p style='color: red;'>Error: All fields are required.</p>");
    } else {
        try {
            // Load Oracle JDBC Driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Establish database connection
            try (Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "system", "123456");
                 PreparedStatement ps = con.prepareStatement(
                         "INSERT INTO reserve (location, date, session, time) VALUES (?, ?, ?, ?)")) {
                
                // Set parameters in the query
                ps.setString(1, location);
                ps.setString(2, date);
                ps.setString(3, session);
                ps.setString(4, time);

                // Execute the query and check the result
                int result = ps.executeUpdate();
                if (result > 0) {
                    // Redirect to a confirmation page on success
                    response.sendRedirect("confirmation.html");
                } else {
                    out.print("<p style='color: red;'>Reservation failed. Please try again.</p>");
                }
            }
        } catch (ClassNotFoundException e) {
            out.print("<p style='color: red;'>Error: JDBC Driver not found - " + e.getMessage() + "</p>");
        } catch (SQLException e) {
            out.print("<p style='color: red;'>Error: Database error - " + e.getMessage() + "</p>");
        } catch (Exception e) {
            out.print("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        }
    }
%>
</body>
</html>
