class HomeController < ApplicationController
  def index
    @search = params[:search]

    if @search
      require 'open-uri'
      require 'nokogiri'
      require 'multi_xml'
      require 'net/http'

      url = @search
      
      # convert @url variable to a URI
      uri = URI(url)
      
      # initialize response with the uri
      response = Net::HTTP.get(uri)
      
      # parse the XML using Nokogiri
      doc = MultiXml.parse(response) 
    
      doc1 = doc['rss']['channel']
      title = doc['rss']['channel']['description']

      # @des = doc2 = doc['rss']['channel']['item'][0]['description']
    
      @title = title
      
      # iterate through the first <item> tag
      doc1.each do |name, content, pub_date|
        if name == 'item'
            @description = "#{content[0]['title']}"
            @link = "#{content[0]['link']}"
            @pub_date = "#{content[0]['pubDate']}"
        end
      end
    end
  end
end
