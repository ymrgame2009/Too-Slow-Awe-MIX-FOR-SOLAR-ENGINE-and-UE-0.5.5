local choose=1
local nomoresanbs=false
local countdown=-1
local counting=false
local more=false
function destory()
	counting=true
	runTimer('startcountdowntime',0.6)
	closeCustomSubstate()
	doTweenAlpha('pauseBgAlpha','pauseBg',0,1.8)
	doTweenAlpha('pausetextAlpha1','pausetext1',0,0.5,'quartout')
	doTweenAlpha('pausetextAlpha2','pausetext2',0,0.5,'quartout')
	doTweenAlpha('pausetextAlpha3','pausetext3',0,0.5,'quartout')
	doTweenAlpha('pausetextAlpha4','pausetext4',0,0.5,'quartout')
	doTweenAlpha('logoAlpha','logo',0,0.5,'quartout')
	doTweenX('boxupX','boxup',-1000,0.5,'circIn')
	doTweenX('boxdownX','boxdown',1000,0.5,'circIn')
	--doTweenAlpha('soulAlpha','soul-pause',0,0.5,'quartout')
	--doTweenX('sanb?','random???'..randomsanbCount,-1000,1,'circIn')
	--doTweenX('sanb','randomsanb'..randomsanbCount,-1000,1,'circIn')
	runHaxeCode([[
		var video = getVar('video');
		game.getLuaObject('videoSprite').loadGraphic(video.bitmapData);
		video.pause();
	]])
	doTweenAlpha('songAlpha','song',0,0.5,'quartout')
	doTweenAlpha('botplayAlpha','botplaytext',0,0.5,'quartout')
	doTweenAlpha('timeTextAlpha','timeText',0,0.5,'quartout')
	doTweenAlpha('practicetextAlpha','practicetext',0,0.5,'quartout')
	doTweenAlpha('deathAlpha','death',0,0.5,'quartout')
	doTweenAlpha('difficultyAlpha','difficulty',0,0.5,'quartout')
end
function randomsanbsappear()
	if nomoresanbs then
		setProperty('random???'..randomsanbCount..'.alpha',1)
		doTweenX('sanb?','random???'..randomsanbCount,0,1,'circOut')
		nomoresanbs=false
	else
		setProperty('randomsanb'..randomsanbCount..'.alpha',1)
		doTweenX('sanb','randomsanb'..randomsanbCount,0,1,'circOut')
	end
end
function moresettings()
	cancelTween('pausetextAlpha1')
	cancelTween('pausetextAlpha2')
	cancelTween('pausetextAlpha3')
	cancelTween('pausetextAlpha4')
	if more then
		setProperty('pausetext1.alpha',1)
		setProperty('pausetext2.alpha',1)
		setProperty('pausetext3.alpha',1)
		setProperty('pausetext4.alpha',1)
		setProperty('moretext1.alpha',0)
		setProperty('moretext2.alpha',0)
		setProperty('moretext3.alpha',0)
		setProperty('moretext4.alpha',0)
		more=false
	else
		setProperty('pausetext1.alpha',0)
		setProperty('pausetext2.alpha',0)
		setProperty('pausetext3.alpha',0)
		setProperty('pausetext4.alpha',0)
		setProperty('moretext1.alpha',1)
		setProperty('moretext2.alpha',1)
		setProperty('moretext3.alpha',1)
		setProperty('moretext4.alpha',1)
		more=true
	end
end
function transpractice()
	if practice then
		setProperty('practiceMode',false)
		setTextString('moretext1','Practice Mode ：Off')
		practice=false
	else
		setProperty('practiceMode',true)
		setTextString('moretext1','Practice Mode ：On')
		practice=true
	end
end
function transbot()
	if botPlay then
		setProperty('cpuControlled',false)
		setTextString('moretext2','Bot Play ：Off')
		botPlay=false
	else
		setProperty('cpuControlled',true)
		setTextString('moretext2','Bot Play ：On')
		botPlay=true
	end
