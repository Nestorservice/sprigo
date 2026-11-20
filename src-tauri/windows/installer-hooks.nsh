; Windows 10/11 do not always have the Visual C++ runtime installed. The app and
; whisper.cpp are built with MSVC, so sprigo.exe needs msvcp140.dll / vcruntime140.dll.
; CI copies the redistributable DLLs into resources/vc-runtime; this hook puts them
; next to the executable, where Windows looks first (no admin, no separate install).
!include LogicLib.nsh

!macro NSIS_HOOK_POSTINSTALL
  ${If} ${FileExists} "$INSTDIR\resources\vc-runtime\msvcp140.dll"
    CopyFiles /SILENT "$INSTDIR\resources\vc-runtime\msvcp140.dll" "$INSTDIR"
  ${EndIf}
  ${If} ${FileExists} "$INSTDIR\resources\vc-runtime\vcruntime140.dll"
    CopyFiles /SILENT "$INSTDIR\resources\vc-runtime\vcruntime140.dll" "$INSTDIR"
  ${EndIf}
  ${If} ${FileExists} "$INSTDIR\resources\vc-runtime\vcruntime140_1.dll"
    CopyFiles /SILENT "$INSTDIR\resources\vc-runtime\vcruntime140_1.dll" "$INSTDIR"
  ${EndIf}
  ${If} ${FileExists} "$INSTDIR\resources\vc-runtime\concrt140.dll"
    CopyFiles /SILENT "$INSTDIR\resources\vc-runtime\concrt140.dll" "$INSTDIR"
  ${EndIf}
!macroend

!macro NSIS_HOOK_PREUNINSTALL
  ; These copies are not tracked by the installer's file list.
  Delete "$INSTDIR\msvcp140.dll"
  Delete "$INSTDIR\vcruntime140.dll"
  Delete "$INSTDIR\vcruntime140_1.dll"
  Delete "$INSTDIR\concrt140.dll"
!macroend
