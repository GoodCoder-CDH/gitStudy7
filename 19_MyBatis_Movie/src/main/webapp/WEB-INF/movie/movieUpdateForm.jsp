<%@page import="java.sql.Array"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../common/common.jsp" %>
movieList.jsp<br>
<style type="text/css">
	.err{
		font-size : 9pt;
		color : red;
		font-weight : bold;
	}
	table{
		border: 1;
		width: 70%;
	}
</style>

<script>
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
		}
	} // first change

</script>

<%
	String[] continentList = {"아시아","아프리카","유럽","아메리카","오세아니아"};
	String[][] nationList = {
			{"한국","중국","베트남","네팔"},
			{"케냐","가나","세네갈"},
			{"스페인","영국","덴마크","러시아","체코"},
			{"미국","캐나다"},
			{"뉴질랜드","오스트레일리아"}
	};
%>
<c:set var="cList" value="<%=continentList %>"/>
<c:set var="nList" value="<%=nationList %>"/>

<%-- <body onload="init('${movie.continent}', '${movie.nation}')"> --%>
<h1 align="center">영화 정보 등록 화면</h1>
<form:form commandName = "movie" action = "update.mv" method = "post" name="myform">
 	<input type="hidden" name="num" value="${movie.num}">
 	<input type="hidden" name="pageNumber" value="${param.pageNumber}">
 	<input type="hidden" name="whatColumn" value="${param.whatColumn}">
 	<input type="hidden" name="keyword" value="${param.keyword}">
 	
	<table border="1" width="50%">
		<tr>
			<td>영화 제목</td>
			<td>
				<input type = "text" name = "title" value = "${movie.title}">
				<form:errors path = "title" cssClass = "err"></form:errors>
			</td>
		</tr>
		<tr>
			<td>대륙</td>
			<td>
	             <select id="first" name="continent" onChange="firstChange()" style="width: 150px">
	                 <option value="">대륙 선택하세요</option>
	                  <c:forEach var="i" begin="0" end="${fn:length(cList)-1 }">
	                  		<option value="${cList[i]}" <c:if test="${movie.continent eq cList[i]}">selected</c:if>>${cList[i]}
	                  </c:forEach>
	              </select>
				<form:errors path = "continent" cssClass = "err"></form:errors>
			</td>
		</tr>
		<tr>
			<td>나라</td>
			<td>
	         <select id="second" name="nation" style="width: 150px">
               	<option value="">나라 선택하세요</option>
                	<c:forEach var="i" begin="0" end="${fn:length(cList)-1 }">
	                	<c:if test="${movie.continent eq cList[i]}">
	                		<c:forEach var="j" begin="0" end="${fn:length(nList[i])-1}">
								<option value="${nList[i][j]}" <c:if test="${movie.nation eq nList[i][j]}">selected</c:if>>${nList[i][j]}
							</c:forEach>
	              		</c:if>
                	</c:forEach>
               </select>
				<form:errors path = "nation" cssClass = "err"></form:errors>			
			</td>
		</tr>
		<tr>
			<td>장르</td>
			<td>
				<% String[] genre = {"액션","스릴러","코미디","판타지","애니메이션"}; %>
				<c:forEach var = "genre" items="<%=genre%>">
				<input type = "checkbox" name = "genre" value = "${genre}" <c:if test="${fn:contains(movie.genre,genre)}">checked</c:if>>${genre}
				</c:forEach>
				<form:errors path = "genre" cssClass = "err"></form:errors>
			</td>
		</tr>
		<tr>
			<td>등급</td>
			<td>
				<% String[] grade = {"19","15","12","7"}; %>
				<c:forEach var = "grade" items="<%=grade%>">
				<input type = "radio" name = "grade" value = "${grade}"  <c:if test = "${movie.grade eq grade }">checked</c:if>>${grade}
				</c:forEach> 
				<form:errors path = "grade" cssClass = "err"></form:errors>
			</td>
		</tr>
		<tr>
			<td>배우</td>
			<td>
				<input type="text" name="actor" value="${movie.actor}">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정하기">
               <input type="button" value="목록보기" onClick="location='list.mv?pageNumber=${param.pageNumber}&whatColumn=${param.whatColumn}&keyword=${param.keyword}'">
			</td>
		</tr>
	</table>
</form:form>
<!-- </body> -->
    