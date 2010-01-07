require 'rubygems'

gem 'mongo', '0.18.2'
gem 'mongo_ext', '0.18.2'
gem 'durran-validatable', '1.8.4'
gem 'leshill-will_paginate', '2.3.11'

require 'mongo'
require 'activesupport'
require 'validatable'
require 'will_paginate/collection'

module MongoDoc
  VERSION = '0.1.2'

  class NoConnectionError < RuntimeError; end
  class NoDatabaseError < RuntimeError; end
end

require 'mongodoc/connection'
require 'mongodoc/collection'
require 'mongodoc/document'
