<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../style/css/jianjie.css" />
	<link rel="stylesheet" href="../style/css/index.css" />
    <link rel="shortcut icon " type="images/x-icon" href="../style/image/logo.ico">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>衡阳学院 - 学院简介</title>
</head>
<body>
<div class="app">
<div class="top" id="top">
	<div class="logo" onclick="window.location.href='../index.jsp?t=衡阳学院'">
		<img src="../style/image/logo-bai.png" alt="Logo" />
	</div>
	<div class="title-h1">
		<h1>衡阳学院 - 学院简介</h1>
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
	<div class="about-school">
            <h1>衡阳学院 - 学院简介</h1>
					<p>衡阳学院，作为一所历史悠久且享有盛誉的高等教育机构，始终致力于为学生提供卓越的教育资源和广阔的发展平台。学院坐落于风景如画、人文荟萃的衡阳市雁峰区，这里不仅自然环境优美，而且文化底蕴深厚，为学子们营造了一个既宁静又充满活力的学习氛围。
		</p><p>
		学院占地面积广阔，校园内绿树成荫，花香四溢，各类现代化教学设施一应俱全。从宽敞明亮的图书馆到配备先进设备的实验室，从多功能报告厅到标准化的运动场，每一处都彰显着学院对教育质量和学生发展的高度重视。此外，学院还不断投入资金，更新和完善教学设施，确保学生能够接触到最前沿的科学技术和学术成果。
		</p><p>
		衡阳学院拥有一支由资深教授、知名学者和青年才俊组成的优秀师资队伍。他们不仅学术造诣深厚，而且教学经验丰富，能够为学生提供高质量的教学和指导。在这里，学生们可以充分领略到大师的风采，汲取知识的养分，为未来的学术研究和职业发展打下坚实的基础。
		</p><p>
		学院秉承“厚德博学，求实创新”的校训，将品德教育放在首位，注重培养学生的综合素质和实践能力。通过丰富多彩的校园文化活动和社会实践活动，学生们不仅能够拓宽视野、增长见识，还能够锻炼自己的组织协调能力和团队合作精神。同时，学院还积极与企业、科研机构等社会各界建立合作关系，为学生提供更多的实习实训和就业机会，帮助他们更好地适应社会的需求和发展。
		</p><p>
		多年来，衡阳学院已经为社会输送了大量优秀人才。他们在各自的领域里发光发热，为社会的进步和发展做出了积极的贡献。这既是学院教育质量的最好证明，也是学院不断追求卓越、勇攀高峰的动力源泉。
		</p><p>
		展望未来，衡阳学院将继续秉承优良传统，不断创新教育理念和方法，努力培养更多具有创新精神和实践能力的高素质人才，为国家的繁荣富强和民族的伟大复兴贡献自己的力量。</p>
        </div>
    <div class="content">
        
        
        <div class="campus-map">
            <h2>校园地图</h2>
            <img src="../style/image/campus-map.png" alt="校园地图" />
        </div>
        
        <div class="news-section">
            <h2>最新消息</h2>
            <ul>
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
            String sql = "SELECT wid, title FROM info  order by wid desc LIMIT 15"; // 根据需要选择字段
            rs = stmt.executeQuery(sql);
 
            // 遍历
            while (rs.next()) {
                int wid = rs.getInt("wid")+10000;
                String title = rs.getString("title");
                
    %>
    <li><a href="../info.jsp?wid=<%= wid %>"><%= title %></a></li>
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
            </ul>
        </div>
    </div>
</div>
</div>
<%@ include file="../bottom.jsp" %>