#!/usr/bin/env ruby

# Add height="16" attributes to all FontAwesome SVG icons
# http://www.otsukare.info/2017/11/02/fatwigoo

require 'nokogiri'

svgPaths = {}

Dir["svg/**/*.svg"].each do |path|
  formatted = ""
  icon_name = path.split('/')[-1][0..-5]
  new_path = path.sub /svg\//, 'academicons/'

  File.open path, 'r' do |fstream|
    doc = Nokogiri::XML fstream, &:noblanks

    newDoc = Nokogiri::XML::Document.new
    svgEl = Nokogiri::XML::Node.new 'svg', doc
    svgEl[:xmlns] = 'http://www.w3.org/2000/svg'
    svgEl[:viewBox] = doc.child[:viewBox]
    svgEl[:height] = 16
    svgEl[:class] = 'icon icon-' + icon_name

    pathEls = doc.css('path')
    pathEls.each do |pathEl|
      pathEl.attributes.each do |attr, _|
        unless attr == 'd' or attr == 'transform'
          pathEl.delete attr
        end
      end
      pathEl[:d] = pathEl[:d].gsub(/(?:^| )([A-Za-z])(?:$| )/, '\1').gsub(' -', '-').gsub(/(?<=[^\d])0\./, '.')
      svgEl.add_child pathEl
    end

    formatted = svgEl.to_xml :indent => 0
  end

  File.write new_path, formatted.gsub(/\n/, '') + "\n", mode: 'w+'

  svgPaths[icon_name] = formatted
end

File.open 'demo.html', 'w' do |f|
  f.puts <<~EOF
  <!doctype html>
  <html>
  <head><style>body { display: grid; grid-template-columns: repeat(auto-fill, 100px); grid-auto-rows: minmax(100px, auto); gap: 2em; }
  .ic-wrap { display: flex; flex-direction: column; align-items: center; }
  .icon { height: 64px; }</style></head>
  <body>
  EOF
  svgPaths.sort.map do |path, content|
    f.puts <<~EOF
    <figure class="ic-wrap">
    #{content}
    <figcaption>#{path}</figcaption>
    </figure>
    EOF
  end
  f.puts "</body></html>"
end
