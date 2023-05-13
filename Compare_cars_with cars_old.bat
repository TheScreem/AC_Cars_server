@echo off
chcp 65001 > nul

REM Chemin du dossier "cars_old"
set "oldCarsDirectory=cars_old"

REM Chemin du dossier "cars"
set "newCarsDirectory=cars"

REM Vérifier si le dossier "cars_old" existe
if not exist "%oldCarsDirectory%" (
    echo Le dossier "cars_old" n'existe pas.
    echo Veuillez exécuter le script d'installation avant de poursuivre.
    echo Terminé.
    PAUSE
    exit /b
)

REM Vérifier si le dossier "cars" existe
if not exist "%newCarsDirectory%" (
    echo Le dossier "cars" n'existe pas.
    echo Veuillez exécuter le script d'installation avant de poursuivre.
    echo Terminé.
    PAUSE
    exit /b
)

REM Copier les voitures de "cars_old" vers "cars"
echo Copie des voitures de "cars_old" vers "cars"...
xcopy "%oldCarsDirectory%\*" "%newCarsDirectory%\" /E /I /-Y

echo Les voitures présentes dans "cars_old" ont été copiées avec succès vers "cars".
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
