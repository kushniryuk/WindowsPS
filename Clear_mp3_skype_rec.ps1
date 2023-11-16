# Получаем список пользовательских профилей
$profiles = Get-ChildItem "C:\Users" | Where-Object { $_.PSIsContainer }

# Выводим список пользователей
Write-Host "Список пользователей на компьютере:"
for ($i = 0; $i -lt $profiles.Count; $i++) {
    Write-Host "$i. $($profiles[$i].Name)"
}

# Запрашиваем у пользователя номера профилей для удаления папки MP3SkypeRecorder
$selectedProfiles = (Read-Host "Введите номера профилей через запятую (например, '0,1')").Split(',')

# Перебираем выбранные профили
foreach ($selectedProfile in $selectedProfiles) {
    $profileNumber = [int]$selectedProfile
    if ($profileNumber -ge 0 -and $profileNumber -lt $profiles.Count) {
        $selectedProfileName = $profiles[$profileNumber].Name
        $mp3SkypeRecorderPath = Join-Path "C:\Users" $selectedProfileName
        $mp3SkypeRecorderPath = Join-Path $mp3SkypeRecorderPath "AppData\Local\MP3SkypeRecorder"

        # Проверяем, существует ли папка MP3SkypeRecorder
        if (Test-Path $mp3SkypeRecorderPath) {
            Remove-Item -Path $mp3SkypeRecorderPath -Recurse -Force
            Write-Host "Папка 'MP3SkypeRecorder' в профиле пользователя $selectedProfileName удалена."
        } else {
            Write-Host "Папка 'MP3SkypeRecorder' не найдена в профиле пользователя $selectedProfileName."
        }
    } else {
        Write-Host "Недопустимый номер профиля: $selectedProfile"
    }
}
