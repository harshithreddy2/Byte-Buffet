<%@ page import="java.sql.*" %>
<html>
<body>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    if (email == null || password == null) {
        out.print("Error: Email or Password cannot be empty");
        return;
    }
    try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "123456");
         Statement st = con.createStatement()) {
        Class.forName("oracle.jdbc.driver.OracleDriver");

        int result = st.executeUpdate("INSERT INTO user1 (mail, pass) VALUES ('" + email + "', '" + password + "')");
        if (result > 0) {
            response.sendRedirect("projectsignin.html");
        } else {
            out.print("Insert failed");
        }
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
</body>
</html>
