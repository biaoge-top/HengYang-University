<%@ page import="java.sql.*, java.util.*, java.security.MessageDigest, java.security.NoSuchAlgorithmException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

	//检查登录
	Cookie[] cookies = request.getCookies();
	String logonusername = null;
	if (cookies != null) {
	    for (Cookie cookie : cookies) {
	        if ("logonusername".equals(cookie.getName())) {
	        	logonusername = cookie.getValue(); // 获取Cookie的值
	            break; 
	        }
	    }
	}
	if(logonusername!=null){
		out.println("<script>alert('"+logonusername+"，您已登录无需注册！');window.location.href='../index.jsp'</script>");
	}
	
    // 获取表单参数
    String username = request.getParameter("username");
    String sno = request.getParameter("sno"); 
    String password = request.getParameter("password");
    String verpassword = request.getParameter("verpassword");

    // 初始化数据库连接
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        //JDBC
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hengyang", "hengyang", "hengyang");
        //匹配
        if (password == null || verpassword == null || !password.equals(verpassword)) {
            out.println("<script>alert('密码不匹配或未填写！');window.location.href='../login.jsp'</script>");
        } else {
            // 检查用户名和学号
            String checkUserQuery = "SELECT COUNT(*) FROM users WHERE username = ? OR sno = ?";
            pstmt = conn.prepareStatement(checkUserQuery);
            pstmt.setString(1, username);
            pstmt.setString(2, sno);
            rs = pstmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                out.println("<script>alert('用户名或学号已存在！');window.location.href='../login.jsp'</script>");
            } else {
                // 密码加密
                MessageDigest md = MessageDigest.getInstance("MD5");
                byte[] digest = md.digest(password.getBytes("UTF-8"));
                StringBuilder hexString = new StringBuilder();
                for (byte b : digest) {
                    String hex = Integer.toHexString(0xff & b);
                    if (hex.length() == 1) hexString.append('0');
                    hexString.append(hex);
                }
                String hashedPassword = hexString.toString();

                // 插入
                String insertQuery = "INSERT INTO users (username, sno, password) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(insertQuery);
                pstmt.setString(1, username);
                pstmt.setString(2, sno);
                pstmt.setString(3, hashedPassword);

                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<script>alert('注册成功！');window.location.href='../index.jsp'</script>");
                } else {
                    out.println("<script>alert('注册失败，请重试！');window.location.href='../login.jsp'</script>");
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println();
        out.println("<script>alert('发生错误：" + e.getMessage()+"');window.location.href='../login.jsp'</script>");
    } finally {
        // 关闭资源
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>