end
function onPause()
	if counting then
		cameraShake('camGame',0.008,0.1)
		cameraShake('camHUD',0.008,0.1)
		--playSound('hurt',1)
	else
		if songName~='start' and songName~='shop' and songName~='gallery' then
			openCustomSubstate('pause',true)
		end
	end
	setPropertyFromClass('flixel.FlxG','mouse.visible',true)
	curSongPos=getPropertyFromClass('Conductor','songPosition')
	return Function_Stop
end
function onCreate()
	setPropertyFromClass('lime.app.Application','current.window.title','Friday Night Funkin\': Vs Sonic.EXE')

	makeLuaSprite('pauseBg',nil,0,0)
	makeGraphic('pauseBg',1280,720,'000000')
	addLuaSprite('pauseBg',true)
	setObjectCamera('pauseBg','other')
	setObjectOrder('pauseBg',1145)
	setProperty('pauseBg.alpha',0)

	makeLuaSprite('logo','pause/logo',0,0)
	addLuaSprite('logo',true)
	setObjectCamera('logo','other')
	setObjectOrder('logo',1146)
	setProperty('logo.alpha',0)

	makeLuaSprite('boxup','pause/boxup',-1000,0)
	addLuaSprite('boxup',true)
	setObjectCamera('boxup','other')
	setObjectOrder('boxup',1147)

	makeLuaSprite('boxdown','pause/boxdown',1000,0)
	addLuaSprite('boxdown',true)
	setObjectCamera('boxdown','other')
	setObjectOrder('boxdown',1148)

	--[[makeLuaSprite('soul-pause','pause/soul',510,114514)
	addLuaSprite('soul-pause',true)
	setProperty('soul-pause.color',getColorFromHex('FF0000'))
	scaleObject('soul-pause',2.5,2.5)
	setObjectOrder('soul-pause',114514)
	setObjectCamera('soul-pause','other')
	setProperty('soul-pause.alpha',0)
	setProperty('soul-pause.antialiasing',false)]]

	makeLuaText('pausetext1','Resume',1280,0,250)
	setObjectCamera('pausetext1','other')
	addLuaText('pausetext1')
	setTextBorder('pausetext1',1,'000000')
	setTextSize('pausetext1',36)
	setTextFont('pausetext1','text.ttf')
	setProperty('pausetext1.alpha',0)
	setObjectOrder('pausetext1',1150)

	makeLuaText('pausetext2','Restart Song',1280,0,300)
	setObjectCamera('pausetext2','other')
	addLuaText('pausetext2')
	setTextBorder('pausetext2',1,'000000')
	setTextSize('pausetext2',36)
	setTextFont('pausetext2','text.ttf')
	setProperty('pausetext2.alpha',0)
	setObjectOrder('pausetext2',1151)

	makeLuaText('pausetext3','Game Options',1280,0,350)
	setObjectCamera('pausetext3','other')
	addLuaText('pausetext3')
	setTextBorder('pausetext3',1,'000000')
	setTextSize('pausetext3',36)
	setTextFont('pausetext3','text.ttf')
	setProperty('pausetext3.alpha',0)
	setObjectOrder('pausetext3',1152)

	makeLuaText('pausetext4','Exit',1280,0,400)
	setObjectCamera('pausetext4','other')
	addLuaText('pausetext4')
	setTextBorder('pausetext4',1,'000000')
	setTextSize('pausetext4',36)
	setTextFont('pausetext4','text.ttf')
	setProperty('pausetext4.alpha',0)
	setObjectOrder('pausetext4',1153)

	makeLuaSprite('intro1','ready',240,178)
	setObjectCamera('intro1','other')
	addLuaSprite('intro1',true)
	setProperty('intro1.alpha',0)
	setObjectOrder('intro1',1154)

	makeLuaSprite('intro2','set',240,178)
	setObjectCamera('intro2','other')
	addLuaSprite('intro2',true)
	setProperty('intro2.alpha',0)
	setObjectOrder('intro2',1155)

	makeLuaSprite('intro3','go',240,178)
	setObjectCamera('intro3','other')
	addLuaSprite('intro3',true)
	setProperty('intro3.alpha',0)
	setObjectOrder('intro3',1156)

	makeLuaText('moretext1','Practice Mod ：Off',1280,0,250)
	setObjectCamera('moretext1','other')
	addLuaText('moretext1')
	setTextBorder('moretext1',1,'000000')
	setTextSize('moretext1',36)
	setTextFont('moretext1','text.ttf')
	setProperty('moretext1.alpha',0)
	setObjectOrder('moretext1',1157)
	if practice then
		setTextString('moretext1','Practice Mod ：On')
	end

	makeLuaText('moretext2','Bot Play ：Off',1280,0,300)
	setObjectCamera('moretext2','other')
	addLuaText('moretext2')
	setTextBorder('moretext2',1,'000000')
	setTextSize('moretext2',36)
	setTextFont('moretext2','text.ttf')
	setProperty('moretext2.alpha',0)
	setObjectOrder('moretext2',1158)
	if botPlay then
		setTextString('moretext2','Bot Play ：On')
	end

	makeLuaText('moretext3','Chart Editor',1280,0,350)
	setObjectCamera('moretext3','other')
	addLuaText('moretext3')
	setTextBorder('moretext3',1,'000000')
	setTextSize('moretext3',36)
	setTextFont('moretext3','text.ttf')
	setProperty('moretext3.alpha',0)
	setObjectOrder('moretext3',1159)

	makeLuaText('moretext4','Back',1280,0,400)
	setObjectCamera('moretext4','other')
	addLuaText('moretext4')
	setTextBorder('moretext4',1,'000000')
	setTextSize('moretext4',36)
	setTextFont('moretext4','text.ttf')
	setProperty('moretext4.alpha',0)
	setObjectOrder('moretext4',1160)

	--[[makeLuaSprite('randomsanb1','pause/randomsanbs/埃及伊爱慕',-1000,0)
	addLuaSprite('randomsanb1',true)
	setObjectCamera('randomsanb1','other')
	setObjectOrder('randomsanb1',11451)
	setProperty('randomsanb1.alpha',0)
	setProperty('randomsanb1.antialiasing',false)

	makeLuaSprite('randomsanb2','pause/randomsanbs/艾福艾福踢必欧',-1000,0)
	addLuaSprite('randomsanb2',true)
	setObjectCamera('randomsanb2','other')
	setObjectOrder('randomsanb2',11452)
	setProperty('randomsanb2.alpha',0)
	setProperty('randomsanb2.antialiasing',false)

	makeLuaSprite('randomsanb3','pause/randomsanbs/爱那卧',-1000,0)
	addLuaSprite('randomsanb3',true)
	setObjectCamera('randomsanb3','other')
	setObjectOrder('randomsanb3',11453)
	setProperty('randomsanb3.alpha',0)
	setProperty('randomsanb3.antialiasing',false)

	makeLuaSprite('randomsanb4','pause/randomsanbs/不信你了',-1000,0)
	addLuaSprite('randomsanb4',true)
	setObjectCamera('randomsanb4','other')
	setObjectOrder('randomsanb4',11454)
	setProperty('randomsanb4.alpha',0)
	setProperty('randomsanb4.antialiasing',false)

	makeLuaSprite('randomsanb5','pause/randomsanbs/高个子山羊和新蓝僵尸',-1000,0)
	addLuaSprite('randomsanb5',true)
	setObjectCamera('randomsanb5','other')
	setObjectOrder('randomsanb5',11455)
	setProperty('randomsanb5.alpha',0)
	setProperty('randomsanb5.antialiasing',false)

	makeLuaSprite('randomsanb6','pause/randomsanbs/贵州鱼王',-1000,0)
	addLuaSprite('randomsanb6',true)
	setObjectCamera('randomsanb6','other')
	setObjectOrder('randomsanb6',11456)
	setProperty('randomsanb6.alpha',0)
	setProperty('randomsanb6.antialiasing',false)

	makeLuaSprite('randomsanb7','pause/randomsanbs/哈德莫德',-1000,0)
	addLuaSprite('randomsanb7',true)
	setObjectCamera('randomsanb7','other')
	setObjectOrder('randomsanb7',11457)
	setProperty('randomsanb7.alpha',0)
	setProperty('randomsanb7.antialiasing',false)

	makeLuaSprite('randomsanb8','pause/randomsanbs/厚肉',-1000,0)
	addLuaSprite('randomsanb8',true)
	setObjectCamera('randomsanb8','other')
	setObjectOrder('randomsanb8',11458)
	setProperty('randomsanb8.alpha',0)
	setProperty('randomsanb8.antialiasing',false)

	makeLuaSprite('randomsanb9','pause/randomsanbs/可乐',-1000,0)
	addLuaSprite('randomsanb9',true)
	setObjectCamera('randomsanb9','other')
	setObjectOrder('randomsanb9',11459)
	setProperty('randomsanb9.antialiasing',false)

	makeLuaSprite('randomsanb10','pause/randomsanbs/六根sanb',-1000,0)
	addLuaSprite('randomsanb10',true)
	setObjectCamera('randomsanb10','other')
	setObjectOrder('randomsanb10',11460)
	setProperty('randomsanb10.alpha',0)
	setProperty('randomsanb10.antialiasing',false)

	makeLuaSprite('randomsanb11','pause/randomsanbs/螺母遮',-1000,0)
	addLuaSprite('randomsanb11',true)
	setObjectCamera('randomsanb11','other')
	setObjectOrder('randomsanb11',11461)
	setProperty('randomsanb11.alpha',0)
	setProperty('randomsanb11.antialiasing',false)

	makeLuaSprite('randomsanb12','pause/randomsanbs/末二得',-1000,0)
	addLuaSprite('randomsanb12',true)
	setObjectCamera('randomsanb12','other')
	setObjectOrder('randomsanb12',11462)
	setProperty('randomsanb12.alpha',0)
	setProperty('randomsanb12.antialiasing',false)

	makeLuaSprite('randomsanb13','pause/randomsanbs/牛逼旧事煮',-1000,0)
	addLuaSprite('randomsanb13',true)
	setObjectCamera('randomsanb13','other')
	setObjectOrder('randomsanb13',11463)
	setProperty('randomsanb13.alpha',0)
	setProperty('randomsanb13.antialiasing',false)

	makeLuaSprite('randomsanb14','pause/randomsanbs/牛逼螺母遮',-1000,0)
	addLuaSprite('randomsanb14',true)
	setObjectCamera('randomsanb14','other')
	setObjectOrder('randomsanb14',11464)
	setProperty('randomsanb14.alpha',0)
	setProperty('randomsanb14.antialiasing',false)

	makeLuaSprite('randomsanb15','pause/randomsanbs/牛逼虾仁膜',-1000,0)
	addLuaSprite('randomsanb15',true)
	setObjectCamera('randomsanb15','other')
	setObjectOrder('randomsanb15',11465)
	setProperty('randomsanb15.alpha',0)
	setProperty('randomsanb15.antialiasing',false)

	makeLuaSprite('randomsanb16','pause/randomsanbs/星期二',-1000,0)
	addLuaSprite('randomsanb16',true)
	setObjectCamera('randomsanb16','other')
	setObjectOrder('randomsanb16',11466)
	setProperty('randomsanb16.alpha',0)
	setProperty('randomsanb16.antialiasing',false)

	makeLuaSprite('randomsanb17','pause/randomsanbs/虚哥招呼俺',-1000,0)
	addLuaSprite('randomsanb17',true)
	setObjectCamera('randomsanb17','other')
	setObjectOrder('randomsanb17',11467)
	setProperty('randomsanb17.alpha',0)
	setProperty('randomsanb17.antialiasing',false)

	makeLuaSprite('randomsanb18','pause/randomsanbs/因三体',-1000,0)
	addLuaSprite('randomsanb18',true)
	setObjectCamera('randomsanb18','other')
	setObjectOrder('randomsanb18',11468)
	setProperty('randomsanb18.alpha',0)
	setProperty('randomsanb18.antialiasing',false)

	makeLuaSprite('randomsanb19','pause/randomsanbs/游乐比',-1000,0)
	addLuaSprite('randomsanb19',true)
	setObjectCamera('randomsanb19','other')
	setObjectOrder('randomsanb19',11469)
	setProperty('randomsanb19.alpha',0)
	setProperty('randomsanb19.antialiasing',false)

	makeLuaSprite('randomsanb20','pause/randomsanbs/有科比',-1000,0)
	addLuaSprite('randomsanb20',true)
	setObjectCamera('randomsanb20','other')
	setObjectOrder('randomsanb20',11470)
	setProperty('randomsanb20.alpha',0)
	setProperty('randomsanb20.antialiasing',false)

	makeLuaSprite('randomsanb21','pause/randomsanbs/右臂',-1000,0)
	addLuaSprite('randomsanb21',true)
	setObjectCamera('randomsanb21','other')
	setObjectOrder('randomsanb21',11471)
	setProperty('randomsanb21.alpha',0)
	setProperty('randomsanb21.antialiasing',false)

	makeLuaSprite('randomsanb22','pause/randomsanbs/鱼雷',-1000,0)
	addLuaSprite('randomsanb22',true)
	setObjectCamera('randomsanb22','other')
	setObjectOrder('randomsanb22',11472)
	setProperty('randomsanb22.alpha',0)
	setProperty('randomsanb22.antialiasing',false)

	makeLuaSprite('random???1','pause/randomsanbs/不正经的/666这是什么',-1000,0)
	addLuaSprite('random???1',true)
	setObjectCamera('random???1','other')
	setObjectOrder('random???1',114514)
	setProperty('random???1.alpha',0)

	makeLuaSprite('random???2','pause/randomsanbs/不正经的/哎哟我去这么师',-1000,0)
	addLuaSprite('random???2',true)
	setObjectCamera('random???2','other')
	setObjectOrder('random???2',114515)
	setProperty('random???2.alpha',0)

	makeLuaSprite('random???3','pause/randomsanbs/不正经的/句吗',-1000,0)
	addLuaSprite('random???3',true)
	setObjectCamera('random???3','other')
	setObjectOrder('random???3',114516)
	setProperty('random???3.alpha',0)

	makeLuaSprite('random???4','pause/randomsanbs/不正经的/我真的变成sanb了吗',-1000,0)
	addLuaSprite('random???4',true)
	setObjectCamera('random???4','other')
	setObjectOrder('random???4',114516)
	setProperty('random???4.alpha',0)

	makeLuaSprite('random???5','pause/randomsanbs/不正经的/一看就很牛逼',-1000,0)
	addLuaSprite('random???5',true)
	setObjectCamera('random???5','other')
	setObjectOrder('random???5',114517)
	setProperty('random???5.alpha',0)

	makeLuaSprite('random???6','pause/randomsanbs/不正经的/这位更是牛逼',-1000,0)
	addLuaSprite('random???6',true)
	setObjectCamera('random???6','other')
	setObjectOrder('random???6',114518)
	setProperty('random???6.alpha',0)]]

	makeLuaText('song','Song: ' .. songName,1000,270,0)
	addLuaText('song')
	setObjectCamera('song','other')
	setObjectOrder('song',getObjectOrder('boxup')+1)
	setTextSize('song',30)
	setTextFont('song', 'Chinese.ttf')
	setProperty('song.alpha',0)
	setTextAlignment('song', 'right')
	
	makeLuaText('difficulty',difficultyName,1000,270,35)
	addLuaText('difficulty')
	setObjectCamera('difficulty','other')
	setObjectOrder('difficulty',getObjectOrder('boxup')+1)
	setTextSize('difficulty',30)
	setTextFont('difficulty', 'Chinese.ttf')
	setProperty('difficulty.alpha',0)
	setTextAlignment('difficulty', 'right')

	if version <= '0.7' then
		makeLuaText('death','Death:' .. getPropertyFromClass('PlayState', 'deathCounter'),1000,270,70)
		addLuaText('death')
		setObjectOrder('death',getObjectOrder('boxup')+1)
		setObjectCamera('death','other')
		setTextSize('death',30)
		setTextFont('death', 'Chinese.ttf')
		setProperty('death.alpha',0)
		setTextAlignment('death', 'right')
		elseif version >= '0.7' then
		makeLuaText('death','Death:' .. getPropertyFromClass('states.PlayState', 'deathCounter'),1000,270,70)
		addLuaText('death')
		setObjectOrder('death',getObjectOrder('boxup')+1)
		setObjectCamera('death','other')
		setTextSize('death',30)
		setTextFont('death', 'Chinese.ttf')
		setProperty('death.alpha',0)
		setTextAlignment('death', 'right')
	end

	makeLuaText('botplaytext','Bot Play',1000,270,105)
	addLuaText('botplaytext')
	setObjectOrder('botplaytext',getObjectOrder('boxup')+1)
	setObjectCamera('botplaytext','other')
	setTextSize('botplaytext',30)
	setTextFont('botplaytext', 'Chinese.ttf')
	setProperty('botplaytext.alpha',0)
	setTextAlignment('botplaytext', 'right')

	makeLuaText('practicetext','Practice Mod',1000,270,140)
	addLuaText('practicetext')
	setObjectOrder('practicetext',getObjectOrder('boxup')+1)
	setObjectCamera('practicetext','other')
	setTextSize('practicetext',30)
	setTextFont('practicetext', 'Chinese.ttf')
	setProperty('practicetext.alpha',0)
	setTextAlignment('practicetext', 'right')

	makeLuaText('timeText','Time',1000,0,0)
	addLuaText('timeText')
	setObjectOrder('timeText',getObjectOrder('boxup')+1)
	setObjectCamera('timeText','other')
	setTextSize('timeText',30)
	setTextFont('timeText', 'Chinese.ttf')
	setProperty('timeText.alpha',0)
	setTextAlignment('timeText', 'left')
