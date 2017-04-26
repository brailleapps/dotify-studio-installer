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

${gradle-install-files}

 # write reg keys
WriteRegStr HKCR ".pef" "" "dotify-studio.PortableEmbosserFormat"
WriteRegStr HKCR "dotify-studio.PortableEmbosserFormat" "" "Portable Embosser Format"
WriteRegStr HKCR "dotify-studio.PortableEmbosserFormat\DefaultIcon" "" "$PROGRAMFILES\dotify-studio\favicon.ico,0"
WriteRegStr HKCR "dotify-studio.PortableEmbosserFormat\shell\open\command" "" "$\"$PROGRAMFILES\dotify-studio\dotify-studio.exe$\" -view $\"%1$\""
WriteRegStr HKCR "dotify-studio.PortableEmbosserFormat\shell\print\command" "" "$\"$PROGRAMFILES\dotify-studio\dotify-studio.exe$\" -emboss $\"%1$\""

# create shortcut
CreateDirectory "$SMPROGRAMS\Dotify Studio"
createShortCut "$SMPROGRAMS\Dotify Studio\Dotify Studio.lnk" "$INSTDIR\dotify-studio.exe"
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
delete "$SMPROGRAMS\Dotify Studio\Dotify Studio.lnk"
 
# now delete installed file

${gradle-uninstall-files}

DeleteRegKey HKCR ".pef"
DeleteRegKey HKCR "dotify-studio.PortableEmbosserFormat"
 
sectionEnd