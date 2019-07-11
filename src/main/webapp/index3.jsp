<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="css/icon.css" />
    <link rel="stylesheet" href="css/easyui.css" />
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/easyui.js"></script>
    <meta charset="UTF-8">
    <meta charset="UTF-8">
    <title>test</title>
    <script>
        var url;
        function searchUser() {
            $("#dg").datagrid('load', {
                "userName" : $("#s_userName").val()
            });
        }

        function addData() {
            $("#dlg").dialog("open").dialog("setTitle", "添加数据");
            url = "../user/saveData.do";
        }

        function editdata() {
            var selectedRows = $("#dg").datagrid("getSelections");
            if (selectedRows.length != 1) {
                $.messager.alert("系统提示", "请选择一条要编辑的数据！");
                return;
            }
            var row = selectedRows[0];
            $("#dlg").dialog("open").dialog("setTitle", "编辑数据");
            $("#fm").form("load", row);
            url = "../user/updateData.do?id=" + row.id;
        }

        function saveData() {
            $("#fm").form("submit", {
                url : url,
                onSubmit : function() {
                    if ($("#tsp_name").combobox("getValue") == "") {
                        $.messager.alert("系统提示", "请选择运行商！");
                        return false;
                    }
                    if ($("#is_complete").combobox("getValue") == "") {
                        $.messager.alert("系统提示", "请选择是否完成派送！");
                        return false;
                    }
                    if ($("#is_force").combobox("getValue") == "") {
                        $.messager.alert("系统提示", "请选择是否强制派送！");
                        return false;
                    }
                    return $(this).form("validate");
                },
                success : function(result) {
                    var result = eval('(' + result + ')');
                    if (result.success) {
                        $.messager.alert("系统提示", "保存成功！");
                        resetValue();
                        $("#dlg").dialog("close");
                        $("#dg").datagrid("reload");
                    } else {
                        $.messager.alert("系统提示", "保存失败！");
                        return;
                    }
                }
            });
        }

        function resetValue() {
            $("#plan_send_num").val("");
            $("#send_num").val("");
            $("#latn_name").val("");
            $("#area_id").val("");
            $("#tsp_name").combobox("setValue","");
            $("#call_lang").val("");
            $("#age_min").val("");
            $("#age_max").val("");
            $("#avg_min_fee").val("");
            $("#avg_max_fee").val("");
            $("#avg_stream").val("");
            $("#send_type").val("");
            $("#active_name").val("");
            $("#staff_type").val("");
            $("#staff_id").val("");
            $("#sheet_chnl").val("");
            $("#is_complete").combobox("setValue","");
            $("#is_force").combobox("setValue","");
        }

        function closeUserDialog() {
            $("#dlg").dialog("close");
            resetValue();
        }

        function deletedata() {
            var selectedRows = $("#dg").datagrid("getSelections");
            if (selectedRows.length == 0) {
                $.messager.alert("系统提示", "请选择要删除的数据！");
                return;
            }
            var strIds = [];
            for ( var i = 0; i < selectedRows.length; i++) {
                strIds.push(selectedRows[i].id);
            }
            var ids = strIds.join(",");
            $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
                + selectedRows.length + "</font>条数据吗？", function(r) {
                if (r) {
                    $.post("../user/deleteData.do", {
                        ids : ids
                    }, function(result) {
                        if (result.success) {
                            debugger;
                            $.messager.alert("系统提示", "数据已成功删除！");
                            $("#dg").datagrid("reload");
                        } else {
                            $.messager.alert("系统提示", "数据删除失败，请联系系统管理员！");
                        }
                    }, "json");
                }
            });
        }
    </script>
</head>

<body>
<table id="dg" title="用户管理" class="easyui-datagrid" fitColumns="true" width="2500px"
       url="../user/showUser.do" toolbar="#tb">
    <thead>
    <tr>
        <th field="id" width="50" align="center">ID</th>
        <th field="create_date" width="50" align="center">创建时间</th>
        <th field="plan_send_num" width="50" align="center">计划派数量</th>
        <th field="send_num" width="50" align="center">已找到的数据量</th>
        <th field="latn_name" width="50" align="center">地州名称</th>
        <th field="area_id" width="50" align="center">地州所对应的区县</th>
        <th field="tsp_name" width="50" align="center">运营商</th>
        <th field="call_lang" width="50" align="center">语言</th>
        <th field="age_min" width="50" align="center">最小年龄</th>
        <th field="age_max" width="50" align="center">最大年龄</th>
        <th field="avg_min_fee" width="50" align="center">最低消费</th>
        <th field="avg_max_fee" width="50" align="center">最高消费</th>
        <th field="avg_stream" width="50" align="center">平均流量</th>
        <th field="send_type" width="50" align="center">常规派数</th>
        <th field="active_name" width="50" align="center">活动名称</th>
        <th field="staff_type" width="50" align="center">派单岗位</th>
        <th field="staff_id" width="50" align="center">派单工号</th>
        <th field="sheet_chnl" width="50" align="center">渠道名称</th>
        <th field="is_complete" width="50" align="center">是否完成</th>
        <th field="is_force" width="50" align="center">是否强制派送</th>
    </tr>
    </thead>
