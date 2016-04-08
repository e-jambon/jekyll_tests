#encoding: utf-8
module Jekyll

  require 'metainspector'
  require 'fileutils'
  require 'uri'
  require 'digest'



  class EmbarkTag < Liquid::Tag

    def initialize(tag_name, params, tokens)
      super
      # params are contained within a written after the tag.
      # params are separated by "__" characters. Arbitrary decision.
      
      # FIXME : This is absurd and probably a source for bugs, given an url can contain __.
      

      array_of_params = params.split("__")

      @embarkedURI = URI("#{array_of_params[0]}")
      @title = array_of_params[1]
      @comment = array_of_params[2]
      @style = array_of_params[3]
      @cacheFolder = "assets/embarked" #choose where your cache will be...
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
      uriOrderParams!
      md5 = Digest::MD5.new
      md5 << @embarkedURI.to_s # exactly the same as above, it's an alias.
      md5.hexdigest
    end

    def writeContentToCache (filename, content )
        embarkedHtmlFile = File.new("#{@cacheFolder}/#{filename}.html", "w")
        embarkedHtmlFile.puts content
        embarkedHtmlFile.close
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

        writeContentToCache cacheFileName , content
        content # Including the content in the post.
      end

      # No error management, no tests...
      # what could possibly go wrong  when playing with strings and files.

    end
  end
end

Liquid::Template.register_tag('embark', Jekyll::EmbarkTag)