end
function onCustomSubstateCreate(name)
	doTweenAngle('logoAngle','logo',0.3,1.5,'sineInOut')
	doTweenAngle('boxupAngle','boxup',0.3,1.5,'sineInOut')
	doTweenAngle('boxdownAngle','boxdown',0.3,1.5,'sineInOut')

	doTweenAlpha('timeTextAlpha','timeText',1,0.5,'quartout')
	doTweenAlpha('deathAlpha','death',1,0.5,'quartout')
		doTweenAlpha('songAlpha','song',1,0.5,'quartout')
		doTweenAlpha('difficultyAlpha','difficulty',1,0.5,'quartout')
		doTweenAlpha('botplayAlpha','botplaytext',1,0.5,'quartout')
		doTweenAlpha('practicetextAlpha','practicetext',1,0.5,'quartout')
	if name == 'pause' then
		if randomsanbCount==23 then
			nomoresanbs=true
			randomsanbCount=math.random(1,6)
		end
		randomsanbsappear()
		doTweenAlpha('pauseBgAlpha','pauseBg',0.5,0.5,'quartout')
		doTweenAlpha('pausetextAlpha1','pausetext1',1,0.5,'quartout')
		doTweenAlpha('pausetextAlpha2','pausetext2',1,0.5,'quartout')
		doTweenAlpha('pausetextAlpha3','pausetext3',1,0.5,'quartout')
		doTweenAlpha('pausetextAlpha4','pausetext4',1,0.5,'quartout')
		doTweenAlpha('logoAlpha','logo',1,0.75,'quartout')
		doTweenX('boxupX','boxup',0,1,'circOut')
		doTweenX('boxdownX','boxdown',0,1,'circOut')
		doTweenAlpha('soulAlpha','soul-pause',1,0.5,'quartout')
	end