</table>
<div id="tb">
    <a href="javascript:addData()" class="easyui-linkbutton"
       iconCls="icon-add" plain="true">添加</a> <a
        href="javascript:editdata()" class="easyui-linkbutton"
        iconCls="icon-edit" plain="true">修改</a> <a
        href="javascript:deletedata()" class="easyui-linkbutton"
        iconCls="icon-remove" plain="true">删除</a>
    <div>
    &nbsp;用户名：&nbsp;<input type="text" id="s_userName" size="20"
                           onkeydown="if(event.keyCode == 13)searchUser()" /> <a
        href="javascript:searchUser()" class="easyui-linkbutton"
        iconCls="icon-search" plain="true">查询</a>
</div>

    <div id="dlg-buttons">
        <a href="javascript:saveData()" class="easyui-linkbutton"
           iconCls="icon-ok">保存</a> <a href="javascript:closeUserDialog()"
                                       class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
    </div>

    <div id="dlg" class="easyui-dialog"
         style="width: 730px;height:420px;padding:10px 10px;" closed="true"
         buttons="#dlg-buttons">
        <form method="post" id="fm">
            <table cellspacing="8px;">
                <tr>
                    <td>计划派数量：</td>
                    <td><input type="text" id="plan_send_num" name="plan_send_num"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>已找到的数据量：</td>
                    <td><input type="text" id="send_num" name="send_num"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                    </td>
                </tr>
                <tr>
                    <td>地州名称：</td>
                    <td><input type="text" id="latn_name" name="latn_name"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>地州所对应的区县：</td>
                    <td><input type="text" id="area_id" name="area_id"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                    </td>
                </tr>
                <tr>
                    <td>运营商：</td>
                    <td><%--<input type="text" id="operator" name="operator"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>--%>
                        <select name="tsp_name" class="easyui-combobox" id="tsp_name"
                                width="60px" editable="false" panelHeight="auto">
                            <option value="移动">移动</option>
                            <option value="联通">联通</option>
                            <option value="电信">电信</option>
                        </select>
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>语言：</td>
                    <td><input type="text" id="call_lang" name="call_lang"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                    </td>
                </tr>
                <tr>
                    <td>最大年龄：</td>
                    <td><input type="text" id="age_max" name="age_max"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>最小年龄：</td>
                    <td><input type="text" id="age_min" name="age_min"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                    </td>
                </tr>
                <tr>
                    <td>最低消费：</td>
                    <td><input type="text" id="avg_min_fee" name="avg_min_fee"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>最高消费：</td>
                    <td><input type="text" id="avg_max_fee" name="avg_max_fee"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                    </td>
                </tr>
                <tr>
                    <td>平均流量：</td>
                    <td><input type="text" id="avg_stream" name="avg_stream"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>常规派数：</td>
                    <td><input type="text" id="send_type" name="send_type"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                    </td>
                </tr>
                <tr>
                <td>活动名称：</td>
                <td><input type="text" id="active_name" name="active_name"
                           class="easyui-validatebox" required="true" />&nbsp;<span
                        style="color: red">*</span>
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>渠道名称：</td>
                <td><input type="text" id="sheet_chnl" name="sheet_chnl"
                           class="easyui-validatebox" required="true" />&nbsp;<span
                        style="color: red">*</span>
                </td>
            </tr>
                <tr>
                    <td>派单岗位：</td>
                    <td><input type="text" id="staff_type" name="staff_type"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>派单工号：</td>
                    <td><input type="text" id="staff_id" name="staff_id"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                    </td>
                </tr>
                <tr>
                    <td>是否派送完成：</td>
                    <td><%--<input type="text" id="c" name="is_complete"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>--%>
                        <select name="is_complete" class="easyui-combobox" id="is_complete"
                                width="30px" editable="false" panelHeight="auto">
                            <option value="1">完成</option>
                            <option value="0">未完成</option>
                        </select>
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>是否强制派送：</td>
                    <td><%--<input type="text" id="is_force" name="is_force"
                               class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>--%>
                        <select name="is_force" class="easyui-combobox" id="is_force"
                                width="30px" editable="false" panelHeight="auto">
                        <option value="1">是</option>
                        <option value="0">否</option>
                        </select>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>