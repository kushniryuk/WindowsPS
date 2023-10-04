Function Check-RunAsAdministrator()
{
  #Get current user context
  $CurrentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  
  #Check user is running the script is member of Administrator Group
  if($CurrentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
  {
       Write-host "Script is running with Administrator privileges!"
  }
  else
    {
       #Create a new Elevated process to Start PowerShell
       $ElevatedProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";
 
       # Specify the current script path and name as a parameter
       $ElevatedProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"
 
       #Set the Process to elevated
       $ElevatedProcess.Verb = "runas"
 
       #Start the new elevated process
       [System.Diagnostics.Process]::Start($ElevatedProcess)
 
       #Exit from the current, unelevated, process
       Exit
 
    }
}
 
#Check Script is running with Elevated Privileges
Check-RunAsAdministrator

while ($true) {
    Clear-Host
    $quserInfo = quser
    Write-Host "Список текущих сеансов пользователей:"
    quser

    # Запрос пользователя на выбор ID сеанса для подключения
    $selectedId = Read-Host "Введите ID пользователя для подключения"

    # Проверка, что введенный ID не пуст и существует в списке сеансов
    if (-not [string]::IsNullOrWhiteSpace($selectedId) -and $quserInfo -match "\b$selectedId\b") {
        # Подключение к выбранному сеансу с использованием mstsc
        $mstscCommand = "Mstsc /shadow:$selectedId /control /noConsentPrompt"
        Invoke-Expression $mstscCommand
    } elseif ([string]::IsNullOrWhiteSpace($selectedId)) {
        Write-Host "В начало скрипта"
    } else {
        Write-Host "В начало скрипта"
    } 
}
