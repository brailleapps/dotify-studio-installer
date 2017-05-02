
# Dotify Studio Installer #
Provides an installer för Dotify Studio, a graphical user interface for embossing PEF-files.

## Building ##
Build an installer on the target platform with the corresponding command.
  
| Platform  | Command                          |
| :---------| :------------------------------- |
| Windows   | `gradlew msi`                |
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