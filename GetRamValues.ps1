Param
(
  [string]$vmfqdn
)

$VM_ = $vmfqdn.Split(".")
$ThisVM = $VM_[0]

$xmlresult =""
$dataset = ""
$xmlret =""  

$VMsXML= $null
$VMsXML = Import-Clixml -Path "C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\RamValues\UpdateRamValues.xml"

foreach($VM in $VMsXML) {
if($VM.Name -eq $ThisVM){

$demand = $VM.MemoryDemand/1MB
$assignd =$VM.MemoryAssigned/1MB
$status=$VM.MemoryStatus
$minimum=$VM.MemoryMinimum/1MB
$maximum=$VM.MemoryMaximum/1MB
[int]$free=100-($VM.MemoryDemand/$VM.MemoryAssigned*100)
[int]$freemax=100-($VM.MemoryDemand/$VM.MemoryMaximum*100)


if($status -eq "OK"){
$statusval = 0
}
else{
$statusval = 1
}


$dataset=              

                         "<result>
                            <channel>"+"Demand"+"</channel>
                            <unit>"+"Custom"+"</unit>
                            <CustomUnit>"+"MB"+"</CustomUnit>
                            <value>"+$demand+"</value>
                        </result>
                        <result>
                            <channel>"+"Assigned"+"</channel>
                            <unit>"+"Custom"+"</unit>
                            <CustomUnit>"+"MB"+"</CustomUnit>
                            <value>"+$assignd+"</value>
                        </result>
                        <result>
                            <channel>"+"Status"+"</channel>
                            <value>"+$statusval+"</value>
                            <ValueLookup>hyperv.ram.status</ValueLookup>
                        </result>
                        <result>
                            <channel>"+"Minimum"+"</channel> 
                            <unit>"+"Custom"+"</unit>
                            <CustomUnit>"+"MB"+"</CustomUnit>                 
                            <value>"+$minimum+"</value>
                        </result>
                         <result>
                            <channel>"+"Maximum"+"</channel>  
                            <unit>"+"Custom"+"</unit>
                            <CustomUnit>"+"MB"+"</CustomUnit>      
                            <value>"+$maximum+"</value>
                        </result>
                        <result>
                            <channel>"+"Free"+"</channel>
                            <unit>"+"Percent"+"</unit>
                            <value>"+$free+"</value>
                        </result>
                        <result>
                            <channel>"+"Free Max"+"</channel>
                            <unit>"+"Percent"+"</unit>
                            <value>"+$freemax+"</value>
                        </result>"


$xmlresult = $dataset
$xmlret="<prtg>"+$xmlresult+"</prtg>"
$xmlret
}
}