$applicationId = Get-AutomationVariable -Name 'applicationId'
$tenantId = Get-AutomationVariable -Name 'tenantId'
$appsecret = Get-AutomationVariable -Name 'secureStringPwd'
$virtualNetworkResourceGroup = Get-AutomationVariable -Name ''
$virtualnetworkname = Get-AutomationVariable -Name 'virtualNetworkResourceGroup'
$pdc_networkInterfaceIP = Get-AutomationVariable -Name 'pdc_networkInterfaceIP'


#LOGON TO AZURE
$secpasswd = ConvertTo-SecureString $appsecret -AsPlainText -Force
($creds = New-Object System.Management.Automation.PSCredential ($applicationId, $secpasswd))
Connect-AzureRmAccount -ServicePrincipal -Credential $credential -TenantId $tenantId

#SET DNS SERVER IP IN AZURE VNET
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $virtualNetworkResourceGroup -name $virtualnetworkname 
$vnet.DhcpOptions.DnsServers = $pdc_networkInterfaceIP 
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
