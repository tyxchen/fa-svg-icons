## Icons

The icons in this folder are customized from [FontAwesome 7.2.0](https://fontawesome.com/) and
[Academicons 1.9.6](https://jpswalsh.github.io/academicons), which are licensed under
[CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and
[SIL OFL 1.1](https://openfontlicense.org/open-font-license-official-text/) respectively.

## Customized? What does that mean?

All of the SVG icons have an extra `height='16'` attribute added to the root svg element.
This is done to prevent what is known as a [fatwigoo](http://www.otsukare.info/2017/11/02/fatwigoo).

Each icon is also given a class corresponding to their file name.

## How are the icons customized?

1. Download `fontawesome-free-7.2.0-web.zip` and `academicons-1.9.6.zip` to this directory
2. Extract the `svgs` folder, so that the path of an icon would look like
    `./svgs/icon-type/icon.svg`
3. Chmod and run `./_tools/format-icons.py`. The customized icons will appear in the current folder.

## I don't see the icons appearing when I run `git status`!

That's fine. The source folder and zip are ignored by default.