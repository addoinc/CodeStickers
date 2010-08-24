require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)
require 'syntax/convertors/html'

class Sticker
  def self.call(env)
    sticker = Sticker.new
    sticker.request_handler(env)
  end

  def request_handler(env)
    if env["PATH_INFO"] =~ /^\/sticker$/
      [200, {"Content-Type" => "text/html"}, new_sticker]
    elsif env["PATH_INFO"] =~ /^\/sticker\/create$/
      create_sticker(Rack::Request.new(env))
    elsif env["PATH_INFO"] =~ /^\/sticker\/(\d+)$/
      show($1)
    elsif env["PATH_INFO"] =~ /^\/sticker\/(\d+)\.js$/
      render_js($1)
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
  
  private
  
  def initialize
  end
   
  def new_sticker
    layout(%(
      <tt>Type/paste ruby code and press create to generate your code sticker</tt><br /><br />
      <form action='/sticker/create' class='new_sticker' id='new_sticker' method='post'>
        <textarea name='sticker[sticker]' rows="20" cols="80"></textarea><br />
        <input name='commit' type='submit' value='Create' />
      </form>
    ))
  end
  
  def create_sticker(request)
    if request.post?
      params = request.params['sticker']
      sticker = CodeSticker.new(params)
      sticker.save
      [301, { "Location" => "/sticker/#{sticker.id}"}, []]
    else
      [301, { "Location" => "/sticker"}, []]
    end
  end
  
  def show(id)
    sticker = CodeSticker.find_by_id(id)
    if( !sticker.nil? )
      convertor = Syntax::Convertors::HTML.for_syntax 'ruby'
      html = convertor.convert(sticker.sticker)
      html = %(
      <div class="ruby">
      CodeSticker Link: &nbsp; <a href="http://127.0.0.1:3000/sticker/#{sticker.id}">http://127.0.0.1:3000/sticker/#{sticker.id}</a> | 
      Embed: &nbsp: <input type="text" value="<script src='http://127.0.0.1:3000/sticker/#{sticker.id}.js'></script>" /><br /><br />
      #{html}
      </div>
      )
      [200, {"Content-Type" => "text/html"}, layout(html)]
    else
      [301, { "Location" => "/sticker", "Cache-Control" => "no-cache"}, []]
    end
  end

  def render_js(id)
    sticker = CodeSticker.find_by_id(id)
    if( !sticker.nil? )
      convertor = Syntax::Convertors::HTML.for_syntax 'ruby'
      html = convertor.convert(sticker.sticker)
      html = %(<div class="ruby">#{html}</div>)
      
      html = html.split("\n").map {
        |line|
        line.gsub!(/\s+$/, '')
        line.gsub!(/'/, "\'")
        line.gsub!(/\\n/, '\\\#{$1}')
        "document.write('#{line} <br />');"
      }.join("\n")
      [200, {"Content-Type" => "text/javascript"}, "#{html}"]
    else
      [200, {"Content-Type" => "text/javascript"}, "document.write('');"]
    end
  end
  
  def layout(content)
    %(<html><head>
    <title>CodeStickers</title>
    <style type="text/css">
    body {
      text-align: center;
    }
    #header {
      background:#111111 none repeat scroll 0%;
      border-bottom:3px solid #999999;
      padding:5px 4% 10px;
      color: #FFFFFF;
      font-weight: bold;
      font-size: 3em;
      text-align: center;
      font-family: monospace;
    }
    #container {
      background:white none repeat scroll 0%;
      border-color:#CCCCCC rgb(187, 187, 187) rgb(187, 187, 187) rgb(204, 204, 204);
      border-style:solid;
      border-width:1px 4px 4px 1px;
      margin:0 auto;
      min-height:330px;
      min-width:450px;
      padding:25px;
      position:relative;
      width:70%;
    }
    textarea {
      border: 1px solid #AAAAAA;
    }
    .ruby { text-align: left; }
    .ruby .normal {}
    .ruby .comment { color: #005; font-style: italic; }
    .ruby .keyword { color: #A00; font-weight: bold; }
    .ruby .method { color: #077; }
    .ruby .class { color: #074; }
    .ruby .module { color: #050; }
    .ruby .punct { color: #447; font-weight: bold; }
    .ruby .symbol { color: #099; }
    .ruby .string { color: #944; background: #FFE; }
    .ruby .char { color: #F07; }
    .ruby .ident { color: #004; }
    .ruby .constant { color: #07F; }
    .ruby .regex { color: #B66; background: #FEF; }
    .ruby .number { color: #F99; }
    .ruby .attribute { color: #7BB; }
    .ruby .global { color: #7FB; }
    .ruby .expr { color: #227; }
    .ruby .escape { color: #277; }
    </style>
    </head><body>
    <div id="header">
    <a href="/sticker">CodeStickers</a>
    </div>
    <br />
    <div id="container">
    #{content}
    </div>
    </boby></html>)
  end
  
end
