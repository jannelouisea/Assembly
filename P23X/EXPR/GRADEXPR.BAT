@echo  off
echo.

if exist expr.ans      erase expr.ans
if exist grad*.in      erase grad*.in
if exist gradres.tmp   erase gradres.tmp
if exist gradtemp      erase gradtemp
if exist okay          erase okay
if exist testout       erase testout

if exist results       erase results
if exist results       goto  locked

if not exist expr.asm     goto error3
if not exist expr.exe     goto error2
if not exist gradcomp.exe goto error1
if not exist gradcpy.bat  goto error1
if not exist graddata.exe goto error1
if not exist graddoc.exe  goto error1
if not exist gradexok.exe goto error1
if not exist gradexpr.mod goto error1
if not exist gradgtl.exe  goto error1
if not exist gradlog.exe  goto error1
if not exist gradlogt.exe goto error1
if not exist gradmexp.exe goto error1
if not exist gradres.exe  goto error1

rem // init grading count
if exist gradexpr.cnt goto tmetest
call gradcpy gradexpr.mod gradexpr.cnt
:tmetest

rem // init history log
if exist gradexpr.tme goto endtme
echo Grading and testing history log > gradexpr.tme
:endtme
if %1. == s. goto run
gradgtl gradexpr.tme
if errorlevel 4 goto exit

:run
rem // update count and log
gradlog gradexpr.cnt gradexpr.tme p17 1
if errorlevel 4 goto locked

echo EXPR Grading System Version 4.0
echo EXPR Grading System Version 4.0 >> results

type  gradid.p17
type  gradid.p17    >> results
type  gradexpr.tme  >> results



:t01
graddata 01 > grad01.in
if       errorlevel 1 goto exit
 echo    Running test 01  >> results
 echo    Running test 01
gradexok < grad01.in > okay
expr     < grad01.in > testout
gradcomp
if       not errorlevel 1 goto fin01
 echo.
 echo    Error encountered in test 01
 echo    grad01.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 01                                   >> results
 echo    grad01.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:fin01
erase grad01.in
erase testout
erase okay



:t02
graddata 02 > grad02.in
if       errorlevel 1 goto exit
 echo    Running test 02  >> results
 echo    Running test 02
gradexok < grad02.in > okay
expr     < grad02.in > testout
gradcomp
if       not errorlevel 1 goto fin02
 echo.
 echo    Error encountered in test 02
 echo    grad02.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 02                                   >> results
 echo    grad02.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:fin02
erase grad02.in
erase testout
erase okay



:t03
graddata 03 > grad03.in
if       errorlevel 1 goto exit
 echo    Running test 03  >> results
 echo    Running test 03
gradexok < grad03.in > okay
expr     < grad03.in > testout
gradcomp
if       not errorlevel 1 goto fin03
 echo.
 echo    Error encountered in test 03
 echo    grad03.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 03                                   >> results
 echo    grad03.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:fin03
erase grad03.in
erase testout
erase okay



:t04
graddata 04 > grad04.in
if       errorlevel 1 goto exit
 echo    Running test 04  >> results
 echo    Running test 04
gradexok < grad04.in > okay
expr     < grad04.in > testout
gradcomp
if       not errorlevel 1 goto fin04
 echo.
 echo    Error encountered in test 04
 echo    grad04.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 04                                   >> results
 echo    grad04.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:fin04
erase grad04.in
erase testout
erase okay



:t05
graddata 05 > grad05.in
if       errorlevel 1 goto exit
 echo    Running test 05  >> results
 echo    Running test 05
gradexok < grad05.in > okay
expr     < grad05.in > testout
gradcomp
if       not errorlevel 1 goto fin05
 echo.
 echo    Error encountered in test 05
 echo    grad05.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++   10 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 05                                   >> results
 echo    grad05.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++   10 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradedoc
:fin05
erase grad05.in
erase testout
erase okay



