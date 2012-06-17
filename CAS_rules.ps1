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
$serviceList = @("Outlook Web App", "Exchange ActiveSync", "Exchange Control Panel", "Exchange Web Services", "POP3", "IMAP4")
$serviceCount = 1
foreach ($service in $serviceList)
{
  write-host $serviceCount, $service
  $serviceCount += 1
}
$accessedService = Read-Host "Please choose a Service by number from the list above."
#TODO List all CAS with ExternalURL for the selected service by number
$casCount = 1
foreach ($casServer in $casList)
{
  if ($casServer.ExternalURL)
    {
      Write-Host $casCount, $casServer.Name, $casServer.Version, $casServer.ServicePack, $casServer.Site
    }
  $casCount += 1
}
$accessedCAS = Read-Host "Please choose a CAS by number from the list above."

Write-Host "Simulating a user from mailbox server", $mbxList[($accessedMBX - 1)].Name, "accessing", $serviceList[($accessedService - 1)], "though client access server", $casList[($accessedCAS - 1)].Name