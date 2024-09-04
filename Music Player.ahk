#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance, force

SetBatchLines, -1
Gui, Color, Aqua
Gui, Font, q5
Gui, Font, s8
Gui, Add, Button, x5 y5 gImport, Import Music
Gui, Add, Button, x83 y5 gFindFile, Find Current Song
Gui, Add, Button, x185 y5 gShowLoaded, Loaded Songs
Gui, Font, s15 Bold Underline
Gui, Add, Text, y35 x5 w270 +Center, Now Playing:
Gui, Font, s12 Norm
Gui, Add, Edit, w260 +ReadOnly +Center vNowPlaying, %NowPlaying%
Gui, Add, Progress, w260 h10 cRed Range0-1000000 vSongProgress, 0
Gui, Font, s10 Norm
Gui, Add, Button, x5 y115 w45 gPlay vPlay, Play
Gui, Add, Checkbox, x52 y121 w60 gShuffle vShuffleChecked, Shuffle
Gui, Add, Button, x112 y115 w45 gSkip vSkip, Skip
Gui, Add, Button, x220 y115 w45 gStop vStop, Stop
Gui, Show, w270, Lazuli's Music Player v1.0

SongList := []

Return


GuiClose:
	ExitApp
	Return


Import:
	Select := 0
	GuiControl,, Shuffle, 0
	if (!MusicLocation)
		MusicLocation := A_Desktop
	Gui, Import:New
	Gui, Color, Aqua
	Gui, Font, s18 Bold Underline
	Gui, Add, Text, x0 y10 w370 +Center, Import Music
	Gui, Font, s8 Norm
	Gui, Add, Edit, x5 y55 h20 w300 +Left vMusicLocation , %MusicLocation%
	Gui, Add, Button, x+1 y54 h22 w60 gLocate, Locate...
	Gui, Font, s10 Norm
	Gui, Add, Checkbox, x5 y80 vRecurseLower, Search for files in subfolders?
	GuiControl,, RecurseLower, 1
	Gui, Font, s12 Bold
	Gui, Add, Text, x5 y110, Select File Types:
	Gui, Font, s10 Norm
	Gui, Add, Checkbox, x5 y135 vwav, .wav
	Gui, Add, Checkbox, x5 y155 vmp3, .mp3
	Gui, Add, Checkbox, x5 y175 vaif, .aif
	Gui, Font, Bold
	Gui, Add, Checkbox, x5 y195 gSelectAll, Select all file types
	Gui, Font, Bold s15
	Gui, Add, Button, x5 y215 h50 w360 gConfirm vConfirm, Confirm
	Gui, Show, w370 h270, Import Music
	Return


Locate:
	FileSelectFolder, MusicLocation, *, 0, Select the folder that the music you would like to import is stored in.
	GuiControl, Import:, MusicLocation, %MusicLocation%
	Return


FindFile:
	MsgBox % CurrentElement
	Return