:t06
graddata 06 > grad06.in
if       errorlevel 1 goto exit
 echo    Running test 06  >> results
 echo    Running test 06
gradexok < grad06.in > okay
expr     < grad06.in > testout
gradcomp
if       not errorlevel 1 goto fin06
 echo.
 echo    Error encountered in test 06
 echo    grad06.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++   10 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 06                                   >> results
 echo    grad06.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++   10 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradedoc
:fin06
erase grad06.in
erase testout
erase okay



:t07
graddata 07 > grad07.in
if       errorlevel 1 goto exit
 echo    Running test 07  >> results
 echo    Running test 07
gradexok < grad07.in > okay
expr     < grad07.in > testout
gradcomp
if       not errorlevel 1 goto fin07
 echo.
 echo    Error encountered in test 07
 echo    grad07.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++   10 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 07                                   >> results
 echo    grad07.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++   10 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradedoc
:fin07
erase grad07.in
erase testout
erase okay



:t08
graddata 08 > grad08.in
if       errorlevel 1 goto exit
 echo    Running test 08  >> results
 echo    Running test 08
gradexok < grad08.in > okay
expr     < grad08.in > testout
gradcomp
if       not errorlevel 1 goto fin08
 echo.
 echo    Error encountered in test 08
 echo    grad08.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++   10 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 08                                   >> results
 echo    grad08.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++   10 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradedoc
:fin08
erase grad08.in
erase testout
erase okay



:t09
graddata 09 > grad09.in
if       errorlevel 1 goto exit
 echo    Running test 09  >> results
 echo    Running test 09
gradexok < grad09.in > okay
expr     < grad09.in > testout
gradcomp
if       not errorlevel 1 goto fin09
 echo.
 echo    Error encountered in test 09
 echo    grad09.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++   20 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 09                                   >> results
 echo    grad09.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++   20 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradedoc
:fin09
erase grad09.in
erase testout
erase okay



:t10
graddata 10 > grad10.in
if       errorlevel 1 goto exit
 echo    Running test 10  >> results
 echo    Running test 10
gradexok < grad10.in > okay
expr     < grad10.in > testout
gradcomp
if       not errorlevel 1 goto fin10
 echo.
 echo    Error encountered in test 10
 echo    grad10.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++   20 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 10                                   >> results
 echo    grad10.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++   20 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradedoc
:fin10
erase grad10.in
erase testout
erase okay



:t11
graddata 11 > grad11.in
if       errorlevel 1 goto exit
 echo    Running test 11  >> results
 echo    Running test 11
gradexok < grad11.in > okay
expr     < grad11.in > testout
gradcomp
if       not errorlevel 1 goto fin11
 echo.
 echo    Error encountered in test 11
 echo    grad11.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++   20 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 11                                   >> results
 echo    grad11.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++   20 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradedoc
:fin11
erase grad11.in
erase testout
erase okay



:t12
graddata 12 > grad12.in
if       errorlevel 1 goto exit
 echo    Running test 12  >> results
 echo    Running test 12
gradexok < grad12.in > okay
expr     < grad12.in > testout
gradcomp
if       not errorlevel 1 goto fin12
 echo.
 echo    Error encountered in test 12
 echo    grad12.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++   20 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 12                                   >> results
 echo    grad12.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++   20 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradedoc
:fin12
erase grad12.in
erase testout
erase okay



:t13
graddata 13 > grad13.in
if       errorlevel 1 goto exit
 echo    Running test 13  >> results
 echo    Running test 13
gradexok < grad13.in > okay
expr     < grad13.in > testout
gradcomp
if       not errorlevel 1 goto fin13
 echo.
 echo    Error encountered in test 13
 echo    grad13.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++   30 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 13                                   >> results
 echo    grad13.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++   30 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradedoc
:fin13
erase grad13.in
erase testout
erase okay



:t14
graddata 14 > grad14.in
if       errorlevel 1 goto exit
 echo    Running test 14  >> results
 echo    Running test 14
