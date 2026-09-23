-- ╔══════════════════════════════════════════════════════╗
-- ║   V-Slice Hold Cover — Auto RGB / Multi-Color        ║
-- ║   Psych Engine 0.6.3  [v7 - Pixel Fix]              ║
-- ║   Solar Engine 0.6.X — Universe Engine 0.5.5	      ║
-- ║   By Mr YMR (@ymrgame2009)				              ║
-- ╚══════════════════════════════════════════════════════╝

local colorNames   = {'Purple', 'Blue', 'Green', 'Red'}
local playerCovers = {'coverP0', 'coverP1', 'coverP2', 'coverP3'}
local enemyCovers  = {'coverE0', 'coverE1', 'coverE2', 'coverE3'}

local rgbApplied = {
    player = {false, false, false, false},
    enemy  = {false, false, false, false}
}

local pActive = {false, false, false, false}
local eActive = {false, false, false, false}
local pFading = {false, false, false, false}

local pHasSustain = {false, false, false, false}
local eHasSustain = {false, false, false, false}

local pHeadTime = {0, 0, 0, 0}
local eHeadTime = {0, 0, 0, 0}

local isPixelStage = false
local isBotPlay    = false
local useRGB       = false
local forcePixelCover = false

-- Size Control (Normal)
local normalSizeMult = 1.0 
local normalEndSizeMult = 1.0  

-- Position Offset for HOLD/START animation (Normal X, Y)
local normalHoldOffsetX = -110
local normalHoldOffsetY = -100

-- Position Offset for END animation (Normal X, Y)
local normalEndOffsetX = -110
local normalEndOffsetY = -100

local useOldPixelSprite = true

-- Size Control (New Pixel)
local pixelSizeMult = 1.0 
local pixelEndSizeMult = 2 

-- Position Offset for HOLD animation (New Pixel X, Y)
local pixelHoldOffsetX = 0
local pixelHoldOffsetY = 20

-- Position Offset for END animation (New Pixel X, Y)
local pixelEndOffsetX = -55
local pixelEndOffsetY = -50

-- Size Multiplier (Old Pixel)
local oldPixelHoldSize = 12 
local oldPixelEndSize = 12 

-- Position Offset for HOLD animation (Old Pixel X, Y)
local oldPixelHoldOffsetX = -395
local oldPixelHoldOffsetY = -120

-- Position Offset for END animation (Old Pixel X, Y)
local oldPixelEndOffsetX = -395
local oldPixelEndOffsetY = -120


local pixelStages = {
    school = true, schoolevil = true, schoolerect = true, ['schoolevil-alt'] = true,
    idk = true, block = true, missingblock = true, undertale = true, shadow = true,
    stage1b = true, stage1f = true, stage2b = true, stage2f = true, stage3b = true,
    stage3f = true, stagecb = true, stagep = true, stagepenser = true
}

function detectPixelStage()
    local pixel = getPropertyFromClass('states.PlayState', 'isPixelStage')
    if pixel == nil then pixel = getPropertyFromClass('PlayState', 'isPixelStage') end
    if pixel == nil then pixel = getPropertyFromClass('states.PlayState', 'stageData.isPixelStage') end
    if pixel == nil then pixel = getPropertyFromClass('PlayState', 'stageData.isPixelStage') end
    if pixel == nil then pixel = getProperty('isPixelStage') end
    if pixel == nil then pixel = getProperty('stageData.isPixelStage') end

    if forcePixelCover or pixel == true or pixel == 'true' then return true end

    local stage = getPropertyFromClass('states.PlayState', 'curStage')
    if stage == nil then stage = getPropertyFromClass('PlayState', 'curStage') end
    if stage == nil then stage = getProperty('curStage') end
    if stage == nil then stage = getProperty('SONG.stage') end

    if stage ~= nil then
        return pixelStages[string.lower(tostring(stage))] == true
    end
    return false
end

function forcePixelRender(tag)
    setProperty(tag..'.antialiasing', false)
    runHaxeCode(
        'var spr = game.modchartSprites.get("' .. tag .. '");'
     .. 'if (spr != null) {'
     ..     'spr.antialiasing = false;'
     ..     'if (spr.graphic != null && spr.graphic.bitmap != null) spr.graphic.bitmap.smoothing = false;'
     .. '}'
    )
end

