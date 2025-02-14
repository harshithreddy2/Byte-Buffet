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
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "123456");
        String sql = "SELECT * FROM user1 WHERE mail = ? AND pass = ?";
        pst = con.prepareStatement(sql);
        pst.setString(1, email.trim());  
        pst.setString(2, password.trim());
        rs = pst.executeQuery();
        if (rs.next()) {
            response.sendRedirect("a1.html");
        } else {
            out.print("Invalid Email or Password.");
        }
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
        e.printStackTrace();
    }
%>
</body>
</html>
