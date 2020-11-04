================DiscoverScheduledTasks ================

This template use PowerShell Cmdlets to discover and manage Windows Tasks Scheduled.

Items : Task Last Result (Status for each tasks), Task Last Run Time, Task Next Run time

Discovery : All tasks Active or Running

Triggers : [HIGH] => Last Result of tasks FAILED<br>
Triggers : [HIGH] => State of tasks Disabled

Install :
Import template,
Install the Zabbix agent on your host,
Copy DiscoverScheduledTasks.ps1 in your zabbix agent directory,
In powershell script change $path variable for subsfolders,
Add the following line to your Zabbix agent configuration file :


EnableRemoteCommands=1
UnsafeUserParameters=1
UserParameter=TaskSchedulerMonitoring[*],powershell -NoProfile -ExecutionPolicy Bypass -File "C:\_zabbix\DiscoverScheduledTasks.ps1" "$1" "$2"
Timeout=30



do not forget to restart the zabbix agent!!









####### USER-DEFINED MONITORED PARAMETERS #######

### Option: UnsafeUserParameters
#	Allow all characters to be passed in arguments to user-defined parameters.
#	The following characters are not allowed:
#	\ ' " ` * ? [ ] { } ~ $ ! & ; ( ) < > | # @
#	Additionally, newline characters are not allowed.
#	0 - do not allow
#	1 - allow
#
# Mandatory: no
# Range: 0-1
# Default:
# UnsafeUserParameters=0
UnsafeUserParameters=1

### Option: UserParameter
#	User-defined parameter to monitor. There can be several user-defined parameters.
#	Format: UserParameter=<key>,<shell command>
#
# Mandatory: no
# Default:
# UserParameter=
UserParameter=TaskSchedulerMonitoring[*],powershell -NoProfile -ExecutionPolicy Bypass -File "C:\_zabbix\DiscoverScheduledTasks.ps1" "$1" "$2"