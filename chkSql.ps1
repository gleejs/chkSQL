$srvName=“Servername”
#chkSQL
$sName="MSSQLSERVER"
$service=Get-Service -name $sName -ErrorAction SilentlyContinue
if( -not $service)
{
  $sName + "Is not installed on this computer 'n
  this is second line"
}
else
{
  Write-Host "SQL is installed"
  $os=get-wmiobject -class Win32_OperatingSystem
  Switch -Regex ($os.version)
  {
     "6.3"
         {
            #Windows 8.1 and Windows Sever 2012R2
            #Checked for SQL2016
            $sqlPath="HKLM:SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL13.MSSQLSERVER\Setup"
            if (Get-ItemProperty -Path $sqlPath -ErrorAction Silentlycontinue)
            {
                 $sqlVer=(Get-ItemProperty -Path $sqlPath -ErrorAction Silentlycontinue).version
                 $sqlVer
                 if ($sqlVer -Like "13.0.*")
                 {
                     Write-Host "Installing Management tools"
                     $argvSMS = " /install /quiet"
                     $argvSMS
                     start-process "\\$srvName\Deploymentshare$\Applications\sql2016OSCHK\SSMS-Setup-ENU.exe" $argvSMS -wait
                      

                 }

             }
             


          }
  DEFAULT {"Version not listed"}
  }

   $sName + "Is Installed"
  
   $sComputername=$env:computername
   $sComputername
   
 
    $sqlstr = 'Create Login ['+$sComputername+'\admin] from windows'
    $sqlstr
    & sqlcmd -Usa -PYourPassword -Q "$sqlstr"
    #start-process sqlcmd -argumentlist "$sqlstr" -wait
   #Invoke-sqlcmd $sqlstr
   $sqlstr ="exec sys.sp_addsrvrolemember ["+$scomputername+"\admin], 'sysadmin'"
   $sqlstr
   #Invoke-sqlcmd $sqlstr
   & sqlcmd -Usa -PYourPassword -Q "$sqlstr"
   
}

$os=get-wmiobject -class Win32_OperatingSystem
  Switch -Regex ($os.version)
  {
     "6.3"
         {
            #Windows 8.1

               if($os.productType -eq 1)
               {
                   if(Test-Path c:\InstallESE.txt)
                   
                   {

                     $GLBINSTDIR=(${env:ProgramFiles(x86)},${env:ProgramFiles} -ne $null)[0]
                     $GLBINSTDIR=$GLBINSTDIR+"\Exact Software\SYNERGY.NET\"
                     $GLBINSTDIR
                     $Program="\\$srvName\deploymentshare$\Applications\programcd\Setup.exe"
                     $arguments=' /S:2 /I:'+'"'+ $GLBINSTDIR+'"'
                     start-process "$Program" "$arguments" -Wait 
                     write-host 'Completed'
                     Remove-Item c:\InstallESE.txt
                 
                   }
               }
               
         }

    "6.1"
         {
            Write-host "Installing ESE on Windows 7"
            #Windows 7 SP1

               if($os.productType -eq 1)
               {
                   if(Test-Path c:\InstallESE.txt)
                   
                   {

                     $GLBINSTDIR=(${env:ProgramFiles(x86)},${env:ProgramFiles} -ne $null)[0]
                     $GLBINSTDIR=$GLBINSTDIR+"\Software\cdset\"
                     $GLBINSTDIR
                     $Program="\\$srvName\deploymentshare$\Applications\_CDSet\Setup.exe"
                     $arguments=' /S:2 /I:'+'"'+ $GLBINSTDIR+'"'
                     start-process "$Program" "$arguments" -Wait 
                     write-host 'Completed'
                     Remove-Item c:\InstallESE.txt
                 
                   }
               }
               
         }   


   DEFAULT{"NO ESE Installation"}

   }


