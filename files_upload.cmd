@echo off

@set YEAR=%date:~0,4%
@set MONTH=%date:~5,2%
@set DAY=%date:~8,2%


rem 로컬 소스가 있는 경로를 지정해준다 ./WebApp 폴더 안에 war 압축 푼 소스가 있다
echo lcd ./WebApp > file_upload.ftp

rem 원격 소스 경로를 지정해준다. 로컬에 있는 폴더 구조가 동일하게 맞춰준다. 
echo cd /home/keehyun2/WebApp >> file_upload.ftp

rem batch script 에 빈줄추가 함. 
echo. >> file_upload.ftp

rem batch 파일 만들기(upload_list.txt 가 제대로 작성됬어 있어야함. )
for /f "delims=" %%i in (./upload_list.txt) do (
	rem 원래 소스를 날짜를 추가 해서 rename 한다
	echo mv %%i %%i.%YEAR%%MONTH%%DAY%.bak >> file_upload.ftp
	rem 소스를 업로드한다. 
	echo put %%i %%i >> file_upload.ftp
)

rem 생성된 FTP 일괄처리 스크립트를 아래 명령어로 psftp 로 접속해서 실행한다
echo. >> ./logs/restore_%YEAR%_%MONTH%_%DAY%.log
echo %time:~0,8% start >> ./logs/upload_%YEAR%_%MONTH%_%DAY%.log
psftp -l keehyun2 -pw 12345678 -b file_upload.ftp localhost >> ./logs/upload_%YEAR%_%MONTH%_%DAY%.log
rem psftp -l 계정 -pw 암호 -b 배치파일 주소
rem -load 0.SSG