function onCreatePost()
    isPixelStage = detectPixelStage()
    isBotPlay    = getPropertyFromClass('states.PlayState', 'cpuControlled')

    useRGB = getPropertyFromClass('backend.ClientPrefs', 'data.noteRGB')
    if useRGB == nil then useRGB = getPropertyFromClass('ClientPrefs', 'data.noteRGB') end
    if useRGB == nil then useRGB = getPropertyFromClass('backend.ClientPrefs', 'noteRGB') end
    if useRGB == nil then useRGB = true end

    for i = 0, 3 do
        setupCover(playerCovers[i+1], colorNames[i+1])
        setupCover(enemyCovers[i+1],  colorNames[i+1])
    end
end

function setupCover(tag, color)
    local image
    if useRGB then
        if isPixelStage then
            image = useOldPixelSprite and 'holdCoverPixelRGB-Old' or 'holdCoverPixelRGB'
        else
            image = 'holdCoverRGB'
        end
        
        makeAnimatedLuaSprite(tag, image, 0, 0)
        if isPixelStage then
            addAnimationByPrefix(tag, 'hold', 'holdCoverRGB',    24, true)
            addAnimationByPrefix(tag, 'end',  'holdCoverEndRGB', 24, false)
        else
            addAnimationByPrefix(tag, 'start', 'holdCoverStartRGB', 24, false)
            addAnimationByPrefix(tag, 'hold',  'holdCoverRGB',      24, true)
            addAnimationByPrefix(tag, 'end',   'holdCoverEndRGB',   24, false)
        end
    else
        image = 'holdCover' .. color
        makeAnimatedLuaSprite(tag, image, 0, 0)
        addAnimationByPrefix(tag, 'start', 'holdCoverStart' .. color, 24, false)
        addAnimationByPrefix(tag, 'hold',  'holdCover'      .. color, 24, true)
        addAnimationByPrefix(tag, 'end',   'holdCoverEnd'   .. color, 24, false)
    end

    setProperty(tag .. '.antialiasing', not isPixelStage)
    scaleObject(tag, 1, 1)
    setObjectCamera(tag, 'camHUD')
    setProperty(tag .. '.alpha', 0.0001)
    setProperty(tag .. '.visible', true)
    addLuaSprite(tag, true)

    if isPixelStage then forcePixelRender(tag) end
end

function getSustainEndByGap(dir, isPlayer, headTime)
    local pStr = isPlayer and 'true' or 'false'
    local res = runHaxeCode(
        'var hTime:Float = ' .. headTime .. ';'
     .. 'var times:Array<Dynamic> = [];'
     .. 'try {'
     ..     'for (n in game.notes.members) {'
     ..         'if (n != null && n.alive && n.isSustainNote && n.noteData == ' .. dir .. ' && n.mustPress == ' .. pStr .. ') {'
     ..             'if (n.strumTime >= hTime && n.strumTime < (hTime + 30000)) {'
     ..                 'times.push(n.strumTime);'
     ..             '}'
     ..         '}'
     ..     '}'
     .. '} catch(e:Dynamic) {}'
     .. 'times.sort(function(a, b) { if (a < b) return -1; if (a > b) return 1; return 0; });'
     .. 'var bestMax:Float = 0;'
     .. 'var lastT:Float = -1;'
     .. 'for (t in times) {'
     ..     'var tFloat:Float = t;'
     ..     'if (lastT < 0 || (tFloat - lastT) <= 200) {'
     ..         'bestMax = tFloat;'
     ..         'lastT = tFloat;'
     ..     '} else {'
     ..         'break;'
     ..     '}'
     .. '}'
     .. 'return bestMax;'
    )
    if res == nil or res == '' then return 0 end
    return tonumber(res) or 0
end

function fixEndBounds(tag)
    runHaxeCode(
        'var spr = game.modchartSprites.get("' .. tag .. '");'
     .. 'if (spr != null && spr.animation.curAnim != null) {'
     ..     'try {'
     ..         'var targetW:Float = 16.0;'
     ..         'var targetH:Float = 10.0;'
     ..         'for (frame in spr.animation.curAnim.frames) {'
     ..             'var drawW:Float = (frame.frame.sourceSize != null) ? frame.frame.sourceSize.x : 16.0;'
     ..             'var drawH:Float = (frame.frame.sourceSize != null) ? frame.frame.sourceSize.y : 10.0;'
     ..             'frame.frame.width = targetW;'
     ..             'frame.frame.height = targetH;'
     ..             'frame.frame.offset.x = (targetW - drawW) / 2;'
     ..             'frame.frame.offset.y = (targetH - drawH) / 2;'
     ..         '}'
     ..     '} catch(e:Dynamic) {}'
     .. '}'
    )
