rem Loggen des Abmeldezeitpunkts bei Beenden von Windows
string l_sDate
string l_sDatName
string l_sTime

rem Pfade und Daten initialisieren
set l_sDate=%date%
set l_sDatName=C:\Users\xXx\Documents\Stunden-Logger\Log%l_sDate:~3,9%.txt
set l_sTime=%time:~0,8%

REM Wochentag als Zahl
for /F "skip=2 tokens=2-4 delims=," %%A in ('WMIC Path Win32_LocalTime Get DayOfWeek /Format:csv') do set daynumber=%%A  

REM Wochentag ausgeschrieben
set daysofweek=Montag,Dienstag,Mittwoch,Donnerstag,Freitag,Samstag,Sonntag
for /F "tokens=%daynumber% delims=," %%B in ("%daysofweek%") do set day=%%B

rem Auslesen der bestehenden Events
rem FOR /F "delims=" %%i in (%l_sDatName%) do (
rem echo %%i>>tmp.txt
rem )

rem Auslesen der bestehenden Events
type %l_sDatName%>>tmp.txt

rem Neues Event in 1. Zeile schreiben
echo ---------------------------------------------                >  %l_sDatName%
echo Abmeldung: %day%, %l_sDate%, %l_sTime%                                          >> %l_sDatName%
echo --------------------------------------------- >> %l_sDatName%

rem Alte Events anschließend einfügen
rem FOR /F "delims=" %%i in (tmp.txt) do (
rem echo %%i>>%l_sDatName%
rem )

rem Beschreiben mit alten Events
type tmp.txt>>%l_sDatName%

rem Temporäre Speicherdatei löschen
del tmp.txt

rem shutdown -s -t 10
exit
