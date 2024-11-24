<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.nio.file.*" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    request.setAttribute("logonusername", logonusername);
%>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
    <link rel="shortcut icon " type="images/x-icon" href="style/image/logo.ico">
	<link rel="stylesheet" href="style/css/index.css" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>衡阳学院 - 首页</title>
</head>
<body>
<div class="app">
<div class="top" id="top">
	<div class="logo" onclick="window.location.href='index.jsp?t=衡阳学院'">
		<img src="style/image/logo-bai.png" alt="Logo" />
	</div>
	<div class="title-h1">
		<!-- h1>站点为学习专用，非官方站点！</h1 -->
	</div>
	<div class="so">
		<form action="so.jsp" method="get">
			<input type="text" name="somsg" placeholder="检索的内容"/>
			<input type="submit" value="搜索" />
		</form>
	</div>
</div>
<div class="nev">
	<div class="nev-item">
		<a class="nev-name" href="page/jianjie.jsp" target="_blank">学院简介</a>
	</div>
	<div class="nev-item">
		<a class="nev-name" href="page/yuanbu.jsp" target="_blank">院部设置</a>
	</div>
	<div class="nev-item">
		<a class="nev-name" href="page/jioayu.jsp" target="_blank">教育教学</a>
	</div>
	<div class="nev-item">
		<a class="nev-name" href="page/zhaosheng.jsp" target="_blank">招生就业</a>
	</div>
	<div class="nev-item">
		<a class="nev-name" href="page/xinxi.jsp" target="_blank">信息公开</a>
	</div>
</div>
<div class="main">
<div class="main-all">
	<div class="index-pic">
		<div class="pic-item-1" id="pic1">
			<img src="style/image/pic1.png"/>
		</div>
		<div class="pic-item-2" id="pic2">
			<img src="style/image/pic2.png"/>
		</div>
		<div class="pic-item-3" id="pic3">
			<img src="style/image/pic3.png"/>
		</div>
	</div>
	<div class="main-bottom">
		<div class="info">
			<div class="xinwen">
				<span class="info-title">通知公告</span>
				<div class="xinwen-item">
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
            String sql = "SELECT wid, title FROM info  order by wid desc LIMIT 15"; 
            rs = stmt.executeQuery(sql);
 
            // 遍历
            while (rs.next()) {
                int wid = rs.getInt("wid")+10000;
                String title = rs.getString("title");
    	%>
    	<li><a href="info.jsp?wid=<%= wid %>" target="_blank"><%= title %></a></li>
    	<%
            }
    	%>
				</div>
			</div>
		</div>
		<div class="zhuanti">
			<span class="info-title">专栏报道</span>
			<div class="zhuanti-item"> 
    	<%        
		    String sqls = "SELECT wid,title,imageurl,msg FROM info WHERE type like '专栏报道' order by wid desc LIMIT 3"; 
		    rs = stmt.executeQuery(sqls);

		    // 遍历新闻
		    while (rs.next()) {
		        int wid = rs.getInt("wid")+10000;
		        String title = rs.getString("title");
		        String imageurl = rs.getString("imageurl");
		        String msg = rs.getString("msg").length() > 60 ? rs.getString("msg").substring(0, 60) + "..." : rs.getString("msg");
				msg = msg.replaceAll("<p>", "").replaceAll("</p>", "").replaceAll("<h1>", "").replaceAll("</h1>", "").replaceAll("<h2>", "").replaceAll("</h2>", "");
		%>
					<div class="zhuanti-li" onclick="window.open('info.jsp?wid=<%= wid %>')">
						<li class="zhuanti-img"><img src="style/image/<%= imageurl %>"/></li>
						<div class="zhuanti-li-msg">
							<li class="zhuanti-msg-title"><%= title %></li>
							<p class="zhuanti-msg-msg"><%= msg %></p>
						</div>
					</div>
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
			</div>
		</div>

<div class="index-right">
	<c:choose>
	    <c:when test="${not empty logonusername}">
	        <span class="info-title">账号信息</span>
	        <div class="user-info">
	        	<li>已登录，欢迎 ${logonusername}！</li>
	        	<button><a href="api/exit_logon.jsp">退出登录</a></button>
	        </div>
	    </c:when>
	    <c:otherwise>
	        <!-- 未登录 -->
	            <span class="info-title">账号登录</span>
	            <div class="logon">
	                <form action="api/back_logon.jsp" method="post">
	                    <input type="text" name="username" placeholder="学号 / 用户名" />
	                    <input type="password" name="password" placeholder="密码" />
	                    <input type="submit" name="login" value="登录" />
	                    <a href="login.jsp">没有账号？注册</a>
	                </form>
	            </div>
	    </c:otherwise>
	</c:choose>
		</div>	
	</div>
</div>	
</div>
<%@ include file="bottom.jsp" %>
