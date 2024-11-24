<%@ page import="java.sql.*, java.util.*, java.security.MessageDigest, java.security.NoSuchAlgorithmException" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%
    // 获取请求参数
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    if(username==null || password==null){
    	out.println("<script>alert('请输入账号或者密码');window.location.href='../login.jsp'</script>");
    }
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean isValidUser = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); 

        // 建立连接
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hengyang", "hengyang", "hengyang");
                
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] digest = md.digest(password.getBytes("UTF-8")); 
        StringBuilder hexString = new StringBuilder();
        for (byte b : digest) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        String hashedPassword = hexString.toString();

        
        //查询
        String sql = "SELECT * FROM users WHERE (username = ? OR sno = ?) AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, username); // sno字段
        pstmt.setString(3, hashedPassword);

        // 查询
        rs = pstmt.executeQuery();
        if (rs.next()) {
            isValidUser = true; //密码正确

            // 检查用户状态
            String state = rs.getString("state");
            if ("1".equals(state)) { 
                isValidUser = false; // 禁用
            }
        }

    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<script>alert('数据库驱动加载失败！');window.location.href='../index.jsp'</script>");
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('数据库连接或查询失败!');window.location.href='../index.jsp'</script>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //设置cookie
    if (isValidUser) {
    	Cookie userCookie = new Cookie("logonusername", username);
		userCookie.setMaxAge(60 * 60 * 48);
    	userCookie.setPath("/");
    	response.addCookie(userCookie);
        response.sendRedirect("../index.jsp");
    } else {
        // 验证失败
        out.println("<script>alert('登录失败,用户名或密码错误');window.location.href='../index.jsp'</script>");
    }
%>