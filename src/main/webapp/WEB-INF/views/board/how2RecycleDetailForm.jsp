<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;200;300;400;500;600;700;800;900&family=Noto+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
  
    <title>Document</title>
    <style>
        html,body{
            margin: 0;
            padding: 0;
        }
        .wrap{
            width: 100%;
            height: auto;
            font-family: 'Noto Sans KR',sans-serif;
        }
        .hrb_header{
            height: 180px;
            position: relative;
        }
          #tit{
            font-size: 40px;
            font-weight: 400;
            display: flex;
            justify-content: center;
            margin-top: 60px;
            margin-bottom: 60px;
            color: #fff;
            
        }
        #tit a{
           text-decoration: none;
           color: #000;
        }
        .hrb_detail{
            height: auto;
        }
        .hrb_det_table{
            width: 60%;
            border-top: 3px solid black;
            border-collapse: collapse;
            border-bottom: 3px solid black;
            padding-bottom: 40px;
            margin-bottom: 80px;
        }


       .hrb_det_table td{
            color: #000;
            text-align: left;
               border-bottom: 1px solid #d8d8d8;
            height: 42px;
            padding: 5px;
            font-weight: 500;
        }
        .hrb_det_table th{
            width: 50px;
            color: #8c8c8c;
            font-weight: 400;
               border-bottom: 1px solid #d8d8d8;
            height: 42px;
            text-align: left;
            padding: 5px;
            
            
	        }

        #contents{
            height: 300px;
        }
        .ad_btn{
            text-align: center;
            padding-top: 60px;
            border-radius: 0;
            padding-bottom: 80px;
            
        }
        
        
        .hrb_btn:hover {
            cursor: pointer;
        }
        
        .hrb_btn{
            width: 150px;
            height: 50px;
            font-size: 14px;
            font-weight: 400;
            margin-right: 6px;
        }
        #hrup{
            background-color: #002c7b;
            color:#e6e6e6;
            border-style: none;
        }
        #hrde{
            background-color: #d00000;
            color: #fce6e6;
            border-style: none;
        }
    </style>
</head>
<body>
  <%@ include file="../common/header.jsp" %>
    <div id="wrap">
      <div id="tit" ><a href="rblist.hrb" style="text-decoration:none;">How2Recycle</a></div>
        <div class="hrb_detail">
            <table class="hrb_det_table" align="center">
                <tbody>
                    <tr>
                        <th>제목</th>
                        <td colspan="5">  ${rb.recycleBoardTitle }</td>
                    </tr>
                    <tr>
                        <th >작성자</th>
                        <td>관리자</td>
                        <th>작성일</th>
                        <td>${rb.createDate }</td>
                        <th>조회수</th>
                        <td>${rb.count }</td>
                    </tr>
                    <tr>
                        <th>첨부파일</th>
                        <td colspan="5">
                        
                       <c:choose>
                    		<c:when test="${empty rb.boOriginName }">
                    		<script >
                    		console.log(${rb.boOriginName});
                    		</script>
                    			첨부파일이 없습니다.
                        	</c:when>
                       	<c:otherwise>
                        		<a href="${bat.boChangeName }" download="${bat.boOriginName }" >${bat.boOriginName }</a>
                        	</c:otherwise>
                        </c:choose>
                        	
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" width="100%" id="contents">
                        	${rb.recycleBoardContent }
                        </td>
                    </tr>

                </tbody>

            </table>
        </div>
   <c:if test="${not empty loginUser and loginUser.memberId eq ('admin1')}">
        <div class="ad_btn">
<%--         	<input type="hidden" id="rbno" name="rbno" value='${rb.boardNo}' /> --%>
            <button type="submit" class="hrb_btn" id="hrl" onclick="location.href='rblist.hrb'" >목록가기</button>
            <button type="submit" class="hrb_btn" id="hrup"  onclick="location.href='rbUpdate.hrb?rbno=${rb.boardNo}'">수정하기</button>
            <button type="submit" class="hrb_btn" id="hrde" >삭제하기</button>

        </div>
        
</c:if>
    </div>
    
    <script >
    
	$(function(){
		//삭제하기 버튼에 form submit함수 작성하기 
		//버튼요소잡기
		var dlBtn = $("#hrde");
		$("#hrde").click(function(){
			//ㅂ해당 버튼이 눌러졌 을때 deletebo로 맵핑될수 있도록 
			//form태그가 있어야 하고 해당 form 태그에 각 속성들을 채우고 
			//원하는 데어터가 있다면 해당 데이터도 같이 태그 작성하여 채워주고 
			//마지막으로 submit을 진행하면 된다. 
			
			
			//form태그 직접생성 
			var formObj = $("<form>");
			console.log(formObj);
			
			//생성된 form 태그에 action속성과 method속성값 채워주기 
			formObj.attr("action","rbdelete.hrb").attr("method","post");

			//생성된 form태그로 전송할 데이터 추가하기 
			//1번 bno (게시글 번호 )- 해당 게시글을 삭제하려면 게시글 번호가 있어햐한다. 없는 태그 추가할떄 prop 
			//<input type = "hidden" name = "bno" value= "19"
			var rbno = $("<input>").prop("type","hidden").prop("name","rbno").prop("value","${rb.boardNo}");

			//2번 첨부파일 경로 - 해당 게시글에 첨부파일이 있엇으면 해당 첨부파일도 서버에서 삭제해야하기 때문에 
			//<input type="hidden" name="filePath" value="${b.changeName}">
			var filePath = $("<input>").prop("type","hidden").prop("name","filePath").prop("value","${rb.boChangeName}");
			
		
			console.log(formObj);
			console.log(rbno);
			console.log(filePath);
			
			//생성한 form태그에 bno태그와 filePath태그들 넣어주기 
			var obj = formObj.append(rbno).append(filePath);
			console.log(obj);
			
			//생성된 form을 body에 넣어서 문서에 포함시키기 
			$("body").append(obj);
			
			//최종적으로 완성된 form태그 obj를 submit()하기 
			obj.submit();
			
		});
		
	});
	
	
    
    
    </script>
    
    
    
    
       <%@ include file="../common/footer.jsp" %>
</body>




</html>