ShowLoaded:
	Gui, Loaded:New
	Gui, Color, Aqua
	Gui, Font, s18 Bold Underline
	Gui, Add, Text, x0 y10 w330 +Center, Loaded Songs
	Gui, Font, s8 Norm
	SongNumber := 0
	Gui, Add, Edit, x0 y55 h20 w27 +Right +ReadOnly vSongNumber1, % %SongNumber% + 1 . ")"
	Gui, Add, Edit, x27 y55 h20 w300 +Left +ReadOnly vSong1 , %Song1%
	Gui, Add, Edit, x0 y80 h20 w27 +Right +ReadOnly vSongNumber2, % %SongNumber% + 2 . ")"
	Gui, Add, Edit, x27 y80 h20 w300 +Left +ReadOnly vSong2 , %Song2%
	Gui, Add, Edit, x0 y105 h20 w27 +Right +ReadOnly vSongNumber3, % %SongNumber% + 3 . ")"
	Gui, Add, Edit, x27 y105 h20 w300 +Left +ReadOnly vSong3 , %Song3%
	Gui, Add, Edit, x0 y130 h20 w27 +Right +ReadOnly vSongNumber4, % %SongNumber% + 4 . ")"
	Gui, Add, Edit, x27 y130 h20 w300 +Left +ReadOnly vSong4 , %Song4%
	Gui, Add, Edit, x0 y155 h20 w27 +Right +ReadOnly vSongNumber5, % %SongNumber% + 5 . ")"
	Gui, Add, Edit, x27 y155 h20 w300 +Left +ReadOnly vSong5 , %Song5%
	Gui, Add, Edit, x0 y180 h20 w27 +Right +ReadOnly vSongNumber6, % %SongNumber% + 6 . ")"
	Gui, Add, Edit, x27 y180 h20 w300 +Left +ReadOnly vSong6 , %Song6%
	Gui, Add, Edit, x0 y205 h20 w27 +Right +ReadOnly vSongNumber7, % %SongNumber% + 7 . ")"
	Gui, Add, Edit, x27 y205 h20 w300 +Left +ReadOnly vSong7 , %Song7%
	Gui, Add, Edit, x0 y230 h20 w27 +Right +ReadOnly vSongNumber8, % %SongNumber% + 8 . ")"
	Gui, Add, Edit, x27 y230 h20 w300 +Left +ReadOnly vSong8 , %Song8%
	Gui, Add, Edit, x0 y255 h20 w27 +Right +ReadOnly vSongNumber9, % %SongNumber% + 9 . ")"
	Gui, Add, Edit, x27 y255 h20 w300 +Left +ReadOnly vSong9 , %Song9%
	Gui, Add, Edit, x0 y280 h20 w27 +Right +ReadOnly vSongNumber10, % %SongNumber% + 10 . ")"
	Gui, Add, Edit, x27 y280 h20 w300 +Left +ReadOnly vSong10 , %Song10%
	Gui, Font, s12
	Gui, Add, Button, x10 y305 h40 gPrevious vPrevious, Prev.
	GuiControl, Disable, Previous
	Gui, Add, Button, x274 y305 h40 gNext vNext, Next
	
	Page := 0
	
	if (ShuffleChecked = 1){
		LoadSongs(ShuffledSongs, SongNumber)
	} else{
		LoadSongs(SongList, SongNumber)
	}
	Gui, Show, w330 h355, Loaded Songs
	Return


SelectAll:
	Select := !Select
	GuiControl, Import:, wav, %Select%
	GuiControl, Import:, mp3, %Select%
	GuiControl, Import:, aif, %Select%
	Return


Confirm:
	GuiControl, Disable, Confirm
	Gui, Submit, NoHide
	SongList := object()
	ShuffledSongs := object()
	if (RecurseLower = 1){
		if (wav = 1){
			Loop, Files, %MusicLocation%\*.wav, R
				SongList.Push(A_LoopFilePath)
		} if (mp3 = 1){
			Loop, Files, %MusicLocation%\*.mp3, R
				SongList.Push(A_LoopFilePath)
		} if (aif = 1){
			Loop, Files, %MusicLocation%\*.aif, R
				SongList.Push(A_LoopFilePath)
		}
	} else{
		if (wav = 1){
			Loop, Files, %MusicLocation%\*.wav, F
				SongList.Push(A_LoopFilePath)
		} if (mp3 = 1){
			Loop, Files, %MusicLocation%\*.mp3, F
				SongList.Push(A_LoopFilePath)
		} if (aif = 1){
			Loop, Files, %MusicLocation%\*.aif, F
				SongList.Push(A_LoopFilePath)
		}
	}
	
	for index, element in SongList
		ShuffledSongs.Push(element)
	
	GuiControl, Enable, Confirm
	Gui, Submit
	Return


