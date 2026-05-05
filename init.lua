hs.window.animationDuration = 0

units = {
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bottom50      = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  topLeft       = { x = 0.00, y = 0.00, w = 0.50, h = 0.50 },
  topRight      = { x = 0.50, y = 0.00, w = 0.50, h = 0.50 },
  bottomLeft    = { x = 0.00, y = 0.50, w = 0.50, h = 0.50 },
  bottomRight   = { x = 0.50, y = 0.50, w = 0.50, h = 0.50 },
  left25        = { x = 0.00, y = 0.00, w = 0.25, h = 1.00 },
  right75       = { x = 0.25, y = 0.00, w = 0.75, h = 1.00 },
  left75        = { x = 0.00, y = 0.00, w = 0.75, h = 1.00 },
  right25       = { x = 0.75, y = 0.00, w = 0.25, h = 1.00 },
  maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}

-- Credits to https://stackoverflow.com/a/55778307
function moveWindowToNextDisplay()
  -- Get the focused window, its window frame dimensions, its screen frame dimensions,
  -- and the next screen's frame dimensions.
  local focusedWindow = hs.window.focusedWindow()
  local focusedScreenFrame = focusedWindow:screen():frame()
  local nextScreenFrame = focusedWindow:screen():next():frame()
  local windowFrame = focusedWindow:frame()

  -- Calculate the coordinates of the window frame in the next screen and retain aspect ratio
  windowFrame.x = ((((windowFrame.x - focusedScreenFrame.x) / focusedScreenFrame.w) * nextScreenFrame.w) + nextScreenFrame.x)
  windowFrame.y = ((((windowFrame.y - focusedScreenFrame.y) / focusedScreenFrame.h) * nextScreenFrame.h) + nextScreenFrame.y)
  windowFrame.h = ((windowFrame.h / focusedScreenFrame.h) * nextScreenFrame.h)
  windowFrame.w = ((windowFrame.w / focusedScreenFrame.w) * nextScreenFrame.w)

  -- Set the focused window's new frame dimensions
  focusedWindow:setFrame(windowFrame)
end

mash = { 'ctrl', 'alt', 'cmd' }

hs.hotkey.bind(mash, 'Left',  function() hs.window.focusedWindow():move(units.left50,      nil, true) end)
hs.hotkey.bind(mash, 'Right', function() hs.window.focusedWindow():move(units.right50,     nil, true) end)
hs.hotkey.bind(mash, 'Up',    function() hs.window.focusedWindow():move(units.top50,       nil, true) end)
hs.hotkey.bind(mash, 'Down',  function() hs.window.focusedWindow():move(units.bottom50,    nil, true) end)
hs.hotkey.bind(mash, '9',     function() hs.window.focusedWindow():move(units.topLeft,     nil, true) end)
hs.hotkey.bind(mash, '0',     function() hs.window.focusedWindow():move(units.topRight,    nil, true) end)
hs.hotkey.bind(mash, 'o',     function() hs.window.focusedWindow():move(units.bottomLeft,  nil, true) end)
hs.hotkey.bind(mash, 'p',     function() hs.window.focusedWindow():move(units.bottomRight, nil, true) end)
hs.hotkey.bind(mash, '7',     function() hs.window.focusedWindow():move(units.left25,      nil, true) end)
hs.hotkey.bind(mash, '8',     function() hs.window.focusedWindow():move(units.right75,     nil, true) end)
hs.hotkey.bind(mash, 'u',     function() hs.window.focusedWindow():move(units.left75,      nil, true) end)
hs.hotkey.bind(mash, 'i',     function() hs.window.focusedWindow():move(units.right25,     nil, true) end)
hs.hotkey.bind(mash, 'm',     function() hs.window.focusedWindow():move(units.maximum,     nil, true) end)
hs.hotkey.bind(mash, 'n',     moveWindowToNextDisplay)

-- Maps the key between the left shift and the Z key to what it should really be on an US International keyboard layout
-- in case the mapping doesn't work automatically for any reason
-- If you want to really use the symbols § and ± you can always copy them from the internet :D
hs.hotkey.bind({}, '§', function() hs.eventtap.keyStrokes('`') end)
hs.hotkey.bind({ 'cmd' }, '§', function() hs.eventtap.event.newKeyEvent( { 'cmd' }, '`', true):post() end)
hs.hotkey.bind({ 'shift' }, '§', function() hs.eventtap.event.newKeyEvent( { 'alt' }, 'n', true):post() end)

-- Caffeinate: Hammerspoon extension

caffeine = hs.menubar.new()
function setCaffeineDisplay()
  if hs.caffeinate.get("displayIdle") then
    caffeine:setTitle("☕️")
  else
    caffeine:setTitle("💤")
  end
end

function caffeineClicked()
  hs.caffeinate.toggle("displayIdle")
  setCaffeineDisplay()
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay()
end

-- local log = hs.logger.new('mymodule','debug')
-- wfs = hs.spaces.windowsForSpace(1)

-- log.d(wfs)
-- log.i(hs.window.orderedWindows())
-- log.i(hs.window.focusedWindow():title())

-- function debugWindow()
--   -- log.i(hs.window.focusedWindow():title())
--   -- log.i(hs.window.focusedWindow():application():title())
--   -- win = hs.window.find('Ghostty')
--   win = hs.window.allWindows()
--   log.i(win)
--   for i = 1, #win do
--     print(win[i]:application():title()) -- Access value by index
--   end
-- end

-- -- Ghostty, Telegram, Brave Browser, Code

-- hs.hotkey.bind(mash, 'v', debugWindow)

