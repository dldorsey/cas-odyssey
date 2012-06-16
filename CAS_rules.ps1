$serverList = Import-CSV .\CAS_scenario.csv

#TODO List all Mailbox servers by number
$userMailboxServer = Read-Host "Please choose a Mailbox Server by number from the list above."
#TODO List all services by number
$accessedService = Read-Host "Please choose a Service by number from the list above."
#TODO List all CAS with ExternalURL for the selected service by number
$accessedCAS = Read-Host "Please choose a CAS by number from the list above."

$magic