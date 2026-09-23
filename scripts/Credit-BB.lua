local out = 5 --5
--right mode
local rightmode = false;
local position_intro = 0
local position_outro = -1372
--text--


function onCreate()
	makeLuaSprite('B0X', 'C_box', -1372, 0);
	addLuaSprite('B0X', true)
	setObjectCamera('B0X', 'other');
	scaleObject('B0X', 0.75, 1.25);
	setProperty('B0X.alpha', 0.75);
	
	makeLuaSprite('B0XR', 'C_boxR', -1372, 0);
	addLuaSprite('B0XR', true)
	setObjectCamera('B0XR', 'other');
	scaleObject('B0XR', 0.75, 1.25);
	setProperty('B0XR.alpha', 0.75);
	
	--text--
	-----Default text-----
	makeLuaText('songname', string.upper(songName), 0, -550, 105)
	setTextSize('songname', 45)
	setObjectCamera('songname', 'other');
	addLuaText('songname', true)
	setTextColor('songname', 'ffffff')
	setTextAlignment("songname", "left")
	
	makeLuaText('composer', 'Composer', 0, -500, 160)
	setTextSize('composer', 30)
	setObjectCamera('composer', 'other');
	addLuaText('composer', true)
	setTextColor('composer', 'FFC733')
	setTextAlignment("composer", "left")
	
	makeLuaText('artist', 'Artist', 0, -500, 300)
	setTextSize('artist', 30)
	setObjectCamera('artist', 'other');
	addLuaText('artist', true)
	setTextColor('artist', 'FFC733')
	setTextAlignment("artist", "left")
	
	makeLuaText('charter', 'Charter', 0, -500, 450)
	setTextSize('charter', 30)
	setObjectCamera('charter', 'other');
	addLuaText('charter', true)
	setTextColor('charter', 'FFC733')
	setTextAlignment("charter", "left")
	
	
	-----changeable text-----
	makeLuaText('composer-name1', ' ', 0, -500, 190)
	setTextSize('composer-name1', 28)
	setObjectCamera('composer-name1', 'other');
	addLuaText('composer-name1', true)
	setTextAlignment("composer-name1", "left")
	
	makeLuaText('composer-name2', ' ', 0, -500, 218)
	setTextSize('composer-name2', 28)
	setObjectCamera('composer-name2', 'other');
	addLuaText('composer-name2', true)
	setTextAlignment("composer-name2", "left")
	
	makeLuaText('composer-name3', ' ', 0, -500, 246)
	setTextSize('composer-name3', 28)
	setObjectCamera('composer-name3', 'other');
	addLuaText('composer-name3', true)
	setTextAlignment("composer-name3", "left")
	
	makeLuaText('composer-name4', ' ', 0, -500, 274)
	setTextSize('composer-name4', 28)
	setObjectCamera('composer-name4', 'other');
	addLuaText('composer-name4', true)
	setTextAlignment("composer-name4", "left")
	
	-------------------------
	
	makeLuaText('artist-name1', ' ', 0, -500, 330)
	setTextSize('artist-name1', 28)
	setObjectCamera('artist-name1', 'other');
	addLuaText('artist-name1', true)
	setTextAlignment("artist-name1", "left")
	
	makeLuaText('artist-name2', ' ', 0, -500, 358)
	setTextSize('artist-name2', 28)
	setObjectCamera('artist-name2', 'other');
	addLuaText('artist-name2', true)
	setTextAlignment("artist-name2", "left")
	
	makeLuaText('artist-name3', ' ', 0, -500, 386)
	setTextSize('artist-name3', 28)
	setObjectCamera('artist-name3', 'other');
	addLuaText('artist-name3', true)
	setTextAlignment("artist-name3", "left")
	
	makeLuaText('artist-name4', ' ', 0, -500, 414)
	setTextSize('artist-name4', 28)
	setObjectCamera('artist-name4', 'other');
	addLuaText('artist-name4', true)
	setTextAlignment("artist-name4", "left")
	
	-------------------------
	
	makeLuaText('charter-name1', ' ', 0, -500, 480)
	setTextSize('charter-name1', 28)
	setObjectCamera('charter-name1', 'other');
	addLuaText('charter-name1', true)
	setTextAlignment("charter-name1", "left")
	
	makeLuaText('charter-name2', ' ', 0, -500, 508)
	setTextSize('charter-name2', 28)
	setObjectCamera('charter-name2', 'other');
	addLuaText('charter-name2', true)
	setTextAlignment("charter-name2", "left")
	
	makeLuaText('charter-name3', ' ', 0, -500, 536)
	setTextSize('charter-name3', 28)
	setObjectCamera('charter-name3', 'other');
	addLuaText('charter-name3', true)
	setTextAlignment("charter-name3", "left")
	
	makeLuaText('charter-name4', ' ', 0, -500, 564)
	setTextSize('charter-name4', 28)
	setObjectCamera('charter-name4', 'other');
	addLuaText('charter-name4', true)
	setTextAlignment("charter-name4", "left")
	
	

end

