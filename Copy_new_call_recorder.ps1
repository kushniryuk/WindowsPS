# Указываем исходную папку "DesktopCallRecorder"
$sourceFolder = "C:\Users\Администратор\AppData\Local\DesktopCallRecorder"

# Получаем список пользовательских профилей
$profiles = Get-ChildItem "C:\Users" | Where-Object { $_.PSIsContainer }

# Выводим список пользователей
Write-Host "Список пользователей на компьютере:"
for ($i = 0; $i -lt $profiles.Count; $i++) {
    Write-Host "$i. $($profiles[$i].Name)"
}

# Запрашиваем у пользователя номера профилей, в которые нужно скопировать папку
$selectedProfiles = (Read-Host "Введите номера профилей через запятую (например, '0,1')").Split(',')

# Перебираем выбранные профили
foreach ($selectedProfile in $selectedProfiles) {
    $profileNumber = [int]$selectedProfile
    if ($profileNumber -ge 0 -and $profileNumber -lt $profiles.Count) {
        $selectedProfileName = $profiles[$profileNumber].Name
        $destinationFolder = Join-Path "C:\Users" $selectedProfileName
        $destinationFolder = Join-Path $destinationFolder "AppData\Local\DesktopCallRecorder"

        # Проверяем, существует ли исходная папка
        if (Test-Path $sourceFolder -PathType Container) {
            # Копируем папку в профиль пользователя
            Copy-Item -Path $sourceFolder -Destination $destinationFolder -Recurse -Force
            Write-Host "Папка 'DesktopCallRecorder' скопирована в профиль пользователя $selectedProfileName."
        } else {
            Write-Host "Исходная папка 'DesktopCallRecorder' не найдена."
        }
    } else {
        Write-Host "Недопустимый номер профиля: $selectedProfile"
    }
}
