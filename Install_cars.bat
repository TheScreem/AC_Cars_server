@echo off
chcp 65001 > nul

REM Vérifier si Chocolatey est installé
choco --version > nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey n'est pas installé. Installation en cours...
    REM Installer Chocolatey
    powershell -command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    if %errorlevel% neq 0 (
        echo L'installation de Chocolatey a échoué.
        echo Veuillez installer Chocolatey manuellement avant de poursuivre.
        echo Terminé.
        PAUSE
        exit /b
    )
    echo Chocolatey a été installé avec succès.
)

REM Vérifier si Git est installé
git --version > nul 2>&1
if %errorlevel% neq 0 (
    echo Git n'est pas installé. Installation en cours...
    REM Installer Git avec Chocolatey
    choco install git -y
    if %errorlevel% neq 0 (
        echo L'installation de Git a échoué.
        echo Veuillez installer Git manuellement avant de poursuivre.
        echo Terminé.
        PAUSE
        exit /b
    )
    echo Git a été installé avec succès.
)

REM Chemin du dossier "cars_old"
set "oldCarsDirectory=cars_old"

REM Chemin du dossier "cars"
set "newCarsDirectory=cars"

REM Renommer le dossier "cars" en "cars_old" s'il existe
if exist "%newCarsDirectory%" (
    echo Renommage du dossier "cars" en "cars_old"...
    ren "%newCarsDirectory%" "%oldCarsDirectory%"
)

REM Cloner le repository dans le dossier "cars"
echo Clonage du repository Git dans le dossier "cars"...
git clone http://git-lab.dfanetwork.fr:17080/gitlab-instance-d91bbde8/assettocorsa-server-alex.git "%newCarsDirectory%"

REM Aller dans le dossier du repository cloné
cd "%newCarsDirectory%"

REM Mise à jour du repository
echo Mise à jour du repository...
git pull

echo Le repository a été mis à jour avec succès.
echo Terminé.

REM Définir la durée du compte à rebours en secondes
set "countdown=5"

REM Afficher le message du compte à rebours
echo La fenêtre se fermera dans %countdown% secondes...

REM Attendre une seconde à la fois jusqu'à la fin du compte à rebours
for /l %%i in (%countdown%,-1,1) do (
    REM Afficher le temps restant
    echo Temps restant : %%i secondes...
    REM Attendre une seconde
    timeout /t 1 > nul
)

REM Fermer le CMD
echo Temps écoulé. Fermeture de la fenêtre...
exit
