<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.Cookie" %>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="style/css/so.css" />
	<link rel="stylesheet" href="style/css/index.css" />
    <link rel="shortcut icon " type="images/x-icon" href="style/image/logo.ico">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>衡阳学院 - 全站搜索</title>
</head>
<body>
<div class="app">
<div class="top" id="top">
	<div class="logo" onclick="window.location.href='index.jsp?t=衡阳学院'">
		<img src="style/image/logo-bai.png" alt="Logo" />
	</div>
	<div class="title-h1">
		<h1>衡阳学院 - 全站搜索</h1>
	</div>
	<div class="so">
		<form action="so.jsp" method="get">
			<input type="text" name="somsg" placeholder="检索的内容"/>
			<input type="submit" value="搜索" />
		</form>
	</div>
</div>
<div class="main">
<div class="main-all">
    <div class="search-tips">
        <p>输入关键词，如新闻标题、课程名称开始您的搜索之旅。</p>
    </div>
    
    <div class="search-results">
        <h2>搜索结果</h2>
        <ul>
   <%
    String somsg = request.getParameter("somsg");
    if (somsg == null) somsg = "";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hengyang", "hengyang", "hengyang");
        String sql = "SELECT wid, title, imageurl, msg, username, time FROM info WHERE title LIKE '%' ? '%'";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, somsg); // somsg
        rs = stmt.executeQuery();
 
        while (rs.next()) {
            int wid = rs.getInt("wid") + 10000;
            String title = rs.getString("title");
            String imageurl = (rs.getString("imageurl") != null && !rs.getString("imageurl").isEmpty()) ? rs.getString("imageurl") : "logo_min.png";
            String msg = rs.getString("msg");
            
            if (msg != null && msg.length() > 60) {
                msg = msg.substring(0, 60) + "...";
            }
            msg = msg.replaceAll("<p>", "").replaceAll("<h1>", "").replaceAll("</h1>", "");
%>
<li class="search-item">
    <a href="info.jsp?wid=<%= wid %>">
        <img src="style/image/<%= imageurl %>" alt="<%= title %>" class="search-icon">
        <span class="search-title"><%= title %></span> 
        <span class="search-description"><%= msg %></span> 
    </a>
</li>
<%
       
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { /* ignored */ }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { /* ignored */ }
        try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
    }
%>

        </ul>
        <!-- 如果没有搜索结果 -->
        <div class="no-results" style="display:none;">
            <p>没有找到与您的搜索词匹配的结果。</p>
        </div>
    </div>
</div>
</div>
<%@ include file="bottom.jsp" %>