-- function filterWin(win)
--   return win:application():title() == "Brave"-- or win:application():title() == "Ghostty" or win:application():title() == "Brave Browser" or win:application():title() == "Code"
-- end
-- local wf = hs.window.filter
-- local appNameTable = { Telegram = true, Ghostty = true, Code = true }
-- local win = wf.new(appNameTable)
-- for i = 1, #win do
--   log.i(win[i]:application():title()) -- Access value by index
-- end

-- local spaceNames = hs.spaces.missionControlSpaceNames()
-- spaces = {}
-- for uuid, desktops in pairs(spaceNames) do
--     for index, name in pairs(desktops) do
--         spaces[name] = index
--     end
-- end


-- config: edit these to match your setup ----------------------------------------------------------
-- local CONFIG = {
--   appName = "Ghostty",           -- app name to watch for
--   desktopName = "Desktop 2",     -- Mission Control Space name
--   windowCount = 1,              -- how many windows to wait for
--   pollInterval = 1.0,           -- seconds between checks
--   timeoutSeconds = 60,          -- give up after this long
-- }

-- -- internal state
-- local _timer = nil
-- local _elapsed = 0

-- local function getSpaceIndexByName(name)
--   local spaces = hs.spaces.missionControlSpaceNames()
--   for screenUUID, screenSpaces in pairs(spaces) do
--     for spaceID, spaceName in pairs(screenSpaces) do
--       if spaceName == name then
--         return spaceID
--       end
--     end
--   end
--   return nil
-- end

-- local function moveWindowsToDesktop()
--   local wins = hs.application.find(CONFIG.appName)
--   if not wins then return false end
--   log.i("found it")

--   local allWindows = wins:allWindows()
--   if #allWindows < CONFIG.windowCount then
--     return false
--   end

--   local spaceID = getSpaceIndexByName(CONFIG.desktopName)
--   if not spaceID then
--     log.i("Space not found: " .. CONFIG.desktopName)
--     return true -- stop polling, nothing we can do
--   end

--   for _, win in ipairs(allWindows) do
--     local wasMoved = hs.spaces.moveWindowToSpace(win:id(), spaceID, true)
--     log.i(wasMoved and "moved " or "failed to move " .. win:title() .. " to " .. CONFIG.desktopName)
--   end

--   log.i(#allWindows .. " window(s) moved to " .. CONFIG.desktopName)

--   return true -- done
-- end

-- local function startWatching()
--   if _timer then _timer:stop() end
--   _elapsed = 0

--   _timer = hs.timer.doEvery(CONFIG.pollInterval, function()
--     _elapsed = _elapsed + CONFIG.pollInterval

--     if moveWindowsToDesktop() then
--       _timer:stop()
--       _timer = nil
--       return
--     end

--     if _elapsed >= CONFIG.timeoutSeconds then
--       _timer:stop()
--       _timer = nil
--       log.i("Timed out waiting for " .. CONFIG.appName)
--     end
--   end)
-- end

-- startWatching()
-- config: edit these to match your setup ----------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- API was disabled by apple
-- an alternative is clicking & holding on the title bar, holding ctrl and move to the desired space:
-- https://gist.github.com/jdtsmith/8f08cf22a7177884b437cd25c0fba7d5
-- local hotkey = hs.hotkey
-- local window = hs.window
-- local hse, hsee, hst = hs.eventtap,hs.eventtap.event,hs.timer
-- local spaces = hs.spaces

-- function switchSpace(skip,dir)
--    for i=1,skip do
--       hs.eventtap.keyStroke({"ctrl","fn"},dir,0) -- "fn" is a bugfix!
--    end
-- end

-- function getGoodFocusedWindow(nofull)
--    local win = window.focusedWindow()
--    if not win or not win:isStandard() then return end
--    if nofull and win:isFullScreen() then return end
--    return win
-- end

-- function moveWindowOneSpace(dir,switch)
--    local win = getGoodFocusedWindow(true)
--    if not win then return end
--    local screen=win:screen()
--    local uuid=screen:getUUID()
--    local userSpaces=nil
--    for k,v in pairs(spaces.allSpaces()) do
--       userSpaces=v
--       if k==uuid then break end
--    end
--    if not userSpaces then return end

--    for i, spc in ipairs(userSpaces) do
--       if spaces.spaceType(spc)~="user" then -- skippable space
-- 	 table.remove(userSpaces, i)
--       end
--    end
--    if not userSpaces then return end

--    local initialSpace = spaces.windowSpaces(win)
--    if not initialSpace then return else initialSpace=initialSpace[1] end
--    local currentCursor = hs.mouse.getRelativePosition()

--    if (dir == "right" and initialSpace == userSpaces[#userSpaces]) or
--       (dir == "left" and initialSpace == userSpaces[1]) then
--       log.i('end of valid spaces')
--    else
--       local zoomPoint = hs.geometry(win:zoomButtonRect())
--       local safePoint = zoomPoint:move({-1,-1}).topleft
--       hsee.newMouseEvent(hsee.types.leftMouseDown, safePoint):post()
--       switchSpace(1, dir)
--       hst.waitUntil(
-- 	 function () return spaces.windowSpaces(win)[1]~=initialSpace end,
-- 	 function ()
-- 	    hsee.newMouseEvent(hsee.types.leftMouseUp, safePoint):post()
-- 	    hs.mouse.setRelativePosition(currentCursor)
--       end, 0.05)
--    end
-- end

-- hotkey.bind(mash, "s", function() moveWindowOneSpace("right",true) end)
-- hotkey.bind(mash, "a", function() moveWindowOneSpace("left",true) end)
----------------------------------------------------------------------------------------------------
-- above ended up being unreliable, continue testing comments from here and below
-- https://github.com/Hammerspoon/hammerspoon/issues/3698#issuecomment-3550103441