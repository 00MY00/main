@echo off
color e
chcp 65001
mode con cols=30 lines=20
title Verification integraliter
taskkill /im iexplore.exe
set back=%~dp0

set back=%back:~0,-5%


:start
cls
set b-image=0
set icon=0
set python=0
set Git=0
set logAjour=0


rem supretion des oubliés
cd %USERPROFILE%\Downloads
if exist timeee.txt del timeee.txt
if exist timee.txt del timee.txt

cd %back%\temp
if exist version.txt del version.txt


rem controle d'integriter



cd %back%\resourc-img

if exist Back.png (echo [40;33mBack image         [42;37m[OK] [42;37m [40;37m) else (echo [41;37m[ERREUR] [40;33mBack imag est manquant ! [40;37m & set b-image=1)

if exist logo-network-bunny.ico (echo [40;33mIcon image         [42;37m[OK] [42;37m [40;37m) else (echo [41;37m[ERREUR] [40;33mIcon imag est manquant ! [40;37m & set ico=1)

if exist %USERPROFILE%\AppData\Local\Programs\Python\Python* (echo [40;33mPython est instalé [42;37m[OK] [42;37m [40;37m) else (echo [41;37m[ERREUR] [40;33mPython est manquant ! [40;37m & set python=1)

if exist "C:\Program Files (x86)\Git*" (echo [40;33mGit est instalé    [42;37m[OK] [42;37m [40;37m) else (echo [41;37m[ERREUR] [40;33mGit est manquant ! [40;37m & set Git=1)




if %b-image% == 1 echo [42;37m [40;33mRéinstalation du fichiez manquant [40;33m. & cd %back% & rmdir /S /Q resourc-img & mkdir resourc-img & cd %USERPROFILE% & if not exist resourc-img (git clone https://github.com/00MY00/resourc-img.git --progress & copy /Y %userprofile%\resourc-img %back%resourc-img\ & cd %userprofile% & rmdir /S /Q resourc-img & cd %back% & taskkill /f /im mshta.exe & start Michros-scripts.hta & start %back%main\mise-a-jour.bat & exit) else (cd %USERPROFILE% & copy /Y %userprofile%\resourc-img %back%resourc-img\ & cd %USERPROFILE% & rmdir /S /Q resourc-img & cd %back% & cls & taskkill /f /im mshta.exe & start Michros-scripts.hta & start %back%main\mise-a-jour.bat & exit) 

if %icon% == 1 echo [40;33mRéinstalation du fichiez manquant [40;33m. & cd %back% & rmdir /S /Q resourc-img & mkdir resourc-img & cd %USERPROFILE% & if not exist resourc-img (git clone https://github.com/00MY00/resourc-img.git --progress & copy /Y %userprofile%\resourc-img %back%resourc-img\ & cd %userprofile% & rmdir /S /Q resourc-img & cd %back% & taskkill /f /im mshta.exe & start Michros-scripts.hta & start %back%main\mise-a-jour.bat & exit) else (cd %USERPROFILE% & copy /Y %userprofile%\resourc-img %back%resourc-img\ & cd %USERPROFILE% & rmdir /S /Q resourc-img & cd %back% & cls & taskkill /f /im mshta.exe & start Michros-scripts.hta & start %back%main\mise-a-jour.bat & exit)

if %Git% == 1 goto instal-resource

if %python% == 1 (goto instal-resource) else (goto Git-)




rem instalation des fichier .bat avec git command line
:Git- 
cd %back%\temp
if exist version.txt del version.txt
git --version >> version.txt
if %errorlevel% == 0 (echo [40;36mGit [40;33mest bien lancé [42;37m[OK]  [40;33m) else (cls & echo [41;37m[ERREUR] [40;33mGit c'est mal éxecuter réinstaler git ! & set Git=1 & echo [40;35msuprimer le fichier "C:\Program Files (x86)\Git"[40;33m ou atender 5 minute est résailler & pause)
set /p version=<version.txt
if exist version.txt del version.txt
goto Python-


rem verification fonctionement de python
:Python-
cd %USERPROFILE%\AppData\Local\Programs\Python\Python*

if exist version.txt del version.txt
python --version >> version.txt
if %errorlevel% == 0 (echo [40;36mPY[40;33m est bien lancé  [42;37m[OK]  [40;33m) else (cls & echo [41;37m[ERREUR] [40;33mPython c'est mal éxecuter réinstaler Python ! & set Python=1 & echo [40;35msuprimer le fichier %USERPROFILE%\AppData\Local\Programs\Python\Python*[40;33m ou atender 5 minute est résailler & pause)
if exist version.txt del version.txt
cd %back%

rem verifier ci c'est la première foi qu'il es lancer si oui change l'interface utilisateur

cd %back%temp
if not exist %USERDOMAIN_ROAMINGPROFILE%_instal.ok goto verif-prems-instaltion
cd %back%
if %logAjour% == 1 (echo [42;37mMichros-scripts a jour[40;33m & pause) else (goto mise-a-jour-nesesaire)

rem --------------------------------------------------------------------------------
rem test ci les fichier bat et py sont instaler

pause
:mise-a-jour-nesesaire

rem verife que la derniere version est instaler

cd %USERPROFILE%
if exist version rmdir /S /Q version
git clone https://github.com/00MY00/version.git --progress
if %errorlevel% == 0 (echo [40;33mversion recuperer [42;37m[OK]  [40;33m) else (echo 41;37m[ERREUR] [40;33mversion introuvable & pause & exit)

cd %back%
if exist version.txt (set /p version_1= <version.txt & del /f version.txt) else (set version_1=0)

cd %USERPROFILE%
copy /y %USERPROFILE%\version %back%
if %errorlevel% == 0 (echo [40;33mcopy réusit       [42;37m[OK]  [40;33m) else (echo 41;37m[ERREUR] [40;33mCopy échouée & pause & exit)

cd %back%
if exist version.txt set /p version_2= <version.txt


rem la boucle est infinita partir d'ici
if %version_1% == %version_2% (echo [40;32mDernière version a jour[40;33m & set logAjour=1 & timeout /t 3 nobreak & goto start) else (echo [40;36mC'est partie pour la mise a jour ![40;33m & timeout /T 5 & goto add-scripts)
pause
rem atention si continu entre dans l'instalation scripts






:add-scripts
cd %back%
if exist scripts rmdir /S /Q scripts
if %errorlevel% == 0 (echo [40;33mfichier suprimer   [42;37m[OK]  [40;33m) else (echo [41;37m[ERREUR] [40;33mDossier [40;35mscripts [40;33mn'as pas pu etre suprimer ![42;37m)
mkdir scripts
cd %USERPROFILE%
if not exist scripts git clone https://github.com/00MY00/scripts.git --progress
copy /Y %USERPROFILE%\scripts %back%\scripts\ & if %errorlevel% == 0 (echo [40;33mScripts chargée   [42;37m[OK]  [40;33m) else (echo [41;37m[ERREUR] [40;33mLes [40;35mscripts [40;33mn'ont pas pus etre importer comilfau ! & echo. & echo se trouve dans [40;35m%USERPROFILE%[40;33mn)

cd %USERPROFILE%
rmdir /S /Q scripts
cd %back%

rem pause du prog
pause
goto start














rem --------------------------------------------------



:verif-prems-instaltion
cd %back%\main
set ERREUR=0
if exist bienvenu.bat start bienvenu.bat
cd %back%
if exist t.hta del t.hta

cd %USERPROFILE%

git clone https://github.com/00MY00/interface.git --progress
if %errorlevel% == 1 set ERREUR=1
copy /Y %USERPROFILE%\interface %back%
if %errorlevel% == 1 set ERREUR=1

if %ERREUR% == 1 (echo [41;37m[ERREUR] [40;33mLa creation de la nouvelle interface a échouer & echo [40;31mRéinstaler le programe	[40;33mest verifier que votre système est compatible & echo une fenaitre va s'ouvrir vous permetent de verifier & timeout /t 10 nobreak & goto test-version-compatibl-system) else (echo [40;33mNouvelle interface [42;37m[OK]  [40;33m)

cd %back%

if exist Michros-scripts.hta del Michros-scripts.hta
ren t.hta Michros-scripts.hta
if exist t.hta del t.hta
taskkill /f /im mshta.exe
cd %back%
start Michros-scripts.hta
cd %back%temp
echo ok >> %USERDOMAIN_ROAMINGPROFILE%_instal.ok
cd %back%


goto start


:test-version-compatibl-system
cd %back%\temp
if exist version.txt del version.txt
if exist vers.txt del vers.txt
if exist version-windows.py del version-windows.py
ver >> version.txt

for /F "tokens=4,5" %%i IN (version.txt) DO echo %%i >> vers.txt
set /p version-windows=<vers.txt
set version-windows=%version-windows:~0,-2%

if exist version.txt del version.txt
if exist vers.txt del vers.txt

set ERREUR=0

@echo x = "%version-windows%" >> version-windows.py
if %errorlevel% == 1 set ERREUR=1
@echo x = x.split(".") >> version-windows.py
if %errorlevel% == 1 set ERREUR=1
@echo x = "".join(x) >> version-windows.py
if %errorlevel% == 1 set ERREUR=1
@echo x = int(x) >> version-windows.py
if %errorlevel% == 1 set ERREUR=1
@echo if x ^< 100190421415: >> version-windows.py
if %errorlevel% == 1 set ERREUR=1
@echo 		print("VOTRE version de windows ne suporte pas les script de Michros-scripts") >> version-windows.py
if %errorlevel% == 1 set ERREUR=1
@echo else: >> version-windows.py
if %errorlevel% == 1 set ERREUR=1
@echo 		print("VOTRE système d'éxploitation est bien compatible ^\nl'ERREUR provien d'un autre facteur comme une movaise ^\ninstalation de resourse réinstaler le programe") >> version-windows.py
if %errorlevel% == 1 set ERREUR=1
@echo 		ok = open("version-ok.ok", "w+") >> version-windows.py
if %errorlevel% == 1 set ERREUR=1
@echo input() >> version-windows.py
if %errorlevel% == 1 set ERREUR=1

if %ERREUR% == 1 (echo [41;37m[ERREUR] [40;33mnous ne parvenon pas a verifier la version du système d'éxploitation !) else (cd %USERPROFILE%\AppData\Local\Programs\Python\Python* & start %back%\temp\version-windows.py)
if exist version-windows.py del version-windows.py
cd %back%\temp
if exist version-ok.ok (echo [40;33msystème compatible [42;37m[OK][40;33m & goto start) else (echo [41;37m[ERREUR] [40;33msystème non compatibl & pause & exit)


echo.
goto start










rem instalation de resourse selon bout manquant
rem lansement de l'instalation et atente jusque a détecter

:instal-resource
if exist timeee.txt del timeee.txt
if exist timee.txt del timee.txt


if %python% == 1 echo [40;33mRéinstalation du fichiez manquant [40;33m. & set nom=python*.* & set instal=https://www.python.org/ftp/python/3.9.6/python-3.9.6-amd64.exe

if %Git% == 1 echo [40;33mRéinstalation du fichiez manquant [40;33m. & set nom=Git*.* & set instal=https://github.com/git-for-windows/git/releases/download/v2.34.1.windows.1/Git-2.34.1-32-bit.exe

cd %USERPROFILE%\Downloads


rem si deja instaler saut l'instalation
if exist %nom% goto deja-instaler 

start %instal%

:deja-instaler

echo %nom%

:atente-totale

cls
if exist %USERPROFILE%\AppData\Local\Programs\Python\Python* (echo [40;33mPython est instalé [42;37m[OK] [40;33m) else (echo [41;37m[ERREUR] [40;33mPython est manquant ! [40;37m)

if exist "C:\Program Files (x86)\Git*" (echo [40;33mGit est instalé    [42;37m[OK] [40;33m) else (echo [41;37m[ERREUR] [40;33mGit est manquant ! [40;37m)

if exist timeee.txt del timeee.txt
if exist timee.txt del timee.txt

dir %nom% >> timee.txt
if %errorlevel% == 1 goto atente-totale

for /F "skip=4 tokens=4,6" %%i IN (timee.txt) DO echo %%i >> timeee.txt

set /p fichier-trouver=< timeee.txt
set fichier-trouver=%fichier-trouver:~0,-1%
if %errorlevel% == 0 (echo [40;33moperation réusit   [42;37m[OK] [40;33m) else (echo [41;37m[ERREUR] [40;33mLe fichier est imposible a trouver ! & echo. & echo instalez le programe %nom% manuelement ! & pause & exit)

echo [40;33mFichier trouvé     [42;37m[OK] [40;33m%fichier-trouver%


if exist timeee.txt del timeee.txt
if exist timee.txt del timee.txt

start %fichier-trouver%
if %errorlevel% == 0 (echo operation réusit finaliser & echo l'instalation      [42;37m[OK] [40;33m) else (echo [41;37m[ERREUR] [40;33mLe programe n'as pas bien démarrer & echo. & timeout /t 10)

cd %back%\temp

echo [40;33mEn atente de fin d'instalation [40;32m;[40;33m)

echo %fichier-trouver%


:atente-ouverture-programe
if exist timee.txt del timee.txt
cls
echo [40;33mEn atente d'ouverture de [40;36%fichier-trouver%[40;33m!

if exist %USERPROFILE%\AppData\Local\Programs\Python\Python* (echo [40;33mPython est instalé [42;37m[OK] [40;33m) else (echo [41;37m[ERREUR] [40;33mPython est manquant ! [40;37m)

if exist "C:\Program Files (x86)\Git*" (echo [40;33mGit est instalé    [42;37m[OK] [40;33m) else (echo [41;37m[ERREUR] [40;33mGit est manquant ! [40;37m)

wmic PROCESS WHERE (Description="%fichier-trouver%") get Commandline >> timee.txt
set /p programe-executer= <timee.txt

if exist timee.txt del timee.txt

if %programe-executer% == �� (goto atente-ouverture-programe) else (goto atente-instalation)


rem --------------------------------------------------------------------------------------------

:atente-instalation
if exist timee.txt del timee.txt
cls
echo  [40;33mouvrez [40;32m%fichier-trouver% [40;33met instalé

if exist %USERPROFILE%\AppData\Local\Programs\Python\Python* (echo [40;33mPython est instalé [42;37m[OK] [40;33m) else (echo [41;37m[ERREUR] [40;33mPython est manquant ! [40;37m)

if exist "C:\Program Files (x86)\Git*" (echo [40;33mGit est instalé    [42;37m[OK] [40;33m) else (echo [41;37m[ERREUR] [40;33mGit est manquant ! [40;37m)

wmic PROCESS WHERE (Description="%fichier-trouver%") get Commandline >> timee.txt
set /p programe-executer= <timee.txt
if exist timee.txt del timee.txt

if %python% == 1 if exist %USERPROFILE%\AppData\Local\Programs\Python\Python* cd %USERPROFILE%\AppData\Local\Programs\Python\Python* & python --version & if %errorlevel% == 0 timeout /t 30 /nobreak &  set python=0 & goto start

if %Git% == 1 if exist "C:\Program Files (x86)\Git" git --version & if %errorlevel% == 0 (timeout /t 30 /nobreak & set Git=0 & goto	start) else	(goto extraction-resourc-prog)


if %programe-executer% == �� (echo [41;37m[ERREUR] [40;33mLe programe c'est fermer nous alons réseiller & echo Si le problaime persiste instaler %fichier-trouver% manuelement & echo. & timeout /t 30) else (goto atente-instalation)


goto start

rem END ! 
 








pause
