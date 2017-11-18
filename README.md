[![Build Status](https://travis-ci.org/brailleapps/dotify-studio-installer.svg?branch=master)](https://travis-ci.org/brailleapps/dotify-studio-installer)

# Dotify Studio Installer #
Provides an installer för Dotify Studio, a graphical user interface for creating, managing and embossing PEF-files.

## Building ##
Build an installer on the target platform with the corresponding command.
  
| Platform  | Command                          |
| :---------| :------------------------------- |
| Windows  (x64) | `gradlew msi`                |
| Windows (x86)   | `gradlew msi32`                |
| Linux     | `./gradlew rpm`              |
| Linux     | `./gradlew deb`              |
| maOS     | `./gradlew dmg`               |

## Requirements & Compatibility ##
Requires Java 8

| Platform  | Requirement                                                          |
| :---------| :------------------------------------------------------------------- |
| Windows   | Wix Toolset or WixEdit must be installed                             |
| Linux     | Lintian, FakeRoot <br> on Ubuntu: `apt-get install lintian fakeroot` |
| Linux     | rpm for creating RPM packages: `apt-get install rpm`              |