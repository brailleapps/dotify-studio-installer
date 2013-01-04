# for font registration
!include FontReg.nsh
!include FontName.nsh
!include WinMessages.nsh

!define /date DATE "%Y-%m-%d"

# define installer name
Name "Easy Embossing Utility"
Caption "Easy Embossing Utility"
outFile "../output/dist/Easy Embossing Utility Windows installer ${DATE}.exe"
 
# set desktop as install directory
InstallDir $PROGRAMFILES\e2u
 
# default section start
section

# define output path
setOutPath $INSTDIR
 
# specify file to go in output path
file "e2u.exe"
file "favicon.ico"
file "odt2braille6.ttf"

setOutPath $INSTDIR\lib
file "..\temp\e2u\lib\brailleUtils-core-1.2b.jar"
file "..\temp\e2u\lib\brailleUtils-catalog-1.2b.jar"
file "..\temp\e2u\lib\ajui-1.0b.jar"
file "..\temp\e2u\lib\isorelax.jar"
file "..\temp\e2u\lib\jing.jar"
file "..\temp\e2u\lib\saxon8.jar"
file "..\temp\e2u\lib\xercesImpl.jar"
file "..\temp\e2u\lib\xml-apis.jar"

setOutPath $INSTDIR\examples
file "..\temp\e2u\examples\butterfly.pef"
file "..\temp\e2u\examples\6-dot-chart.pef"
file "..\temp\e2u\examples\8-dot-chart.pef"

setOutPath $INSTDIR\docs
file "..\temp\e2u\docs\Release notes.txt"
file "..\temp\e2u\docs\Getting started.txt"
file "..\temp\e2u\docs\Known issues.txt"

 # write reg keys
WriteRegStr HKCR ".pef" "" "e2u.PortableEmbosserFormat"
WriteRegStr HKCR "e2u.PortableEmbosserFormat" "" "Portable Embosser Format"
WriteRegStr HKCR "e2u.PortableEmbosserFormat\DefaultIcon" "" "$PROGRAMFILES\e2u\favicon.ico,0"
WriteRegStr HKCR "e2u.PortableEmbosserFormat\shell\open\command" "" "$\"$PROGRAMFILES\e2u\e2u.exe$\" -view $\"%1$\""
WriteRegStr HKCR "e2u.PortableEmbosserFormat\shell\print\command" "" "$\"$PROGRAMFILES\e2u\e2u.exe$\" -emboss $\"%1$\""

# create shortcut
CreateDirectory "$SMPROGRAMS\Easy Embossing Utility"
createShortCut "$SMPROGRAMS\Easy Embossing Utility\Embosser test - Butterfly.lnk" "$INSTDIR\examples\butterfly.pef"
createShortCut "$SMPROGRAMS\Easy Embossing Utility\Embosser test - 6 dot chart.lnk" "$INSTDIR\examples\6-dot-chart.pef"
createShortCut "$SMPROGRAMS\Easy Embossing Utility\Embosser test - 8 dot chart.lnk" "$INSTDIR\examples\8-dot-chart.pef"
createShortCut "$SMPROGRAMS\Easy Embossing Utility\Release notes.lnk" "$INSTDIR\docs\Release notes.txt"
createShortCut "$SMPROGRAMS\Easy Embossing Utility\Getting started.lnk" "$INSTDIR\docs\Getting started.txt"
createShortCut "$SMPROGRAMS\Easy Embossing Utility\Known issues.lnk" "$INSTDIR\docs\Known issues.txt"
createShortCut "$SMPROGRAMS\Easy Embossing Utility\Uninstall.lnk" "$INSTDIR\uninstall.exe"

# install fonts
StrCpy $FONT_DIR $INSTDIR
!insertmacro InstallTTFFont 'odt2braille6.ttf'
SendMessage ${HWND_BROADCAST} ${WM_FONTCHANGE} 0 0 /TIMEOUT=5000


# define uninstaller name
writeUninstaller $INSTDIR\uninstall.exe
 
# default section end
sectionEnd
 
# create a section to define what the uninstaller does.
# the section will always be named "Uninstall"
section "Uninstall"
 
# Always delete uninstaller first
delete $INSTDIR\uninstall.exe

# delete shortcut
delete "$SMPROGRAMS\Easy Embossing Utility\Uninstall.lnk"
delete "$SMPROGRAMS\Easy Embossing Utility\Release notes.lnk"
delete "$SMPROGRAMS\Easy Embossing Utility\Getting started.lnk"
delete "$SMPROGRAMS\Easy Embossing Utility\Known issues.lnk"
delete "$SMPROGRAMS\Easy Embossing Utility\Embosser test - Butterfly.lnk"
delete "$SMPROGRAMS\Easy Embossing Utility\Embosser test - 6 dot chart.lnk"
delete "$SMPROGRAMS\Easy Embossing Utility\Embosser test - 8 dot chart.lnk"
 
# now delete installed file
delete $INSTDIR\e2u.exe
delete $INSTDIR\favicon.ico
delete $INSTDIR\odt2braille6.ttf

delete $INSTDIR\lib\brailleUtils-core-1.2b.jar
delete $INSTDIR\lib\brailleUtils-catalog-1.2b.jar
delete $INSTDIR\lib\ajui-1.0b.jar
delete $INSTDIR\lib\isorelax.jar
delete $INSTDIR\lib\jing.jar
delete $INSTDIR\lib\saxon8.jar
delete $INSTDIR\lib\xercesImpl.jar
delete $INSTDIR\lib\xml-apis.jar
delete "$INSTDIR\docs\Getting started.txt"
delete "$INSTDIR\docs\Known issues.txt"
delete "$INSTDIR\docs\Release notes.txt"
delete $INSTDIR\examples\butterfly.pef
delete $INSTDIR\examples\6-dot-chart.pef
delete $INSTDIR\examples\8-dot-chart.pef


DeleteRegKey HKCR ".pef"
DeleteRegKey HKCR "e2u.PortableEmbosserFormat"
 
sectionEnd