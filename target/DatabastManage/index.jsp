<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>数据管理中心</title>
    <script src="bootstrap/js/jquery.min.js"></script>
    <script src="bootstrap/js/jquery.easyui.min.js"></script>
    <script src="bootstrap/js/easyui-lang-zh_CN.js"></script>
    <script src="bootstrap/js/Home.js"></script>
    <link href="easyui/themes/default/easyui.css" rel="stylesheet">
    <link href="easyui/themes/icon.css" rel="stylesheet">
    <link href="bootstrap/css/common.css" rel="stylesheet">
</head>
<body onLoad="getTime()">
<div id="cc" class="easyui-layout" fit=true style="width:100%;height:100%;">
    <div region="north" title="L&M WorkSystem"  split="false" style="height:60px;">
        <div style="border:1px solid #FF0000; height:20px; width:300px; " id="time">
            <b>欢迎光临数据管理中心</b>&nbsp&nbsp
            <b id="bfortime"></b>
        </div>
    </div>
    <div region="west"  iconCls="icon-ok" split="true" title="菜单" style="width:200px;">
        <div id="aa" class="easyui-accordion" fit=true >
            <div title="数据管理"  style="overflow:auto;padding:10px;">
                <a title="index3.jsp" >表1</a> <br/>
                <a title="http://www.baidu.com" >表2</a>
            </div>
        </div>
    </div>
    <div region="center"  title="主界面" style="padding:5px;">
        <div id="tt" class="easyui-tabs" fit=true style="width:500px;height:250px;">

        </div>
    </div>
</div>
</body>
</html>