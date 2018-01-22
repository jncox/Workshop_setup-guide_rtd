
#hardev.sanghera@nutanix.com
#Internal Use Only
#Provided as is and unsupported
#15Jan18
#Usage: Just run in powershell or call with a (optional) single parameter: the password for the POC
# eg. ./thiscript.ps1 pocpw
# Note: The password should meet the POC complexity rules  - the default supplied with your automation email is the one to use.
#
#22Jan18 - Minor updates made by nathan.cox@nutanix.com
#
##
Param(
  [string]$plainpw
)
# Variables / parameters 
$poc = "bootcamp" #prefix for Hosted POCs
#$plainpw = "nutanix/4u"
#$adssecurepw =  $plainpw | ConvertTo-SecureString -AsPlainText -Force
$ifIndexdefault = 12                        #usually the NIC interface is 12
$adhostname ="DC"                           #hostname for the AD server, using the default would mean one less reboot but it's not pretty  
$markerfile = "C:\scripts\PoCmarker.txt"    #pass information after reboots
$done = "DONE"                              #Termination marker
$step1 = "STEP1"                            #Next step marker
$step2 = "bootcamp*"                        #Next step marker   
$step3 = "*.local"                          #Next step marker
$op = "===== "                              #Helps with my ocd
$firstpartip = "10.21."                     #POC IP Address builder
$defaultstatic = ".40"                      #Use this as the static IP for the AD server VM 
$defaultprefix = 25                         #netmask for POC networks
$defaultgwayend = ".1"                      #Where the default gateway is
$dns1 = "10.21.253.10"                      #The default nameserver 1
$dns2 = "10.21.253.11"                      #The default nameserver 2
$printmask = "255.255.255.128"              #default netmask
#
#Added by Nathan for Group & User Add
#
$Users=Import-csv c:\scripts\add-users.csv
#
$a=1;
$b=1;
$failedUsers = @()
$usersAlreadyExist =@()
$successUsers = @()
$VerbosePreference = "Continue"
$LogFolder = "c:\scripts\logs"
$GroupName = "Bootcamp Users"
$OU = "CN=Users, DC=BOOTCAMP,DC=LOCAL"
#
#
#BEGIN
write-host "$op Start Script"
#Have we rebooted this host after running this script before?
if ((test-Path $markerfile) -eq $true) {
   #We're back from a reboot and previous running of this script
   #file exists, work out what was the last STEP and go to the next step
   $filein = Get-Content $markerfile
   $fileinsplit = $filein.Split(" ")
   $nextstep = $fileinsplit[0]
   $plainpw = $fileinsplit[1]
   #write-host "$op Next step: $nextstep"
   if ($nextstep -eq $done) {
        write-host "$op All steps executed, nothing more to do, quiting"
        exit
   }
}
Else {
      write-host "$op First Run" 
      $nextstep = $step1
}
If ($nextstep -eq $step1) {
   
   #See if we can determine the POCnnn from the IP address
   $dynamicips = Get-NetIPAddress -InterfaceIndex $ifIndexdefault
   $dynamicipv4 = $dynamicips[1] #2nd value is normally the IPv4 address, 1st is normally the IPv6
   $dynamicpocarray = $dynamicipv4 -split "\." #parse the array
   $dynamicpocno = $dynamicpocarray[2] #eg. the 86 from 10.21.86.51
   write-host "$op (I think you're POC $dynamicpocno )"
   #Was the password received as a paramter?  If not then prompt for it
   if ($plainpw -eq "") {
      $plainpw = Read-Host "$op What is the POC$dynamicpocno password, I'll use this for all AD passwords"
   }
   $securepw =  $plainpw | ConvertTo-SecureString -AsPlainText -Force
   #Step 1: Set a Static IP Address
   write-host "$op Step 1: Set Static IP Address for this host"
   #Should only have one ifIndex
   $interface = Get-NetAdapter
   write-host "$op Here is the network ifIndex for this host (it will have the static IP set)"
   $interface | ft Name,ifIndex -AutoSize
   $ifIndex = $interface.ifIndex
   write-host "$op (I think you're POC $dynamicpocno )"
   $pocnumber = $dynamicpocno
   if ($pocnumber -eq "") {$pocnumber = $dynamicpocno}
   $pocnumberstr = $pocnumber
   if ($pocnumberstr.Length -lt 2) {$pocnumberstr = "00" + $pocnumberstr}
   else { if ($pocnumberstr.Length -lt 3) {$pocnumberstr = "0" + $pocnumberstr}}
   write-host "$op I will use the following defaults to setup your AD server."
   write-host "$op They are usually OK to get you an AD suitable for Calm/SSP." 
   $iptouse = $firstpartip + $pocnumber + $defaultstatic
   $prefix = $defaultprefix
   $gw = $firstpartip + $pocnumber + $defaultgwayend
   write-host "$op Static IP for AD Server: $iptouse"
   write-host "$op Network prefix: $prefix ($printmask)"
   write-host "$op Default gateway: $gw"
   write-host "$op DNS: $dns1"
   write-host "$op DNS: $dns2"
   write-host "$op Interface: $ifIndex"
   write-host "$op POC: $pocnumber"
   write-host "$op Domain: $poc.local"
   write-host "$op Password: $plainpw"
   write-host "$op DC hostname: $adhostname"
   $go = read-host "--------- If these are OK hit enter, if not enter q"
   if ($go -eq "q") {exit}
   else { if ($go -eq "") {} }
   $continue = Read-Host "$op Will now change IP address and hostname then reboot, hit enter now to continue"
   write-host "$op Changing IP to $iptouse - if you are RDPng you will lose the session, that's why I said run from console"
   New-NetIPAddress –InterfaceIndex $ifIndex –IPAddress $iptouse –PrefixLength $prefix -DefaultGateway $gw
   Set-DnsClientServerAddress -InterfaceIndex $ifIndex -ServerAddresses ($dns1,$dns2)
   #write a marker for when back from a reboot, pass on the pw too
   $poc = "bootcamp $plainpw"
   $poc | Out-File $markerfile
   write-host "$op Step 1.1: Set hostname to $adhostname"
   Rename-Computer -NewName $adhostname -Restart
} 
if ($nextstep -like $step2 -and $nextstep -notlike "*.local" ) {
   #Step 2: Add AD/DNS Role and also the AD Doman and Forest
   $domain = $nextstep + ".local"
   $netbiosname = $nextstep.ToUpper()
   write-host "$op Step 2: Add AD/DNS Role to server and add $domain Domain/Forest"
   $continue = Read-Host "$op just hit enter now to continue"
   install-windowsfeature AD-Domain-Services -IncludeManagementTools
   write-host "$op Step 2.1: Add AD Domain and Forest, there will be a reboot!!!!!!"
   #write a marker for when back from a reboot
   #Write closing marker
   "$done abc" | Out-File $markerfile
   #make plain password a secure one
   $securepw =  $plainpw | ConvertTo-SecureString -AsPlainText -Force
   #write-host "===== b4 Install-Addsforest: $nextstep $plainpw ========"
   #$continue = read-host "$op Pause, hit enter to continue:"
   Install-ADDSForest -SafeModeAdministratorPassword $securepw -CreateDnsDelegation:$false -DatabasePath “C:\Windows\NTDS” -DomainMode “Win2012R2” -DomainName $domain -DomainNetbiosName $netbiosname -ForestMode “Win2012R2” -InstallDns:$true -LogPath “C:\Windows\NTDS” -SysvolPath “C:\Windows\SYSVOL” -Force:$true
}
if ($nextstep -like $step3) {
   $domain = $nextstep
   write-host "$op Step 3: Add Users and Groups"
   $continue = Read-Host "$op just hit enter now to continue"
   #Add Groups and Users to the Groups
    NEW-ADGroup -name $GroupName -GroupScope Global

    ForEach($User in $Users)
    {
    $User.FirstName = $User.FirstName.substring(0,1).toupper()+$User.FirstName.substring(1).tolower()
    $FullName = $User.FirstName
    $Sam = $User.FirstName 
    $dnsroot = '@' + (Get-ADDomain).dnsroot
    $SAM = $sam.tolower()
    $UPN = $SAM + "$dnsroot"
    $email = $Sam + "$dnsroot"
    $password = $user.password
    try {
        if (!(get-aduser -Filter {samaccountname -eq "$SAM"})){
            New-ADUser -Name $FullName -AccountPassword (ConvertTo-SecureString $password -AsPlainText -force) -GivenName $User.FirstName  -Path $OU -SamAccountName $SAM -UserPrincipalName $UPN -EmailAddress $Email -Enabled $TRUE
            Add-ADGroupMember -Identity $GroupName -Member $Sam
            Write-Verbose "[PASS] Created $FullName"
            $successUsers += $FullName
        }
  
    }
    catch {
        Write-Warning "[ERROR]Can't create user [$($FullName)] : $_"
        $failedUsers += $FullName
        }
    }
    if ( !(test-path $LogFolder)) {
        Write-Verbose "Folder [$($LogFolder)] does not exist, creating"
        new-item $LogFolder -type directory -Force 
        }

    Write-verbose "Writing logs"
    $failedUsers |ForEach-Object {"$($b).) $($_)"; $b++} | out-file -FilePath  $LogFolder\FailedUsers.log -Force -Verbose
    $successUsers | ForEach-Object {"$($a).) $($_)"; $a++} |out-file -FilePath  $LogFolder\successUsers.log -Force -Verbose
}