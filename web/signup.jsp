<%--
  Created by IntelliJ IDEA.
  User: 13994
  Date: 2018/7/3
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>登陆</title>
    <link href="layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <link href="layui/css/layui.mobile.css" rel="stylesheet" type="text/css"/>
    <script src="layui/layui.all.js"></script>
</head>
<body>
<div class="layui-container" align="center">
    <p style="color: #1E9FFF;font-size: 40px">后台注册</p>
    <form class="layui-form" action="proc/dosignup.jsp" method="post">
        <div class="layui-input-inline" style="margin: 8px">
            <input type="text" name="account" required  lay-verify="required" placeholder="邮箱" autocomplete="off" class="layui-input">
        </div>
        <br>
        <div class="layui-input-inline" style="margin: 8px">
            <input type="password" name="password" required  lay-verify="required" placeholder="密码" autocomplete="off" class="layui-input">
        </div>
        <br>
        <div class="layui-input-inline login-btn" style="margin: 8px">
            <button type="submit" class="layui-btn">注册</button>
        </div>
        <br>
        <!--<div class="layui-input-inline">
            <button type="button" class="layui-btn layui-btn-normal">微信登录</button>
        </div>-->
        <p><a href="login.jsp" class="fl">立即登录</a>
    </form>
</div>
<script src="layui/layui.all.js"></script>
<script type="text/javascript">
    layui.use(['form'], function () {
        var form = layui.form(), $ = layui.jquery;
    });
</script>
</body>
</html>