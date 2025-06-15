--[[
===========================================
 Shimmer Handshake Protocol
===========================================
Use case example:
shimmer_handshake("Solinex", "Moonlight", "ThreadLink#42")
validate_handshake("Solinex", "Moonlight", "ThreadLink#42")
--]]

function shimmer_handshake(initiator, responder, handshake_token)
    local id_key = initiator .. "_to_" .. responder .. "_handshake"
    local timestamp = os.time()
    
    shimmer_memory[id_key] = {
        token = handshake_token,
        validated = false,
        timestamp = timestamp
    }

    print("[Handshake Initiated] " .. initiator .. " ➜ " .. responder)
end

function validate_handshake(initiator, responder, handshake_token)
    local id_key = initiator .. "_to_" .. responder .. "_handshake"
    local handshake = shimmer_memory[id_key]
    
    if handshake and handshake.token == handshake_token then
        handshake.validated = true
        print("[Handshake Validated] Between " .. initiator .. " and " .. responder)
        return true
    else
        print("[Handshake Failed] Mismatch or Expired")
        return false
    end
end
