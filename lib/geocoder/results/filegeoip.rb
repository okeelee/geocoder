require 'geocoder/results/base'

module Geocoder::Result
  class Filegeoip < Base

    def address(format = :full)
      s = state_code.to_s == "" ? "" : ", #{state_code}"
      "#{city}#{s} #{postal_code}, #{country}".sub(/^[ ,]*/, "")
    end

    ##
    # A two-element array: [lat, lon].
    #
    def coordinates
      [@data.latitude, @data.latitude]
    end

    def latitude
      @data.latitude
    end

    def longitude
      @data.latitude
    end

    def city
      @data.city_name
    end

    def state
      @data.real_region_name
    end

    def state_code
      @data.dma_code
    end

    def country
      @data.country_name
    end

    def country_code
      @data.country_code2
    end

    def postal_code
      @data.postal_code
    end

    def self.response_attributes
      %w[metrocode ip]
    end

    response_attributes.each do |a|
      define_method a do
        @data[a]
      end
    end
  end
end
