-- Credit to CloneTrooper1019
-- https://devforum.roblox.com/t/sky-upperhue-and-sky-lowerhue-colorsequences/49817

local day = 86400
local hour = day/24
local riseAndSetTime = hour/2
local sunRise = day*0.25
local sunSet = day*0.75

local upperSkyAmbient = ColorSequence.new({
	ColorSequenceKeypoint.new(0,							Color3.new());
	ColorSequenceKeypoint.new((sunRise-(hour*2))/day,		Color3.new());
	ColorSequenceKeypoint.new((sunRise-hour)/day,			Color3.new(0.07,0.07,0.1));
	ColorSequenceKeypoint.new((sunRise-(hour/2))/day,		Color3.new(0.2,0.15,0.01));
	ColorSequenceKeypoint.new(sunRise/day,					Color3.new(0.2,0.15,0.01));
	ColorSequenceKeypoint.new((sunRise+riseAndSetTime)/day,	Color3.new(1,1,1));
	ColorSequenceKeypoint.new((sunSet-riseAndSetTime)/day,	Color3.new(1,1,1));
	ColorSequenceKeypoint.new(sunSet/day,					Color3.new(0.4,0.3,0.05));
	ColorSequenceKeypoint.new((sunSet+(hour/3))/day,		Color3.new());
	ColorSequenceKeypoint.new(1,							Color3.new());
})

local lowerSkyAmbient = ColorSequence.new({
	ColorSequenceKeypoint.new(0,							Color3.new());
	ColorSequenceKeypoint.new((sunRise-(hour*3))/day,		Color3.new());
	ColorSequenceKeypoint.new((sunRise-(hour*2))/day,		Color3.new(0.21,0.21,0.28));
	ColorSequenceKeypoint.new((sunRise-(hour/2))/day,		Color3.new(0.4,0.3,0.3));
	ColorSequenceKeypoint.new(sunRise/day,					Color3.new(0.3,0.2,0.3));
	ColorSequenceKeypoint.new((sunRise+riseAndSetTime)/day,	Color3.new(1,1,1));
	ColorSequenceKeypoint.new((sunSet-riseAndSetTime)/day,	Color3.new(1,1,1));
	ColorSequenceKeypoint.new(sunSet/day,					Color3.new(0.4,0.3,0.2));
	ColorSequenceKeypoint.new((sunSet+(hour/3))/day,		Color3.new(0.3,0.2,0.3));
	ColorSequenceKeypoint.new((sunSet+(hour*2))/day,		Color3.new(0.3,0.2,0.3));
	ColorSequenceKeypoint.new((sunSet+(hour*3))/day,		Color3.new());
	ColorSequenceKeypoint.new(1,							Color3.new());	
})

return {
	UpperSky = upperSkyAmbient,
	LowerSky = lowerSkyAmbient
}