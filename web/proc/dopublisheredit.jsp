<%--
  Created by IntelliJ IDEA.
  User: 13994
  Date: 2018/7/5
  Time: 13:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("utf-8");
    String pid = request.getParameter("pid");
    String publishername = request.getParameter("publishername");
    String location = request.getParameter("location");
    String contact = request.getParameter("contact");
    String sql = String.format("update PublisherInfo set publishername='%s',location='%s',contact='%s' where publisherid ='%s'",publishername,location,contact,pid);
    System.out.println(sql);

    Connection conn;
    Statement stm;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://122.114.113.53/bookstore?characterEncoding=UTF-8";
        conn = DriverManager.getConnection(url, "root", "270400");
        stm = conn.createStatement();
        stm.executeUpdate(sql);
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("../publisherinfo.jsp");
%>
