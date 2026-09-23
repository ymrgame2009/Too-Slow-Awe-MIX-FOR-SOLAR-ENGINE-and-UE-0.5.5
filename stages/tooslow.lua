local xx = 325; --400
local yy = 1375; --1375
local xx2 = 325; --1500
local yy2 = 1375; --750
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;
local damage = false;
local beating = false;
local beat_skip = 0;
local tp = false;
local tspeed = 0.5;
local screenshake = false;
local beep = false;
local beepchance = 0;
local maxchance = 22;
local lockscreen = false;
local lockx = 0;
local locky = 0;
local lockzoom = 1;
local angleshit = 0.55;
local anglevar = 0.55;

function onCreate()
	setProperty('skipCountdown', true)
	
end


function onCreatePost()
	
    setProperty('gf.alpha', 0);
	setProperty('boyfriend.alpha', 0);
	setProperty('camHUD.alpha', 0);
	
	triggerEvent('Camera Follow Pos',xx,yy)
	setProperty('camFollowPos.x',xx)
    setProperty('camFollowPos.y',yy)
	
	makeLuaSprite('sky','BG/sonic/tooslow/sky', -1200, -750)
	addLuaSprite('sky')
	setScrollFactor('sky', 0, 0);
	scaleObject('sky', 0.75, 0.75);

    makeLuaSprite('tree','BG/sonic/tooslow/tree', -900, -350)
	addLuaSprite('tree')
	setScrollFactor('tree', 0.45, 0.45);
	scaleObject('tree', 0.75, 0.75);
   
    makeLuaSprite('grass2','BG/sonic/tooslow/grass2', -1800, -450)
	addLuaSprite('grass2')
	setScrollFactor('grass2', 0.9, 0.9);

	makeLuaSprite('grass1','BG/sonic/tooslow/grass1', -1800, -450)
	addLuaSprite('grass1')
	
	makeAnimatedLuaSprite('faceglitch1','BG/sonic/tooslow/faceglitch', 70, 950);
		addAnimationByPrefix('faceglitch1', 'loop', '1_glitch', 24, true);
	addLuaSprite('faceglitch1')
	
	makeAnimatedLuaSprite('faceglitch2','BG/sonic/tooslow/faceglitch', -500, 850);
		addAnimationByPrefix('faceglitch2', 'loop', '2_glitch', 24, true);
	addLuaSprite('faceglitch2')
	
	makeLuaSprite('overlay2','BG/sonic/tooslow/overlay2', -680, 55)
	addLuaSprite('overlay2', true)
	setScrollFactor('overlay2', 0.2, 0.2);
	scaleObject('overlay2', 2, 2);
	
	makeLuaSprite('omgtoobrightbg','flashwhite', -1800, -450)
	addLuaSprite('omgtoobrightbg')
	scaleObject('omgtoobrightbg', 5, 5);
	setProperty('omgtoobrightbg.alpha', 0);
	
	setProperty('sky.alpha', 0);
	setProperty('tree.alpha', 0);
	setProperty('grass1.alpha', 0);
	setProperty('faceglitch1.alpha', 0);
	setProperty('grass2.alpha', 0);
	setProperty('faceglitch2.alpha', 0);
	setProperty('overlay2.alpha', 0);

	
	makeLuaSprite('light','BG/sonic/tooslow/light', -1800, -450)
	addLuaSprite('light', true)
	setBlendMode('light', 'add')
	
	
	
	makeLuaSprite('DS','DarkSC', 0, 0)
	addLuaSprite('DS')
	setObjectCamera('DS', 'other')
	
	makeAnimatedLuaSprite('jumpscare','BG/sonic/tooslow/jumpscare', -550, -350);
		addAnimationByPrefix('jumpscare', 'loop', 'jumpscare', 24, false);
	addLuaSprite('jumpscare', true)
	setObjectCamera('jumpscare', 'other');
	scaleObject('jumpscare',1,1)
	setProperty('jumpscare.alpha', 0);
	

	-----------------------------------------
	
	makeAnimatedLuaSprite('beeep','BG/sonic/daSTAT', 0, 0);
		addAnimationByPrefix('beeep', 'loop', 'staticFLASH', 24, true);
	setObjectCamera('beeep', 'other');
	setProperty('beeep.alpha', 0);
	scaleObject('beeep',4,3)
	addLuaSprite('beeep')
	
	makeLuaSprite('darkflash','Flash', 0, 0)
	makeLuaSprite('flashwhite','flashwhite', 0, 0)
	
	makeLuaSprite('csdown','cutscene1', 0, 0)
	makeLuaSprite('csup','cutscene2', 0, 0)
	
	makeLuaSprite('playwithme','BG/sonic/tooslow/playwithme', 0, 0)
	setProperty('playwithme.alpha', 0);
	setObjectCamera('playwithme', 'other');
	
	makeLuaSprite('cutscene1','BG/sonic/tooslow/cutscene1', 0, 0)
	setProperty('cutscene1.alpha', 0);
	setObjectCamera('cutscene1', 'other');
	
	makeLuaSprite('cutscene2','BG/sonic/tooslow/cutscene2', 0, 0)
	setProperty('cutscene2.alpha', 0);
	setObjectCamera('cutscene2', 'other');
	
	makeLuaSprite('cutscene3','BG/sonic/tooslow/cutscene3', 0, 0)
	setProperty('cutscene3.alpha', 0);
	setObjectCamera('cutscene3', 'other');
	
	setProperty('darkflash.alpha', 1);
	setObjectCamera('darkflash', 'other');
	setProperty('flashwhite.alpha', 0);
	setObjectCamera('flashwhite', 'other');
	
	setProperty('csup.alpha', 1);
	setObjectCamera('csup', 'other');
	setProperty('csdown.alpha', 1);
	setObjectCamera('csdown', 'other');
	
	addLuaSprite('darkflash')
	addLuaSprite('flashwhite')
	addLuaSprite('csup')
	addLuaSprite('csdown')
	
	addLuaSprite('cutscene1')
	addLuaSprite('cutscene2')
	addLuaSprite('cutscene3')
	addLuaSprite('playwithme')
	
	addCharacterToList('sonicexe')
	addCharacterToList('sonicexe-alt')
	addCharacterToList('sonic_cutscene')
