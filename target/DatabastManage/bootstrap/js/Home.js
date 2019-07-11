$(function(){
				
				$('a[title]').click(function(){
						var src = $(this).attr('title');
						var title = $(this).html();
				//		alert(src);
						if($('#tt').tabs('exists' ,title)){
							$('#tt').tabs('select',title);
						} else {
							$('#tt').tabs('add',{   
							    title:title,   
							    content:'<iframe frameborder=0 style=width:100%;height:100% src='+ src +' ></iframe>',   
							    closable:true  
							});  
						}
						

				});
								
			});
function getTime(){
	var t=$("#bfortime");
	 var a=new Date()   
	   var timea=(a.getMonth()+1)+"月"+a.getDate()+"日  "+a.getHours()+":"+a.getMinutes()+":"+a.getSeconds();
	 t.text(timea);
	 setTimeout('getTime()',1000);
}

    