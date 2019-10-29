#include<_Httprequest.au3>

$data=_Httprequest(2,'https://vnpt.com.vn/Support/GenerateCaptcha?_=1572332902456')

$data=StringLeft($data,StringLen($data)-1)
$data=StringRight($data,StringLen($data)-1)
MsgBox(0,0,$data)


Local $sImageName = ""
Local $hFile = 0

$sImageName = "nghiahsgs.jpg"
$hFile=FileOpen($sImageName, 18)
FileWrite($hFile, _Encoding_Base64Decode($data))
FileClose($hFile)

Func _Encoding_Base64Decode($sData)
    Local $struct = DllStructCreate("int")

    $a_Call = DllCall("Crypt32.dll", "int", "CryptStringToBinary", _
            "str", $sData, _
            "int", 0, _
            "int", 1, _
            "ptr", 0, _
            "ptr", DllStructGetPtr($struct, 1), _
            "ptr", 0, _
            "ptr", 0)

    If @error Or Not $a_Call[0] Then
        Return SetError(1, 0, "") ; error calculating the length of the buffer needed
    EndIf

    Local $a = DllStructCreate("byte[" & DllStructGetData($struct, 1) & "]")

    $a_Call = DllCall("Crypt32.dll", "int", "CryptStringToBinary", _
            "str", $sData, _
            "int", 0, _
            "int", 1, _
            "ptr", DllStructGetPtr($a), _
            "ptr", DllStructGetPtr($struct, 1), _
            "ptr", 0, _
            "ptr", 0)

    If @error Or Not $a_Call[0] Then
        Return SetError(2, 0, "") ; error decoding
    EndIf

    Return BinaryToString(DllStructGetData($a, 1))
EndFunc   ;==>_Encoding_Base64Decode
