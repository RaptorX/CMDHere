#SingleInstance force
#Include lib\ScriptObj\scriptobj.ahk

locations := ["DesktopBackground\Shell", "Directory\Background\shell", "Directory\shell"]
global script := {base			: script
				 ,name			: regexreplace(A_ScriptName, "\.\w+")
				 ,version		: "0.1.0"
				 ,author		: "Isaias Baez"
				 ,email			: "graptorx@gmail.com"
				 ,homepagetext	: ""
				 ,homepagelink	: ""
				 ,resfolder		: A_AppData "\" regexreplace(A_ScriptName, "\.\w+") "\res"
				 ,iconfile		: A_AppData "\" regexreplace(A_ScriptName, "\.\w+") "\res\main.ico"
				 ,config 		: A_AppData "\" regexreplace(A_ScriptName, "\.\w+") "\settings.ini"}

RegRead, installed, % "HKCU\Software\Classes\" locations[1] "\cmdHere"

if (installed)
{
	MsgBox, % 0x40 + 0x4, % "Information"
						, % "CMD Here has already been configured.`nDo you want to remove it from your system?"

	IfMsgBox, No
		return

	for i, location in locations
	{
		RegDelete, % "HKCU\Software\Classes\" location "\cmdHere"
		RegDelete, % "HKCU\Software\Classes\" location "\cmdHere"
		RegDelete, % "HKCU\Software\Classes\" location "\cmdHere\command"
	}
}
else
{
	for i, location in locations
	{
		RegWrite, % "REG_SZ", % "HKCU\Software\Classes\" location "\cmdHere",, % "Open CMD Here"
		RegWrite, % "REG_SZ", % "HKCU\Software\Classes\" location "\cmdHere", % "Icon", % "cmd.exe"
		RegWrite, % "REG_SZ", % "HKCU\Software\Classes\" location "\cmdHere\command",, % "cmd.exe /s /k pushd ""%V"""
	}

	MsgBox, % 0x40, % "Installation Finished"
				  , % "CMD Here has been installed"
}
ExitApp, 0