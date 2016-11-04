#!/usr/bin/env ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'optparse'
require 'uri'
options={}
opt_parser = OptionParser.new do |opts|
	opts.banner = "Usage: opt.rb [options]"
	opts.on("-n", "--website website", "website") do |website|
	    options[:website] = website
	end    
end
opt_parser.parse!
strurl = options[:website]
page = Nokogiri::HTML(open(strurl))   
puts "title:\t"+ page.css('title').text
['h1', 'h2', 'h3' , 'h4'].each { |tag| puts tag + ':' + page.css(tag).map(&:text).join(",") }
l = page.css('a').map do |link| 
	URI::join(strurl, l) if (l = link.attr("href")) && !l.empty?
end.compact.uniq
n = l.size
puts"extrnallink:"
puts l.reject{ |n| n.to_s.include?strurl}
puts"internallink:" 
puts l.select{ |n| n.to_s.include?strurl}
