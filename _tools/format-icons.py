#!/usr/bin/env ruby

# Add height="16" attributes to all FontAwesome SVG icons
# http://www.otsukare.info/2017/11/02/fatwigoo

import glob
import pathlib
import xml.etree.ElementTree as ET

ET.register_namespace("", "http://www.w3.org/2000/svg")

def format_svg(svg_path, icon_set, icon_name):
	tree = ET.parse(svg_path)
	root = tree.getroot()
	root.set("height", "16")
	root.set("class", f"icon icon-{icon_set} icon-{icon_name}")
	return tree

def format_all():
	for raw_path in glob.iglob("svgs/**/*.svg"):
		svg_path = pathlib.Path(raw_path)
		icon_name = svg_path.stem
		icon_set = svg_path.parent.stem
		new_path = pathlib.Path(".") / svg_path.with_stem(f"{icon_set}-{icon_name}").name
		
		if icon_set == "solid":
			new_path = new_path.with_stem(icon_name)

		formatted_tree = format_svg(svg_path, icon_set, icon_name)
		formatted_tree.write(new_path)

if __name__ == "__main__":
	format_all()