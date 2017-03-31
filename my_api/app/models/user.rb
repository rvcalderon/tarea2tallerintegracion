class User < ApplicationRecord
	validates_presence_of :usuario
	validates_presence_of :nombre
end
