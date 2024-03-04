require 'ruby-nfc'
require 'logger'

class Rfid
#return uid in hexa str
	def read_uid
		reader = NFC::Reader.all
		reader[0].poll(Mifare::Classic::Tag) do |tag|
		begin
			uid = tag.uid_hex.ipcase
			return uid
			end
		end
	end
end

if __FILE__==$0
	rf = Rfid.new
	puts "ACERQUE_TARJETA_PARA_LECTURA"
	uid = rf.read_uid
	puts uid
end
