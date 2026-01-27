

function run(taskspawn)    
    pcall(function()
        loadstring(taskspawn)
    end)
end

        -- // System old \\ --

--[[ if not _G.key and not getgenv().accesskey then
    local Identifier = "dynamic-"
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    local TweenService = game:GetService("TweenService")
    local LocalPlayer = Players.LocalPlayer
    local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
    local FILENAME = "jthrgsdcde34qdsfeqre.txt"
    local savedkey = isfile(FILENAME) and readfile(FILENAME) or ""


    local function GetKeyLink(serviceId, hwid)
        return "https://pandadevelopment.net/getkey?service=" .. tostring(serviceId) .. "&hwid=" .. tostring(hwid)
    end

    local function ValidateKey(key, serviceId, hwid)
        local validationUrl = string.format(
            "https://pandadevelopment.net/v2_validation?key=%s&service=%s&hwid=%s",
            tostring(key), tostring(serviceId), tostring(hwid)
        )

        local requestFunction =
            (syn and syn.request) or
            (http and http.request) or
            (http_request) or
            (fluxus and fluxus.request) or
            (krnl and krnl.request) or
            (request) or
            nil

        if not requestFunction then
            return false, "Executor does not support HTTP requests"
        end

        local success, response = pcall(function()
            return requestFunction({
                Url = validationUrl,
                Method = "GET"
            })
        end)

        if not success or not response or not response.Body then
            return false, "No response"
        end

        local jsonSuccess, jsonData = pcall(function()
            return HttpService:JSONDecode(response.Body)
        end)

        if not jsonSuccess then
            return false, "JSON decode error"
        end

        if jsonData["V2_Authentication"] == "success" then
            return true, "Authenticated"
        else
            local reason = jsonData["reason"] or "Unknown reason"
            return false, reason
        end
    end
    local isValid, message = ValidateKey(_G.key, Identifier, HWID) or ValidateKey(tostring("9575ff46be51c548c160b75b4"), Identifier, HWID)
    if isValid then
        run()
    else
        game:shutdown()
    end
elseif _G.key and not getgenv().accesskey then
    local Identifier = "dynamic-"
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    local TweenService = game:GetService("TweenService")
    local LocalPlayer = Players.LocalPlayer
    local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
    local FILENAME = "jthrgsdcde34qdsfeqre.txt"
    local savedkey = isfile(FILENAME) and readfile(FILENAME) or ""


    local function GetKeyLink(serviceId, hwid)
        return "https://pandadevelopment.net/getkey?service=" .. tostring(serviceId) .. "&hwid=" .. tostring(hwid)
    end

    local function ValidateKey(key, serviceId, hwid)
        local validationUrl = string.format(
            "https://pandadevelopment.net/v2_validation?key=%s&service=%s&hwid=%s",
            tostring(key), tostring(serviceId), tostring(hwid)
        )

        local requestFunction =
            (syn and syn.request) or
            (http and http.request) or
            (http_request) or
            (fluxus and fluxus.request) or
            (krnl and krnl.request) or
            (request) or
            nil

        if not requestFunction then
            return false, "Executor does not support HTTP requests"
        end

        local success, response = pcall(function()
            return requestFunction({
                Url = validationUrl,
                Method = "GET"
            })
        end)

        if not success or not response or not response.Body then
            return false, "No response"
        end

        local jsonSuccess, jsonData = pcall(function()
            return HttpService:JSONDecode(response.Body)
        end)

        if not jsonSuccess then
            return false, "JSON decode error"
        end

        if jsonData["V2_Authentication"] == "success" then
            return true, "Authenticated"
        else
            local reason = jsonData["reason"] or "Unknown reason"
            return false, reason
        end
    end
    local isValid, message = ValidateKey(_G.key, Identifier, HWID) or ValidateKey(tostring("9575ff46be51c548c160b75b4"), Identifier, HWID)
    if isValid then
        run()
    else
        game:shutdown()
    end
elseif not _G.key and getgenv().accesskey then
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")

    local url = "https://test-1-49w9.onrender.com/checkandupdate"

    local function checkKeyWithServer(key)
        local player = Players.LocalPlayer
        if not player then
            warn("LocalPlayer not available")
            return "No player"
        end

        local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
        local robloxName = player.Name .. " (" .. player.DisplayName .. ")"
        local gameName = "Unknown"
        pcall(function()
            gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        end)

        local position = "Unknown"
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            position = tostring(player.Character.HumanoidRootPart.Position)
        end

        local executor = identifyexecutor()
        local clientId = hwid
        local jobId = game.JobId or "Unknown"

        local bodyTable = {
            key = key,
            hwid = hwid,
            robloxName = robloxName,
            gameName = gameName,
            position = position,
            executor = executor,
            clientId = clientId,
            jobId = jobId,
        }

        local jsonBody = HttpService:JSONEncode(bodyTable)

        local requestFunction =
            (syn and syn.request) or
            (http and http.request) or
            (http_request) or
            (fluxus and fluxus.request) or
            (krnl and krnl.request) or
            (request) or
            nil

        if not requestFunction then
            warn("No supported HTTP request method found in executor.")
            return "No HTTP request support"
        end

        local success, response = pcall(function()
            return requestFunction({
                Url = url,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                },
                Body = jsonBody,
            })
        end)

        if not success then
            warn("HTTP request failed:", response)
            return response
        end

        if not response or not response.Body then
            warn("No response body received")
            return "No response body"
        end

        local responseBody = response.Body
        print("Server response:", responseBody)

        if responseBody == "success" then
            return "Key and HWID valid"
        elseif responseBody == "hwid_mismatch" then
            return "HWID mismatch"
        elseif responseBody:sub(1, 10) == "key_expired" then
            return "Key expired"
        elseif responseBody:sub(1, 13) == "key_blacklisted" then
            return "Key blacklisted"
        elseif responseBody == "key_not_found" then
            return "Key not found"
        else
            return "Unknown response: " .. responseBody
        end
    end

    local result = checkKeyWithServer(getgenv().accesskey)

    if result == "Key and HWID valid" then
        run()
    elseif result == "HWID mismatch" then
        game.Players.LocalPlayer:Kick("HWID mismatch")
    elseif result == "Key expired" then
        game.Players.LocalPlayer:Kick("Key expired")
    elseif result == "Key blacklisted" then
        game.Players.LocalPlayer:Kick("Key blacklisted")
    elseif result == "Key not found" then
        game.Players.LocalPlayer:Kick("Key not found")
    else
        game.Players.LocalPlayer:Kick("Unknown response")
    end
end ]]

        -- // System new \\ --

