--[[

	ColorSequencePoint(colorSequence: ColorSequence, time: number) -> Color3

	Returns a Color3 based on the ColorSequence and time provided.
	Time must be on the interval [0, 1] (from 0 to 1, including 0 and 1).

--]]

return function(colorSequence, time)
	assert((time >= 0) and (time <= 1), "Time must be on the interval [0, 1]")

	local keypoints = colorSequence.Keypoints

	local lowerBound = ColorSequenceKeypoint.new(-1, Color3.new())
	local upperBound = ColorSequenceKeypoint.new(2, Color3.new())

	-- assumes that keypoints are ordered by time
	for _, keypoint in ipairs(keypoints) do
		if (keypoint.Time == time) then
			return keypoint.Value
		end

		if (keypoint.Time < time) and (keypoint.Time > lowerBound.Time) then
			lowerBound = keypoint
		elseif (keypoint.Time > time) and (keypoint.Time < upperBound.Time) then
			upperBound = keypoint
		end
	end

	return lowerBound.Value:Lerp(upperBound.Value, (time - lowerBound.Time) / (upperBound.Time - lowerBound.Time))
end