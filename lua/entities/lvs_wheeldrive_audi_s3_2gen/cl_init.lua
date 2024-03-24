include("shared.lua")

function ENT:UpdatePoseParameters( steer, speed_kmh, engine_rpm, throttle, brake, handbrake, clutch, gear, temperature, fuel, oil, ammeter )
	self:SetPoseParameter( "vehicle_steer", steer )
	self:SetPoseParameter( "tacho_gauge", engine_rpm / 8000 )
	self:SetPoseParameter( "vehicle_gauge", speed_kmh / 300 )
	self:SetPoseParameter( "temp_gauge", temperature )
	self:SetPoseParameter( "fuel_gauge", fuel )
	self:SetPoseParameter( "throttle_pedal", throttle )
	self:SetPoseParameter( "brake_pedal", brake )
	self:SetPoseParameter( "handbrake_pedal", handbrake )
	self:SetPoseParameter( "clutch_pedal", clutch )

	local GearIDtoPose = {
		[-1] = 0,
		[1] = 3,
		[2] = 5,
		[3] = 8,
		[4] = 10,
		[5] = 13,
		[6] = 15,
	}

	self:SetPoseParameter( "gear",  self:QuickLerp( "gear", (GearIDtoPose[ gear ] or 1) ) )

	self:SetPoseParameter( "sunroof", self:QuickLerp( "sunroof", self:GetSunRoof(), 5 ) )
end