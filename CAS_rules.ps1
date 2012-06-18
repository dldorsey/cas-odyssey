$serverList = Import-CSV .\CAS_scenario.csv
cls
#Process the $serverList into arrays for CAS and MBX
$casList = @()
$mbxList = @()
foreach ($server in $serverList)
{
  if ($server.IsCAS -eq $True) {$casList += $server}
  if ($server.IsMBX -eq $True) {$mbxList += $server}
}

#List all Mailbox servers by number, adding one so humans don't have to deal with 0 indexed arrays
$mbxCount = 1
foreach ($mbxServer in $mbxList)
{
  Write-Host $mbxCount, $mbxServer.Name, $mbxServer.Version, $mbxServer.ServicePack, $mbxServer.Site
  $mbxCount += 1
}
$accessedMBX = Read-Host "Please choose a Mailbox Server by number from the list above."
#Convert from integer selection to object and adjust by 1 for 0 based array index
$accessedMBX = $mbxList[$accessedMBX - 1]

#List all services by number, adding one so humans don't have to deal with 0 indexed arrays
#$serviceList created as an array of two item arrays. The individual service arrays contain the friendly name at [0] and the external data column name at [1]. This is used to test for service availability when prompting the user to select a CAS that offers the selected service externally.
$serviceList = @(@("Outlook Web App","OWA_ExternalURL"), @("Exchange ActiveSync", "EAS_ExternalURL"), @("Exchange Control Panel", "ECP_ExternalURL"), @("Exchange Web Services", "EWS_ExternalURL"), @("POP3","POP_InternalConnectionSettings"), @("IMAP4","IMAP_InternalConnectionSettings"))
$serviceCount = 1
cls
foreach ($service in $serviceList)
{
  Write-Host $serviceCount, $service[0]
  $serviceCount += 1
}
$accessedService = Read-Host "Please choose a Service by number from the list above."
#Convert from integer selection to object and adjust by 1 for 0 based array index
$accessedService = $serviceList[$accessedService - 1]

#List all CAS with ExternalURL for the selected service by number, adding one so humans don't have to deal with 0 indexed arrays
#TODO add logic to make numbers for each service sequential, instead of just skipping over servers that don't offer the service externally
$casCount = 1
cls
foreach ($casServer in $casList)
{
  #For some reason, the propterty column name needs to be evaluated before it will work - thus the parentheses around $accessedService[1]
  if ($casServer.($accessedService[1]))
    {
      Write-Host $casCount, $casServer.Name, $casServer.Version, $casServer.ServicePack, $casServer.Site
    }
  $casCount += 1
}
$accessedCAS = Read-Host "Please choose a CAS by number from the list above."
#Convert from integer selection to object and adjust by 1 for 0 based array index
$accessedCAS = $casList[$accessedCAS - 1]
#Report selections back to the user
cls
Write-Host "Simulating a user from mailbox server " -nonewline
Write-Host $accessedMBX.Name -nonewline -foregroundcolor green
Write-Host " accessing " -nonewline
Write-Host $accessedService[0] -nonewline -foregroundcolor green
Write-Host " though client access server " -nonewline
Write-Host $accessedCAS.Name -nonewline -foregroundcolor green
Write-Host "."


