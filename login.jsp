<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.Cookie" %>
    
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
		out.println("<script>alert('"+logonusername+"，您已登录无需注册！');window.location.href='index.jsp'</script>");
	}

%>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="style/css/index.css" />
	<link rel="stylesheet" href="style/css/login.css" />
    <link rel="shortcut icon " type="images/x-icon" href="style/image/logo.ico">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>衡阳学院 - 注册</title>
</head>
<body>
<div class="app">
<div class="top" id="top">
	<div class="logo" onclick="window.location.href='index.jsp?t=衡阳学院'">
		<img src="style/image/logo-bai.png" alt="Logo" />
	</div>
	<div class="title-h1">
		<h1>衡阳学院 - 注册</h1>
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
	<div class="container">
        <form action="api/back_login.jsp" method="post">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" placeholder="用户名" required>
            </div>
            <div class="form-group">
                <label for="studentId">学号</label>
                <input type="text" id="studentId" name="sno" placeholder="学号" required>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" placeholder="6-15位密码" required>
            </div>
			<div class="form-group">
			    <label for="password">确认密码</label>
			    <input type="password" id="verpassword" name="verpassword" placeholder="确认密码相同" required>
			</div>
            <button type="submit">注册</button>
        </form>
		<a href="index.jsp">返回登录</a>
    </div>
</div>	
</div>

<%@ include file="bottom.jsp" %>