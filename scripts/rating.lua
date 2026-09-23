--Credits

--First og script Made by Shaggy#3760(Psych Engine server)
--Second script made by BombasticTom#0646 and another unknown guy
--Ratings in cam script made by Unholywanderer04
--BF Vanilla notes postion script by BombasticTom#0084
--Other lua scripts made by Steve The Creeper
--All lua scripts combined + edited by Steve The Creeper

--BF OG Note position + no arrow glow for dad notes

local preferences = { --This is just to activate it(always leave to true)
	vanillaStrumPos = false,
}

function fixStrumPosition()
	if not preferences.vanillaStrumPos then return end

	for i=0, getProperty('strumLineNotes.length')-1 do
		setPropertyFromGroup('strumLineNotes', i, 'x', (screenWidth / 2 * getPropertyFromGroup('strumLineNotes', i, 'player')) + 50 + getPropertyFromClass('Note', 'swagWidth') * (i%4))
	end
end

function onCountdownTick(count)
	if count == 0 then
		fixStrumPosition();
	end
end



--Ratings In Cam (Sick, Good, bad and stuff)

-- Settings (Player) --
    local visible = true  -- Show it?

    local pixel = true   -- Pixel check 

    local showCombo = true           -- Show the "unused" combo thing (optional)
    local msTxt     = false           -- Show your hit milliseconds next to the rating (optional)

    local foreverCount = false       -- Shows combo number like forever engine 
    local countMisses  = false       -- Show the amount of misses each miss (Like Forever Engine)
    local missSprite   = true       -- Show a thing when you fuck up

    -- path to images, for both ratings and numbers | Will be used for all proceeding images 
    local path = {
        ratings = '',
        nums = ''
    }
    
    local ratingGrab = {'sick', 'good', 'bad', 'shit'} -- What it'll grab
    local numPrefix  = 'num'               
    local numSuffix  = ''

    local combType   = 'combo'        -- For swappin with pixel 'n such
    local missType   = 'miss'

    local constantGameCam =  true    -- Keeps things hooked onto characters

    local ratingPos = {
        game   = {x = nil, y = nil},  -- camGame position
        cam    = {x = 0, y = 1280},  -- HUD and Other position | DEFAULT: {450, 280}
        offset = {x = 405, y = 230}}  -- onPlayerCombo offsets

    local numPos = {
        game   = {x = nil, y = nil},
        cam    = {x = 0, y = 1400},
        offset = {x = 444, y = 385}}

    local comboPos = {
        game   = {x = nil, y = nil},  -- will be dependant on the number and rating postion if left nil
        cam    = {x = nil, y = nil}, 
        offset = {x = 770, y = 400}}

    local scales = {
        rating = {0.69, 0.69},  -- DEFAULT: {0.70, 0.70}
        nums   = {0.5, 0.5},    -- DEFAULT: {0.51, 0.51}   | IF messed with, be sure to adjust it's spacing down below as they might overlap
        combo  = {0.58, 0.58},  -- DEFAULT: {0.59, 0.59}
        miss   = {0.69, 0.69}}  -- DEFAULT: {0.70, 0.70] | fuck it

    local onPlayerCombo = true  -- It'll show on where the player has the ratings offsets, IF TIED TO HUD

    local camSet = 'false'       -- Should it be on the Hud or Game or Other?  Hud | Game | Other  
    -- (NOTICE: for game cam, I have its default set to rely on bf's position)

    local add5thRating = true -- cosmetic-ish (optional)
    local customRating = {
        image = 'epic',
        color = 'ff00ff',
        score = 500,        -- Points added on hit
        hitWindow = 22.5,   -- Amount of time you have to hit in ms | Has to be less than the 'sick' window
        total = 0           -- For counting total amount hit, don't change
    }

local MODES = {
    single         = false, -- Only 1 set of numbers and ratings are shown at a time | Helps prevent lag

    stationary     = false, -- Prevent the Rating hop | Single mode recommended

    showRating     = true, -- Shows rating (who coulda guessed)
    showNums       = true, -- Shows numbers (who coulda guessed)

    colorRatings   = false, -- Color the ratings based on which you get, Sick is blue, good is green, etc | NEEDS TO BE ON FOR THESE OTHER RATING COLOR SETTINGS TO WORK
    colorSyncing   = false, -- Rating takes color of direction pressed | Overwrites colorRatings and fcColorRating
    fcColorRating  = false, -- Colors Ratings based of FC level, like andromeda!!!
    colorFade      = false, -- Fades color back to baseColor's value

    colorNumbers   = false, -- Same as above, but for numbers
    colorSyncNums  = false,
    fcColorNums    = false,
    colorFadeNums  = false,

    comboColor      = true,
    comboColorFade  = false,

    randomColor    = false, -- Randomized 'sick' color | Only 'colorRatings' or 'colorNumbers' should be on
    COLORSWAP_rate = false, -- Colorswap your sick ratin (and combo sprite) | 6.1 and above
    COLORSWAP_num  = false  -- Colorswap your combo nums | 6.1 and above
}


-- Colors --
    -- Best with white ratings --
    local ratingColors = {'68fafc', '48f048', 'fffecb', 'ffffff'} 

    local colorSync = {'c24b99', '68fafc', '12fa05', 'f9393f'} 

    local comboUse -- Uses rating colors, no unique value

-- Dont touch these unless you know what you're doing | I do :)
    local isThousand = false
    local eh = 0         -- Make the sprites load in the way it does
    local curRating = ''
    --
    local addedOffset = false -- for the combo sprite
    local brokeCombo = nil  -- only one set of 0's will appear if you miss more than 1 time in a row
    local mainOffset = {}
    local isEarly = ''

function onDestroy()
    setPropertyFromClass('ClientPrefs', 'hideHud', false) -- So the thing unhides once you complete a song
end

function onCreatePost()
    mainOffset = getPropertyFromClass('ClientPrefs', 'comboOffset') -- rating offsets 
    -- ( [1] Rating X | [2] Rating Y | [3] Number X | [4] Number Y ) 

    if msTxt then
        makeLuaText('msTxt', '', 200, 0, 0)
        addLuaText('msTxt')
        setTextSize('msTxt', (camSet == 'game' and 25 or 20))
        setTextAlignment('msTxt', 'center')
        setObjectCamera('msTxt', camSet)
        setTextFont('msTxt', 'vcr.ttf')
    end

    pixel = getPropertyFromClass('PlayState', 'isPixelStage')

    -- Pixel shit --
    if pixel then 
        path.ratings = 'pixelUI/'
        path.nums = 'pixelUI/'

        for i = 1, #ratingGrab do
            ratingGrab[i] = ratingGrab[i].. '-pixel' end
        
        customRating.image = customRating.image .. '-pixel'
        scales.rating = {5, 5}

        numSuffix = '-pixel'
        scales.nums = {5.5, 5.5}

        ratingPos.game = {x = getProperty('boyfriend.x') - 120, y = getProperty('boyfriend.y') - 250}
        numPos.game    = {x = ratingPos.game.x + 30, y = ratingPos.game.y + 100}
        comboPos.offset.x = 480

        combType = 'combo-pixel'
        missType = 'miss-pixel'
        scales.combo = {4, 4}
        
        colorSync = {'e276ff', '3dcaff', '71e300', 'ff884e'}

        ratingColors[1] = '3dcaff'
        ratingColors[2] = '71e300'
    end

    -- nil checks!!!! --
    ratingPos.game.x = (ratingPos.game.x or getProperty('boyfriend.x') - 100)
    ratingPos.game.y = (ratingPos.game.y or getProperty('boyfriend.y') - 100)
         
    numPos.game.x = (numPos.game.x or ratingPos.game.x + 30)
    numPos.game.y = (numPos.game.y or ratingPos.game.y + 100)

    comboPos.cam.x = (comboPos.cam.x or numPos.cam.x + 30)
    comboPos.cam.y = (comboPos.cam.y or numPos.cam.y)
    
    comboPos.game.x = (comboPos.game.x or numPos.game.x + 30)
    comboPos.game.y = (comboPos.game.y or numPos.game.y)

    fakeFC = string.sub(customRating.image:upper(), 1, 1)..'FC'
    if MODES.COLORSWAP_rate or MODES.COLORSWAP_num then
        addHaxeLibrary('ColorSwap')
        runHaxeCode('colorSw = new ColorSwap();')
    end
end

local colorsRand = {}
local noNeed = false
function onUpdate(elapsed)
    setPropertyFromClass('ClientPrefs', 'hideHud', visible)

    if constantGameCam then
        if camSet == 'game' and visible then -- no point in doing it if not on game cam
            bf1 = (getProperty('boyfriend.x') + (getMidpointX('boyfriend') / (getProperty('boyfriend.width'))) - 120)
            bf2 = ((getMidpointY('boyfriend') - (getProperty('boyfriend.height') / 1.7)) / (pixel and 1.5 or 1))

            ratingPos.game = {x = bf1, y = bf2}
            numPos.game    = {x = ratingPos.game.x + 30, y = ratingPos.game.y + 100}
            comboPos.game  = {x = numPos.game.x + (not isThousand and 30 or 70), y = numPos.game.y}
        end
    end
    
    -- For the combo sprite
    if showCombo then
        isThousand = getProperty('combo') >= 999

        comboPos.game.x = numPos.game.x + (isThousand and 70 or 30)
        comboPos.cam.x = numPos.cam.x + (isThousand and 70 or 30)

        if isThousand and not addedOffset then
            addedOffset = true 
            comboPos.offset.x = comboPos.offset.x + 42
        elseif not isThousand and addedOffset then 
            addedOffset = false 
            comboPos.offset.x = comboPos.offset.x - 42
        end
    end
    
    if ratingName ~= '?' and not noNeed and add5thRating then -- a bit stupid, but it works 
        isC = customRating.total == getProperty('sicks')
        for _, v in pairs({'goods', 'bads', 'shits', 'songMisses'}) do
            if getProperty(v) > 0 or not isC then noNeed = true break end
        end
        --setTextString('scoreTxt', 'Score: '..score..' | Misses: '..misses..' | Rating: '..ratingName..' ('.. round(rating * 100, 2)..'%) - '..(isC and fakeFC or ratingFC))
    end

    eh = getProperty('combo') + misses
    
    if (getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') or 
        getPropertyFromClass('flixel.FlxG', 'keys.justPressed.EIGHT')) then
        setPropertyFromClass('ClientPrefs', 'hideHud', false)
    end

    if msTxt then
        setProperty('msTxt.scrollFactor.x', camSet == 'game' and 1 or 0)
        setProperty('msTxt.scrollFactor.y', camSet == 'game' and 1 or 0)
    end

    if MODES.randomColor then
        colorsRand = {getRandomInt(1, 255), getRandomInt(1, 255), getRandomInt(1, 255)}
        ratingColors[1] = rgb_to_hex(colorsRand)
    end

    if MODES.COLORSWAP_rate or MODES.COLORSWAP_num then
        runHaxeCode([[
            if (colorSw.hue > 0) colorSw.hue -= ]]..elapsed..[[;
            if (colorSw.saturation > 0) colorSw.saturation -= ]]..elapsed..[[;
        ]])
    end
end

function goodNoteHit(id, d, noteType, isSustainNote)
    if visible then
        if not isSustainNote then
            brokeCombo = false

            if MODES.single then eh = 0 end 

            -- Took from Whitty mod >:)
            strumTime = getPropertyFromGroup('notes', id, 'strumTime')
            curRating = getRating((strumTime - getSongPosition() + getPropertyFromClass('ClientPrefs','ratingOffset')) / playbackRate)

            isEarly = strumTime < getSongPosition() and '' or '-'

            useColor = '' -- for checking rating color
       
            local ratingNumbers = {['sick'] = 1, ['good'] = 2, ['bad'] = 3, ['shit'] = 4, [customRating.image] = 5}
            ratiNum = ratingNumbers[curRating]
            local canSwap = (ratiNum == 1) or (ratiNum == 5) -- color swap only the 'sick' and 'custom' rating

            useColor = (ratiNum < 5 and ratingColors[ratiNum] or customRating.color)
            setTextColor('msTxt', useColor)

            -- so the color gets set based on rating, THEN it removes the rating
            if not MODES.showRating then curRating = '' ratiNum = nil end

            local fcs = {['SFC'] = 1, ['GFC'] = 2, ['FC'] = 3}
            levelNum = (fcs[ratingFC] or 4)

            thisOne, numUse = ratingColors[4], ratingColors[4]

            if MODES.colorRatings then
                thisOne = useColor
                if MODES.colorSyncing then
                    thisOne = (curRating ~= 'shit' and colorSync[d+1])
                elseif MODES.fcColorRating then
                    thisOne = ratingColors[levelNum]
                end
            end
            comboUse = (MODES.comboColor and thisOne or ratingColors[4])

            if MODES.colorNumbers then 
                numUse = useColor
                if MODES.colorSyncNums then 
                    numUse = colorSync[d+1]
                elseif MODES.fcColorNums then 
                    numUse = ratingColors[levelNum] 
                end
            end

            if MODES.COLORSWAP_rate or MODES.COLORSWAP_num then 
                runHaxeCode('colorSw.hue += '..(d + 1)..'; colorSw.saturation += 0.3;')
            end

            setTextSize('msTxt', (camSet == 'game' and 25 or 20))
            setObjectCamera('msTxt', camSet)    

            -------------------------------Ratings---------------------------------------            

            -- This grabs the default Rating images in either assets/shared/images or mods/images depending on if you're using a mod AND if there are Rating images in there.
            -- I recommend making a folder for ratings if you do some wacky things, specifially for ease of access.
            
            local ratingSpr = 'rating'..(MODES.single and '' or curRating..eh)
            local x, y = getXandY(ratingPos, true)
            if msTxt then setProperty('msTxt.x', x + 100) setProperty('msTxt.y', y + 70) end
           
            if ratiNum ~= nil then
                local ratingImage = (ratiNum < 5 and ratingGrab[ratiNum] or customRating.image)
           
                makeLuaSprite(ratingSpr, path.ratings .. ratingImage, x, y)
            
                setProperty(ratingSpr .. '.color', getColorFromHex(thisOne))
                setObjectCamera(ratingSpr, camSet)
                if camSet == 'hud' then 
                    setObjectOrder(ratingSpr, getObjectOrder('strumLineNotes')-1)
                end
                scaleObject(ratingSpr, scales.rating[1], scales.rating[2])
                setProperty(ratingSpr .. '.antialiasing', not pixel)

                addLuaSprite(ratingSpr, true)
                if not MODES.stationary then
                    setProperty(ratingSpr ..'.acceleration.y', 550 * playbackRate * playbackRate)
                    setVelocity(ratingSpr, getRandomInt(0, 10), -180)
                end

                if MODES.single then cancelThings(ratingSpr..'Fade') end 
                runTimer(ratingSpr..'Fade', (crochet * 0.001) / playbackRate)

                if MODES.COLORSWAP_rate and canSwap then 
                    runHaxeCode('game.getLuaObject("'..ratingSpr..'").shader = colorSw.shader;') 
                end

                if MODES.colorFade then
                    doTweenColor('coolRatn'..eh, ratingSpr, ratingColors[4], (0.2 + (crochet * 0.0005)) / playbackRate, 'quartIn')
                end
            end

            if showCombo then
                local comboSpr = 'combThing' .. eh
                local x, y = getXandY(comboPos, false)
                
                makeLuaSprite(comboSpr, path.ratings .. combType, x, y)
                setObjectCamera(comboSpr, camSet)
                setProperty(comboSpr .. '.antialiasing', not pixel)
                if camSet == 'hud' then 
                    setObjectOrder(comboSpr, getObjectOrder('strumLineNotes')-1) 
                end
                scaleObject(comboSpr, scales.combo[1], scales.combo[2])
                setProperty(comboSpr .. '.color', getColorFromHex(comboUse))
                addLuaSprite(comboSpr, true)
                if not MODES.stationary then
                    setProperty(comboSpr .. '.acceleration.y', 550 * playbackRate * playbackRate)
                    setVelocity(comboSpr, getRandomInt(0,10), -180)
                end

                if MODES.single then cancelThings(comboSpr..'Fade') end 
                runTimer(comboSpr..'Fade', (crochet * 0.0015) / playbackRate)

                if MODES.COLORSWAP_rate and canSwap then 
                    runHaxeCode('game.getLuaObject("'..comboSpr..'").shader = colorSw.shader;')
                end

                if MODES.comboColorFade then
                    doTweenColor('coolCom' .. eh, comboSpr, ratingColors[4], (0.2 + (crochet * 0.001)) / playbackRate, 'quartIn')
                end
            end

            if msTxt then
                if luaSpriteExists(ratingSpr) or luaSpriteExists('combThing'..eh) then
                    setObjectOrder('msTxt', getObjectOrder(showCombo and 'combThing'..eh or ratingSpr) * 2)
                end
            end

            --------------------------------Numbers----------------------------------------
            local combo = getProperty('combo')
            local split, numCount = splitNums(combo, foreverCount)

            if MODES.showNums then
                sequence = nil
                for i = 1, numCount do
                    multBy = (((i + 2) - numCount) * 43) -- spacing and spawning

                    local sequence = numPrefix .. split[i] .. numSuffix  
                    local numSpr = 'num' .. i .. eh

                    local x, y = getXandY(numPos, false) 

                    makeLuaSprite(numSpr, path.nums .. sequence, x - multBy, y)
                    setObjectCamera(numSpr, camSet)
                    setProperty(numSpr .. '.color', getColorFromHex(numUse))
                    if camSet == 'hud' then 
                        setObjectOrder(numSpr, getObjectOrder('strumLineNotes')-1)
                    end

                    setProperty(numSpr .. '.antialiasing', not pixel)

                    scaleObject(numSpr, scales.nums[1], scales.nums[2])
                    addLuaSprite(numSpr, true)
                    if not MODES.stationary then
                        setProperty(numSpr .. '.acceleration.y', getRandomInt(200, 400) * playbackRate * playbackRate)
                        setVelocity(numSpr, getRandomInt(-5, 5), getProperty(numSpr..'.velocity.y') - getRandomInt(140, 160))
                    end

                    if MODES.single then cancelThings(numSpr..'Fade') end 
                    runTimer(numSpr..'Fade', (crochet * 0.002 / playbackRate))

                    if MODES.COLORSWAP_num then 
                        runHaxeCode('game.getLuaObject("'..numSpr..'").shader = colorSw.shader;') 
                    end

                    if MODES.colorFadeNums then
                        doTweenColor('itsjustafad' .. numSpr, numSpr, ratingColors[4], (0.2 + (crochet * 0.0015)) / playbackRate, 'quartIn')
                    end
                end
            end
        end
    end
