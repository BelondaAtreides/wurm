#include <Misc.au3>
#include <ImageSearch.au3>

HotKeySet("{PAUSE}", "TogglePause")
HotKeySet("{z}", "Start")
HotKeySet("{ESC}", "_Exit")
HotKeySet("{x}", "SetLockLocation")
HotKeySet("{c}", "lowerright")
HotKeySet("{v}", "randomitem")
HotKeySet("{b}", "settimer")

global $Paused
global $running = 0
global $randomspot = 0
global $ulsearch = 0
global $lrsearch = 0
global $setlockLoc = 0
global $lowerrightvar = 0
global $x1
global $y1
global $xx
global $yy
global $randombs
global $timerr = 0
global $length
global $lengthms = 30000

Func _Exit()
	Exit
EndFunc   ;==>_Exit

Func TogglePause()
	$Paused = NOT $Paused
	While $Paused
		sleep(100)
		ToolTip('Script is "Paused"',0,0)
	WEnd
	ToolTip("")
EndFunc

Func settimer()
	$timerr = 1
EndFunc

Func SetLockLocation()
	MsgBox(0, "", "upper left")
	$setlockLoc = 1
EndFunc

Func lowerright()
	MsgBox(0, "", "lowerright")
	$lowerrightvar = 1
EndFunc
	
Func randomitem()
	MsgBox(0, "", "click on a random item to move the blue bullshit")
	$randombs = 1
EndFunc

Func checktimer()
	Local $time = TimerDiff($timer)
		if $time > $lengthms Then
			Exit
		EndIf
EndFunc

Func Needle()
	MouseMove($x1, $y1, 20)
	MouseClick("left")
	sleep(50)
	Send("{1}")
	Sleep(75)
	Send("{i}")
	sleep(100)
	mousemove($randomspot[0],$randomspot[1],2)
	sleep(25)
	mouseclick("left")
	sleep(Random(15000, 16000))
EndFunc

Func Scissors()
	MouseMove($x1, $y1, 20)
	MouseClick("left")
	sleep(50)
	Send("{2}")
	Sleep(75)
	Send("{i}")
	sleep(100)
	mousemove($randomspot[0],$randomspot[1],2)
	sleep(25)
	mouseclick("left")
	sleep(Random(15000, 16000))
EndFunc

Func Water()
	MouseMove($x1, $y1, 20)
	MouseClick("left")
	sleep(50)
	Send("{3}")
	Sleep(75)
	Send("{i}")
	sleep(100)
	mousemove($randomspot[0],$randomspot[1],2)
	sleep(25)
	mouseclick("left")
	sleep(Random(15000, 16000))
EndFunc

Func Cloth()
	MouseMove($x1, $y1, 20)
	MouseClick("left")
	sleep(50)
	Send("{4}")
	Sleep(75)
	Send("{i}")
	sleep(100)
	mousemove($randomspot[0],$randomspot[1],2)
	sleep(25)
	mouseclick("left")
	sleep(Random(15000, 16000))
EndFunc

Func Repair()
	local $repair = 1
	$repair = _ImageSearchArea("image/repair.png",1,$x1-200,$y1-15,$x1,$y1+15,$xx,$yy,50)
	If $repair = 0 Then
		MouseMove($x1, $y1, 20)
		sleep(50)
		MouseClick("left")
		sleep(50)
		Send("{r}")
		sleep(75)
		mousemove($randomspot[0],$randomspot[1],2)
		sleep(25)
		mouseclick("left")
		sleep(4000)
	EndIf
EndFunc

Func Start()
	if $running == 0 Then
		$running = 1
		TrayTip("", "Macro started", 5)
	ElseIf $running == 1 Then
		$running = 0
		TrayTip("", "Macro stopped", 5)
	EndIf
EndFunc

While (1)
	
	if _IsPressed("01") And $setlockLoc == 1 Then
		$ulsearch = MouseGetPos()
		$setlockLoc = 0
		Beep(1400, 500)
	EndIf
	
	if $timerr == 1 Then
		$length = InputBox("HOW LONG TO RUN", "How many minutes to run? *TOOLBELT ORDER*, 1=Needle, 2=Scissors, 3=Water, 4=Cloth *BIND* I Improve/Finish and R repair *Z Starts*", 30)
		$lengthms = $length * 60 * 1000
		global $timer = TimerInit()	
			$timerr = 0
	EndIf
	
	if _IsPressed("01") And $lowerrightvar == 1 Then
		$lrsearch = MouseGetPos()
		$lowerrightvar = 0
		Beep(1400, 500)
	EndIf
	
	if _IsPressed("01") And $randombs == 1 Then
		$randomspot = MouseGetPos()
		$randombs = 0
		Beep(1400, 500)
	EndIf
	
	if $running == 1 Then
		
		Local $needle = 1
		While $needle = 1
			$needle = _ImageSearchArea("image/needle.png",1,$ulsearch[0],$ulsearch[1],$lrsearch[0],$lrsearch[1],$x1,$y1,50)
			If $needle = 1 Then
				Needle()
				Repair()
				checktimer()
			EndIf
		WEnd
		
		Local $scissors = 1
		While $scissors = 1
			$scissors = _ImageSearchArea("image/scissors.png",1,$ulsearch[0],$ulsearch[1],$lrsearch[0],$lrsearch[1],$x1,$y1,50)
			If $scissors = 1 Then
				Scissors()
				Repair()
				checktimer()
			EndIf
		WEnd
		
		Local $water = 1
		While $water = 1
			$water = _ImageSearchArea("image/water.png",1,$ulsearch[0],$ulsearch[1],$lrsearch[0],$lrsearch[1],$x1,$y1,50)
			If $water = 1 Then
				Water()
				Repair()
				checktimer()
			EndIf
		WEnd
		
		Local $cloth = 1
		While $cloth = 1
			$cloth = _ImageSearchArea("image/cloth.png",1,$ulsearch[0],$ulsearch[1],$lrsearch[0],$lrsearch[1],$x1,$y1,50)
			If $cloth = 1 Then
				Cloth()
				Repair()
				checktimer()
			EndIf
		WEnd
	
	EndIf

	Sleep(10)
WEnd