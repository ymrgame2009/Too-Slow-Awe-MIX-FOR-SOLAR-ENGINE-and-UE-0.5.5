
function onCreatePost()
	makeLuaText('gaster-subs-main', '', 1000, 150, 500);
	setTextFont('gaster-subs-main', 'determination.ttf');
	setTextSize('gaster-subs-main', 35);
	setObjectCamera('gaster-subs-main', 'other');
	setTextColor('gaster-subs-main', 'FFFFFF')
	setTextAlignment('gaster-subs-main', "center")
	
	makeLuaText('gaster-subs-ghost', '', 1000, 150, 500);
	setTextFont('gaster-subs-ghost', 'pixelated-wingdings.ttf');
	setTextSize('gaster-subs-ghost', 45);
	setObjectCamera('gaster-subs-ghost', 'other');
	setTextColor('gaster-subs-ghost', 'FFFFFF')
	setTextAlignment('gaster-subs-ghost', "center")
	setProperty('gaster-subs-ghost.alpha', 0.35);

	addLuaText('gaster-subs-ghost', true)
	addLuaText('gaster-subs-main', true)
	
    --runTimer('gastererror1', 0.05);

end

function onEvent(name, value1, value2)
    if name == "BB-substitle-Gaster" then
	local var string = (value1)
	local Gasterdeletetime = value2
	
	runTimer('gasterwait', Gasterdeletetime);
	
	setTextString('gaster-subs-main', '' .. string)
	setTextString('gaster-subs-ghost', '' .. string)
    end
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'gasterwait' then
	setTextString('gaster-subs-main', '')
	setTextString('gaster-subs-ghost', '')
	end
	if tag == 'gastererror1' then
	setProperty("gaster-subs-ghost-red.y", 500);
	end
end