@echo off

:Run
cls
if not exist test.wav (
	echo test.wav�ļ������ڣ���Ӧ��¼һ��test.wav�ļ��ŵ����batͬ��Ŀ¼��
	goto Pause
)

javac -version
if errorlevel 1 (
	echo ��Ҫ��װJDK���ܱ�������java�ļ�
	goto Pause
)

javac *.java && java Main

set /p step=�Ƿ���������(y):
if "%step%"=="y" goto Run
goto End

:Pause
pause
:End