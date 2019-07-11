var flag ; //判断走的是保存还是修改方法
$(function(){
	Inittreegrid();
});

function Inittreegrid(){
	$('#tree_org').treegrid({
		title:'组织机构列表', 
		iconCls:'icon-ok',
		width:1500,
		height:400,
		nowrap: false,
		rownumbers: true,
		collapsible:true,
		url:'privilegemgmt/resourceAction_loadAll.action',			
		idField:'id',				//数据表格要有主键	
		treeField:'name',			//treegrid 树形结构主键 text
		fitColumns:true ,
		toolbar :'#tb', 
		columns:[[
			{field:'name',title:'机构名称',width:200,formatter:function(val,rec){
					return '<a href="http://120.24.162.217/cmp/'+rec.id+'" style="color:red;">('+val+')</a>';
					} } ,
			{field:'count',title:'机构人数',width:120} ,
			{field:'principal',title:'机构负责人',width:120} ,
			{field:'description',title:'机构描述',width:120} 
		]],
		onContextMenu: function(e,row){
			e.preventDefault();					//屏蔽浏览器的菜单
			$(this).treegrid('unselectAll');	//清除所有选中项
			$(this).treegrid('select', row.id);	//选中状态 
			$('#mm').menu('show', {
				left: e.pageX,
				top: e.pageY
			});
		}
});

$('#btn1').click(function(){
	var checkname = ValidationName();
	if(checkname == false){
		return false;
	}
		if(flag == 'add'){
					//保存方法 
					//1 前台保存    注意: 没有保存id
					var node = $('#tree_org').treegrid('getSelected');
					$('#tree_org').treegrid('append',{
							parent:node.id ,
							data:[{
									name:$('#myform').find('input[name=name]').val(),
									count:$('#myform').find('input[name=count]').val(),
									principal:$('#myform').find('input[name=principal]').val(),
									description:$('#myform').find('textarea[name=description]').val()
							}]
					});
					
					//2 后台保存 
					$.ajax({
						type:'post',
						url:'privilegemgmt/resourceAction_saveDep.action',
						cache:false , 
						dataType:'json',
						data:{
								parentId:node.id ,
								name:$('#myform').find('input[name=name]').val(),
								count:$('#myform').find('input[name=count]').val(),
								principal:$('#myform').find('input[name=principal]').val(),
								description:$('#myform').find('textarea[name=description]').val()
						} ,
						success:function(r){
								//刷新节点 : 刷新当前选中节点
								$('#tree_org').treegrid('reload',node.id);
								$.messager.show({
									title:'提示信息' , 
									msg:'操作成功!'
								});
						}
					});
					//3关闭窗口
					$('#div1').dialog('close');
		} else {
					$.ajax({
						type:'post',
						url:'privilegemgmt/resourceAction_updateDep.action',
						cache:false , 
						dataType:'json',
						data:{
								id:$('#myform').find('input[name=id]').val() ,
								name:$('#myform').find('input[name=name]').val(),
								count:$('#myform').find('input[name=count]').val(),
								principal:$('#myform').find('input[name=principal]').val(),
								description:$('#myform').find('textarea[name=description]').val()
						} ,
						success:function(data){
							//刷新节点  :如果当前选中的节点是叶子节点的话,刷新该节点的父亲 ,如果不是叶子节点,刷新当前选中节点即可
							var node = $('#tree_org').treegrid('getSelected');
							var parent =	$('#tree_org').treegrid('getParent' , node.id);
							$('#tree_org').treegrid('reload');
							$.messager.show({
								title:'提示信息',
								msg:'操作成功!'
							});
						},
						error:function(XMLResponse){
							alert('12345');
							
						}
					});
					//3关闭窗口
					$('#div1').dialog('close');
		}

			
			
});

//关闭窗口
$('#btn2').click(function(){
		$('#div1').dialog('close');
});

$('#depAdd').click(function(){
	append();
});
	
$('#depEdit').click(function(){
	update();
});

$('#depRemove').click(function(){
	remove();
});
}





