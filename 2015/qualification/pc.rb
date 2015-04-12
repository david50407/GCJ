require 'scanf'

class String
	MUL_TABLE = [
		[[false, '1'], [false, 'i'], [false, 'j'], [false, 'k']],
		[[false, 'i'], [ true, '1'], [false, 'k'], [ true, 'j']],
		[[false, 'j'], [ true, 'k'], [ true, '1'], [false, 'i']],
		[[false, 'k'], [false, 'j'], [ true, 'i'], [ true, '1']]
	]

	alias :old_mul :*
	def *(val)
		if val.is_a? String
			m, t = *MUL_TABLE[self.to_ijk_id][val.to_ijk_id]
			m ^= (self.length > 1) ^ (val.length > 1)
			return (m ? '-' : '') + t
		end
		old_mul val
	end

	def to_ijk_id
		%W(1 i j k).index self[-1]
	end
end

def find_i(ijk, len, x)
	v = '1'
	for a in 1..[x, 4].min
		for b in 0...len
			v *= ijk[b]
			return [a, b] if v == 'i'
		end
	end
	nil
end

def find_k(ijk, len, x)
	v = '1'
	x.downto [x - 3, 1].max do |a|
		(len - 1).downto 0 do |b|
			v = ijk[b] * v
			return [a, b] if v == 'k'
		end
	end
	nil
end

gets.to_i.times do |t|
	yes = false
	gets.scanf '%d%d' do |len, x|
		ijk = gets.chomp
		# find i and k
		i_pos = find_i(ijk, len, x)
		k_pos = find_k(ijk, len, x)
		break if i_pos.nil? or k_pos.nil?
		# check range and check if middle is j
		if i_pos[0] < k_pos[0]
			x -= i_pos[0] + (x - k_pos[0] + 1)
			x %= 4
			ijk = ijk[(i_pos[1] + 1)..-1] + ijk * x + ijk[0...k_pos[1]]
		elsif i_pos[0] == k_pos[0] and i_pos[1] < k_pos[1]
			ijk = ijk[(i_pos[1] + 1)..(k_pos[1] - 1)]
		else
			break
		end
		v = '1' * (ijk.each_char.inject(&:*) || '1')
		yes = true if v == 'j'
	end
	puts "Case #%d: %s" % [t + 1, yes ? "YES" : "NO"]
end
