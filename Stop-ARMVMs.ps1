param(
[string]$resourcegroup,
[string]$subscriptionname
)

$cred = Get-AutomationPSCredential -Name "AzureAutomation"
Login-AzureRmAccount -Credential $cred -SubscriptionName $subscriptionname -TenantId 72f988bf-86f1-41af-91ab-2d7cd011db47

function get-priorityvms
{
param($resourcegroup,
$a)

   get-azurermvm -ResourceGroupName $resourcegroup | select Name,ResourceGroupName,Tags | ForEach-Object {
        if ($_.tags.Keys -contains "Priority" -and $_.tags.Values -eq $a) {
            Write-Output $_
            }
        }
}

function Stop-Vms
{
param ($vms,
$resourcegroup)

    $stopoutput = stop-azurermvm -Name $vms.Name -ResourceGroupName $resourcegroup -Force
    Write-Output "Stopping VM : $vm.Name"

}

$vms = get-priorityvms $resourcegroup "9" 
foreach ($vm in $vms) { Stop-VMs $vm $resourcegroup }
$vms = get-priorityvms $resourcegroup "2" 
foreach ($vm in $vms) { Stop-VMs $vm $resourcegroup }
$vms = get-priorityvms $resourcegroup "1" 
foreach ($vm in $vms) { Stop-VMs $vm $resourcegroup }
$vms = get-priorityvms $resourcegroup "0" 
foreach ($vm in $vms) { Stop-VMs $vm $resourcegroup }
