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