end

function onBeatHit()
    if curBeat > 152 and curBeat < 157 or curBeat > 160 and curBeat < 165 or curBeat > 176 and curBeat < 191 or curBeat > 193 and curBeat < 207 or curBeat > 244 and curBeat < 271 or curBeat > 308 and curBeat < 322 or curBeat > 325 and curBeat < 337 or curBeat > 339 and curBeat < 355 or curBeat > 357 and curBeat < 369 or curBeat > 419 and curBeat < 515 then

		if curBeat % 2 == 0 then
			angleshit = anglevar;
		else
			angleshit = -anglevar;
		end
		setProperty('camHUD.angle',angleshit*3)
		setProperty('camGame.angle',angleshit*3)
		doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.002, 'circOut')
		doTweenX('tuin', 'camHUD', -angleshit*8, crochet*0.001, 'linear')
		doTweenAngle('tt', 'camGame', angleshit, stepCrochet*0.002, 'circOut')
		doTweenX('ttrn', 'camGame', -angleshit*8, crochet*0.001, 'linear')
	else
		setProperty('camHUD.angle',0)
		setProperty('camHUD.x',0)
		setProperty('camHUD.x',0)
	end
end

function onStepHit()

    beepchance = getRandomInt(1, maxchance);
	if beepchance == 1 and beep == true then
	beep = false;
	setProperty('beeep.alpha', 0.25);
	runTimer('beepwait', 0.175);
	playSound('staticBUZZ', 1.35)
    end
	
    if curStep == 672 or curStep == 1104 or curStep == 1480 or curStep == 2032 then
	cuton();
	maxchance = 99999;
	end
	if curStep == 1 or curStep == 704 or curStep == 1232 or curStep == 1680 then
	cutoff();
	maxchance = 22;
	end
    if curStep == 128 or curStep == 543 or curStep == 704 or curStep == 772 or curStep == 912 or curStep == 1936 or curStep == 2063 then
	flash();
	end
	if curStep == 1680 or curStep == 9999 then
	flashdark();
	end
	if curStep == 1480 or curStep == 2032 then
	xx = 170;
    xx2 = 170; 
	end
	if curStep == 1680 or curStep == 9999 then
	xx = -100
	xx2 = 355
	triggerEvent('Camera Follow Pos',xx,yy)
	end
	if curStep == 9999 or curStep == 9999 then
	beating = true;
	end
	if curStep == 9999 or curStep == 9999 then
	beating = false;
	end
	----
	if curStep == 16 then
	setProperty('cutscene1.alpha', 1);
	doTweenAlpha('coot1', 'cutscene1', 0, 3, 'linear');
	end
	if curStep == 48 then
	setProperty('cutscene2.alpha', 1);
	doTweenAlpha('coot2', 'cutscene2', 0, 3, 'linear');
	end
	if curStep == 80 then
	setProperty('cutscene3.alpha', 1);
	doTweenAlpha('coot3', 'cutscene3', 0.3, 4, 'linear');
	end
	if curStep == 112 then
	setProperty('cutscene3.alpha', 0);
	end
	if curStep == 120 then
	doTweenAlpha('flashdowndark', 'darkflash', 0, 3, 'linear');
	end
	if curStep == 128 then
	doTweenAlpha('starthudfade', 'camHUD', 1, 1, 'linear');
	end
	if curStep == 672 or curStep == 2063 then
	doTweenAlpha('hudfade1', 'camHUD', 0, 1, 'linear');
	end
	if curStep == 512 then
	doTweenAlpha('PLAYWITHMEFUCKER', 'playwithme', 1, 1.75, 'linear');
	setProperty('darkflash.alpha', 1);
	setProperty('DS.alpha', 0);
	triggerEvent('Change Character',1,'sonicexe')
	xx = -100
	xx2 = 355
	setProperty('camFollowPos.x',xx)
    setProperty('camFollowPos.y',yy)
	setCharacterX('dad', -500);
	end
	if curStep == 543 then
	setProperty('darkflash.alpha', 0);
	beep = true;
	setProperty('playwithme.alpha', 0);
	setProperty('gf.alpha', 1);
	setProperty('boyfriend.alpha', 1);
	setProperty('sky.alpha', 1);
	setProperty('tree.alpha', 1);
	setProperty('grass1.alpha', 1);
	setProperty('faceglitch1.alpha', 1);
	setProperty('grass2.alpha', 1);
	setProperty('faceglitch2.alpha', 1);
	setProperty('overlay2.alpha', 1);
	end
	if curStep == 704 or curStep == 1488 then
	setProperty('camHUD.alpha', 1);
	end
	if curStep == 1104 then
	doTweenAlpha('cutscenefade', 'camHUD', 0, 1, 'linear');
	end
	if curStep == 1232 then
	doTweenAlpha('cutscenefadeoff', 'camHUD', 1, 0.5, 'linear');
	end
	if curStep == 1088 or curStep == 896 or curStep == 1203 or curStep == 1920 then
	triggerEvent('Camera Follow Pos',xx,yy)
	end
	if curStep == 1194 or curStep == 1296 then
	triggerEvent('Camera Follow Pos',xx2,yy2)
	end
	if curStep == 1480 then
	doTweenAlpha('omgtoobright', 'camHUD', 0.5, 0.5, 'linear');
	doTweenAlpha('overlay2', 'overlay2', 0, 1, 'linear');
	doTweenAlpha('ohmyfuckingeyes', 'omgtoobrightbg', 1, 1, 'linear');
	doTweenColor('sonicdark', 'dad', '000000', 1, 'linear')
	doTweenColor('gf', 'gf', '000000', 1, 'linear')
	doTweenColor('boyfriend', 'boyfriend', '000000', 1, 'linear')
	end
	if curStep == 1680 then
	lockscreen = false;
	followchars = true;
	doTweenAlpha('ohmyfuckingeyes', 'omgtoobrightbg', 0, 0.01, 'linear');
	doTweenAlpha('overlay2', 'overlay2', 1, 0.01, 'linear');
	doTweenColor('sonicdark', 'dad', 'FFFFFF', 0.01, 'linear')
	doTweenColor('gf', 'gf', 'FFFFFF', 0.01, 'linear')
	doTweenColor('boyfriend', 'boyfriend', 'FFFFFF', 0.01, 'linear')
	end
	if curStep == 1360 then
	playAnim('jumpscare','loop', true);
	setProperty('jumpscare.alpha', 1);
	runTimer('jumpsoundwait', 0.2);
	end
	if curStep == 2096 then
	setProperty('darkflash.alpha', 1);
	end
	if curStep == 1648 or curStep == 2000 then
	lockscreen = true;
	followchars = false;
	lockx = -150
	locky = 1425
	lockzoom = 1.1
	end
	if curStep == 1654 or curStep == 2008 or curStep == 2024 then
	lockx = 400
	locky = 1425
	end
	if curStep == 1658 or curStep == 2016 then
	lockx = -150
	locky = 1425
	end
	if curStep == 1662 then
	lockx = 125
	locky = 1325
	lockzoom = 0.7
	end
	if curStep == 2032 then
	lockscreen = false;
	followchars = true;
	end
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'jumpsoundwait' then
	playSound('datOneSound', 0.75)
	playSound('jumpscare', 0.75)
	end
	if tag == 'beepwait' then
	beep = true;
	setProperty('beeep.alpha', 0);
	end
