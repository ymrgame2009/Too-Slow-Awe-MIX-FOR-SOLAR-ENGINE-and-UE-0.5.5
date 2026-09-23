local playerLastFrame = {};
local playerLastTimer = {};
local pressedAnimTimer = {};
local opponentLastFrame = {};
local opponentLastTimer = {};

for i = 0, 3 do
    playerLastFrame[i] = 0;
    playerLastTimer[i] = 0.0;
    pressedAnimTimer[i] = 0.0;
    opponentLastFrame[i] = 0;
    opponentLastTimer[i] = 0.0;
end

function onCreatePost()
    -- Disable default engine animation for sustains to prevent strum conflicts
    for i = 0, getProperty("unspawnNotes.length")-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
            setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
        end
    end
end

function goodNoteHit(i, d, t, s)
    if not s then
        -- Normal note hit (Replaced callMethod with runHaxeCode for 0.6.3 support)
        runHaxeCode('game.playerStrums.members['..d..'].playAnim("static", true);');
        runHaxeCode('game.playerStrums.members['..d..'].playAnim("confirm", false);');
    else
        -- Sustain note hit (Strums) - Using HaxeCode to bypass 0.6.3 _frameTimer limits
        runHaxeCode('game.playerStrums.members['..d..'].animation.curAnim.curFrame = '..playerLastFrame[d]..';');
        runHaxeCode('game.playerStrums.members['..d..'].animation.curAnim._frameTimer = '..playerLastTimer[d]..';');
        pressedAnimTimer[d] = 0.0;
        
        -- Character Animation Fix: Force holdTimer to 0 so the character plays the sing anim once and stops
        setProperty('boyfriend.holdTimer', 0);
    end
end

function opponentNoteHit(i, d, t, s)
    if not s then
        -- Opponent normal note hit
        runHaxeCode('game.opponentStrums.members['..d..'].playAnim("static", true);');
        runHaxeCode('game.opponentStrums.members['..d..'].playAnim("confirm", false);');
    else
        -- Opponent sustain note hit (Strums)
        runHaxeCode('game.opponentStrums.members['..d..'].animation.curAnim.curFrame = '..opponentLastFrame[d]..';');
        runHaxeCode('game.opponentStrums.members['..d..'].animation.curAnim._frameTimer = '..opponentLastTimer[d]..';');
        
        -- Character Animation Fix: Force holdTimer to 0 so the opponent plays the sing anim once and stops
        setProperty('dad.holdTimer', 0);
    end
end

function onUpdate(elapsed)
    for i = 0, 3 do
        if getPropertyFromGroup('playerStrums', i, 'animation.curAnim.name') == 'confirm' then
            playerLastFrame[i] = getPropertyFromGroup('playerStrums', i, 'animation.curAnim.curFrame');
            
            -- Safely get the hidden _frameTimer value
            local timerVal = runHaxeCode('return game.playerStrums.members['..i..'].animation.curAnim._frameTimer;');
            if timerVal ~= nil then
                playerLastTimer[i] = tonumber(tostring(timerVal)) or 0.0;
            else
                playerLastTimer[i] = 0.0;
            end
        else
            playerLastFrame[i] = 0;
            playerLastTimer[i] = 0.0;
        end

        if getPropertyFromGroup('opponentStrums', i, 'animation.curAnim.name') == 'confirm' then
            opponentLastFrame[i] = getPropertyFromGroup('opponentStrums', i, 'animation.curAnim.curFrame');
            
            local timerVal = runHaxeCode('return game.opponentStrums.members['..i..'].animation.curAnim._frameTimer;');
            if timerVal ~= nil then
                opponentLastTimer[i] = tonumber(tostring(timerVal)) or 0.0;
            else
                opponentLastTimer[i] = 0.0;
            end
        else
            opponentLastFrame[i] = 0;
            opponentLastTimer[i] = 0.0;
        end
    end
end

function onUpdatePost(e)
    for i = 0, 3 do
        local name = getPropertyFromGroup('playerStrums', i, 'animation.curAnim.name');
        local finished = getPropertyFromGroup('playerStrums', i, 'animation.finished');

        if name == 'confirm' then
            pressedAnimTimer[i] = pressedAnimTimer[i] + (e * 1000);
        else
            pressedAnimTimer[i] = 0.0;
        end
        
        -- Transition to 'pressed' animation (Replaced callMethod with runHaxeCode)
        if finished and pressedAnimTimer[i] >= (stepCrochet + (1000/12)) then
            runHaxeCode('game.playerStrums.members['..i..'].playAnim("pressed", false);');
            pressedAnimTimer[i] = 0.0;
        end
    end
end