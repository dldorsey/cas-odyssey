$serverList = Import-CSV .\CAS_scenario.csv

#Process the $serverList into arrays for CAS and MBX
$casList = @()
$mbxList = @()
foreach ($server in $serverList)
{
  if ($server.IsCAS -eq $True) {$casList += $server}
  if ($server.IsMBX -eq $True) {$mbxList += $server}
}

#List all Mailbox servers by number
$mbxCount = 1
foreach ($mbxServer in $mbxList)
{
  write-host $mbxCount, $mbxServer.Name, $mbxServer.Version, $mbxServer.ServicePack, $mbxServer.Site
  $mbxCount += 1
}
$accessedMBX = Read-Host "Please choose a Mailbox Server by number from the list above."
#Convert from integer selection to object and adjust by 1 for 0 based array index
$accessedMBX = $mbxList[$accessedMBX - 1]

#List all services by number
$serviceList = @(@("Outlook Web App","OWA_ExternalURL"), @("Exchange ActiveSync", "EAS_ExternalURL"), @("Exchange Control Panel", "ECP_ExternalURL"), @("Exchange Web Services", "EWS_ExternalURL"), @("POP3","POP_InternalConnectionSettings"), @("IMAP4","IMAP_InternalConnectionSettings"))
$serviceCount = 1
foreach ($service in $serviceList)
{
  write-host $serviceCount, $service[0]
  $serviceCount += 1
}
$accessedService = Read-Host "Please choose a Service by number from the list above."
#Convert from integer selection to object and adjust by 1 for 0 based array index
$accessedService = $serviceList[$accessedService - 1]

#List all CAS with ExternalURL for the selected service by number
$casCount = 1
foreach ($casServer in $casList)
{
  #For some reason, the propterty needs to be evaluated before it will work - thus the parenthesis around $accessedService[1]
  if ($casServer.($accessedService[1]))
    {
      Write-Host $casCount, $casServer.Name, $casServer.Version, $casServer.ServicePack, $casServer.Site
    }
  $casCount += 1
}
$accessedCAS = Read-Host "Please choose a CAS by number from the list above."
#Convert from integer selection to object and adjust by 1 for 0 based array index
$accessedCAS = $casList[$accessedCAS - 1]

Write-Host "Simulating a user from mailbox server", $accessedMBX.Name, "accessing", $accessedService[0], "though client access server", $accessedCAS.Name

