local amount = 0;
local subsname = 'subs';
local textID = 0;
local color = ' '

local subsposy = {};
subsposy[1] = 500
subsposy[2] = 500
subsposy[3] = 500

local subsID = {};
subsID[1] = 'subs-1'
subsID[2] = 'subs-2'
subsID[3] = 'subs-3'

local subsalpha = {};
subsalpha[1] = 0.75
subsalpha[2] = 1
subsalpha[3] = 1.25

local remember = ''


function onCreate()
    makeLuaText('subs-1', ' ', 1000, 150, subsposy[1])
	setTextSize('subs-1', 30)
	setObjectCamera('subs-1', 'other');
	addLuaText('subs-1', true)
	setTextColor('subs-1', 'FFFFFF')
	setTextAlignment('subs-1', "center")
	
	makeLuaText('subs-2', ' ', 1000, 150, subsposy[2])
	setTextSize('subs-2', 30)
	setObjectCamera('subs-2', 'other');
	addLuaText('subs-2', true)
	setTextColor('subs-2', 'FFFFFF')
	setTextAlignment('subs-2', "center")
	
	makeLuaText('subs-3', ' ', 1000, 150, subsposy[3])
	setTextSize('subs-3', 30)
	setObjectCamera('subs-3', 'other');
	addLuaText('subs-3', true)
	setTextColor('subs-3', 'FFFFFF')
	setTextAlignment('subs-3', "center")
	
	makeLuaText('subs-main', ' ', 1000, 150, 500)
	setTextSize('subs-main', 35)
	setObjectCamera('subs-main', 'other');
	addLuaText('subs-main', true)
	setTextColor('subs-main', 'FFFFFF')
	setTextAlignment('subs-main', "center")
	
end

function onEvent(name, value1, value2)
    if name == "BB-substitle" then
	local var string = (value1)
	local color = value2
	
	runTimer('wait', 2.5);
	
	setProperty("subs-main.y", 500);

	setTextString('subs-main', '' .. string)
	setTextColor('subs-main', color)
	doTweenColor('subs-main', 'subs-main', 'FFFFFF', 0.25, 'linear')
	
	for i=0, 3 do 
	subsposy[i + 1] = subsposy[i + 1] - 25
	if subsalpha[i + 1] == 0.25 then
	setProperty(subsID[i + 1]..".y", subsposy[i + 1]);
	else
	doTweenY(subsID[i + 1], subsID[i + 1], subsposy[i + 1], 0.1, 'linear');
	end
	
	if subsalpha[i + 1] == 0.75 then
		setTextString(subsID[i + 1], remember)
		break
	    end
	end
	
    remember = '' .. string
	
	for i=0, 3 do 

		subsalpha[i + 1] = subsalpha[i + 1] - 0.25
		setProperty(subsID[i + 1]..".alpha", subsalpha[i + 1]);
		
		if subsalpha[i + 1] == 0 then
		subsposy[i + 1] = 500
		subsalpha[i + 1] = 0.75

		setTextString(subsID[i + 1], '')
		setProperty(subsID[i + 1]..".y", subsposy[i + 1]);
		end
	end
	
	
		
    end
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'wait' then
	doTweenY("turnback1", 'subs-1', 1000, 0.2, 'linear');
	doTweenY("turnback2", 'subs-2', 1000, 0.2, 'linear');
	doTweenY("turnback3", 'subs-3', 1000, 0.2, 'linear');
	doTweenY("turnback4", 'subs-main', 1000, 0.2, 'linear');
	end
end