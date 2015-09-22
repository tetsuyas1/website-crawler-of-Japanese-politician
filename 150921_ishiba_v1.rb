# -*- coding: utf-8 -*-
		require 'open-uri'
		require 'rexml/document'
		require 'date'
		require 'nokogiri'
		require 'kconv'

		#1	 ishiba-net
	   	require "fileutils"
#   	#1-0 file open do 2-ishiba contents clear
		File.open("2-Ishiba.txt", "w") do |file|
		file.close
		#1-0 file open do end
		end

		#1-1 file open do 
    	File.open("1-Ishiba.txt", "w") do |file|	

		#1  個別URLの取得
		doc = Nokogiri::HTML(open('http://ishiba-shigeru.cocolog-nifty.com/blog/archives.html'))
		mo01 = doc.xpath("//*[@id=\"center\"]/div[2]/div[1]/p").text rescue nil
		mo02 = doc.xpath("//*[@id=\"center\"]/div[2]/div[1]/p").inner_html rescue nil
		puts mo01

		#2 正規表現でURLにする
		str = mo02
		str.gsub!(/<a\shref="/,"") while /a\shref="/ =~ str
		str.gsub!(/年/,"") while /年/ =~ str
		str.gsub!(/月/,"") while /月/ =~ str
		str.gsub!(/">[0-9]+/,"") while /">[0-9]+/ =~ str
		str.gsub!(/\<\/a><br>/,"") while /\<\/a><br>/ =~ str
		str
		mo02 = str

#		puts mo02　ファイルに書き込む
		file.puts mo02
		file.close
#   	#1-1 file open do
		end

		urls=[]
		#1-2 File open do
    	File.open("1-Ishiba.txt", "r") do |file|
    	#1-3while
    	while line = file.gets
    	urls.push(line)	
    	#1-3 while
     	end
     	#1-2 file open do 
     	file.close
     	end
		


			#2-0 file open do
    		File.open("2-Ishiba.txt", "w") do |file| 

		require 'anemone'	
			#2-1 anemone crawl
			Anemone.crawl(urls, :depth_limit => 0) do |anemone| 
 

			#2-2 anemone.focus crawl
			anemone.focus_crawl do |page|
				http = "http://ishiba-shigeru.cocolog-nifty.com/blog/"
				page.links.keep_if { |link|
					link.to_s.match(http)
				}
			#2-2 focus_crawl end
			end

			#2-3 anemone.on every page
			anemone.on_every_page do |page|
			test = page.url rescue nil
     		doc = Nokogiri::HTML.parse(open(test).read, nil, 'utf-8') rescue nil

#     		puts test
     		head = doc.xpath("//*[@id=\"center\"]/div[2]/div[3]/h3/a").text rescue nil
#     		puts head
     		link = doc.xpath("//*[@id=\"center\"]/div[2]/*/p/a[1]").to_html rescue nil
     		str = link
     		str.gsub!(/固定リンク/,"\n") while /固定リンク/ =~ str
     		str.gsub!(/年/,"") while /年/ =~ str
			str.gsub!(/月/,"") while /月/ =~ str
			str.gsub!(/<\/a><a class="permalink" href="/,"") while /<\/a><a class="permalink" href="/ =~ str
			str.gsub!(/">/,"") while /">/ =~ str
			str.gsub!(/<a\shref="/,"") while /a\shref="/ =~ str
			str.gsub!(/ishiba\-shigeru\.cocolog\-nifty\.com\/blog\/[0-9][0-9][0-9][0-9]\/[0-9][0-9]\/index\.html/, "") while /<ishiba\-shigeru\.cocolog\-nifty\.com\/blog\/[0-9][0-9][0-9][0-9]\/[0-9][0-9]\/index\.html/ =~ str
			str.gsub!(/[0-9][0-9][0-9][0-9][0-9][0-9]/,"") while /[0-9][0-9][0-9][0-9][0-9][0-9]/ =~ str
			str.gsub!(/[0-9][0-9][0-9][0-9][0-9]/,"") while /[0-9][0-9][0-9][0-9][0-9]/ =~ str
			str.gsub!(/<\/a>/,"") while /<\/a>/ =~ str
			str.gsub!(/«/,"") while /«/ =~ str
			str.gsub!(/http:\/\/ishiba-shigeru.cocolog-nifty.com\/blog\/トップページ/,"") while /http:\/\/ishiba-shigeru.cocolog-nifty.com\/blog\/トップページ/ =~ str
			str.gsub!(/http:\/\/ishiba-shigeru.cocolog-nifty.com\/blog\/[0-9][0-9][0-9][0-9]\/[0-9][0-9]\/index\.html\s/,"") while /http:\/\/ishiba-shigeru.cocolog-nifty.com\/blog\/[0-9][0-9][0-9][0-9]\/[0-9][0-9]\/index.html\s/ =~ str
#			str.gsub!(/\s+/,"") while /\s+/ =~ str

     		link = str
#     		puts link

			#2-0 file open do
    		File.open("2-Ishiba.txt", "a") do |file| 

    		file.puts link
    		file.close

    	end
     		#2-3 anemone.on every page
	     	end
	     	#2-1 anemone do 
	     	end
	    #2-0 file open do
    	end

    	urls=[]
		#3-0 File open do
    	File.open("2-Ishiba.txt", "r") do |file|
    	#3-1while
    	while line = file.gets
    	urls.push(line)	
    	#3-2 while
     	end
     	#3-3 file open do 
     	file.close
     	end

		require 'json'
		#4-0 open json do
		open("file.json", "w") do |io|

		require 'anemone'	
			#4-1 anemone crawl
			Anemone.crawl(urls, :depth_limit => 0) do |anemone|
 

			#4-2 anemone.focus crawl
			anemone.focus_crawl do |page|
				http = "http://ishiba-shigeru.cocolog-nifty.com/blog/"
				page.links.keep_if { |link|
					link.to_s.match(http)
				}
			#4-2 focus_crawl end
			end

			#4-3 anemone.on every page
			anemone.on_every_page do |page|
			test = page.url rescue nil
     		doc = Nokogiri::HTML.parse(open(test).read, nil, 'utf-8') rescue nil
     		if test == nil
     		else

     		head = doc.xpath("//*[@id=\"center\"]/div[2]/div[3]/h3").text rescue nil
     		time = doc.xpath("//*[@id=\"center\"]/div[2]/h2").text rescue nil
     		body = doc.xpath("//*[@id=\"center\"]/div[2]/div[3]/div[2]").text rescue nil
     		puts head
     		puts time
     		puts body
     		puts test
     		puts
     		puts


			JSON.dump([{"title" => head}, {"date" => time}, {"body" => body}, {"uri" => test}], io)
			#4-0 open json do
			end

			#if end
     		end

     		#4-3
	     	end
	     	#4-1
	     	end
