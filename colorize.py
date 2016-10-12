import colorsys
import os
import re
import sys

crispy_css = 'static/css/crisp.css'
pattern = re.compile(r'^([^#]+)(#[^;]+)(; /\* crispy([^ ]{7}) \*/)')


def hex_to_rgb(hex_str):
    hex_str = hex_str.lstrip('#')
    hex_ = (hex_str[2 * i: 2 * (i + 1)] for i in range(3))
    return tuple(int('0x' + c, 16) for c in hex_)


def rgb_to_hex(dec_tup):
    return '#' + ''.join('%02x' % min(int(round(dec)), 255) for dec in dec_tup)


def get_hex_str_for(groups, hue, lum, sat):
    base_h, base_l, base_s = colorsys.rgb_to_hls(*hex_to_rgb('#24890d'))
    h, l, s = colorsys.rgb_to_hls(*hex_to_rgb(groups[3]))
    h = hue or base_h
    if groups[3] not in ['#24890d', '#fdfffc']:
        s = -0.025 * (255.0 / l)
        l *= 0.975
    if groups[3] == '#24890d':
        l = lum if lum is not None else l
        s = sat if sat is not None else s
    return rgb_to_hex(colorsys.hls_to_rgb(h, l, s))


def change_color(hue, lum, sat):
    crispy_css_tmp = '%s.tmp' % crispy_css
    with open(crispy_css_tmp, 'w') as tmp_fp:
        with open(crispy_css, 'r') as crispy_fp:
            for line in crispy_fp:
                match = pattern.match(line)
                if match:
                    groups = match.groups()
                    hex_str = get_hex_str_for(groups, hue, lum, sat)
                    line = '{}{}{}\n'.format(groups[0], hex_str, groups[2])
                tmp_fp.write(line)
    os.rename(crispy_css_tmp, crispy_css)


def main():
    try:
        color = sys.argv[1]
        hue, lum, sat = colorsys.rgb_to_hls(*hex_to_rgb(color))
    except:
        try:
            hue = float(color)
        except:
            try:
                hue = float(eval(color))
            except:
                hue = None
        try:
            lum = float(sys.argv[2])
        except:
            lum = None
        try:
            sat = float(sys.argv[3])
        except:
            sat = None
    change_color(hue, lum, sat)


if __name__ == '__main__':
    main()