end

function showCover(tag, dir, isPlayer)
    isPixelStage = detectPixelStage()
    if isPlayer then
        pActive[dir+1] = true
        pFading[dir+1] = false 
        rgbApplied.player[dir+1] = false
    else
        eActive[dir+1] = true; rgbApplied.enemy[dir+1] = false
    end
    
    local strumGroup = isPlayer and 'playerStrums' or 'opponentStrums'
    setProperty(tag..'.visible', true)
    setProperty(tag..'.alpha', getPropertyFromGroup(strumGroup, dir, 'alpha'))
    
    if isPixelStage then forcePixelRender(tag)
    else setProperty(tag..'.antialiasing', true) end
    
    if getProperty(tag..'.animation.curAnim.name') ~= 'hold' then
        playAnim(tag, 'hold', true)
    end
end

function hideCover(tag, dir, isPlayer)
    if isPlayer then
        if not pActive[dir+1] then return end
        pActive[dir+1] = false; rgbApplied.player[dir+1] = false
        if getProperty(tag..'.animation.curAnim.name') == 'hold' then
            playAnim(tag, 'end', true)
            if isPixelStage and not useOldPixelSprite then fixEndBounds(tag) end
            pFading[dir+1] = true
        else
            setProperty(tag..'.alpha', 0.0001)
        end
    else
        if not eActive[dir+1] then return end
        eActive[dir+1] = false; rgbApplied.enemy[dir+1] = false
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if direction == nil or direction < 0 or direction > 3 then return end
    if isSustainNote then
        pHasSustain[direction + 1] = true
        local sTime = tonumber(getPropertyFromGroup('notes', id, 'strumTime'))
        if sTime ~= nil and sTime > 0 then
            if pHeadTime[direction + 1] == 0 or sTime < pHeadTime[direction + 1] then
                pHeadTime[direction + 1] = sTime
            end
        end
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if direction == nil or direction < 0 or direction > 3 then return end
    if isSustainNote then
        eHasSustain[direction + 1] = true
        local sTime = tonumber(getPropertyFromGroup('notes', id, 'strumTime'))
        if sTime ~= nil and sTime > 0 then
            if eHeadTime[direction + 1] == 0 or sTime < eHeadTime[direction + 1] then
                eHeadTime[direction + 1] = sTime
            end
        end
    end
end

function onUpdatePost(elapsed)
    isPixelStage = detectPixelStage()
    local curTime = getSongPosition()

    for i = 0, 3 do
        local pTag   = playerCovers[i+1]
        local eTag   = enemyCovers[i+1]

        if useRGB then
            if getProperty(pTag..'.alpha') > 0.5 and not rgbApplied.player[i+1] then
                applyRGB(pTag, i, true); rgbApplied.player[i+1] = true
            end
            if getProperty(eTag..'.alpha') > 0.5 and not rgbApplied.enemy[i+1] then
                applyRGB(eTag, i, false); rgbApplied.enemy[i+1] = true
            end
        end

        if pHasSustain[i+1] then
            local maxTime = getSustainEndByGap(i, true, pHeadTime[i+1])
            if maxTime > 0 and curTime < maxTime then
                showCover(pTag, i, true)
            else
                hideCover(pTag, i, true)
                pHasSustain[i+1] = false
                pHeadTime[i+1] = 0
            end
        else
            hideCover(pTag, i, true)
        end

        if pFading[i+1] then
            local animName = getProperty(pTag..'.animation.curAnim.name')
            local finished = getProperty(pTag..'.animation.finished')
            if animName == 'end' and finished then
                setProperty(pTag..'.alpha', 0.0001)
                pFading[i+1] = false
                rgbApplied.player[i+1] = false
            end
        end

        if eHasSustain[i+1] then
            local eMaxTime = getSustainEndByGap(i, false, eHeadTime[i+1])
            if eMaxTime > 0 and curTime < eMaxTime then
                showCover(eTag, i, false)
            else
                hideCover(eTag, i, false)
                eHasSustain[i+1] = false
                eHeadTime[i+1] = 0
            end
        else
            local eAlpha = getProperty(eTag..'.alpha')
            if eAlpha > 0.01 then
                setProperty(eTag..'.alpha', math.max(0.0001, eAlpha - elapsed * 10))
                if getProperty(eTag..'.alpha') <= 0.01 then
                    eActive[i+1] = false; rgbApplied.enemy[i+1] = false
                end
            end
        end
    end

    for i = 0, 3 do
        local pTag   = playerCovers[i+1]
        local eTag   = enemyCovers[i+1]
        local pStrum = 'playerStrums.members['   .. i .. ']'
        local eStrum = 'opponentStrums.members[' .. i .. ']'

        updatePos(pTag, pStrum)
        updatePos(eTag, eStrum)
    end