function append(){
	var  node  = $('#tree_org').treegrid('getSelected');
	if(node == null || node == 'underdefined')
	{
		  $.messager.alert('提示信息','请选择一个部门!');
		  return false;
	}
			flag='add';
			//1清空表单数据
			$('#myform').form('clear');
			//2打开窗口
			$('#div1').dialog('open');
}

function update(){
			flag='edit';
			//1清空表单数据
			$('#myform').form('clear');
			//2填充表单回显数据
			var  node  = $('#tree_org').treegrid('getSelected');
			if(node == null || node == 'underdefined')
			{
				  $.messager.alert('提示信息','请选择一个部门!');
				  return false;
			}
			$('#myform').form('load',{
					id:node.id ,
					name:node.name ,
					principal:node.principal,
					count:node.count ,
					description:node.description
			});
			//3打开窗口
			$('#div1').dialog('open');
}

function remove(){
	var  node  = $('#tree_org').treegrid('getSelected');
	if(node == null || node == 'underdefined')
	{
		  $.messager.alert('提示信息','请选择一个部门!');
		  return false;
	}
	
	$.messager.confirm("提示信息","确认删除?",function(r){
			if(r){
				// 1前台删除

				$('#tree_org').treegrid('remove',node.id);
				// 2后台删除 
//				$.post('OrgServlet?method=delete' , {id:node.id} , function(result){
//							
//							$('#tree_org').treegrid('unselectAll');
//							$('#tree_org').treegrid('reload');
//							$.messager.show({
//								title:'提示信息',
//								msg:'操作成功!'
//							});
//				});
				
				$.ajax({
					type:'post',
					url:'privilegemgmt/resourceAction_deleteDep.action',
					cache:false,
					dateType:'json',
					data:{
						id:$('#myform').find('input[name=id]').val()
					},
					success:function(data){
						$.messager.show({
							title:'提示信息',
							msg:'删除成功!'
						});
					},
					error:function(data){
						$.messager.show({
							title:'提示信息',
							msg:'操作失败，错误信息为:'
						});
					}
				});
			} else {
				return ;
			}
			
	});
}

function ValidationName() {

    var iswork = true;
    var paricpl = $.trim($('#myform').find('input[name=principal]').val());
    if (paricpl != '') {
        var nameExp = /^([\u4e00-\u9fa5]{2,10}|([a-zA-Z]+\s?){2,10})$/;

        if (nameExp.test(paricpl) == false) {
        	$("#errorparicpl").text("请填写2~10位汉字或字母");
        	iswork = false;
        }
    }
    else {
    	$("#errorparicpl").text("请填写公司名称");
    	iswork = false;
    }
    return iswork;
}


function ValidationCount(){
    var name = $.trim($('#myform').find('input[name=count]').val());

    var isvalid = true;
    $("#errorcount").text("");
    if (name != '') {
        var nameExp = /^[1-9]\d*$/;

        if (nameExp.test(name) == false) {
        	$("#errorcount").text("请填写正确的人数");
            isvalid = false;
        }
    }
    else {
    	$("#errorcount").text("请填写正确的人数");
        isvalid = false;
    }
    return isvalid;
}
/*
toolbar :[  
          //var flag ="${my:aclCreate(2,4)}"  
          //alert(flag);  
          {  
              text:'新增',  
              iconCls:'icon-add',  
              handler:function()  
              {  
//                  addrow();  
              }  
          },  
          '-',  
          {  
              text:'修改',  
              iconCls:'icon-edit',  
              handler:function()  
              {  
//                  updaterow();  
              }  
          },  
          '-',  
          {  
              text:'删除',  
              iconCls:'icon-remove',  
              handler:function()  
              {  
//                  deleterow();  
              }  
          },'-'  
      ], 
columns:[[
	{field:'name',title:'机构名称',width:200} ,
	{field:'count',title:'机构人数',width:120} ,
	{field:'principal',title:'机构负责人',width:120} ,
	{field:'description',title:'机构描述',width:120} 
]], 
*/