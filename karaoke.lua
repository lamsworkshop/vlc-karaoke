-- save this file to /usr/lib/???/vlc/lua/intf/karaoke.lua
-- VLC media player 3.0.23 Vetinari (revision 3.0.23-2-0-g79128878dd)

local function pl_equal(p1, p2)
	if #p1 ~= #p2 then return false end
	for i, v in ipairs(p1) do
		if v.id ~= p2[i].id then return false end
	end
	return true
end

vlc.msg.info("Karaoke interface script started.")

local playlist = {}
local current_id = -1
local status = "stopped"

while true do
	local _status = vlc.playlist.status()
	if status ~= _status then
		status = _status
		vlc.msg.info("status = " .. status)
	end
	local _current_id = vlc.playlist.current()
	if current_id ~= _current_id then
		current_id = _current_id
		vlc.msg.info("current id = " .. current_id)
	end
	local _playlist = vlc.playlist.get("playlist", true).children
	if not pl_equal(playlist, _playlist) then
		playlist = _playlist
		vlc.msg.info("length = " .. #playlist)
	end
	if status == "stopped" then
		if #playlist > 0 then
			vlc.playlist.delete(current_id)
			vlc.msg.info("current track deleted")
		end
	else
		local first_id = playlist[1].id
		if first_id ~= current_id then
			vlc.playlist.delete(first_id)
			vlc.msg.info("first track deleted")
		end
	end
	vlc.misc.mwait(vlc.misc.mdate() + 1000000)
end
