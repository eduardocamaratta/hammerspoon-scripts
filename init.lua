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
hs.hotkey.bind(mash, 'm',     function() hs.window.focusedWindow():move(units.maximum,     nil, true) end)
hs.hotkey.bind(mash, 'n',     moveWindowToNextDisplay)

-- Maps the key between the left shift and the Z key to what it should really be on an US International keyboard layout
-- in case the mapping doesn't work automatically for any reason
-- If you want to really use the symbols § and ± you can always copy them from the internet :D
hs.hotkey.bind({}, '§', function() hs.eventtap.keyStrokes('`') end)
hs.hotkey.bind({ 'shift' }, '§', function() hs.eventtap.event.newKeyEvent( { 'alt' }, 'n', true):post() end)