end

function noteMiss(id, d, noteType, isSustainNote)
    if missSprite then
        local sprName = MODES.single and 'rating' or 'missrating' .. eh

        local x, y = getXandY(ratingPos, true) 
    
        makeLuaSprite(sprName, path.ratings .. missType, x, y) 
        setObjectCamera(sprName, camSet)
        setProperty(sprName .. '.antialiasing', not pixel)
        scaleObject(sprName, scales.miss[1], scales.miss[2])

        if camSet == 'hud' then 
            setObjectOrder(sprName, getObjectOrder('strumLineNotes')-1)
        end
        addLuaSprite(sprName, true)
        if not MODES.stationary then
            setProperty(sprName .. '.acceleration.y', 650 * playbackRate * playbackRate)
            setVelocity(sprName, getRandomInt(0, 10), -100)
        end
        runTimer(sprName..'Fade', (crochet * 0.001) / playbackRate)
    end

    local missCount = {}
    if MODES.showNums then
        if not countMisses then
            missCount = {0, 0, 0} -- just to make three numbers appear
            numCount = 3
        else
            missCount, numCount = splitNums(misses, foreverCount) 
            numCount = numCount + 1
            table.insert(missCount, 'minus') -- always at the end for consistency
        end
        
        for i = 1, numCount do
            multBy = (((i + (countMisses and 3 or 2)) - numCount) * 43) -- spacing and spawning

            if not countMisses then 
                sequence = numPrefix..'0'..numSuffix
            else
                isMinus = type(missCount[i]) ~= 'number'
                sequence = (isMinus and '' or numPrefix)..missCount[i]..numSuffix
            end

            local missNum = 'MISSnum' .. (MODES.single and '' or eh) .. i
            if not brokeCombo or countMisses then
                local x, y = getXandY(numPos, false) 
                
                makeLuaSprite(missNum, path.nums .. sequence, x - multBy, y)
                setObjectCamera(missNum, camSet)
                setProperty(missNum .. '.color', getColorFromHex('bc0000'))
                if camSet == 'hud' then 
                    setObjectOrder(missNum, getObjectOrder('strumLineNotes')-1)
                end
                setProperty(missNum .. '.antialiasing', not pixel)
  
                scaleObject(missNum, scales.nums[1], scales.nums[2])
                addLuaSprite(missNum, true)
                if not MODES.stationary then
                    setProperty(missNum .. '.acceleration.y', 300 * playbackRate * playbackRate)
                    setVelocity(missNum, 0, -100)
                end
                runTimer(missNum..'Fade', (crochet * 0.002 / playbackRate))
            end
        end
    end
    brokeCombo = true
