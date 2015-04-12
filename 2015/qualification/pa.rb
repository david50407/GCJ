require "scanf"

gets.to_i.times do |t|
	gets.scanf "%d%s" do |s_max, s_i|
		total, added = 0, 0
		(s_max + 1).times do |i|
			total, added = i, added + i - total if total < i
			total += s_i[i].to_i
		end
		puts "Case #%d: %d" % [t + 1, added]
	end
end
