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
      [@data.try(:latitude), @data.try(:longitude)]
    end

    def latitude
      @data.try(:latitude)
    end

    def longitude
      @data.try(:longitude)
    end

    def city
      @data.try(:city_name)
    end

    def state
      @data.try(:real_region_name)
    end

    def state_code
      @data.try(:region_name)
    end

    def country
      @data.try(:country_name)
    end

    def country_code
      @data.try(:country_code2)
    end

    def postal_code
      @data.try(:postal_code)
    end

    def ip
      @data.try(:ip)
    end
  end
end
