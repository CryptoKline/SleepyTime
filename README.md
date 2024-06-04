# SleepyTime
Set a sleep Date and Time instead of windows sleep timer

This is a powershell script I created due to some issues I've had with programs not allowing the computer to go to sleep. My personal experience is stability testing software like TestMem5 will put your computer to sleep in the middle of the memory test if there's user activity or something like OCCT that won't allow sleep to function if the program is open at all. Those are just two examples. This script works by prompting the user for the Date and Time the computer should be put to sleep. This solves both of the above mentioned software sleep issues. It also solves the issue of windows only having a max 5hr sleep function. With TM5, I can guess about how long a test will take just from my own previous observations and I can set a sleep timer close to the duration of the test. But what if I accidentally move the mouse during the test? Then the sleep timer starts all over. Or what if I want to crank up the test duration and a 5hr sleep timer isn't long enough? If I want to run a OCCT 12 hour stability test, I always do it overnight. Then I'm at work the next day when the test finishes and my power hungry, overclocked pc is running all day until I get home. I'm not sure why windows doesn't have sleep time option instead of the sleep timer option but this is a little workaround for anyone else in the same boat. 




******* INSTRUCTIONS ********
Right click windows Start button and run terminal as admin

Enter the following into the terminal and press enter (this allows your computer to run unsigned powershell scripts)
set-executionpolicy remotesigned

Save SleepyTime.ps1 to your computer
For convenience, I have SleepyTime.ps1 saved in c:\windows\system32

In windows search bar, type "powershell" and hit enter. Then right click powershell and run as administrator (Must be ran with admin privileges)

Powershell by default opens to the system32 folder (hence the convenience thing earlier). Type "SleepyTime.ps1" (without quotations) and hit enter if you have saved it to system32. If not, type in powershell "cd c:\your location here\SleepyTime.ps1" (without quotations) and hit enter. 

The script should run and prompt you for the date.
Enter the date in the format MM:DD or M:D then hit enter

The script should prompt you for the time
Enter the time in the format HH:MM am/pm or H:M am/pm then hit enter

Close powershell if it's still open after entering the time. 

This will automatically create a basic task in the task scheduler to put your machine to sleep on whatever date, at whatever time you input during the prompt.
It's a one time use task so next time you want to set a sleep time, just run the script again and input the new date and time. 

NOTE: The script does not automatically delete the task that was created so if you use this often, you may want to clear out your task scheduler of all the sleep tasks that you have previously used. 
They are disabled after one time use but they will clutter up your scheduler. If any experts out there know how the script could auto delete the task, feel free to modify the script. 
To clear the task scheduler, type in windows search bar "task scheduler" (without quotations) and open the scheduler. In the task scheduler libray, look for any old entries named "PutComputerToSleep_########_######" and delete them.
