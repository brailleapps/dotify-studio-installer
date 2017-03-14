# for font registration
!include FontReg.nsh
!include FontName.nsh
!include WinMessages.nsh

!define /date DATE "%Y-%m-%d"

# define installer name
Name "Dotify Studio"
Caption "Dotify Studio"
outFile "../output/dist/dotify-studio-installer-${DATE}.exe"
 
# set desktop as install directory
InstallDir $PROGRAMFILES\dotify-studio
 
# default section start
section

# define output path
setOutPath $INSTDIR
# specify file to go in output path
file "..\temp\dotify-studio\dotify-studio.exe"
file "favicon.ico"
file "odt2braille6.ttf"

setOutPath $INSTDIR\lib
file "..\temp\dotify-studio\lib\ajui-1.0.0-SNAPSHOT.jar"
file "..\temp\dotify-studio\lib\braille-utils.api-3.0.1.jar"
file "..\temp\dotify-studio\lib\braille-utils.impl-3.0.0-beta.jar"
file "..\temp\dotify-studio\lib\braille-utils.pef-tools-2.0.0-alpha.jar"
file "..\temp\dotify-studio\lib\dotify-studio-0.1.0-SNAPSHOT.jar"
file "..\temp\dotify-studio\lib\jing-20120724.0.0.jar"
file "..\temp\dotify-studio\lib\saxon-he-9.5.1.5.jar"
file "..\temp\dotify-studio\lib\xml-apis-1.4.01.jar"

setOutPath $INSTDIR\examples
file "..\temp\dotify-studio\examples\butterfly.pef"
file "..\temp\dotify-studio\examples\6-dot-chart.pef"
file "..\temp\dotify-studio\examples\8-dot-chart.pef"

setOutPath $INSTDIR\docs
file "..\temp\dotify-studio\docs\Release notes.txt"
file "..\temp\dotify-studio\docs\Getting started.txt"
file "..\temp\dotify-studio\docs\Known issues.txt"

 # write reg keys
WriteRegStr HKCR ".pef" "" "e2u.PortableEmbosserFormat"
WriteRegStr HKCR "e2u.PortableEmbosserFormat" "" "Portable Embosser Format"
WriteRegStr HKCR "e2u.PortableEmbosserFormat\DefaultIcon" "" "$PROGRAMFILES\dotify-studio\favicon.ico,0"
WriteRegStr HKCR "e2u.PortableEmbosserFormat\shell\open\command" "" "$\"$PROGRAMFILES\dotify-studio\dotify-studio.exe$\" -view $\"%1$\""
WriteRegStr HKCR "e2u.PortableEmbosserFormat\shell\print\command" "" "$\"$PROGRAMFILES\dotify-studio\dotify-studio.exe$\" -emboss $\"%1$\""

# create shortcut
CreateDirectory "$SMPROGRAMS\Dotify Studio"
createShortCut "$SMPROGRAMS\Dotify Studio\Embosser test - Butterfly.lnk" "$INSTDIR\examples\butterfly.pef"
createShortCut "$SMPROGRAMS\Dotify Studio\Embosser test - 6 dot chart.lnk" "$INSTDIR\examples\6-dot-chart.pef"
createShortCut "$SMPROGRAMS\Dotify Studio\Embosser test - 8 dot chart.lnk" "$INSTDIR\examples\8-dot-chart.pef"
createShortCut "$SMPROGRAMS\Dotify Studio\Release notes.lnk" "$INSTDIR\docs\Release notes.txt"
createShortCut "$SMPROGRAMS\Dotify Studio\Getting started.lnk" "$INSTDIR\docs\Getting started.txt"
createShortCut "$SMPROGRAMS\Dotify Studio\Known issues.lnk" "$INSTDIR\docs\Known issues.txt"
createShortCut "$SMPROGRAMS\Dotify Studio\Uninstall.lnk" "$INSTDIR\uninstall.exe"

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
delete "$SMPROGRAMS\Dotify Studio\Uninstall.lnk"
delete "$SMPROGRAMS\Dotify Studio\Release notes.lnk"
delete "$SMPROGRAMS\Dotify Studio\Getting started.lnk"
delete "$SMPROGRAMS\Dotify Studio\Known issues.lnk"
delete "$SMPROGRAMS\Dotify Studio\Embosser test - Butterfly.lnk"
delete "$SMPROGRAMS\Dotify Studio\Embosser test - 6 dot chart.lnk"
delete "$SMPROGRAMS\Dotify Studio\Embosser test - 8 dot chart.lnk"
 
# now delete installed file
delete $INSTDIR\favicon.ico
delete $INSTDIR\odt2braille6.ttf
delete $INSTDIR\dotify-studio.exe

delete $INSTDIR\lib\ajui-1.0.0-SNAPSHOT.jar
delete $INSTDIR\lib\braille-utils.api-3.0.1.jar
delete $INSTDIR\lib\braille-utils.impl-3.0.0-beta.jar
delete $INSTDIR\lib\braille-utils.pef-tools-2.0.0-alpha.jar
delete $INSTDIR\lib\dotify-studio-0.1.0-SNAPSHOT.jar
delete $INSTDIR\lib\jing-20120724.0.0.jar
delete $INSTDIR\lib\saxon-he-9.5.1.5.jar
delete $INSTDIR\lib\xml-apis-1.4.01.jar

delete "$INSTDIR\docs\Getting started.txt"
delete "$INSTDIR\docs\Known issues.txt"
delete "$INSTDIR\docs\Release notes.txt"

delete $INSTDIR\examples\butterfly.pef
delete $INSTDIR\examples\6-dot-chart.pef
delete $INSTDIR\examples\8-dot-chart.pef


DeleteRegKey HKCR ".pef"
DeleteRegKey HKCR "e2u.PortableEmbosserFormat"
 
sectionEnd