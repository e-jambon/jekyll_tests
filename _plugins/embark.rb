#encoding: utf-8
module Jekyll

  require 'metainspector'
  require 'fileutils'
  require 'uri'
  require 'digest'


CACHEFOLDER = "assets/embarked" # Change this in case you want to set the cachefolder elsewhere.


  class EmbarkTag < Liquid::Tag

    def initialize(tag_name, params, tokens)
      super
      # params are contained within a written after the tag.
      # params are separated by "__" characters. Arbitrary decision.
      
      # FIXME : This is absurd and probably a source for bugs, given an url can contain __.
      

      array_of_params = params.split("__")
      url = (array_of_params[0]).strip
      @embarkedURI = URI("#{url}")
      @title = (array_of_params[1]).strip
      @comment = array_of_params[2]
      @style = array_of_params[3]


      @cacheFolder = CACHEFOLDER # You may want to choose another structure.
    end

    def folderExists?(folder)
      File.directory?(folder)
    end

    def alreadyEmbarked?(folder, filename)
      File.exists?("#{folder}/#{filename}.html")
    end

    def uriOrderParams!()
      @embarkedURI.query &&= @embarkedURI.query.split("&").sort.join("&")
    end

    def getUriMD5()
      begin
        uriOrderParams!
        md5 = Digest::MD5.new
        md5 << @embarkedURI.to_s 
        md5.hexdigest  
      rescue StandardError => e
        puts " Error in  embark plugin : getUriMD5. #{e.backtrace.first}: #{e.message} (#{e.class})", e.backtrace.drop(1).map{|s| "\t#{s}"}
      end
    end

    def writeContentToCache (filename, content )
      begin
        embarkedHtmlFile = File.new("#{@cacheFolder}/#{filename}.html", "w:UTF-8")
        embarkedHtmlFile.puts content       
      rescue IOError => e
        puts " Error in  embark plugin : writeContentToCache. #{e.backtrace.first}: #{e.message} (#{e.class})", e.backtrace.drop(1).map{|s| "\t#{s}"}
      ensure
        embarkedHtmlFile && embarkedHtmlFile.close
      end
    end


    def render(context)
      cacheFileName = getUriMD5()
      if ( alreadyEmbarked?(@cacheFolder, "#{cacheFileName}") )
        html = File.read("#{@cacheFolder}/#{cacheFileName}.html")
        html #  including the content of the file it in the post.
      else
        if !(folderExists? ("#{@cacheFolder}"))
          FileUtils::mkdir_p "#{@cacheFolder}"
        end

        # cf metainspector : https://github.com/jaimeiniesta/metainspector
        page = MetaInspector.new(@embarkedURI.to_s)

        content = "<div  class='sheet_#{@style}'>"  +
        "<a  href='#{@embarkedURI.to_s}' target='_blank'></a>" +
        "<h3  class='sheet_title_#{@style}'>#{@title}</h3>" +
        "<p  class='sheet_description_#{@style}'> #{@comment}</p>" +
        "<div  class='sheet_embed_#{@style}'> " +
        "<img  src='#{page.images.best}'  class='image_embeded_#{@style}'>" +
        "<h4  class='title_embeded_#{@style}'>#{page.best_title}</h4>" +
        "<p  class='excerpt_embeded_#{@style}'> #{page.description}</p>" +
        "<p  class='domain_name_embeded'>Source : #{page.host}</p>" +
        "</div>" +
        "</div>"

        content && (writeContentToCache cacheFileName , content)
        content # Including the content in the post. 
      end
      # What could possibly go wrong  when playing with strings and files ?
      # FIXME : No tests...
    end # render(context)
  end # class EmbarkTag
end # Module Jekyll

Liquid::Template.register_tag('embark', Jekyll::EmbarkTag)
