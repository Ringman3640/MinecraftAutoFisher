#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include FindText.ahk

global Text:="|<>*119$71.kzzzzzzzzzzzVzzzzzzzzzzz3zzzzzzzzzzy7zzzzzzzzzzwDzzzzzzzzzzsS0TzU0TzU01kw0zz00zz003Vs1zy01zy0073k3zw03zw00C0TsS7zsS7zzw0zkwDzkwDzzs1zVsTzVsTzzk3z3kzz3kzzzVzy7U007y01z3zwD000Dw03y7zsS000Ts07wDzkw000zk0DsTzVsTzzzzzVkzz3kzzzzzz3Vzy7Vzzzzzy73zwD3zzzzzwC7zsTs00S007wDzkzk00w00DsTzVzU01s00Tkzz3z003k00z"
global TIME_OUT = 35000 ; 35 sec
global CONT_LOOP := false

f1::
CONT_LOOP := true
farmLoop()
return

f2::
CONT_LOOP := false
return

f3::
if (ok:=FindText(X, Y, 1687-150000, 920-150000, 1687+150000, 920+150000, 0, 0, Text)) {
    ToolTip, % "True"
}
else {
    ToolTip, % "False"
}
return

f4::
ExitApp
return

farmLoop() {
    iteration := 0
    timeoutCount := 0

    ; Ensure rod is selected
    Send, 1
    Sleep, 1000

    while (CONT_LOOP) {
        startTime := A_TickCount
        found := false

        if (timeoutCount > 25) {
            ; Shutdown PC if an error state is reached indefinitely
            Shutdown, 1
            ExitApp
        }
        
        if (iteration >= 20) {
            ; Reset rod state
            Send, 2
            Sleep, 1000
            Send, 1
            Sleep, 1000
            iteration := 0
        }

        ; Cast fishing rod
        MouseClick, right
        Sleep, 3000

        while (found == false) {
            ; Check if past time limit
            endTime := A_TickCount
            if (endTime - startTime > TIME_OUT) {
                found == true
                ++timeoutCount
                continue
            }

            ; Check if need to exit func
            if (CONT_LOOP == false) {
                return
            }

            ; Check for caught fish message
            if (ok:=FindText(X, Y, 1687-150000, 920-150000, 1687+150000, 920+150000, 0, 0, Text)) {
                found := true
                timeoutCount := 0
            }

            Sleep, 50
        }

        ; Reel fishing rod
        MouseClick, right
        Sleep, 500

        ++iteration
    }
}
