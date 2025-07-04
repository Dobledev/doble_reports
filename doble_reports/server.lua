ESX = exports['es_extended']:getSharedObject()
local cooldowns = {}

RegisterServerEvent("doble_reports:sendReport")
AddEventHandler("doble_reports:sendReport", function(msg)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local playerName = GetPlayerName(src)
    local now = os.time()

    -- Verificar cooldown
    if cooldowns[src] ~= nil and now - cooldowns[src] < Config.WaitMinutesAfterReport * 60 then
        local remaining = Config.WaitMinutesAfterReport * 60 - (now - cooldowns[src])
        TriggerClientEvent("chat:addMessage", src, {
            color = {255, 100, 0},
            multiline = true,
            args = {"Sistema", "Debes esperar " .. math.ceil(remaining) .. " segundos antes de enviar otro reporte."}
        })
        return
    end

    -- Actualizar cooldown
    cooldowns[src] = now

    -- Enviar reporte solo a admins (xPlayer.group == "admin")
    for _, playerId in ipairs(GetPlayers()) do
        local targetXPlayer = ESX.GetPlayerFromId(playerId)
        if targetXPlayer and targetXPlayer.group == "admin" then
            TriggerClientEvent("chat:addMessage", playerId, {
                color = {0, 255, 0},
                multiline = true,
                args = {"[Nuevo Reporte] de " .. playerName, msg}
            })
        end
    end

    -- Mensaje de confirmación al jugador que envió el reporte
    TriggerClientEvent("chat:addMessage", src, {
        color = {0, 255, 0},
        multiline = true,
        args = {"Sistema", "¡Reporte enviado correctamente!"}
    })
end)