if not _G.key and not getgenv().accesskey then
    local Identifier = "dynamic-"
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    local TweenService = game:GetService("TweenService")
    local LocalPlayer = Players.LocalPlayer
    local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
    local FILENAME = "jthrgsdcde34qdsfeqre.txt"
    local savedkey = isfile(FILENAME) and readfile(FILENAME) or ""


    local function GetKeyLink(serviceId, hwid)
        return "https://pandadevelopment.net/getkey?service=" .. tostring(serviceId) .. "&hwid=" .. tostring(hwid)
    end

    local function ValidateKey(key, serviceId, hwid)
        local validationUrl = string.format(
            "https://pandadevelopment.net/v2_validation?key=%s&service=%s&hwid=%s",
            tostring(key), tostring(serviceId), tostring(hwid)
        )

        local requestFunction =
            (syn and syn.request) or
            (http and http.request) or
            (http_request) or
            (fluxus and fluxus.request) or
            (krnl and krnl.request) or
            (request) or
            nil

        if not requestFunction then
            return false, "Executor does not support HTTP requests"
        end

        local success, response = pcall(function()
            return requestFunction({
                Url = validationUrl,
                Method = "GET"
            })
        end)

        if not success or not response or not response.Body then
            return false, "No response"
        end

        local jsonSuccess, jsonData = pcall(function()
            return HttpService:JSONDecode(response.Body)
        end)

        if not jsonSuccess then
            return false, "JSON decode error"
        end

        if jsonData["V2_Authentication"] == "success" then
            return true, "Authenticated"
        else
            local reason = jsonData["reason"] or "Unknown reason"
            return false, reason
        end
    end
    local isValid, message = ValidateKey(_G.key, Identifier, HWID) or ValidateKey(tostring("9575ff46be51c548c160b75b4"), Identifier, HWID)
    if isValid then
        run()
    else
        game:shutdown()
    end
