<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h2>영화 상세 화면</h2>

<table border="1" width="50%">
	<tr>
		<td>번호</td>
		<td>${mb.num}</td>
	</tr>
	<tr>
		<td>영화제목</td>
		<td>${mb.title}</td>
	</tr>
	<tr>
		<td>제작국가</td>
		<td>${mb.nation}</td>
	</tr>
	<tr>
		<td>장르</td>
		<td>${mb.genre}</td>
	</tr>
	<tr>
		<td>등급</td>
		<td>${mb.grade}</td>
	</tr>
	<tr>
		<td>배우</td>
		<td>${mb.actor}</td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="list.mv?pageNumber=${param.pageNumber}
			&whatColumn=${param.whatColumn}
			&keyword=${param.keyword}">
			영화 리스트 화면으로 돌아감
			</a>
		</td>
	</tr>
</table>