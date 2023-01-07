ESX  = exports.es_extended:getSharedObject()

ESX.RegisterCommand("roll", 'user', function(xPlayer, args)

    if args.angka <= 100 then
        if xPlayer.source then
            xPlayer.triggerEvent("rolldadu", args.angka)
        end
    else 
        xPlayer.triggerEvent("DoLongHudText", "inform", "Angka maksimal adalah 100 !")
    end

    
end, false, {help = "Lempar Dadu", arguments = {
    {
        name = "angka",
        help = "1 - 100",
        type = "number"
    }
}})