# �������� ������ ���������������� ��������
$profiles = Get-ChildItem "C:\Users" | Where-Object { $_.PSIsContainer }

# ������� ������ �������������
Write-Host "������ ������������� �� ����������:"
for ($i = 0; $i -lt $profiles.Count; $i++) {
    Write-Host "$i. $($profiles[$i].Name)"
}

# ����������� � ������������ ������ �������� ��� �������� ����� MP3SkypeRecorder
$selectedProfiles = (Read-Host "������� ������ �������� ����� ������� (��������, '0,1')").Split(',')

# ���������� ��������� �������
foreach ($selectedProfile in $selectedProfiles) {
    $profileNumber = [int]$selectedProfile
    if ($profileNumber -ge 0 -and $profileNumber -lt $profiles.Count) {
        $selectedProfileName = $profiles[$profileNumber].Name
        $mp3SkypeRecorderPath = Join-Path "C:\Users" $selectedProfileName
        $mp3SkypeRecorderPath = Join-Path $mp3SkypeRecorderPath "AppData\Local\MP3SkypeRecorder"

        # ���������, ���������� �� ����� MP3SkypeRecorder
        if (Test-Path $mp3SkypeRecorderPath) {
            Remove-Item -Path $mp3SkypeRecorderPath -Recurse -Force
            Write-Host "����� 'MP3SkypeRecorder' � ������� ������������ $selectedProfileName �������."
        } else {
            Write-Host "����� 'MP3SkypeRecorder' �� ������� � ������� ������������ $selectedProfileName."
        }
    } else {
        Write-Host "������������ ����� �������: $selectedProfile"
    }
}