end

function noteMissPress() noteMiss() end

function getRating(diff) -- fused them, cuz they basically did the same thing
	diff = math.abs(diff)

    if msTxt then
        setTextString('msTxt', isEarly..round(diff, 2)..' ms')
        cancelTween('out')
        setProperty('msTxt.alpha', 1)
        doTweenAlpha('out', 'msTxt', 0, crochet/1000, 'quartIn')
    end

    local windows = {'bad', 'good', 'sick'}
    if add5thRating then table.insert(windows, customRating.image) end

    local toReturn = 'shit'
    for i = 1, #windows do
        local hitWindow = (i < 4 and getPropertyFromClass('ClientPrefs', windows[i]..'Window') or customRating.hitWindow)
        if diff <= hitWindow then
            toReturn = windows[i]
        else break end -- if its not less than the window, no need to contine
    end
    
    if toReturn == customRating.image and not botPlay then 
        customRating.total = customRating.total + 1
        addScore(math.abs(customRating.score - 350)) -- hitting a 'sick' already adds 350
    end
    
    return toReturn
end

function rgb_to_hex(rgb) return string.format('%x', (rgb[1] * 0x10000) + (rgb[2] * 0x100) + rgb[3]) end

function setVelocity(thing, x, y)
    setProperty(thing..'.velocity.x', x * playbackRate)
    setProperty(thing..'.velocity.y', y * playbackRate)