function onEvent(name, value1, value2)
    if name == "credit-option" then
	local num = tonumber(value1)
	
	    if num == 1 then
		rightmode = true
		position_intro = 850
		position_outro = 1500
		setProperty('B0XR.x', position_outro);
		setProperty('songname.x', position_outro);
		setProperty('composer.x', position_outro);
		setProperty('charter.x', position_outro);
		setProperty('artist.x', position_outro);
		setProperty('composer-name1.x', position_outro);
		setProperty('composer-name2.x', position_outro);
		setProperty('composer-name3.x', position_outro);
		setProperty('composer-name4.x', position_outro);
		setProperty('charter-name1.x', position_outro);
		setProperty('charter-name2.x', position_outro);
		setProperty('charter-name3.x', position_outro);
		setProperty('charter-name4.x', position_outro);
		setProperty('artist-name1.x', position_outro);
		setProperty('artist-name2.x', position_outro);
		setProperty('artist-name3.x', position_outro);
		setProperty('artist-name4.x', position_outro);
		end
	end
    if name == "credit-show" then
	    if rightmode == true then
		setProperty('B0X.visible',false)
		doTweenX('NameTweenXR', 'B0XR', 250, 2, 'CircInOut');
		else
		setProperty('B0XR.visible',false)
		doTweenX('NameTweenX', 'B0X', position_intro, 2, 'CircInOut');
	    end
	runTimer('nameout', out);
	
	doTweenX('songname_Intro', 'songname', position_intro, 2, 'CircInOut');
	doTweenX('composer_Intro', 'composer', position_intro, 2, 'CircInOut');
	doTweenX('charter_Intro', 'charter', position_intro, 2, 'CircInOut');
	doTweenX('artist_Intro', 'artist', position_intro, 2, 'CircInOut');
	doTweenX('composername_Intro1', 'composer-name1', position_intro, 2, 'CircInOut');
	doTweenX('composername_Intro2', 'composer-name2', position_intro, 2, 'CircInOut');
	doTweenX('composername_Intro3', 'composer-name3', position_intro, 2, 'CircInOut');
	doTweenX('composername_Intro4', 'composer-name4', position_intro, 2, 'CircInOut');
	doTweenX('chartername_Intro1', 'charter-name1', position_intro, 2, 'CircInOut');
	doTweenX('chartername_Intro2', 'charter-name2', position_intro, 2, 'CircInOut');
	doTweenX('chartername_Intro3', 'charter-name3', position_intro, 2, 'CircInOut');
	doTweenX('chartername_Intro4', 'charter-name4', position_intro, 2, 'CircInOut');
	doTweenX('artistname_Intro1', 'artist-name1', position_intro, 2, 'CircInOut');
	doTweenX('artistname_Intro2', 'artist-name2', position_intro, 2, 'CircInOut');
	doTweenX('artistname_Intro3', 'artist-name3', position_intro, 2, 'CircInOut');
	doTweenX('artistname_Intro4', 'artist-name4', position_intro, 2, 'CircInOut');
	end
	if name == "credit-composer" then
	local var string = (value1)
	local num = tonumber(value2)
	
	    if num == 1 then
	    setTextString('composer-name1', '' .. string)
		elseif num == 2 then
		setTextString('composer-name2', '' .. string)
		elseif num == 3 then
		setTextString('composer-name3', '' .. string)
		elseif num == 4 then
		setTextString('composer-name4', '' .. string)
		end
	end
	if name == "credit-charter" then
	local var string = (value1)
	local num = tonumber(value2)
	
	    if num == 1 then
	    setTextString('charter-name1', '' .. string)
		elseif num == 2 then
		setTextString('charter-name2', '' .. string)
		elseif num == 3 then
		setTextString('charter-name3', '' .. string)
		elseif num == 4 then
		setTextString('charter-name4', '' .. string)
		end
	end
	if name == "credit-artist" then
	local var string = (value1)
	local num = tonumber(value2)
	
	    if num == 1 then
	    setTextString('artist-name1', '' .. string)
		elseif num == 2 then
		setTextString('artist-name2', '' .. string)
		elseif num == 3 then
		setTextString('artist-name3', '' .. string)
		elseif num == 4 then
		setTextString('artist-name4', '' .. string)
		end
	end
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'nameout' then
	doTweenX('NameTweenX2', 'B0X', position_outro, 2, 'CircInOut');
	doTweenX('NameTweenX2R', 'B0XR', position_outro, 2, 'CircInOut');
	
	doTweenX('songname_outro', 'songname', position_outro, 2, 'CircInOut');
	doTweenX('composer_outro', 'composer', position_outro, 2, 'CircInOut');
	doTweenX('charter_outro', 'charter', position_outro, 2, 'CircInOut');
	doTweenX('artist_outro', 'artist', position_outro, 2, 'CircInOut');
	doTweenX('composername_outro1', 'composer-name1', position_outro, 2, 'CircInOut');
	doTweenX('composername_outro2', 'composer-name2', position_outro, 2, 'CircInOut');
	doTweenX('composername_outro3', 'composer-name3', position_outro, 2, 'CircInOut');
	doTweenX('composername_outro4', 'composer-name4', position_outro, 2, 'CircInOut');
	doTweenX('chartername_outro1', 'charter-name1', position_outro, 2, 'CircInOut');
	doTweenX('chartername_outro2', 'charter-name2', position_outro, 2, 'CircInOut');
	doTweenX('chartername_outro3', 'charter-name3', position_outro, 2, 'CircInOut');
	doTweenX('chartername_outro4', 'charter-name4', position_outro, 2, 'CircInOut');
	doTweenX('artistname_outro1', 'artist-name1', position_outro, 2, 'CircInOut');
	doTweenX('artistname_outro2', 'artist-name2', position_outro, 2, 'CircInOut');
	doTweenX('artistname_outro3', 'artist-name3', position_outro, 2, 'CircInOut');
	doTweenX('artistname_outro4', 'artist-name4', position_outro, 2, 'CircInOut');
    end
end

