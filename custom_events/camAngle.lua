--made by [ Paper Face#4233 ]


function onEvent(name, value1, value2)
	if name == 'camAngle' then
		if value2 == '' then
			setProperty('camHUD.angle', tostring(value1));
			setProperty('camGame.angle', tostring(value1));
		else
			doTweenAngle('camHUDTAN', 'camHUD', tostring(value1), tostring(value2));
			doTweenAngle('camGameTAN', 'camGame', tostring(value1), tostring(value2));
		end
	end

end