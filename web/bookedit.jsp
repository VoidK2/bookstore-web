<%--
  Created by IntelliJ IDEA.
  User: 13994
  Date: 2018/7/3
  Time: 16:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>后台</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="./layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <link href="./layui/css/layui.mobile.css" rel="stylesheet" type="text/css"/>
    <script src="./layui/layui.all.js"></script>
</head>
<body class="layui-layout-body">
<%
    //    获取session中存储的权限和用户名
    String userN = (String) session.getAttribute("userN");
    String userP = (String) session.getAttribute("userP");
%>
<%--头部导航栏--%>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">

        <div class="layui-logo">
            <i class="layui-icon layui-icon-website" style="font-size: 35px;"></i>
            书店后台管理
        </div>
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <%
                //                session.invalidate();
//                当sission中有属性时
                if (userN != null) {
            %>
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <i class="layui-icon layui-icon-username" style="font-size: 25px; "></i>
                    <%=userN%>
                </a>
            </li>
            <li class="layui-nav-item"><a href="proc/destroySession.jsp">退了</a></li>
            <%}%>

            <%
                //                session过期时
                if (userN == null) {
            %>
            <li class="layui-nav-item">
                <a href="login.jsp">
                    <i class="layui-icon layui-icon-username" style="font-size: 25px; "></i>
                    请登录
                </a>
            </li>
            <li class="layui-nav-item"><a href="signup.jsp">注册</a></li>
            <%}%>

        </ul>
    </div>
    <%--左侧导航栏--%>
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <%if(userP != null){%>
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">书籍信息管理</a>
                    <dl class="layui-nav-child">
                        <dd class="layui-this"><a href="bookinfo.jsp">图书信息</a></dd>
                        <%if(userP.equals("2")||userP.equals("3")){%>
                        <dd><a href="addbook.jsp">新建图书信息</a></dd>
                        <%}%>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">出版社信息管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="publisherinfo.jsp">出版社信息</a></dd>
                        <%if(userP.equals("2")||userP.equals("3")){%>
                        <dd><a href="addpublisher.jsp">新建出版社信息</a></dd>
                        <%}%>
                    </dl>
                </li>
                <%if(userP.equals("3")){%>
                <li class="layui-nav-item">
                    <a href="javascript:;">账号权限管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="accountinfo.jsp">账号信息</a></dd>
                    </dl>
                </li>
                <%}%>
            </ul>
            <%}%>
        </div>
    </div>

    <div class="layui-body" style="bottom: 0;border-left: solid 2px #1AA094;" id="admin-body">
        <!-- 内容主体区域 -->
        <%
            request.setCharacterEncoding("utf-8");
            String bid = request.getParameter("bid");

            String sql = String.format("select BookInfo.bookname,BookInfo.author,BookInfo.details,PublisherInfo.publishername" +
                    " from PublisherInfo,BookInfo" +
                    " where BookInfo.publisher=PublisherInfo.publisherid and BookInfo.bookid='%s'",bid);
            System.out.println(sql);
            String sql2="select * from PublisherInfo";

            Connection conn;
            Statement stm,stm2;
            ResultSet rs=null,rs2=null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://122.114.113.53/bookstore?characterEncoding=UTF-8";
                conn = DriverManager.getConnection(url, "root", "270400");
                stm = conn.createStatement();
                rs = stm.executeQuery(sql);
                rs.next();
                stm2 = conn.createStatement();
                rs2 = stm2.executeQuery(sql2);
            } catch (Exception e) {
                e.printStackTrace();
            }

        %>
        <div class="layui-tab admin-nav-card layui-tab-brief" lay-filter="admin-tab">
            <ul class="layui-tab-title">
                <li class="layui-this">
                    <i class="fa fa-dashboard" aria-hidden="true"></i>
                    <cite>主面板</cite>
                </li>
            </ul>
            <div class="layui-container" align="center">
            <form class="layui-form" action="proc/dobookedit.jsp?bid=<%=bid%>" method="post" >
                <table class="layui-table" lay-skin="line">
                    <tbody>
                    <tr>
                        <td>书名：</td>
                        <td><input type="text" name="bookname" class="layui-input" value="<%=rs.getString("bookname")%>"></td>
                    </tr>
                    <tr>
                        <td>出版社：</td>
                        <td class="layui-input-block">
                            <select name="publisherSelect">
                                <%
                                    while (rs2.next()) {
                                %>
                                <option value="<%=rs2.getString("publisherid")%>"><%=rs2.getString("publishername")%>

                                </option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>作者：</td>
                        <td><input type="text" name="author" class="layui-input" value="<%=rs.getString("author")%>"></td>
                    </tr>
                    <tr>
                        <td>详情：</td>
                        <td><input type="text" name="details" class="layui-input" value="<%=rs.getString("details")%>"></td>
                    </tr>
                    </tbody>
                </table>
                <br>
                <input type="submit" class="layui-btn layui-btn-normal" value="提交保存"/>
            </form>
        </div>

        <div class="layui-footer">
            <!-- 底部固定区域 -->
            © zhangzexin.site
            <i class="layui-icon layui-icon-link" style="font-size: 15px; "></i>
            <a herf="https://github.com/VoidK2/bookstore-web">github链接</a>
        </div>
    </div>
    <script src="./layui/layui.all.js"></script>
    <script>
        //JavaScript代码区域
        layui.use('element', function () {
            var element = layui.element;

        });
    </script>
</body>
</html>
