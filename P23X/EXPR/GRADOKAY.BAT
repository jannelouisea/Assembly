@echo  off
echo.

rem // verify the user typed the correct command
if %1. == .      goto errcmd

if not exist %1  goto errin

call gradcpy.bat %1+EOF grad.tmp
echo.
echo. To be safe, I added a DOS end_of_file character to %1
echo. and stored the result in grad.tmp which is being used
echo. as the input to the EXPR program.
gradexok < grad.tmp > okay
echo.
echo 'okay' is the expected output file
goto exit

:errcmd
echo.
echo To run a test type:  gradokay  input_file
echo.
goto   exit

:errin
echo.
echo The input file specified: %1 does not exist.
echo.
goto   exit

:exit
echo.
