$serverList = Import-CSV .\CAS_scenario.csv

#Process the $serverList into arrays for CAS and MBX
$casList = @()
$mbxList = @()
foreach ($server in $serverList)
{
  if ($server.IsCAS -eq $True) {$casList += $server}
  if ($server.IsMBX -eq $True) {$mbxList += $server}
}

#TODO List all Mailbox servers by number
$mbxCount = 1
foreach ($mbxServer in $mbxList)
{
  write-host $mbxCount, $mbxServer.Name, $mbxServer.Version, $mbxServer.ServicePack, $mbxServer.Site
  $mbxCount += 1
}
$userMailboxServer = Read-Host "Please choose a Mailbox Server by number from the list above."
#TODO List all services by number
Write-Host 1, "Outlook Web App"
Write-Host 2, "Exchange ActiveSync"
Write-Host 3, "Exchange Control Panel"
Write-Host 4, "Exchange Web Services"
Write-Host 5, "POP3"
Write-Host 6, "IMAP4"
$accessedService = Read-Host "Please choose a Service by number from the list above."
#TODO List all CAS with ExternalURL for the selected service by number
$casCount = 1
foreach ($casServer in $casList)
{
  Write-Host $casCount, $casServer.Name, $casServer.Version, $casServer.ServicePack, $casServer.Site
  $casCount += 1
}
$accessedCAS = Read-Host "Please choose a CAS by number from the list above."

