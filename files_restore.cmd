@echo off

@set YEAR=%date:~0,4%
@set MONTH=%date:~5,2%
@set DAY=%date:~8,2%

rem 반영했던 소스 일괄 복원 처리 - 원본파일과 백업파일을 바꿔치기한다. (이름만 바꾸고 업로드하는 과정은 없다.)

rem 원격 소스 경로를 지정해준다. 
echo cd /home/keehyun2/WebApp > file_restore.ftp

rem 빈줄 추가
echo. >> file_restore.ftp

rem batch 파일 만들기(upload_list.txt 가 제대로 작성됬어 있어야함. )
for /f "delims=" %%i in (./upload_list.txt) do (
	
	echo mv %%i.%YEAR%%MONTH%%DAY%.bak %%i.temp >> file_restore.ftp
	echo mv %%i %%i.%YEAR%%MONTH%%DAY%.bak >> file_restore.ftp
	echo mv %%i.temp %%i >> file_restore.ftp
	
)

rem psftp -l 계정 -pw 암호 -b 배치파일 주소
rem 생성된 FTP 일괄처리 스크립트를 아래 명령어로 psftp 로 접속해서 실행한다
echo. >> ./logs/restore_%YEAR%_%MONTH%_%DAY%.log
echo %time:~0,8% start >> ./logs/restore_%YEAR%_%MONTH%_%DAY%.log
psftp -l keehyun2 -pw 12345678 -b file_restore.ftp -be localhost >> ./logs/restore_%YEAR%_%MONTH%_%DAY%.log