end

function updatePos(tag, strum)
    if isPixelStage then
        local targetSize, offX, offY
        local strumW = getProperty(strum..'.width')
        
        if useOldPixelSprite then
            targetSize = strumW * oldPixelHoldSize
            offX = oldPixelHoldOffsetX
            offY = oldPixelHoldOffsetY
            
            if getProperty(tag..'.animation.curAnim.name') == 'end' then
                targetSize = strumW * oldPixelEndSize
                offX = oldPixelEndOffsetX
                offY = oldPixelEndOffsetY
            end
            
            setGraphicSize(tag, targetSize, 0)
            
        else
            targetSize = strumW * pixelSizeMult
            offX = pixelHoldOffsetX
            offY = pixelHoldOffsetY
            
            if getProperty(tag..'.animation.curAnim.name') == 'end' then
                targetSize = targetSize * pixelEndSizeMult
                offX = pixelEndOffsetX
                offY = pixelEndOffsetY
            end
            
            setGraphicSize(tag, targetSize, 0)
            updateHitbox(tag)
        end
        
        setProperty(tag..'.x', getProperty(strum..'.x') + offX) 
        setProperty(tag..'.y', getProperty(strum..'.y') + offY) 
        
    else
        local targetScale = normalSizeMult
        
        local offX = normalHoldOffsetX
        local offY = normalHoldOffsetY
        
        if getProperty(tag..'.animation.curAnim.name') == 'end' then
            targetScale = normalEndSizeMult
            offX = normalEndOffsetX
            offY = normalEndOffsetY
        end
        
        scaleObject(tag, targetScale, targetScale)
        updateHitbox(tag)
        
        setProperty(tag..'.x', getProperty(strum..'.x') + offX) 
        setProperty(tag..'.y', getProperty(strum..'.y') + offY) 
    end
end

function applyRGB(tag, id, isPlayer)
    local p   = isPlayer and 'true' or 'false'
    local ids = tostring(id)
    runHaxeCode(
        'var cover = game.modchartSprites.get("' .. tag .. '");'
     .. 'var strum = ' .. p
     ..     ' ? game.playerStrums.members['   .. ids .. ']'
     ..     ' : game.opponentStrums.members[' .. ids .. '];'
     .. 'if (cover != null && strum != null) {'
     ..     'try {'
     ..         'var rgb:Dynamic = Reflect.field(strum, "rgbShader");'
     ..         'if (rgb != null) {'
     ..             'try { Reflect.setField(cover, "rgbShader", rgb); } catch(e:Dynamic) {}'
     ..             'var rgbShader:Dynamic = Reflect.field(rgb, "shader");'
     ..             'if (rgbShader != null) cover.shader = rgbShader;'
     ..             'else if (strum.shader != null) cover.shader = strum.shader;'
     ..         '} else if (strum.shader != null) {'
     ..             'cover.shader = strum.shader;'
     ..         '}'
     ..     '} catch(e:Dynamic) {'
     ..         'if (strum.shader != null) cover.shader = strum.shader;'
     ..     '}'
     ..     'if (cover.shader == null) cover.color = strum.color;'
     ..     'if (' .. tostring(isPixelStage) .. ') {'
     ..         'cover.antialiasing = false;'
     ..         'if (cover.graphic != null && cover.graphic.bitmap != null) cover.graphic.bitmap.smoothing = false;'
     ..     '}'
     .. '}'
    )
end