<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%
    Cookie userCookie = new Cookie("logonusername", null);
    userCookie.setMaxAge(0);
    userCookie.setPath("/");
    response.addCookie(userCookie);
    out.println("<script>alert('退出登录成功！');window.location.href='../index.jsp'</script>");
%>