elseif _G.key and not getgenv().accesskey then
    local lp = game.Players.LocalPlayer
    local char = lp.Character
    local lpAttr = lp:GetAttribute("key_checking")
    local charAttr = char:GetAttribute("key_checking")
    if not lpAttr or not charAttr then
        warn("Missing key_checking attribute")
        game:Shutdown()
        return
    end
    local decodedLP, decodedChar
    pcall(function()
        decodedLP = base64_decode(lpAttr)
    end)
    pcall(function()
        decodedChar = base64_decode(charAttr)
    end)
    decodedLP = tostring(decodedLP or "")
    decodedChar = tostring(decodedChar or "")
    local KEY = tostring(getgenv().protection_from_unauthorized_access or "")
    if decodedLP == KEY and decodedChar == KEY then
        run()
    else
        game:Shutdown()
    end
elseif not _G.key and getgenv().accesskey then
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")

    local url = "https://test-1-49w9.onrender.com/checkandupdate"

    local function checkKeyWithServer(key)
        local player = Players.LocalPlayer
        if not player then
            warn("LocalPlayer not available")
            return "No player"
        end

        local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
        local robloxName = player.Name .. " (" .. player.DisplayName .. ")"
        local gameName = "Unknown"
        pcall(function()
            gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        end)

        local position = "Unknown"
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            position = tostring(player.Character.HumanoidRootPart.Position)
        end

        local executor = identifyexecutor()
        local clientId = hwid
        local jobId = game.JobId or "Unknown"

        local bodyTable = {
            key = key,
            hwid = hwid,
            robloxName = robloxName,
            gameName = gameName,
            position = position,
            executor = executor,
            clientId = clientId,
            jobId = jobId,
        }

        local jsonBody = HttpService:JSONEncode(bodyTable)

        local requestFunction =
            (syn and syn.request) or
            (http and http.request) or
            (http_request) or
            (fluxus and fluxus.request) or
            (krnl and krnl.request) or
            (request) or
            nil

        if not requestFunction then
            warn("No supported HTTP request method found in executor.")
            return "No HTTP request support"
        end

        local success, response = pcall(function()
            return requestFunction({
                Url = url,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                },
                Body = jsonBody,
            })
        end)

        if not success then
            warn("HTTP request failed:", response)
            return response
        end

        if not response or not response.Body then
            warn("No response body received")
            return "No response body"
        end

        local responseBody = response.Body
        print("Server response:", responseBody)

        if responseBody == "success" then
            return "Key and HWID valid"
        elseif responseBody == "hwid_mismatch" then
            return "HWID mismatch"
        elseif responseBody:sub(1, 10) == "key_expired" then
            return "Key expired"
        elseif responseBody:sub(1, 13) == "key_blacklisted" then
            return "Key blacklisted"
        elseif responseBody == "key_not_found" then
            return "Key not found"
        else
            return "Unknown response: " .. responseBody
        end
    end

    local result = checkKeyWithServer(getgenv().accesskey)

    if result == "Key and HWID valid" then
        run()
    elseif result == "HWID mismatch" then
        game.Players.LocalPlayer:Kick("HWID mismatch")
    elseif result == "Key expired" then
        game.Players.LocalPlayer:Kick("Key expired")
    elseif result == "Key blacklisted" then
        game.Players.LocalPlayer:Kick("Key blacklisted")
    elseif result == "Key not found" then
        game.Players.LocalPlayer:Kick("Key not found")
    else
        game.Players.LocalPlayer:Kick("Unknown response")
    end
end

getgenv().run_time = false

return run
