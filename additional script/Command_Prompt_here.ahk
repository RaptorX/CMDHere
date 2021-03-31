/*
	Unlike CMD here tool, this script doesnt modify the registry(CtrlHwnd,GuiEvent,EventInfo,ErrLevel:="")
	It gets your active explorer window and opens it in the command prompt.
*/
#SingleInstance,force
SetBatchLines,-1
#NoEnv
path:=GetPath()
Run, cmd /k cd /d "%path%"


;***********Get path of active window from Explorer******************* 
GetPath(hwnd=""){
	if !(window := GetWindow(hwnd))
		return ErrorLevel := "ERROR"
	if (window="desktop") ;If path is desktop 
		return A_Desktop ;use AutoHotkey desktop variable
	 path := StrReplace(StrReplace(RegExReplace(window.LocationURL, "ftp://.*@","ftp://"),"file:///"),"/","\")
	  
	Loop ; thanks to polyethene
		If RegExMatch(path, "i)(?<=%)[\da-f]{1,2}", hex)
			StringReplace, path, path, `%%hex%, % Chr("0x" . hex), All
		Else Break
	return path
}

;***********Get the active windows******************* 
GetWindow(hwnd=""){   ; thanks to jethrow for some pointers here
	 WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")
	 WinGetClass class, ahk_id %hwnd%
	if (process!="explorer.exe") ;Stop if not explorer
		return
	if (class ~= "(Cabinet|Explore)WClass"){
		for window in ComObjCreate("Shell.Application").Windows
			if (window.hwnd==hwnd)
				return window
	} else if (class ~= "Progman|WorkerW")
		return "desktop" ; desktop found
}
;*Borrowed heavily from Joshua A. Kinnison 