loop, 8
menu, ch, add,% "canal " A_Index, channels

class Categories {
	__new(category:="", xCoord:="", yCoord:="", status:="") {
		this.category := category
		this.xCoord := xCoord
		this.yCoord := yCoord
		this.status := status
		}

	click() {
		coordMode, mouse, window
		click,% this.xCoord "," this.yCoord
	}

	check() {
		if (this.status = "no marcado") {
			this.status := "marcado"
			this.speak()
			}
		else {
			this.status := "no marcado"
			this.speak()
			}
		}

	Woodwinds() {
		click, 190, 665, 0
		sleep 50
		click, wheelDown
		click, wheelDown
		click
		sleep 50
		click, wheelUp
		click, wheelUp
		}
		
	speak() {
		Process, Exist, jfw.exe
		If ErrorLevel != 0
			{
			Jaws := ComObjCreate("FreedomSci.JawsApi")
			Jaws.SayString(this.category ", " this.status)
			}
		Else {
			return DllCall("files\nvdaControllerClient" A_PtrSize*8 ".dll\nvdaController_speakText", "wstr", this.category ", " this.status)
			}
		}
	}

soundPlay, files/start.mp3
sleep 750
speech := new Categories("Script iniciado", "", "", "")
speech.speak()

comandos := ["Shift aplicaciones; despliega el menú contextual para seleccionar el canal"
,"shift retroceso; vuelve a la ventana principal"
,"shift flecha abajo; enfoca la siguiente categoría"
,"shift flecha arriba; enfoca la anterior categoría"
,"shift intro; activa o desactiva la categoría con el foco"
,"flecha abajo flecha derecha; activa el siguiente preset"
,"flecha arriba flecha derecha; activa el anterior preset"
,"shift q; cierra el script"]

cl := array()
cl[1] := new Categories("Arpeggio", 199, 103, "no marcado")
cl[2] := new Categories("Bass", 301, 136, "no marcado")
cl[3] := new Categories("Brass", 298, 166, "no marcado",  "no marcado")
cl[4] := new Categories("Chromatic", 301, 193, "no marcado")
cl[5] := new Categories("Drums", 295, 224, "no marcado")
cl[6] := new Categories("Ethnic", 296, 248, "no marcado")
cl[7] := new Categories("Guitar", 293, 278, "no marcado")
cl[8] := new Categories("Loops", 293, 302, "no marcado")
cl[9] := new Categories("Organ", 290, 338, "no marcado")
cl[10] := new Categories("Percussions", 296, 367, "no marcado")
cl[11] := new Categories("Piano", 293, 397, "no marcado")
cl[12] := new Categories("Sound FX", 293, 424, "no marcado")
cl[13] := new Categories("Strings", 293, 452, "no marcado")
cl[14] := new Categories("Synth Bass", 295, 488, "no marcado")
cl[15] := new Categories("Synth FX", 296, 511, "no marcado")
cl[16] := new Categories("Synth Lead", 293, 542, "no marcado")
cl[17] := new Categories("Synth Pad", 287, 571, "no marcado")
cl[18] := new Categories("Synth Pluck", 293, 598, "no marcado")
cl[19] := new Categories("Synth Sweep", 292, 626, "no marcado")
cl[20] := new Categories("Voices", 290, 659, "no marcado")
cl[21] := new Categories("Woodwinds", "", "", "no marcado")

w:=False
x=0
y=0

#ifWinActive, SampleTank 4
+down::
if (w = True) {
x++
if x <= 21
{
cl[x].speak()
}
else {
x=1
cl[x].speak()
}
}
return

+up::
if (w = True) {
x--
if x >= 1
{
cl[x].speak()
}
else {
x=21
cl[x].speak()
}
}
return

+enter::
soundPlay, files/click.mp3
if (x = 21) {
cl[x].Woodwinds()
cl[x].check()
}
else {
cl[x].click()
cl[x].check()
}
return

+AppsKey::
if (w = False)
menu, ch, show
else {
speech := new Categories("Solo disponible desde la ventana principal", "", "", "")
speech.speak()
}
return

+BackSpace::
if (w = True) {
w := False
Click,1180,119
speech := new Categories("Ventana principal", "", "", "")
speech.speak()
}
return

#if
+q::
speech := new Categories("Script finalizado", "", "", "")
speech.speak()
sleep 1000
exitApp

+f1::
y++
if y <= % comandos.maxIndex()
	{
	speech := new Categories(comandos[y], "", "", "")
	speech.speak()
	}
else {
	y=1
	speech := new Categories(comandos[y], "", "", "")
	speech.speak()
	}
	return

f1::
speech := new Categories("Pulsa shift f1 para ir conmutando entre la verbalización de los distintos comandos del script", "", "", "")
speech.speak()
return

channels(ItemName, ItemPos, MenuName) {
	yCoords := [136,205,278,352,425,500,571,650]
	yCoord := yCoords[ItemPos]
	sleep 50
	click, 240, %yCoord%
	global w := True
	}

coordMode, mouse, client
#If WinActive("SampleTank 4 Sound Content")
+s::
	Click, Left, 565, 425
sleep 50
speech := new Categories("Siguiente", "", "", "")
	speech.speak()
	Return

+b::
	Click, Left, 552, 193, 2
sleep 50
speech := new Categories("Browce", "", "", "")
	speech.speak()
Return