end
function onCustomSubstateUpdate(name)
	if name == 'pause' then
		runHaxeCode([[
			var video = getVar('video');
			game.getLuaObject('videoSprite').loadGraphic(video.bitmapData);
			video.pause();
		]])
		local currentTime = os.date('%H:%M:%S')
		setTextString('timeText', 'Time: '.. currentTime)
		if version <= '0.7' then
			setTextString('death', 'Death:' .. getPropertyFromClass('PlayState', 'deathCounter'))
			elseif version >= '0.7' then
			setTextString('death', 'Death:' .. getPropertyFromClass('states.PlayState', 'deathCounter'))
		end
		if getProperty('cpuControlled') == true then
			setTextString('botplaytext', 'Bot Play: On')
		else
			setTextString('botplaytext', 'Bot Play: Off')
		end
		if getProperty('practiceMode') == true then
			setTextString('practicetext', 'Practice Mod: On')
		else
			setTextString('practicetext', 'Practice Mod: Off')
		end

		setProperty('soul-pause.y',getProperty('pausetext1.y')+(choose-1)*50)
		if getProperty('logo.angle')==0.3 then
			doTweenAngle('logoAngle','logo',-0.3,1.5)
			doTweenAngle('boxupAngle','boxup',-0.3,1.5)
			doTweenAngle('boxdownAngle','boxdown',-0.3,1.5)
		elseif getProperty('logo.angle')==-0.3 then
			doTweenAngle('logoAngle','logo',0.3,1.5)
			doTweenAngle('boxupAngle','boxup',0.3,1.5)
			doTweenAngle('boxdownAngle','boxdown',0.3,1.5)
		end
		if keyboardJustPressed('Z') or keyJustPressed('accept') or (getMouseX('camHUD')>=1010 and getMouseX('camHUD')<=1075 and getMouseY('camHUD')>=570 and getMouseY('camHUD')<=635 and mouseClicked('left')) then
			--playSound('confirmMenu',1)
			setProperty('acceptButton.alpha',1)
			cancelTween('acceptFade')
			setTextColor('acceptText','7F7F7F')
			if more then
				if choose == 1 then
					transpractice()
				elseif choose == 2 then
					transbot()
				elseif choose == 3 then
					addHaxeLibrary('LoadingState')
					runHaxeCode([[LoadingState.loadAndSwitchState(new editors.ChartingState());]])
				elseif choose == 4 then
					moresettings()
				end
			else
				if choose == 1 then
					destory()
					doTweenAlpha('acceptFade','acceptButton',0.3,0.15)
					setTextColor('acceptText','FFFFFF')
				elseif choose == 2 then
					restartSong()
				elseif choose == 3 then
					moresettings()
				elseif choose == 4 then
					exitSong()
				end
			end
		else
			doTweenAlpha('acceptFade','acceptButton',0.3,0.15)
			setTextColor('acceptText','FFFFFF')
		end
		if keyboardJustPressed('X') or keyJustPressed('back') or (getMouseX('camHUD')>=1150 and getMouseX('camHUD')<=1215 and getMouseY('camHUD')>=570 and getMouseY('camHUD')<=635 and mouseClicked('left')) then
			setProperty('backButton.alpha', 1)
			cancelTween('backFade')
			setTextColor('backText', '7F7F7F')
			if more then
				moresettings()
			end
		else
			doTweenAlpha('backFade', 'backButton', 0.3, 0.15, 'linear')
			setTextColor('backText', 'FFFFFF')
		end
		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') or (getMouseX('camHUD')>=1080 and getMouseX('camHUD')<=1145 and getMouseY('camHUD')>=570 and getMouseY('camHUD')<=635 and mouseClicked('left')) then
			playSound('scrollMenu',1)
			if choose == 1 then
				choose = 4
			else
				choose = choose - 1
			end
			setProperty('upButton.alpha',1)
			cancelTween('upFade')
			setTextColor('upText','7F7F7F')
		else
			doTweenAlpha('upFade','upButton',0.3,0.15)
			setTextColor('upText','FFFFFF')
		end
		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') or (getMouseX('camHUD')>=1080 and getMouseX('camHUD')<=1145 and getMouseY('camHUD')>=640 and getMouseY('camHUD')<=705 and mouseClicked('left')) then
			playSound('scrollMenu',1)
			if choose == 4 then
				choose = 1
			else
				choose = choose + 1
			end
			setProperty('downButton.alpha',1)
			cancelTween('downFade')
			setTextColor('downText','7F7F7F')
		else
			doTweenAlpha('downFade', 'downButton',0.3,0.15)
			setTextColor('downText','FFFFFF')
		end
		if choose == 1 then
			setTextColor('pausetext1','FFFF00')
			setTextColor('pausetext2','FFFFFF')
			setTextColor('pausetext3','FFFFFF')
			setTextColor('pausetext4','FFFFFF')
			setTextColor('moretext1','FFFF00')
			setTextColor('moretext2','FFFFFF')
			setTextColor('moretext3','FFFFFF')
			setTextColor('moretext4','FFFFFF')
			if more then
				setProperty('soul-pause.x',475)
			else
				setProperty('soul-pause.x',510)
			end
		elseif choose == 2 then
			setTextColor('pausetext1','FFFFFF')
			setTextColor('pausetext2','FFFF00')
			setTextColor('pausetext3','FFFFFF')
			setTextColor('pausetext4','FFFFFF')
			setTextColor('moretext1','FFFFFF')
			setTextColor('moretext2','FFFF00')
			setTextColor('moretext3','FFFFFF')
			setTextColor('moretext4','FFFFFF')
			if more then
				setProperty('soul-pause.x',475)
			else
				setProperty('soul-pause.x',510)
			end
		elseif choose == 3 then
			setTextColor('pausetext1','FFFFFF')
			setTextColor('pausetext2','FFFFFF')
			setTextColor('pausetext3','FFFF00')
			setTextColor('pausetext4','FFFFFF')
			setTextColor('moretext1','FFFFFF')
			setTextColor('moretext2','FFFFFF')
			setTextColor('moretext3','FFFF00')
			setTextColor('moretext4','FFFFFF')
			if more then
				setProperty('soul-pause.x',492)
			else
				setProperty('soul-pause.x',510)
			end
		elseif choose == 4 then
			setTextColor('pausetext1','FFFFFF')
			setTextColor('pausetext2','FFFFFF')
			setTextColor('pausetext3','FFFFFF')
			setTextColor('pausetext4','FFFF00')
			setTextColor('moretext1','FFFFFF')
			setTextColor('moretext2','FFFFFF')
			setTextColor('moretext3','FFFFFF')
			setTextColor('moretext4','FFFF00')
			if more then
				setProperty('soul-pause.x',546)
			else
				setProperty('soul-pause.x',510)
			end
		end
		if botPlay then
			setProperty('botplayTxt.visible',true)
		else
			setProperty('botplayTxt.visible',false)
		end
	end
