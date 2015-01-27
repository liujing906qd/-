[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=bc59b554-3b24-410c-b764-e49ae8bb86b3
Description=舰娘
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
/*****************************初始化变量*****************************/
//资源文件夹路径
Dim resourceFolder
resourceFolder = "C:\Users\LiuJing\Pictures\"

//鼠标点击坐标
Dim X, Y

//出击
Dim AttackMap, AttactMisstion
//演习
Dim exercisesMap, exercisesMisstion
//远征
Dim ExpeditionMap, ExpeditionMisstion
ExpeditionMapIndex = 0
ExpeditionMisstionIndex = 0

//远征相关常量
Dim ExpeditionFirstMapPositionX, ExpeditionFirstMapPositionY, ExpeditionFirstMapPositionOffset
ExpeditionFirstMapPositionX = 135
ExpeditionFirstMapPositionY = 450
ExpeditionFirstMapPositionOffset = 55

Dim ExpeditionFirstMisstionPositionX, ExpeditionFirstMisstionPositionY, ExpeditionFirstMisstionPositionOffset
ExpeditionMisstionPositionX = 160
ExpeditionMisstionPositionY = 170
ExpeditionFirstMisstionPositionOffset = 30

//补给
CheckBoxAll
X = 150
Y = 120
/****************************初始化****************************/
Call GetHwndForGame()
/*****************************远征*****************************/
//Call GoToMuGang()
//Call LJFindPicAndClickUntilFound("母港_出击")
//Call LJFindPicAndClickUntilFound("出击_主界面_远征")
//Call SelectExpeditionMap()
/*****************************维护*****************************/
Call GoToMuGang()
Call LJFindPicAndClickUntilFound("母港_补给")

/*****************************函数*****************************/

Function GetHwndForGame()
    Dim HwndTidu,HwndEmbedding,HwndDocObject
    HwndTidu = Plugin.Window.Find(0, "提督業も忙しい！")
    HwndEmbedding = Plugin.Window.FindEx(hwndTidu, 0, "Shell Embedding", 0)
    HwndDocObject = Plugin.Window.FindEx(HwndEmbedding, 0, "Shell DocObject View", 0)
    hwnd = Plugin.Window.FindEx(HwndDocObject, 0, "Internet Explorer_Server",0 )
End Function

Function GoToMuGang()
    Call LJFindPic("母港_出击")
    If (FoundPic = 0)
        Call LJFindPicAndClickUntilFound("左侧UI_母港")
        Call LJLeftClickOnXY()
    End if
End Function

Function SelectExpeditionMap()
    X = ExpeditionFirstMapPositionX + ExpeditionMapIndex * ExpeditionFirstMapPositionOffset
    Y = ExpeditionFirstMapPositionY
    Call LJLeftClickOnXY()
End Function

Function SelectExpeditionMisstion()
    X = ExpeditionMisstionPositionX
    Y = ExpeditionMisstionPositionY + ExpeditionMisstionIndex * ExpeditionFirstMisstionPositionOffset
    Call LJLeftClickOnXY()
End Function

/*****************************工具函数*****************************/
/**查找图片**/
Function LiebFindPic(picName)
    Call Plugin.BGCP2_02.FindPicture(hwnd, 0, 0, 800, 480, resourceFolder & picName & ".bmp", 50, 0.9, X, Y)
End Function
Function LJFindPic(picName)
    Call Plugin.BGCP2_02.FindPicture(hwnd, 0, 0, 800, 480, resourceFolder & picName & ".bmp", 50, 0.9, X, Y)
    If X > - 1  Then //找到了	
        FoundPic = 1
    Else //没知道，可能是被选中的状态，更换选中状态的图片再找一次
        Call Plugin.BGCP2_02.FindPicture(hwnd, 0, 0, 800, 480, resourceFolder & picName & "_touched.bmp", 50, 0.9, X, Y)
        If X > - 1  Then 
            FoundPic = 1//找到了	
        Else 
            FoundPic = 0//真没找到
        End If
    End If
End Function

Function LJFindPicAndClickUntilFound(picName)
    Call LJFindPic(picName)
    While (FoundPic = 0)
        Call LJFindPic(picName)
        Delay 100
    Wend
    Call LJLeftClickOnXY()
End Function

/**点击位置**/
Function LJLeftClickOnXY()
    Call Plugin.Bkgnd.LeftClick(hwnd, X, Y)
    X = -1 
    y = -1
End Function

Function LJPointSet(PointVar, positionX, positionY)
	PointVar = positionX & + "|" + positionY
End Function

Function LJPointGet(PointVar)
	ZB = InStr(PointVar, "|")
	X = Clng(Left(XY, ZB - 1)): Y = Clng(Right(XY, Len(XY) - ZB))
End Function