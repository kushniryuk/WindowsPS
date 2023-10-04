$lastRestartTime = $null

while ($true) {
    $cpuLoad = Get-WmiObject -Query "SELECT LoadPercentage FROM Win32_Processor" | Select-Object -ExpandProperty LoadPercentage

    if ($cpuLoad -gt 90) {
        if ($lastRestartTime -ne $null) {
            $uptimeMinutes = [math]::Round(([datetime]::Now - $lastRestartTime).TotalMinutes)
            Write-Host "Загрузка процессора превышает 90% ($cpuLoad%). Прошло $uptimeMinutes минут с последней перезагрузки."
        }
        else {
            Write-Host "Загрузка процессора превышает 90% ($cpuLoad%). Первая проверка."
        }

        Write-Host "Выполняю перезапуск службы winmgmt..."
        Restart-Service -Name winmgmt -Force
        $lastRestartTime = Get-Date
    }
    else {
        $currentTime = Get-Date
        if ($lastRestartTime -ne $null) {
            $uptimeMinutes = [math]::Round(([datetime]::Now - $lastRestartTime).TotalMinutes)
            Write-Host "Всё ОК. Загрузка процессора: $cpuLoad%. Прошло $uptimeMinutes минут с последней перезагрузки."
        }
        else {
            Write-Host "Всё ОК. Загрузка процессора: $cpuLoad%. Первая проверка."
        }
        
        Write-Host "Ждём 5 минут..."
        Start-Sleep -Seconds 300
    }
}
