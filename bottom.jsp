<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.nio.file.*" %>
<div class="bottom">
	<div class="kaifazhe">
		<li><b>联系电话：</b>1557555XXX</li>
		<li><b>电子邮箱：</b>XXX@XX.com</li>
		<li><b>学校地址：</b>衡阳市衡阳区衡阳路XX号</li>
		<li><b>版权：衡阳学院&nbsp;&nbsp;&nbsp;&nbsp;备案信息： 湘ICP备00000000号</b></li>
		<tt>Copyright © 2024-2025 彪哥.TOP. All rights reserved.</tt>
	</div>
	<div class="caozuo">
		<a href="#top">返回顶部</a>
		<a onclick="window.open('https://qm.qq.com/cgi-bin/qm/qr?k=OF2zAlrefm7NW5TPeEOD4HQPODCjbly2')">反馈问题</a>
		<br>
		<div class="user-info">
			
			<%
			    String filePath = application.getRealPath("/") + "WEB-INF/coll.txt";
			    int visitCount = 0;
			    try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
			        String line = br.readLine();
			        if (line != null) {
			            visitCount = Integer.parseInt(line);
			        }
			    } catch (IOException e) {
			        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
			            bw.write("0");
			        } catch (IOException ex) {
			            ex.printStackTrace();
			        }
			    }
			    visitCount++;
			    try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
			        bw.write(String.valueOf(visitCount));
			    } catch (IOException e) {
			        e.printStackTrace();
			    }
			    out.println("<li><b>站点访问量: </b>" + visitCount + "</li>");
				//时间
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH");
				String formattedDate = sdf.format(new java.util.Date());
			%>
			<li>当前日期：<b><%= formattedDate %>时</b></li>
			<li><b style="font-size: 24px;color: #f00;">厚德博学 知行合一</b></li>
		</div>
	</div>
</div>
</div>
</body>
</html>