require 'time'

ENV['TZ']='UTC'

def conv_dmm str
  number, fractional = str.split('.')
  (number[0...-2].to_f + "#{number[-2..-1]}.#{fractional}".to_f / 100).to_s
end

io = File.open 'mdr0_20180215_201151_E.mp4'

while length = io.read(4)
	size = length.unpack('N')
	seek = size[0] - 8
	code = io.read(4)
	if code == 'udat' then
		length = io.read(4)
		size = length.unpack('N')
		secn = io.read(4)
		#STDOUT << secn << size[0].to_s << "\n"
		secd = io.read(size[0])
		tim = secd.unpack('N*')
	
		length = io.read(4)
		size = length.unpack('N')
		secn = io.read(4)
		#STDOUT << secn << size[0].to_s << "\n"
		secd = io.read(size[0])

		sen = []
		a = secd.unpack('l*')
		a.each do |s|
			sen << (s.to_f / 256).round(2)
		end

		length = io.read(4)
		size = length.unpack('N')
		secn = io.read(4)
		#STDOUT << secn << size[0].to_s << "\n"
		gps = io.read(size[0])
		
		i = 0
		while i < tim.size
			print sprintf("%05d,", i+1)
			print Time.at(tim[i]).localtime.strftime("%F %T") , \
				",", sen[i*3] , ",", sen[i*3+1], ",", sen[i*3+2], \
				",", conv_dmm(gps[28*i, 9]) ,",", conv_dmm(gps[28*i+12, 10]), \
				"\n"
			i = i + 1
		end

  	else
		io.seek(seek, IO::SEEK_CUR)
  	end
end