gradexok < grad14.in > okay
expr     < grad14.in > testout
gradcomp
if       not errorlevel 1 goto fin14
 echo.
 echo    Error encountered in test 14
 echo    grad14.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++   30 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 14                                   >> results
 echo    grad14.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++   30 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradedoc
:fin14
erase grad14.in
erase testout
erase okay



:t15
graddata 15 > grad15.in
if       errorlevel 1 goto exit
 echo    Running test 15  >> results
 echo    Running test 15
gradexok < grad15.in > okay
expr     < grad15.in > testout
gradcomp
if       not errorlevel 1 goto fin15
 echo.
 echo    Error encountered in test 15
 echo    grad15.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++   30 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 15                                   >> results
 echo    grad15.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++   30 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradedoc
:fin15
erase grad15.in
erase testout
erase okay



:t16
graddata 16 > grad16.in
if       errorlevel 1 goto exit
 echo    Running test 16  >> results
 echo    Running test 16
gradexok < grad16.in > okay
expr     < grad16.in > testout
gradcomp
if       not errorlevel 1 goto fin16
 echo.
 echo    Error encountered in test 16
 echo    grad16.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++   30 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 16                                   >> results
 echo    grad16.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++   30 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradedoc
:fin16
erase grad16.in
erase testout
erase okay



:long
gradlong > gradlong.in
if       errorlevel 1 goto exit
 echo    Running test "long input line test"  >> results
 echo.
 echo    Running test "long input line test"
gradexok < gradlong.in > okay
 echo    The long input file has been created.
 echo    We are now going to pass it to your program.
 echo    If the system hangs then your expr does not handle long input lines.
 echo    You should not buffer the whole input line.
expr      < gradlong.in > testout
 echo    Your program ended. We are now testing your output.
gradcomp
if       not errorlevel 1 goto finlong
 echo.
 echo    Error encountered in long input line test
 echo    gradlong.in is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo.
 echo ++ Grade ++   50 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in long input line test                      >> results
 echo    gradlong.in is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++   50 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto gradedoc
:finlong
erase gradlong.in
erase testout
erase okay



echo    *** Passed all functional tests
echo    *** Passed all functional tests  >> results

rem // All tests passed. Grade efficiency.
:end
Echo ++ Grade ++   60 = Points earned for correct answers.
Echo ++ Grade ++   60 = Points earned for correct answers. >> results
echo.
echo. >> results

rem Grade efficiency
gradmexp expr.asm >> results
gradmexp expr.asm
echo.
echo. >> results



:gradedoc
rem Grade documentation
graddoc expr.asm >> results
graddoc expr.asm
echo.
echo. >> results



:gradesum
rem Calculate the grade
gradres
type  gradres.tmp
type  gradres.tmp >> results
erase gradres.tmp
echo.
echo. >> results

echo Building the file expr.ans for electronic submission...
echo Building the file expr.ans for electronic submission... >> results
echo. >> results
call gradcpy.bat results+expr.asm expr.ans
goto exit

:error1
echo.
echo The grading system has detected a problem.
echo Some of the required files are missing.
echo Try to re-copy all the grading files from the course locker.
echo If this fails then contact the instructor.
echo The grading system has detected a problem.                   >> results
echo Some of the required files are missing.                      >> results
echo Try to re-copy all the grading files from the course locker. >> results
echo If this fails then contact the instructor.                   >> results
echo.
goto exit

:error2
echo.
echo The executable file 'expr.exe' does not exist in this directory.
echo.
echo The executable file 'expr.exe' does not exist in this directory. >> results
goto exit

:error3
echo.
echo The source assembler file 'expr.asm' does not exist in this directory.
echo This file is needed to continue testing.
echo.
echo The source assembler file 'expr.asm' does not exist in this directory. >> results
echo This file is needed to continue testing.                                   >> results
goto exit

:locked
echo.
echo The grading system can not access its files.
echo Shutdown the system and reboot.
echo.
goto exit

:exit
echo.
