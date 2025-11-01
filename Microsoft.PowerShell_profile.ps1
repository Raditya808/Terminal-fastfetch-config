# =========================================================
# Custom PowerShell Profile (Microsoft.PowerShell_profile.ps1)
# =========================================================

# Minimal profile: UTF‑8
try {
    # Set encoding to UTF-8
    [Console]::InputEncoding  = [System.Text.Encoding]::UTF8
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $OutputEncoding = [System.Text.UTF8Encoding]::new($false)
    chcp 65001 > $null
} catch {}

Clear-Host # Bersihkan layar sebelum semua dimulai

# Custom Window Title
$host.ui.RawUI.WindowTitle = "Raditya terminal"

$env:POWERSHELL_UPDATECHECK = 'Off' # Matikan cek update PowerShell



# ========== 🎨 Custom Functions & Aliases (Minimalist Banner) ==========

# 🚩 DEFINISI FUNGSI Show-Banner (Minimalis)
function Show-Banner {
    Write-Host "--- Terminal Initialized ---" -ForegroundColor DarkCyan
    Write-Host "User: $env:USERNAME on $env:COMPUTERNAME" -ForegroundColor Gray
    Write-Host "Time: $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Gray
    Write-Host ""
}

# Clear ala custom → tidak hapus semua output Python + Panggil Fastfetch
function Clear-Terminal {
    # 1. Membersihkan dengan jarak kosong (sesuai niat Anda)
    1..30 | ForEach-Object { Write-Host "" }
    
    # 2. Menampilkan Banner
    Show-Banner
    
    # 3. Menampilkan Spek Laptop (Fastfetch)
    if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
        fastfetch -c "C:/Users/userkorlantas74/.config/fastfetch/config.jsonc"
    }
}

# Set aliases untuk custom functions
Set-Alias clear Clear-Terminal
Set-Alias banner Show-Banner

# Override ls biar tabel auto rapih sesuai ukuran terminal
function ls {
    Get-ChildItem | Select-Object Name, Length, LastWriteTime | Format-Table -AutoSize
}

# Alias mirip Linux
function ll {
    Get-ChildItem -Force | Select-Object Name, Length, LastWriteTime | Format-Table -AutoSize
}
function la {
    Get-ChildItem -Force | Select-Object Name, Length, LastWriteTime | Format-Table -AutoSize
}



# ========== ⚙️ Module & Environment Settings ==========

# Oh My Posh (theme)
oh-my-posh init pwsh --config "C:\Users\userkorlantas74\AppData\Local\Programs\oh-my-posh\themes\night-owl.omp.json" | Invoke-Expression


# PSReadLine (history suggestion + style)
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView


# Terminal Icons
Import-Module -Name Terminal-Icons



# ========== 🚀 Startup Commands ==========

# Force Fastfetch to use YOUR config every time (bypass path confusion)
if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
    # Clear the host again before running fastfetch to ensure it's at the top
    Clear-Host 
    fastfetch -c "C:/Users/userkorlantas74/.config/fastfetch/config.jsonc"
}

# Tampilkan banner saat startup
Show-Banner