# Script: DiscoverSchelduledTasks
# Author: Romain Si
# 
# This script is intended for use with Zabbix > 3.x
#
#
# Add to Zabbix Agent
#   UserParameter=TaskSchedulerMonitoring[*],powershell -NoProfile -ExecutionPolicy Bypass -File "C:\_zabbix\DiscoverScheduledTasks.ps1" "$1" "$2"
#
## Change the $path variable to indicate the Scheduled Tasks subfolder to be processed as "\nameFolder\" or "\nameFolder2\subfolder\" see (Get-ScheduledTask -TaskPath )


$path = "\"


Function Convert-ToUnixDate ($PSdate) {
   $epoch = [timezone]::CurrentTimeZone.ToLocalTime([datetime]'1/1/1970')
   (New-TimeSpan -Start $epoch -End $PSdate).TotalSeconds
}

$ITEM = [string]$args[0]
$ID = [string]$args[1]

switch ($ITEM) {
  "DiscoverTasks" {
$apptasks = Get-ScheduledTask -TaskPath $path | where {$_.state -like "Ready" -or "Running"}
$apptasksok = $apptasks.TaskName
$idx = 1
write-host "{"
write-host " `"data`":[`n"
foreach ($currentapptasks in $apptasksok)
{
    if ($idx -lt $apptasksok.count)
    {
     
        $line= "{ `"{#APPTASKS}`" : `"" + $currentapptasks + "`" },"
        write-host $line
    }
    elseif ($idx -ge $apptasksok.count)
    {
    $line= "{ `"{#APPTASKS}`" : `"" + $currentapptasks + "`" }"
    write-host $line
    }
    $idx++;
} 
write-host
write-host " ]"
write-host "}"}}


switch ($ITEM) {
  "TaskLastResult" {
[string] $name = $ID
$pathtask = Get-ScheduledTask -TaskPath "*" -TaskName "$name"
$pathtask1 = $pathtask.Taskpath
$taskResult = Get-ScheduledTaskInfo -TaskPath "$pathtask1" -TaskName "$name"
Write-Output ($taskResult.LastTaskResult)
}}

switch ($ITEM) {
  "TaskLastRunTime" {
[string] $name = $ID
$pathtask = Get-ScheduledTask -TaskPath "*" -TaskName "$name"
$pathtask1 = $pathtask.Taskpath
$taskResult = Get-ScheduledTaskInfo -TaskPath "$pathtask1" -TaskName "$name"
$taskResult1 = $taskResult.LastRunTime
$date = get-date -date "01/01/1970"
$taskResult2 = (New-TimeSpan -Start $date -end $taskresult1).TotalSeconds
Write-Output ($taskResult2)
}}

switch ($ITEM) {
  "TaskNextRunTime" {
[string] $name = $ID
$pathtask = Get-ScheduledTask -TaskPath "*" -TaskName "$name"
$pathtask1 = $pathtask.Taskpath
$taskResult = Get-ScheduledTaskInfo -TaskPath "$pathtask1" -TaskName "$name"
$taskResult1 = $taskResult.NextRunTime
$date = get-date -date "01/01/1970"
$taskResult2 = (New-TimeSpan -Start $date -end $taskresult1).TotalSeconds
Write-Output ($taskResult2)
}}

switch ($ITEM) {
  "TaskState" {
[string] $name = $ID
$pathtask = Get-ScheduledTask -TaskPath "*" -TaskName "$name"
$pathtask1 = $pathtask.State
Write-Output ($pathtask1)
}}