Play:
	GuiControl, Disable, Shuffle
	GuiControl, Enable, Skip
	Loop{
		if (ShuffleChecked = 1){
			for index, element in ShuffledSongs{
				if (stop = 1){
					stop := 0
					Return
				}
				CurrentElement := element
				SubStrStartingPos := InStr(element, "\", false, 0, 1)
				NowPlaying := SubStr(element, SubStrStartingPos + 1)
				GuiControl,, NowPlaying, %NowPlaying%
				SetTimer, RunTimer, -1
				SoundPlay, %element%, Wait
			}
		} else{
			for index, element in SongList{
				if (stop = 1){
					stop := 0
					Return
				}
				CurrentElement := element
				SubStrStartingPos := InStr(element, "\", false, 0, 1)
				NowPlaying := SubStr(element, SubStrStartingPos + 1)
				GuiControl,, NowPlaying, %NowPlaying%
				SetTimer, RunTimer, -1
				SoundPlay, %element%, Wait
			}
		}
	}
	Return


Shuffle:
	Gui, Submit, NoHide
	if (ShuffleChecked = 1){
	ShuffleMusic(ShuffledSongs)
	}
	Return


Skip:
	SoundPlay, "urw9thgsegjfbns0e95u9y84.wav"
	skipTimer := 1
	SongProgress := 0
	GuiControl,, SongProgress, 0
	GuiControl, Disable, Skip
	Return


Loop:
	Gui, Submit, NoHide
	Return


Stop:
	stop := 1
	stopTimer := 1
	SongProgress := 0
	SoundPlay, "urw9thgsegjfbns0e95u9y84.wav"
	GuiControl,, NowPlaying,
	GuiControl,, SongProgress, 0
	GuiControl, Disable, Skip
	GuiControl, Enable, Shuffle
	Return


Previous:
	Page--
	if (Page = 0)
		GuiControl, Disable, Previous
	if (Page = 98)
		GuiControl, Enable, Next
	
	SongNumber := Page * 10
	GuiControl, Loaded:, SongNumber1, % (SongNumber + 1) . ")"
	GuiControl, Loaded:, SongNumber2, % (SongNumber + 2) . ")"
	GuiControl, Loaded:, SongNumber3, % (SongNumber + 3) . ")"
	GuiControl, Loaded:, SongNumber4, % (SongNumber + 4) . ")"
	GuiControl, Loaded:, SongNumber5, % (SongNumber + 5) . ")"
	GuiControl, Loaded:, SongNumber6, % (SongNumber + 6) . ")"
	GuiControl, Loaded:, SongNumber7, % (SongNumber + 7) . ")"
	GuiControl, Loaded:, SongNumber8, % (SongNumber + 8) . ")"
	GuiControl, Loaded:, SongNumber9, % (SongNumber + 9) . ")"
	GuiControl, Loaded:, SongNumber10, % (SongNumber + 10) . ")"
	
	if (ShuffleChecked = 1){
		LoadSongs(ShuffledSongs, SongNumber)
	} else{
		LoadSongs(SongList, SongNumber)
	}
	
	Return


Next:
	Page++
	if (Page = 1)
		GuiControl, Enable, Previous
	if (Page = 99)
		GuiControl, Disable, Next
	
	SongNumber := Page * 10
	GuiControl, Loaded:, SongNumber1, % (SongNumber + 1) . ")"
	GuiControl, Loaded:, SongNumber2, % (SongNumber + 2) . ")"
	GuiControl, Loaded:, SongNumber3, % (SongNumber + 3) . ")"
	GuiControl, Loaded:, SongNumber4, % (SongNumber + 4) . ")"
	GuiControl, Loaded:, SongNumber5, % (SongNumber + 5) . ")"
	GuiControl, Loaded:, SongNumber6, % (SongNumber + 6) . ")"
	GuiControl, Loaded:, SongNumber7, % (SongNumber + 7) . ")"
	GuiControl, Loaded:, SongNumber8, % (SongNumber + 8) . ")"
	GuiControl, Loaded:, SongNumber9, % (SongNumber + 9) . ")"
	GuiControl, Loaded:, SongNumber10, % (SongNumber + 10) . ")"
	
	if (ShuffleChecked = 1){
		LoadSongs(ShuffledSongs, SongNumber)
	} else{
		LoadSongs(SongList, SongNumber)
	}
	
	Return
	

RunTimer:
	ThousandthsOfSecond := 0
	SongProgress := 0
	Iteration := 0
	Seconds := 0
	ThousandthsOfSecond := GetAudioDuration(CurrentElement)
	Seconds := Floor(ThousandthsOfSecond/1000)
	Iteration := Floor(1000000000/ThousandthsOfSecond)
	GuiControl,, SongProgress, 0
	Seconds--
	SetTimer, EnableSkip, -200
	Loop, %Seconds%
	{
		if (stopTimer = 1 || skipTimer = 1){
			stopTimer := 0
			skipTimer := 0
			SongProgress := 0
			Return
		}
		SongProgress += Iteration
		GuiControl,, SongProgress, %SongProgress%
		Sleep 1000
	}
	GuiControl,, SongProgress, 1000000
	Return


EnableSkip:
	GuiControl, Enable, Skip
	Return


GetAudioDuration(mFile) {
	VarSetCapacity( DN,16 ), DLLFunc := "winmm.dll\mciSendString" ( A_IsUnicode ? "W" : "A" )
	DllCall( DLLFunc, Str,"open " """" mFile """" " Alias MP3", UInt,0, UInt,0, UInt,0 )
	DllCall( DLLFunc, Str,"status MP3 length", Str,DN, UInt,16, UInt,0 )
	DllCall( DLLFunc, Str,"close MP3", UInt,0, UInt,0, UInt,0 )
	Return DN
}


LoadSongs(ListToLoad, SongNumber){
	Song1 := ListToLoad[SongNumber + 1]
	SubStrStartingPos := InStr(Song1, "\", false, 0, 1)
	Song1 := SubStr(Song1, SubStrStartingPos + 1)
	GuiControl, Loaded:, Song1, %Song1%
	
	Song2 := ListToLoad[SongNumber + 2]
	SubStrStartingPos := InStr(Song2, "\", false, 0, 1)
	Song2 := SubStr(Song2, SubStrStartingPos + 1)
	GuiControl, Loaded:, Song2, %Song2%
	
	Song3 := ListToLoad[SongNumber + 3]
	SubStrStartingPos := InStr(Song3, "\", false, 0, 1)
	Song3 := SubStr(Song3, SubStrStartingPos + 1)
	GuiControl, Loaded:, Song3, %Song3%
	
	Song4 := ListToLoad[SongNumber + 4]
	SubStrStartingPos := InStr(Song4, "\", false, 0, 1)
	Song4 := SubStr(Song4, SubStrStartingPos + 1)
	GuiControl, Loaded:, Song4, %Song4%
	
	Song5 := ListToLoad[SongNumber + 5]
	SubStrStartingPos := InStr(Song5, "\", false, 0, 1)
	Song5 := SubStr(Song5, SubStrStartingPos + 1)
	GuiControl, Loaded:, Song5, %Song5%
	
	Song6 := ListToLoad[SongNumber + 6]
	SubStrStartingPos := InStr(Song6, "\", false, 0, 1)
	Song6 := SubStr(Song6, SubStrStartingPos + 1)
	GuiControl, Loaded:, Song6, %Song6%
	
	Song7 := ListToLoad[SongNumber + 7]
	SubStrStartingPos := InStr(Song7, "\", false, 0, 1)
	Song7 := SubStr(Song7, SubStrStartingPos + 1)
	GuiControl, Loaded:, Song7, %Song7%
	
	Song8 := ListToLoad[SongNumber + 8]
	SubStrStartingPos := InStr(Song8, "\", false, 0, 1)
	Song8 := SubStr(Song8, SubStrStartingPos + 1)
	GuiControl, Loaded:, Song8, %Song8%
	
	Song9 := ListToLoad[SongNumber + 9]
	SubStrStartingPos := InStr(Song9, "\", false, 0, 1)
	Song9 := SubStr(Song9, SubStrStartingPos + 1)
	GuiControl, Loaded:, Song9, %Song9%
	
	Song10 := ListToLoad[SongNumber + 10]
	SubStrStartingPos := InStr(Song10, "\", false, 0, 1)
	Song10 := SubStr(Song10, SubStrStartingPos + 1)
	GuiControl, Loaded:, Song10, %Song10%
}


ShuffleMusic(arr) {
	; Skip simple cases
	If (arr.Length() <= 1)
		Return
	
	If (arr.Length() == 2) {
		Random, swap, 0, 1
		If (swap == 1)
			SwapInArray(arr, 1, 2)
		Return
	}
	
	Loop 10 {  ; Iterations
		Loop % arr.Length() {
			; Choose 2 random indices
			Random, indexA, 1, % arr.Length()
			Random, indexB, 1, % arr.Length()-1
			
			; Make sure they aren't equal and evenly distributed
			indexB += (indexB >= indexA)
			
			; Swap elements
			SwapInArray(arr, indexA, indexB)
		}
	}
}


SwapInArray(arr, indexA, indexB) {
	temp := arr[indexA]
	arr[indexA] := arr[indexB]
	arr[indexB] := temp
}


JoinArray(arr) {
	msg := ""
	
	Loop % arr.Length() {
		msg .= arr[A_Index] ", "
	}
	
	Return SubStr(msg, 1, -2)
}