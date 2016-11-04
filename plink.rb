#!/usr/bin/env ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'optparse'
require 'uri'
options={:website=>nil}
opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: opt.rb [options]"
  opts.on("-n", "--website website", "website") do |website|
    options[:website]=website;
    end
    end
    opt_parser.parse!
    page = Nokogiri::HTML(open(options[:website]))
    puts "title:\t"+ page.css('title').text
    puts "h1:"+page.css('h1').text
    puts "h2:"+page.css('h2').text
    puts "h3:"+page.css('h3').text
    puts "h4:"+page.css('h4').text
    l=page.css('a').map { |link| link['href'] }
    url= l.uniq
    n=url.size
    puts"extrnallink:"
    (0..n).each do  |i|
      uri = URI.parse(URI.encode(url[i].to_s))
      if(uri.scheme!=nil)
        puts uri
        end
        end
        puts "internallink:"
        (0..n).each do  |i|
          uri = URI.parse(url[i].to_s)
          if(uri.scheme==nil)
            puts uri
            end
          end