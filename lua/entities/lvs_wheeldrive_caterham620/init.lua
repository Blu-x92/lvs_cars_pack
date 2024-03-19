AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")
include("sv_pds.lua")


function ENT:OnSpawn( PObj )
	local DriverSeat = self:AddDriverSeat( Vector(-34,-10,-5), Angle(0,-85,8) )
	local PassengerSeat = self:AddPassengerSeat( Vector(-20,10,7), Angle(0,-93,28) )

	self:AddEngine( Vector(20,0,20) )
	self:AddSuperCharger()

	self:AddFuelTank( Vector(-70,0,15), Angle(5,0,0), 600, LVS.FUELTYPE_PETROL )

	local DoorHandler = self:AddDoorHandler( "hood", Vector(28,0,23), Angle(5,0,0), Vector(-27,-18,-3), Vector(24,18,3), Vector(-27,-18,-3), Vector(10,18,40) )
	DoorHandler:SetSoundOpen( "lvs/vehicles/generic/car_hood_open.wav" )
	DoorHandler:SetSoundClose( "lvs/vehicles/generic/car_hood_close.wav" )


	local WheelModel = "models/diggercars/caterham_620r/fw.mdl"

	local WheelModelR = "models/diggercars/caterham_620r/rw.mdl"

	local FLWheel = self:AddWheel( { pos = Vector(44.48,27,15), mdl = WheelModel, mdl_ang = Angle(0,0,0), radius = 12 } )
	local FRWheel = self:AddWheel( { pos = Vector(44.48,-27,15), mdl = WheelModel, mdl_ang = Angle(0,180,0), radius = 12} )
	local RLWheel = self:AddWheel( { pos = Vector(-44.74,28,15), mdl = WheelModelR, mdl_ang = Angle(0,0,0), radius = 12 } )
	local RRWheel = self:AddWheel( { pos = Vector(-44.74,-28,15), mdl = WheelModelR, mdl_ang = Angle(0,180,0), radius = 12} )

	self:CreateRigControler( "fl", FLWheel, 7.6, 15.6 )
	self:CreateRigControler( "fr", FRWheel, 7.6, 15.6 )
	self:CreateRigControler( "rl", RLWheel, 7.6, 15.6 )
	self:CreateRigControler( "rr", RRWheel, 7.6, 15.6 )

	local FrontAxle = self:DefineAxle( {
		Axle = {
			ForwardAngle = Angle(0,0,0),
			SteerType = LVS.WHEEL_STEER_FRONT,
			SteerAngle = 30,
			TorqueFactor = 0,
			BrakeFactor = 1,
		},
		Wheels = { FLWheel, FRWheel },
		Suspension = {
			Height = 10,
			MaxTravel = 7,
			ControlArmLength = 25,
			SpringConstant = 6000,
			SpringDamping = 600,
			SpringRelativeDamping = 600,
		},
	} )

	local RearAxle = self:DefineAxle( {
		Axle = {
			ForwardAngle = Angle(0,0,0),
			SteerType = LVS.WHEEL_STEER_NONE,
			SteerAngle = 0,
			TorqueFactor = 1,
			BrakeFactor = 1,
			UseHandbrake = true,
		},
		Wheels = { RLWheel, RRWheel },
		Suspension = {
			Height = 10,
			MaxTravel = 7,
			ControlArmLength = 25,
			SpringConstant = 6000,
			SpringDamping = 600,
			SpringRelativeDamping = 600,
		},
	} )

	self:CreatePDS()

end