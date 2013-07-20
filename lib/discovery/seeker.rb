module Discovery
  class Seeker
    def initialize(adapter)
      @adapter = adapter
    end

    def seek(terms)
      adapter.seek(terms)
    end

    private

    attr_reader :adapter
  end
end
