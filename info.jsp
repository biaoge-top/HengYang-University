<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style/css/info.css" />
    <link rel="stylesheet" href="style/css/index.css" />
    <link rel="shortcut icon " type="images/x-icon" href="style/image/logo.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>衡阳学院 - 文章详细</title>
</head>
<body>
<div class="app">
<div class="top" id="top">
	<div class="logo" onclick="window.location.href='index.jsp?t=衡阳学院'">
		<img src="style/image/logo-bai.png" alt="Logo" />
	</div>
	<div class="title-h1">
		<h1>衡阳学院 - 文章详细</h1>
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
            <div class="article-container">
                <%
                String widStr = request.getParameter("wid");
                int wid = -1;
                try {
                    wid = Integer.parseInt(widStr); if (wid > 10000) {
                        wid -= 10000;
                    } else {
                    	out.println("无效的文章Wid");
                    }
                } catch (NumberFormatException e) {
                    out.println("无效的文章Wid");
                }
                    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hengyang", "hengyang", "hengyang");
                        PreparedStatement stmt = conn.prepareStatement("SELECT wid, title, imageurl, msg, username, time FROM info WHERE wid = ?")) {

                        stmt.setInt(1, wid);
                        ResultSet rs = stmt.executeQuery();

                        if (rs.next()) {
                            String title = rs.getString("title");
                            String imageurl = rs.getString("imageurl");
                            String msg = rs.getString("msg");
                            String username = rs.getString("username");
                            String time = rs.getString("time");
                %>
                <div class="article-header">
                    <h2><%= title %></h2>
                    <div class="article-meta">
                        <span>作者: <%= username %></span>
                        <span>发布日期: <%= time %></span>
                    </div>
                </div>
                <div class="article-content">
                    <%
					    if (imageurl == null || imageurl.trim().isEmpty()) {
					%>
					    <!-- 图片为空 -->
					<%
					    } else {
					%>
					    <img src="style/image/<%= imageurl %>" alt="图片" class="article-image">
					<%
					    }
					%>
                    <p><%= msg %></p>
                    <%
	                        } else {
	                            out.println("没有找到对应的文章");
	                        }
	
	                    } catch (SQLException e) {
	                        e.printStackTrace();
	                        out.println("数据库查询错误");
	                    }
	                %>
                </div>
                 <div class="article-footer">
			         <div class="share-buttons">
			              <button onclick="fenxiang()">分享文章</button>
			              <button  onclick="window.print()">打印文章</button>
			         </div>
			      </div>
                
            </div>
        </div>
    </div>
    <%@ include file="bottom.jsp" %>
</div>
</body>
<script>
	
function fenxiang(){
	if (navigator.share) {
	  navigator.share({
	    title: '衡阳学院 - 文章详细',
	    text: '快来看看我给你发送的文章内容',
	    url: window.location.href, 
	  })
	  .then(() => console.log('分享成功！'))
	  .catch((error) => console.error('分享失败：', error));
	} else {
	  console.log('当前浏览器不支持分享功能。');
	}
}
	
</script>
</html>