<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../style/css/jioayu.css" />
	<link rel="stylesheet" href="../style/css/index.css" />
    <link rel="shortcut icon " type="images/x-icon" href="../style/image/logo.ico">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>衡阳学院 - 教育教学</title>
</head>
<body>
<div class="app">
<div class="top" id="top">
	<div class="logo" onclick="window.location.href='../index.jsp?t=衡阳学院'">
		<img src="../style/image/logo-bai.png" alt="Logo" />
	</div>
	<div class="title-h1">
		<h1>衡阳学院 - 教育教学</h1>
	</div>
	<div class="so">
		<form action="../so.jsp" method="get">
			<input type="text" name="somsg" placeholder="检索的内容"/>
			<input type="submit" value="搜索" />
		</form>
	</div>
</div>
<div class="main">
<div class="main-all">
    <div class="education-section">
        <h2>教育教学动态</h2>
        <div class="news-list">
        
 	<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
        try {
            // 加载JDBC驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hengyang", "hengyang", "hengyang");
            stmt = conn.createStatement();
            // 执行SQL查询
            String sql = "SELECT wid,title,msg FROM info WHERE type like '教育教学' order by wid desc";
            rs = stmt.executeQuery(sql);
 
            // 遍历
            while (rs.next()) {
                int wid = rs.getInt("wid")+10000;
                String title = rs.getString("title");
                String msg = rs.getString("msg").length() > 120 ? rs.getString("msg").substring(0,120) + "..." : rs.getString("msg");
                msg = msg.replaceAll("</p>", "").replaceAll("</h2>", "").replaceAll("<h2>", "").replaceAll("<p>", "").replaceAll("<h1>", "").replaceAll("</h1>", "");
    %>
	    <div class="news-item" >
	       <h3><%= title %></h3>
	       <p><%= msg %></p>
	       <a href="../info.jsp?wid=<%= wid %>" class="read-more">阅读更多</a>
	    </div>
    <%
            }
    %>
            </div>
	    </div>
	
	    <div class="course-section">
	        <h2>精品推荐</h2>
	        <div class="course-list">
    
    <%
		    String sqls = "SELECT wid,title,msg,imageurl FROM info WHERE type like '专栏报道' order by wid desc";
		    rs = stmt.executeQuery(sqls);
		
		    // 遍历
		    while (rs.next()) {
		        int wid = rs.getInt("wid")+10000;
		        String title = rs.getString("title");
		        String imageurl = rs.getString("imageurl");
		        String msg = rs.getString("msg").length() > 120 ? rs.getString("msg").substring(0, 120) + "..." : rs.getString("msg");
		        msg = msg.replaceAll("</p>", "").replaceAll("</h2>", "").replaceAll("<h2>", "").replaceAll("<p>", "").replaceAll("<h1>", "").replaceAll("</h1>", "");
	%>
		<div class="news-item" >
		<img src="../style/image/<%= imageurl %>" alt="<%= title %>" class="course-img">
        <h3><%= title %></h3>
		<p><%= msg %></p>
		<a href="../info.jsp?wid=<%= wid %>" class="read-more">阅读更多</a>
		</div>
	<%
		    }
        } catch (Exception e) {
            e.printStackTrace(); // 打印异常
        } finally {
            // 关闭资源
            try { if (rs != null) rs.close(); } catch (SQLException e) { /* ignored */ }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { /* ignored */ }
            try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
        }
    %>
        </div>
    </div>
</div>
</div>
<%@ include file="../bottom.jsp" %>