end
function onUpdate()
	randomsanbCount=math.random(1,23)
	if counting then
		setPropertyFromClass('Conductor','songPosition',curSongPos)
		setPropertyFromClass('flixel.FlxG','sound.music.time',curSongPos)
		setProperty('vocals.time',currentpausepos)
		setPropertyFromClass('flixel.FlxG','sound.music.volume',0)
		setProperty('vocals.volume',0)
	else
		setPropertyFromClass('flixel.FlxG','sound.music.volume',1)
	end
end
function onTimerCompleted(tag)
	if tag=='startcountdowntime' then
		countdown=countdown+1
		if countdown<2 then
			--playSound('intro2')
			runTimer('startcountdowntime',0)
			setProperty('intro'..countdown..'.alpha',0)
			doTweenAlpha('intro'..countdown,'intro'..countdown,0,0.35)
		elseif countdown==2 then
			--playSound('intro1')
			runTimer('startcountdowntime',0)
			setProperty('intro'..countdown..'.alpha',0)
			doTweenAlpha('intro'..countdown,'intro'..countdown,0,0.35)
		else
			runTimer('gamestart',0)
			--playSound('introGo')
			setProperty('intro3.alpha',0)
			doTweenAlpha('intro3','intro3',0,0.35)
			countdown=-1
		end
	end
	if tag=='gamestart' then
		counting=false
		runHaxeCode([[
			var video = getVar('video');
			game.getLuaObject('videoSprite').loadGraphic(video.bitmapData);
			video.resume();
		]])
	end
end