# Prompt the user for the date to put the computer to sleep
$dateInput = Read-Host "Enter the date to put the computer to sleep (e.g., 6:15 or 12:31)"

# Prompt the user for the time to put the computer to sleep
$timeInput = Read-Host "Enter the time to put the computer to sleep (e.g., 6:00 am or 10:30 pm)"

# Validate the date and time format
if ($dateInput -match '^(0?[1-9]|1[0-2]):(0?[1-9]|[12][0-9]|3[01])$' -and $timeInput -match '^(1[0-2]|0?[1-9]):([0-5][0-9])\s?(AM|PM)$') {
    # Convert the date input to a DateTime object
    $date = [datetime]::ParseExact($dateInput, 'M:d', $null)

    # Convert the time input to a DateTime object
    $time = [datetime]::ParseExact($timeInput, 'h:mm tt', $null)

    # Combine the specified date with input time for the current year
    $scheduledTime = Get-Date -Year (Get-Date).Year -Month $date.Month -Day $date.Day -Hour $time.Hour -Minute $time.Minute -Second 0

    # Ensure the scheduled time is in the future
    if ($scheduledTime -lt (Get-Date)) {
        Write-Host "The specified date and time are in the past. Please enter a future date and time."
    } else {
        # Format the scheduled time for Task Scheduler
        $scheduledTimeString = $scheduledTime.ToString("yyyy-MM-ddTHH:mm:ss")

        # Define the action to put the computer to sleep
        $action = New-ScheduledTaskAction -Execute 'rundll32.exe' -Argument 'powrprof.dll,SetSuspendState 0,1,0'

        # Define the trigger at the specified time
        $trigger = New-ScheduledTaskTrigger -Once -At $scheduledTime

        # Define the principal to run the task with highest privileges
        $principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

        # Create the task in the Task Scheduler
        $taskName = "PutComputerToSleep_$($scheduledTime.ToString('yyyyMMdd_HHmmss'))"
        Register-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -TaskName $taskName -Description "Puts the computer to sleep at the specified date and time."

        Write-Host "Task '$taskName' created to put the computer to sleep at $scheduledTimeString."
    }
} else {
    Write-Host "Invalid date or time format. Please enter the date in the format of 'mm:dd' or 'm:d' and the time in the format of 'hh:mm am/pm'."
}
