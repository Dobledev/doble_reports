RegisterCommand("report", function(source, args)
    local msg = table.concat(args, " ")
    if msg == nil or msg == "" then
        TriggerEvent("chat:addMessage", {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Uso correcto: /report [mensaje]"}
        })
        return
    end
    TriggerServerEvent("doble_reports:sendReport", msg)
end, false)

TriggerEvent('chat:addSuggestion', '/report', 'Enviar un report', {
    {name = "mensaje", help = "Describe tu problema o reporte"}
})
