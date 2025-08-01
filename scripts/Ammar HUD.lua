-- AMMAR HUD RECREATED BY UWENALIL!!!

local FontName = "gaposiss.ttf"
local ComboSpriteFile = "anammar/ComboSprite"

local HudName = {
    "COMBOS: ",
    "MISSES: ",
    "RATING: ",
    "SCORES: "
}

function onCreatePost()
    luaDebugMode = true
    --spacing by 30
    makeHudText("ComboTag", 680 - 60)
    makeHudText("MissTag", 680 - 60)
    makeHudText("AccuracyTag", 680 - 30)
    makeHudText("ScoreTag", 680)

    setProperty('ComboTag.alpha', 0)
    setProperty("ComboTag.x", 20)
    setProperty('healthBar.scale.x', 0)

    setProperty('timeTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('showRating', false);
    setProperty('showComboNum', false);

    makeAnimatedLuaSprite("ComboTagSprite", ComboSpriteFile, 0, 0)
    addAnimationByPrefix("ComboTagSprite", "SICK", "SICK", 24, false)
    addAnimationByPrefix("ComboTagSprite", "GOOD", "GOOD", 24, false)
    addAnimationByPrefix("ComboTagSprite", "BAD", "BAD", 24, false)
    addAnimationByPrefix("ComboTagSprite", "WORST", "WORST", 24, false)
    screenCenter("ComboTagSprite", "x")
    setProperty('ComboTagSprite.scale.x', 0.5)
    setProperty('ComboTagSprite.scale.y', 0.5)
    setObjectCamera("ComboTagSprite", "camHUD")
    addLuaSprite("ComboTagSprite", true)
    setProperty('ComboTagSprite.alpha', 0)

    runTimer("AccuracyTag Slide", 1, 0)
    runTimer("ScoreTag Slide", 0.75, 0)
    runTimer("HealthBar Woop!", 0.75, 0)
end

function onUpdate(elapsed)
    if hits < 1 then
        setTextString("ComboTag", HudName[1].."0")
        setTextString("MissTag", HudName[2].."0")
        setTextString("AccuracyTag", HudName[3].."0%")
        setTextString("ScoreTag", HudName[4].."0")
    end

    if hits > 0 or misses > 1 then
        setTextString("ComboTag", HudName[1]..getProperty("combo"))
        setTextString("MissTag", HudName[2]..misses)
        setTextString("AccuracyTag", HudName[3]..round(rating * 100, 2) .. "%")
        if universeEngine then
            setTextString("ScoreTag", HudName[4]..lerpScore)
        else
            setTextString("ScoreTag", HudName[4]..score)
        end
    end

    if misses == 1 then
        setProperty("MissTag.x", 20)
        setProperty("ComboTag.y", 680 - 90)
    end
end
--my pet rock learns how to code!!! rgvrjhnoerefgbefgbrbherjhioefbjhberjhbveruhdtuhj
function goodNoteHit(id, noteData, noteType, isSustainNote)
    ComboTagSpriteDefaultY = -30
    if downscroll then ComboTagSpriteDefaultY = 490 end
    local rawNoteRating = getPropertyFromGroup('notes', id, 'rating')
    if not isSustainNote then
        setProperty('ScoreTag.scale.x', 1.05)
        setProperty('ScoreTag.scale.y', 1.05)
        doTweenX("ScoreTag Scale X", "ScoreTag.scale", 1, 0.5, "linear")
        doTweenY("ScoreTag Scale Y", "ScoreTag.scale", 1, 0.5, "linear")

        setProperty('ComboTag.scale.x', 1.05)
        setProperty('ComboTag.scale.y', 1.05)
        doTweenX("ComboTag Scale X", "ComboTag.scale", 1, 0.5, "linear")
        doTweenY("ComboTag Scale Y", "ComboTag.scale", 1, 0.5, "linear")

        setProperty('ComboTag.alpha', 1)
        doTweenAlpha("ComboTag Alpha", "ComboTag", 0, 1, "linear")

        cancelTween("ComboTagSprite Goodbye ALPHA")
        cancelTween("ComboTagSprite Goodbye Y")
        setProperty('ComboTagSprite.alpha', 1)
        setProperty('ComboTagSprite.y', ComboTagSpriteDefaultY)

        if rawNoteRating == 'sick' then
            playAnim("ComboTagSprite", "SICK", true)
            runTimer("ComboTagSprite Goodbye", 0.5, 1)
        elseif rawNoteRating == 'good' then
            playAnim("ComboTagSprite", "GOOD", true)
            runTimer("ComboTagSprite Goodbye", 0.5, 1)
        elseif rawNoteRating == 'bad' then
            playAnim("ComboTagSprite", "BAD", true)
            runTimer("ComboTagSprite Goodbye", 0.5, 1)
        elseif rawNoteRating == 'shit' then
            playAnim("ComboTagSprite", "WORST", true)
            runTimer("ComboTagSprite Goodbye", 0.5, 1)
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "ComboTagSprite Goodbye" then
        doTweenAlpha("ComboTagSprite Goodbye ALPHA", "ComboTagSprite", 0, 0.5, "linear")
        doTweenY("ComboTagSprite Goodbye Y", "ComboTagSprite", ComboTagSpriteDefaultY + 50, 0.5, "expoIn")
    end

    if tag == "HealthBar Woop!" then
        doTweenX("HealthBar Woop!", "healthBar.scale", 1, 2, "expoOut")
    end

    if tag == "ScoreTag Slide" then
        doTweenX("ScoreTag Slide", "ScoreTag", 20, 1, "expoOut")
    end

    if tag == "AccuracyTag Slide" then
        doTweenX("AccuracyTag Slide", "AccuracyTag", 20, 1, "expoOut")
    end
end

function makeHudText(tag, ypos)
    makeLuaText(tag, tag, 0, -150, ypos)
    setTextSize(tag, 20)
    setTextFont(tag, FontName)
    addLuaText(tag)
end

function round(x, n) -- https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then
        x = math.floor(x + 0.5)
    else
        x = math.ceil(x - 0.5)
    end
    return x / n
end