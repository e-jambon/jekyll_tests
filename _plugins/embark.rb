#encoding: utf-8
module Jekyll
	
  require 'metainspector'

  class EmbarkTag < Liquid::Tag

    def initialize(tag_name, params, tokens)
      super
      array_of_params = params.split("__")
      @url = array_of_params[0]
      @title = array_of_params[1]
      @comment = array_of_params[2]
      @other = array_of_params[3]

      @page = MetaInspector.new(@url)
   end


    def render(context)
      "<div  class='sheet'>
  			<a  href='#{@url}' target='_blank'></a>
  			<h3  class='sheet_title'>#{@title}</h3>
  			<p  class='sheet_description'> #{@comment}</p>
  			<div  class='sheet_embed'> <img  src='#{@page.images.best}'  class='image_embeded'>
    			<h4  class='title_embeded'>#{@page.best_title}</h4>
    			<p  class='excerpt_embeded'> #{@page.description}</p>
    			<p  class='domain_name_embeded'>Source : #{@page.host}</p>
  			</div>
		  </div>"
    end
  end
end

Liquid::Template.register_tag('embark', Jekyll::EmbarkTag)