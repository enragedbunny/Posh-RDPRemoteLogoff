<#
    Posh-RDPRemotLogoff.ps1
    Purpose:  This script was written to allow non-administrative users the ability to log themselves off of a remote server
              without the need to contact IT support. This script was designed to be ran from by the user (original mechanism is
              through the use of a 'launcher' .bat file that makes sure to run with no window and to bypass execution policy).
    Author:   john.keeton@gracechc.org, techsupport@gracechc.org
    Version:  0.5
    Modified: 2016.11.22
    Future:   Anticipated future features are as follows:
              Message windows always on top (It is hard for the user when the window loads behind the RDP session)
              Email notification support
              Additional client information (OS, Architecture, Memory, RDP version)
              Additional server information (OS, Architecture, Memory, RDP version, # sessions, %CPU)
              Other client environmental details (Client RDP KB updates, Event log parsing, Uptime, Networking, DNS)
              Other server environmental details (Server RDP KB updates, Event log parsing, Uptime, Networking, DNS)
              Monitoring frequency of self-reset
              Monitoring total # of sel-reset over life of script
              Parameterization of the variables (they can be specified in the loading application
              Making it a module, possibly.
#>

# Variables for remote query
$server = "192.168.1.2"
$user = $env:USERNAME # Current logged on user

# Get the session# for the current logged on user
$session = ((quser /server:$server | ? { $_ -Match $user }) -Split ' +')[2]

# Get current date/time
$nowdate = Get-Date -Format "dd-MMM-yyyy"
$nowtime = Get-Date -Format "HH:mm"

If ($session) # If a session was returned from the query
    { # Loads messagebox and asks the user to confirm the user they are logging off
        [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
        $output = [System.Windows.Forms.Messagebox]::Show("Are you sure you want to log off the following user: $user ?", "Confirm", 4)
        If ($output -eq "YES") # If the user confirms 'yes' for the user to log off
            {      
                # Logs the specified user out of the session on the remote server
                Logoff $session /server:$server
            }
    }
Else # If no session was returned from the query
    { # Loads a messagebox to let the user know their current user was not found on the remote server
        [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
        $output = [System.Windows.Forms.Messagebox]::Show("You are not logged in on the server, if you are still having issues, contact IT Support", "Not found")
    }
