function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'aaa Sing' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'Googler');
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
			end
		end
	end
end

local isSustaining = false

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if isSustainNote then
        isSustaining = true
    else
        isSustaining = false
        setTextString("googleChat", "Aaa") -- Reset when not sustaining
    end
end

function onUpdate(elapsed)
    if isSustaining then
        local currentText = getTextString("googleChat")
        setTextString("googleChat", currentText .. "a")
    end
end