end

function round(num, decimals)
    local mult = 10^(decimals or 0)
    return math.floor(num * mult + 0.5) / mult
end

function cancelThings(tag) -- for single mode
    cancelTimer(tag) 
    cancelTween('!'..tag:gsub('Fade', '')) 
end

function onTimerCompleted(t)
    if string.find(t, 'Fade') then
        doTweenAlpha('!'..t:gsub('Fade', ''), t:gsub('Fade', ''), 0, 0.2 / playbackRate)
    end
end

function onTweenCompleted(t)
    if string.find(t, '!') then
        local the = stringSplit(t, '!')
        removeLuaSprite(the[2], true)
    end
end

function getXandY(positionTable, isRating)
    local off1, off2 = (isRating and 1 or 3), (isRating and 2 or 4)

    if onPlayerCombo and camSet == 'hud' then
        return positionTable.offset.x + mainOffset[off1], positionTable.offset.y - mainOffset[off2]
    elseif camSet == 'game' then 
        return positionTable.game.x, positionTable.game.y
    end
    return positionTable.cam.x, positionTable.cam.y
end

function splitNums(number, forev)
    local split, count = {}, 1

    local length = string.len(tostring(number)) 
    local looper = (number >= 999 and 3 or 2)

    for i = 0, looper do
        if (forev and length > i) or not forev then
            table.insert(split, math.floor(number / 10 ^ i % 10)) -- stole the math from pantszoo
        end
    end

    count = (forev and string.len(tostring(number)) or (number > 999 and 4 or 3))          
    return split, count
end