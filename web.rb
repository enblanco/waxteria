$: << File.dirname(__FILE__)

module Web
  def self.root
    File.join(File.dirname(__FILE__), 'web')
  end
end

require 'web/application'
