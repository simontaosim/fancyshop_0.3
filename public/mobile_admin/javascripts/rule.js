$(function(){
	$("#finish").click(function(){
		$(".user").html("");
		$(".pwd").html("");
		$(".apwd").html("");
		$(".tel").html("");
		$ck_user=/\w{6,18}/;
		$ck_pwd=/\S{6,18}/;
		$ck_apwd=/\S{6,18}/;
		$ck_tel=/\d{11}/;
		$user=$("#user").val();
		$pwd=$("#pwd").val();
		$apwd=$("#apwd").val();
		$tel=$("#tel").val();
		if($ck_user.test($user)==false){
			$(".user").html("*账户不合法,不能使用特殊字符,或者您少于了６位字符<br>");
		}
		if($ck_tel.test($tel)==false){
			$(".tel").html("*手机格式错误<br>");
		}
		if($ck_pwd.test($pwd)==false){
			$(".pwd").html("*密码设置错误。密码长度过小<br>");
		}
		if($ck_apwd.test($apwd)==false){
			$(".apwd").html("*密码设置错误。密码长度过小<br>");
		}
		if($pwd!=$apwd){
			$(".pwd").html("*密码输入不一致<br>");
			$(".apwd").html("*密码输入不一致<br>");
		}

		if($ck_user.test($user) && $ck_pwd.test($pwd) && $ck_apwd.test($apwd)  && $ck_tel.test($tel) && $pwd==$apwd){
			$("form").submit();
		}
	})
})