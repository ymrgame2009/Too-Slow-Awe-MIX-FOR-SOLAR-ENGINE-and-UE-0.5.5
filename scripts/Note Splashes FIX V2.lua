function opponentNoteHit(id, direction, noteType, isSustainNote)
    -- لا نفعل شيئاً لخصمك إلا إذا أردت ذلك
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    for i = 0, getProperty('grpNoteSplashes.length')-1 do
	setPropertyFromGroup('grpNoteSplashes', i, 'alpha', 1)
	setPropertyFromGroup('grpNoteSplashes', i, 'offset.x', -25.5)
	setPropertyFromGroup('grpNoteSplashes', i, 'offset.y', -15)
    end

    if not isSustainNote then
        -- ننتظر أجزاء من الثانية ليتأكد المحرك من إنشاء الـ Splash
        runTimer('fixSplashOrder', 0.01)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'fixSplashOrder' then
        -- نقوم بجلب آخر عنصر تم إضافته لمجموعة الـ Splashes ونرفعه للمقدمة
        local splashCount = getProperty('grpNoteSplashes.length')
        if splashCount > 0 then
            setObjectOrder('grpNoteSplashes', getObjectOrder('strumLineNotes') + 10)
        end
    end
end