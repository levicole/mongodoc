class Address
  include MongoDoc::Document

  attr_accessor :street
  attr_accessor :city
  attr_accessor :state
  attr_accessor :zip_code
end

class Place
  include MongoDoc::Document

  attr_accessor :name
  attr_accessor :type
  embed :address
end

class Contact
  include MongoDoc::Document

  attr_accessor :name
  attr_accessor :type
  attr_accessor :note
  attr_accessor :interests
  embed_many :addresses

  scope :rubyists, any_in(:interests => ['ruby'])
  scope :contract_work, any_in(:interests => ['contract work'])
  scope :in_state, lambda {|state| where('addresses.state' => state)}
end

class Event
  include MongoDoc::Document

  attr_accessor :name
  attr_accessor :venue
  attr_accessor :date, :type => Date

  embed_hash :addresses
end

class Person
  include MongoDoc::Document

  attr_accessor :name
  references :address
  references_many :addresses, :as => :previous_addresses

  timestamps!
end

class VIP < Person
  attr_accessor :title
end

class Character
  include MongoDoc::Document

  attr_accessor :name
  references :as_ref => :address
end
