
--Funciona en el Psych Engine, pero funciona en la 0.6.3, 0.7x, 1.0 Pre-Release y 1.0
--Recreación hecha por Sonic356

--Works on Psych Engine, but works on 0.6.3, 0.7x, 1.0 Pre-Release and 1.0
--Recreation made by Sonic356


function onCreate()
    local ueVer = getPropertyFromClass("MainMenuState", "ueVersion")
    local psychVer = getPropertyFromClass("MainMenuState", "psychEngineVersion")
    makeLuaText("memoryUsed", "0 MB", 0, 90, 24)
    setTextSize("memoryUsed", 14)
    setTextBorder('memoryUsed', 2, 'black')
    addLuaText("memoryUsed")
    setObjectCamera('memoryUsed', 'other')

    makeLuaText("memoryMax", "/ 0 MB", 0, 175, 24)
    setTextSize("memoryMax", 14)
    setTextBorder('memoryMax', 2, 'black')
    setProperty('memoryMax.alpha', 0.6)
    addLuaText("memoryMax")
    setObjectCamera('memoryMax', 'other')

    makeLuaText("fps", "0", 0, 0, 10)
    setTextSize("fps", 30)
    addLuaText("fps")
    setObjectCamera('fps', 'other')

    makeLuaText("FPStext", "FPS", 0, 40, 24)
    setTextSize("FPStext", 14)
    addLuaText("FPStext")
    setObjectCamera('FPStext', 'other')

    local engine = "Universe"
    if (ueVer >= "0.6.0") then engine = "Solar" end
    makeLuaText('engineUsed', engine..' Engine '..ueVer..' | Psych Engine '..psychVer, 0, 0, 40)
    setTextSize('engineUsed', 14)
    setTextBorder('engineUsed', 2, 'black')
    addLuaText('engineUsed')
    setObjectCamera('engineUsed', 'other')
end

function onUpdate()
    local memoryUsed = collectgarbage("count") / 1
    local memoryMax = getPropertyFromClass('openfl.system.System', 'totalMemory') / (1024 * 1024)

    setTextString("memoryUsed", string.format("%.2f MB", memoryUsed))
    setTextString("memoryMax", string.format("/ %.2f MB", memoryMax))

    local curFps = ""..getPropertyFromClass("Main", "fpsVar.currentFPS")
    setTextString("fps", curFps)

    local memory = math.abs(roundDecimal(totalMemory / 1000000, 1))
end

function roundDecimal(value, precision)
    local mult = 1

    for i = 0, precision do
        mult = mult * 10
    end

    return fround(value * mult, -1) / mult
end

function fround(number, decimals)
    local power = 10 ^ decimals
    return math.floor(number * power) / power
end

function onCreatePost()
  addHaxeLibrary('Main');
  runHaxeCode([[
    Main.fpsVar.visible = false;
  ]]);
end

function onEndSong() 
addHaxeLibrary('Main');
  runHaxeCode([[
    Main.fpsVar.visible = true;
  ]]);
end

function onExitSong() 
addHaxeLibrary('Main');
  runHaxeCode([[
    Main.fpsVar.visible = true;
  ]]);
end