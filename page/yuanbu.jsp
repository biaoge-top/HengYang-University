<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../style/css/yuanbu.css" />
	<link rel="stylesheet" href="../style/css/index.css" />
    <link rel="shortcut icon " type="images/x-icon" href="../style/image/logo.ico">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>衡阳学院 - 院部设置</title>
</head>
<body>
<div class="app">
<div class="top" id="top">
	<div class="logo" onclick="window.location.href='../index.jsp?t=衡阳学院'">
		<img src="../style/image/logo-bai.png" alt="Logo" />
	</div>
	<div class="title-h1">
		<h1>衡阳学院 - 院部设置</h1>
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
    <div class="departments">
        <h2>院部设置</h2>
        <div class="department-list">
            <div class="department">
                <img src="../style/image/department4.png" alt="计算机学院" class="department-img">
                <h3>计算机学院</h3>
                <p>计算机学院专注于计算机科学技术、网络安全和程序员等领域的教育。</p>
            </div>
            <div class="department">
                <img src="../style/image/department1.png" alt="工程学院" class="department-img">
                <h3>工程学院</h3>
                <p>工程学院是衡阳学院的重要组成部分，致力于培养工程技术领域的专业人才。</p>
            </div>
            <div class="department">
                <img src="../style/image/department2.png" alt="管理学院" class="department-img">
                <h3>管理学院</h3>
                <p>管理学院专注于商业管理、市场营销和人力资源管理等领域的教育。</p>
            </div>
            <div class="department">
                <img src="../style/image/department3.png" alt="文学院" class="department-img">
                <h3>文学院</h3>
                <p>文学院是衡阳学院的人文社科基地，涵盖中文、历史、哲学等多个学科。</p>
            </div>
            <div class="department">
                <img src="../style/image/department5.png" alt="计算机学院" class="department-img">
                <h3>医学院</h3>
                <p>医学院专注于生物技术、护理、医务和药学等领域的教育。</p>
            </div>
        </div>
    </div>
</div>
</div>
<%@ include file="../bottom.jsp" %>