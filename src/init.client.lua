--[[

	This script should go in PlayerStarterScripts. Due to the
	frequent cosmetic changes, it is not recommended to use this
	as a server Script.

	Based on these DevForum posts:

	- A Guide to a Better Looking and More Realistic Day/Night Cycle
	  by shadowcalen1: https://devforum.roblox.com/t/392643

	- How to make your lighting more realistic in shadowmap
	  by Lolaphobia: https://devforum.roblox.com/t/367805

	- Sky.UpperHue and Sky.LowerHue ColorSequences
	  by CloneTrooper1019: https://devforum.roblox.com/t/49817

	=== Lighting settings ===

	- Technology is ShadowMap or Voxel (doesn't work with Compatibility)
	- Ambient and OutdoorAmbient are black (0, 0, 0)
	- EnvironmentalDiffuseScale is 1
	- EnvironmentalSpecularScale is 1

	=== Options (configure below) ===

	These settings should be configured to the nature of your place's
	style.

	- AffectsBrightness: Changes how bright it is during the day
		- MiddayBrightness: How bright it is as 12:00 (12 PM, midday)
		- MidnightBrightness: How bright it is at 00:00 (12 AM, midnight)
		- MiddayBrightness >= MidnightBrightness

	- AffectsShadowSoftness: Changes how soft shadows are during the day
		- MaxSharpness: The maximum sharpness the shadows can have
		- MinSharpness: The minimum sharpness the shadows can have
		- MaxSharpness >= MinSharpness

	- AffectsColorShift: Affects the ColorShift_Top and ColorShift_Bottom
	  properties during the day.

		If you are not using the default skybox then you should probably
		disable this unless you have a ColorSequence for your skybox on
		hand. If you do, you can configure the SkyColorSequence module
		of this script. It should return a Dictionary with two
		ColorSequences, defined by the keys UpperSky and LowerSky.

--]]

local Options = {
	AffectsBrightness = true,
	MiddayBrightness = 2,
	MidnightBrightness = 0,

	AffectsShadowSoftness = true,
	MaxSharpness = 1,
	MinSharpness = 0,

	AffectsColorShift = true,
}

-------------------------------
-- Options are above this line
-------------------------------

local Lighting = game:GetService("Lighting")

local SkyColorSequence = require(script:FindFirstChild("SkyColorSequence"))
local UpperSkySequence = SkyColorSequence.UpperSky
local LowerSkySequence = SkyColorSequence.LowerSky

local ColorSequencePoint = require(script:FindFirstChild("ColorSequencePoint"))

---

local brightnessAmp = (Options.MiddayBrightness - Options.MidnightBrightness) / 2
local brightnessOffset = (Options.MiddayBrightness + Options.MidnightBrightness) / 2

local shadowAmp = (Options.MaxSharpness - Options.MinSharpness) / 2
local shadowOffset = (Options.MaxSharpness + Options.MinSharpness) / 2

local function brightnessFromClockTime(clockTime)
	return brightnessAmp * math.sin((math.pi * clockTime / 12) - (math.pi / 2)) + brightnessOffset
end

local function shadowSoftnessFromClockTime(clockTime)
	return shadowAmp * math.sin((math.pi * clockTime / 6) - (math.pi / 2)) + shadowOffset
end

local function updateLighting()
	local clockTime = Lighting.ClockTime

	if Options.AffectsBrightness then
		Lighting.Brightness = brightnessFromClockTime(clockTime)
	end

	if Options.AffectsShadowSoftness then
		Lighting.ShadowSoftness = shadowSoftnessFromClockTime(clockTime)
	end

	if Options.AffectsColorShift then
		local clockAlpha = clockTime / 24

		Lighting.ColorShift_Top = ColorSequencePoint(UpperSkySequence, clockAlpha)
		Lighting.ColorShift_Bottom = ColorSequencePoint(LowerSkySequence, clockAlpha)
	end
end

---

Lighting:GetPropertyChangedSignal("ClockTime"):Connect(updateLighting)

updateLighting()