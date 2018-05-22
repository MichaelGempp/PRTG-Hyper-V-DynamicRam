#Replace the Computername with the Hyper-V hostnames 

$hypervhost1 = Get-VM –computername ‘hyperv-host1’ | Where { $_.State –eq ‘Running’ } | Select-Object -Property Name,MemoryDemand,MemoryAssigned,MemoryStatus,MemoryMinimum,MemoryMaximum
$hypervhost2 = Get-VM –computername ‘hyperv-host2’ | Where { $_.State –eq ‘Running’ } | Select-Object -Property Name,MemoryDemand,MemoryAssigned,MemoryStatus,MemoryMinimum,MemoryMaximum
$hypervhost3 = Get-VM –computername ‘hyperv-host3’ | Where { $_.State –eq ‘Running’ } | Select-Object -Property Name,MemoryDemand,MemoryAssigned,MemoryStatus,MemoryMinimum,MemoryMaximum
$hypervhost4 = Get-VM –computername ‘hyperv-host4’ | Where { $_.State –eq ‘Running’ } | Select-Object -Property Name,MemoryDemand,MemoryAssigned,MemoryStatus,MemoryMinimum,MemoryMaximum

$VMs = $hypervhost1 + $hypervhost2 + $hypervhost3 + $hypervhost4
$VMs | Export-Clixml -Path "C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\RamValues\UpdateRamValues.xml"

$dataset= "<result>
                            <channel>"+"Updated VMs"+"</channel>
                            <unit>"+"Custom"+"</unit>
                            <CustomUnit>"+"VMs"+"</CustomUnit>
                            <value>"+$VMs.Count+"</value>
                        </result>"

$xmlresult = $dataset
$xmlret="<prtg>"+$xmlresult+"</prtg>"
$xmlret
