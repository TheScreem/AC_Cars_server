@echo off
chcp 65001 > nul

REM Chemin relatif du dossier du repository cloné
set "repoDirectory=.\cars"

REM Aller dans le dossier du repository cloné
cd "%repoDirectory%"

REM Mise à jour du repository
echo Mise à jour du repository...
git pull

REM Vérifier si la mise à jour a été effectuée avec succès
if %errorlevel% neq 0 (
    echo Erreur lors de la mise à jour du repository.
    echo Terminé.
    PAUSE
    exit /b
)

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
