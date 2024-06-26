<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>    

movieList.jsp<br>
<style type="text/css">
	.err{
		font-size : 9pt;
		color : red;
		font-weight : bold;
	}
</style>
<script type="text/javascript">
	function insert(){
		location.href="insert.mv";	
	}
	
	var f_selbox = new Array('아시아','아프리카','유럽','아메리카','오세아니아');
	var s_selbox = new Array();
	s_selbox[0] = new Array('한국','중국','베트남','네팔');
	s_selbox[1] = new Array('케냐', '가나', '세네갈');
	s_selbox[2] = new Array('스페인', '영국','덴마크','러시아','체코');
	s_selbox[3] = new Array('미국', '캐나다'); 
	s_selbox[4] = new Array('뉴질랜드','오스트레일리아');
	
	var selectContinent;
	function init(continent, nation){
		
		//alert(1);
		//alert(continent, nation); // 선택한 대륙과 국가가 넘어옴
		document.myform.first.options[0]=new Option("대륙 선택", ""); // text, value
		document.myform.second.options[0]=new Option("나라 선택", ""); // text, value
		for(i=0;i<f_selbox.length;i++){
			document.myform.first.options[i+1] = new Option(f_selbox[i], f_selbox[i] );
			if(document.myform.first.options[i+1].value==continent){
				//value를 text로 바꿔서 써도 괜찮다.
				document.myform.first.options[i+1].selected = true;
				selectContinent = i; // 아프리카가 선택되면 1이 들어간다.
			}
		}//for
		for(var j=0; j<s_selbox[selectContinent].length;j++){
			document.myform.second.options[j+1] = new Option(s_selbox[selectContinent][j]);
			if(document.myform.second.options[j+1].value == nation){
				document.myform.second.options[j+1].selected = true;
			}
		}
	}//init()
 	
	function firstChange(){
		
		var index = document.myform.first.selectedIndex;
		
		for(i=document.myform.second.length-1;i>0;i--){
			document.myform.second.options[i] = null; // 0:1 1:2 2:3
		}
		for(i=0;i<s_selbox[index-1].length;i++){
			document.myform.second.options[i+1] = new Option(s_selbox[index-1][i]);
		}// first change
	} 

</script>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function() { 
	//alert(1);
	
	var use;
	var isCheck = false;
	
	$('#title_check').click(function(){ // 중복체크 클릭
		//alert(2);
		isCheck = true;
		
		$.ajax({
			url : "title_check_proc.mv",
			type : "post",
			data : ({
				inputtitle : $('input[name=title]').val() // inputtitle=배트맨
			}),
			success :function(data){
				
				if($('input[name=title]').val() ==""){
					$('#titleMessage').html("<font color=red>title 입력 누락</font>");
					$('#titleMessage').show();
					
				}else if(data == 'YES'){
					$('#titleMessage').html("<font color=blue>사용가능합니다.</font>");
					$('#titleMessage').show();
					use = "possible";
				}else{
					$('#titleMessage').html("<font color=red>이미 등록한 제목입니다.</font>");
					use = "impossible";
					$('#titleMessage').show();
				}
			}
		});
	}); // 중복체크 click
	
	$('input[name=title]').keydown(function(){
		isCheck = false;
		use = "";
		$('#titleMessage').css('display','none');
	});
	
	$('#btnSubmit').click(function(){
		if(use == "impossible"){
			alert("이미 사용중인 제목입니다.");
			return false;
		}else if(isCheck == false){
			alert("중복체크를 하세요");
			return false;
		}
	}); // btnSubmit click
});
</script>
<%
	String[] genreArr = {"액션","스릴러","코미디","판타지","애니메이션"};
	String[] gradeArr = {"19","15","12","7"};
%>
<body onload="init('${movie.continent}', '${movie.nation}')">
<h1 align="center">영화 정보 등록 화면</h1>
<form:form commandName = "movie" action = "insert.mv" method = "post" name="myform">
	<p>
	영화 제목 : <input type = "text" name = "title" value = "${movie.title }">
	<input type="button" value="중복체크" id="title_check">
	<span id="titleMessage"></span>
	<form:errors path = "title" cssClass = "err"></form:errors>
	</p>
	<p>
	대륙 : 
	<select id=first name="continent" style="width:70px" onchange="firstChange()">
	<!-- <option value=""> 대륙 선택하세요 -->
	</select>
	<form:errors path = "continent" cssClass = "err"></form:errors>
	나라 : 
	<select id=second name="nation" style="width:70px" onchange="secondChange()"></select>
	<form:errors path = "nation" cssClass = "err"></form:errors>
	</p>
	<p>
	장르 : 
	<c:forEach var = "genre" items="<%=genreArr%>">
		<input type = "checkbox" name = "genre" value = "${genre}" <c:if test = "${genre eq movie.genre}">checked</c:if>>${genre}
	</c:forEach>
	<form:errors path = "genre" cssClass = "err"></form:errors>
	</p>
	
	<p>
	등급 : 
		<c:forEach var = "grade" items="<%=gradeArr%>">
			<input type = "radio" name = "grade" value = "${grade}"  <c:if test = "${movie.grade eq grade }">checked</c:if>>${grade}
		</c:forEach> 
	<form:errors path = "grade" cssClass = "err"></form:errors>
	</p>
	<p>
	출연 배우 : 
	<input type="text" name="actor" value="${movie.actor}">
	<form:errors path = "actor" cssClass = "err"></form:errors>
	</p>
	
	<p>
		<input type = "submit" value = "추가하기" id="btnSubmit">
	</p>
</form:form>
</body>
    
    