require 'scanf'

gets.to_i.times do |t|
	cakes = scanf('%d' * gets.to_i)
	round = cakes.max
	for i in 1..cakes.max
		round = [round, cakes.map { |c| c / i + (c % i > 0 ? 1 : 0) - 1 }.inject(&:+) + i].min
	end
	puts "Case #%d: %d" % [t + 1, round]
end
