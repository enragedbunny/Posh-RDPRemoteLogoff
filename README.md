# Posh-RDPRemoteLogoff
Powershell script that allows a user to remotely log off their own RDP session. This is useful for RemoteApp or RDP users whose session locks up and are unable to log off or exit normally.

It does this by first performing a query on a remote server for the currently logged in user. If it finds the user logged in on the remote server, it asks for confirmation, if it doesn't find the user logged in, it notifies the user of this. Once confirmed, the script remotely logs off the user from the server using built-in commands. Although not adding functionality that is not there already, non-technical users can utilize this script to log off of a remote session themselves. In an environment where users are using RemoteApp and the application hangs, there are few intuitive ways for users to resolve the issue without involving some kind of IT support.

Email notifications and making mesage windows stay active are the two primary features to be worked on.
