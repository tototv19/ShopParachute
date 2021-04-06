ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)

------------ Point au sol -----------

Config = {}
Config.DrawDistance = 100
Config.Size = {x = 1.5, y = 1.5, z = 1.5}
Config.Color = {r = 195, g = 14, b = 14}
Config.Type = 40

local position = {
    {x = 424.04 , y = 5613.99 , z = 766.66},
    {x = -119.50 , y = -977.29 , z = 304.24}
}

------------ Blip ----------------

Citizen.CreateThread(function()
    for k in pairs(position) do
       local blip = AddBlipForCoord(position[k].x, position[k].y, position[k].z)
       SetBlipSprite(blip, 94)
       SetBlipColour(blip, 1)
       SetBlipScale(blip, 0.8)
       SetBlipAsShortRange(blip, true)

       BeginTextCommandSetBlipName('STRING')
       AddTextComponentString("~r~Saut en parachute")
       EndTextCommandSetBlipName(blip)
   end
end)

Citizen.CreateThread(function()
   while true do
       Citizen.Wait(0)
       local coords, letSleep = GetEntityCoords(PlayerPedId()), true

       for k in pairs(position) do
           if (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, position[k].x, position[k].y, position[k].z, true) < Config.DrawDistance) then
               DrawMarker(Config.Type, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
               letSleep = false
           end
       end

       if letSleep then
           Citizen.Wait(500)
       end
   end
end)


----------------- Menu ------------------

RMenu.Add('parachute', 'main', RageUI.CreateMenu("Parachute", "Activité parachute"))

Citizen.CreateThread(function()
   while true do
       RageUI.IsVisible(RMenu:Get('parachute', 'main'), true, true, true, function()

           RageUI.Button("Parachute", "Pour obtenir un parachute", {RightLabel = "~r~1000$"}, true, function(Hovered, Active, Selected)
               if (Selected) then   
               TriggerServerEvent('tototv:giveparachute')
           end
           end)
       end, function()
       end)
           Citizen.Wait(0)
       end
   end)




   ------------ Texte du menu en bas -------------
   
   Citizen.CreateThread(function()
       while true do
           Citizen.Wait(0)
   
           for k in pairs(position) do
   
               local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
               local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
   
               if dist <= 1.0 then
                RageUI.Text({
                    message = "Appuyez sur [~r~E~w~] pour parler au ~r~Vendeur",
                    time_display = 1
                })

                --ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour obtenir un ~b~parachute")
                   if IsControlJustPressed(1,51) then
                       RageUI.Visible(RMenu:Get('parachute', 'main'), not RageUI.Visible(RMenu:Get('parachute', 'main')))
                   end   
               end
           end
       end
   end)


