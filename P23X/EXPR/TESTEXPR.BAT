@echo  off
echo.

rem // verify files exist and are valid
if not exist gradcpy.bat   goto error1
if not exist gradlogt.exe  goto error1
if not exist gradmark.exe  goto error1
if not exist expr.exe      goto error2

rem // verify the user typed the correct command
rem // if this is a marking run then do not test files
if %1. == mark.  goto tmetest
if %1. == .      goto errcmd

if not exist %1 goto errin

:tmetest
if exist gradexpr.tme goto endtme
echo Grading and testing history log > gradexpr.tme
:endtme

rem // test for marking run or user test
if not %1. == mark. goto usertest
gradmark gradexpr.tme
goto exit

:usertest
rem // update the time
gradlogt gradexpr.tme %1 testout
if errorlevel 4 goto locked

call gradcpy.bat %1+EOF grad.tmp
echo.
echo. To be safe, I added a DOS end_of_file character to %1
echo. and stored the result in grad.tmp which is being used
echo. as the input to the EXPR program.
echo.
expr     < grad.tmp > testout
gradexok < grad.tmp > okay
gradcomp

echo 'testout' is your program's output file
echo 'okay'    is the expected output file
if   not errorlevel 1 goto ok01

echo.
echo Your output does not seem correct.
echo Compare the file 'testout' to the file 'okay' to find the error
goto exit

:ok01
echo.
echo Your output is correct.
goto exit

:errcmd
echo.
echo To run a test type:
echo    testexpr  input_file
echo.
echo To mark the program as working type:
echo    testexpr  mark
echo.
goto   exit

:errin
echo.
echo The input file specified: %1 does not exist.
echo.
goto   exit

:error1
echo.
echo The grading system has detected a problem.
echo Some of the required files are missing.
echo Try to re-copy all the grading files from the course locker.
echo If this fails then contact the instructor.
echo.
goto   exit

:error2
echo.
echo The executable file 'expr.exe' does not exist in this directory.
echo.
goto   exit

:locked
echo.
echo I cannot access the required files.
echo Shutdown and reboot the system.
echo If the problem persists contact the instructor.
echo.
goto exit

:exit
echo.
