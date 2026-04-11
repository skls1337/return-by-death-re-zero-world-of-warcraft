local frame = CreateFrame("Frame")

local wasDeadOrGhost = false
local lastPlayed = 0

local function CheckResurrection()
    local now = GetTime()

    local dead = UnitIsDeadOrGhost("player")
    local ghost = UnitIsGhost("player")

    -- If we were dead/ghost and now we're fully alive
    if wasDeadOrGhost and not dead and not ghost then
        if now - lastPlayed > 1 then -- anti-double trigger
            lastPlayed = now

            PlaySoundFile("Interface\\AddOns\\ReturnByDeath\\re-zero-return-by-death.ogg", "Master")
        end
    end

    wasDeadOrGhost = dead or ghost
end

frame:RegisterEvent("PLAYER_DEAD")
frame:RegisterEvent("PLAYER_ALIVE")
frame:RegisterEvent("PLAYER_UNGHOST")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function()
    CheckResurrection()
end)
