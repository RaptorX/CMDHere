
locations := ["DesktopBackground\Shell", "Directory\Background\shell", "Directory\shell"]

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
return