end


function onUpdate()
	
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
	
	if lockscreen == true then
	setProperty('camFollowPos.x',lockx)
    setProperty('camFollowPos.y',locky)
	setProperty('camGame.zoom',lockzoom)
	end
	
    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
			if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
			end

        else

            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
			end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    
end


function flash()
    setProperty('flashwhite.alpha', 1);
	doTweenAlpha('flashdown', 'flashwhite', 0, 0.5, 'linear');
end

function flashdark()
    setProperty('darkflash.alpha', 1);
	doTweenAlpha('flashdowndark', 'darkflash', 0, 3, 'linear');
end

function introflash()
    setProperty('darkflash.alpha', 0);
	doTweenAlpha('beepflash', 'darkflash', 1, 0.1, 'linear');
end

function introflash2()
    setProperty('darkflash.alpha', 1);
	doTweenAlpha('beepflash2', 'darkflash', 0, 0.1, 'linear');
end

function cuton()
    doTweenY('CSUPY', 'csup', 0, 1, 'CircInOut');
    doTweenY('SCDOWNY', 'csdown', 0, 1, 'CircInOut');
end

function cutoff()
    doTweenY('CSUPYend', 'csup', -100, 1, 'CircInOut');
    doTweenY('SCDOWNYend', 'csdown', 100, 1, 'CircInOut');
end

function opponentNoteHit()
    if screenshake == true then
        triggerEvent('Screen Shake','0.02, 0.01','0.1, 0.0075');
	end
	
    health = getProperty('health')
        if getProperty('health') > 0.4 then
            setProperty('health', health- 0.02);
		end
    end