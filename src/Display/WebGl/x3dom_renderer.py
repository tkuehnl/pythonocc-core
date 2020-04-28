##Copyright 2011-2017 Thomas Paviot (tpaviot@gmail.com)
##
##This file is part of pythonOCC.
##
##pythonOCC is free software: you can redistribute it and/or modify
##it under the terms of the GNU Lesser General Public License as published by
##the Free Software Foundation, either version 3 of the License, or
##(at your option) any later version.
##
##pythonOCC is distributed in the hope that it will be useful,
##but WITHOUT ANY WARRANTY; without even the implied warranty of
##MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##GNU Lesser General Public License for more details.
##
##You should have received a copy of the GNU Lesser General Public License
##along with pythonOCC.  If not, see <http://www.gnu.org/licenses/>.

import os
import sys
import tempfile
import uuid

from OCC import VERSION as OCC_VERSION
from OCC.Extend.DataExchange import X3DScene

from OCC.Display.WebGl.simple_server import start_server


HEADER_TEMPLATE = """
<head>
    <title>pythonOCC @VERSION@ x3dom renderer</title>
    <meta name='Author' content='Thomas Paviot - tpaviot@gmail.com'>
    <meta name='Keywords' content='WebGl,pythonOCC'>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="https://x3dom.org/release/x3dom.css">
    <script src="https://x3dom.org/release/x3dom.js"></script>
    <style>
        body {
            background: linear-gradient(@bg_gradient_color1@, @bg_gradient_color2@);
            margin: 0px;
            overflow: hidden;
        }
        #pythonocc_rocks {
            padding: 5px;
            position: absolute;
            left: 1%;
            bottom: 2%;
            height: 38px;
            width: 280px;
            border-radius: 5px;
            border: 2px solid #f7941e;
            opacity: 0.7;
            font-family: Arial;
            background-color: #414042;
            color: #ffffff;
            font-size: 14px;
            opacity: 0.5;
        }
        #commands {
            padding: 5px;
            position: absolute;
            right: 1%;
            top: 2%;
            height: 65px;
            width: 180px;
            border-radius: 5px;
            border: 2px solid #f7941e;
            opacity: 0.7;
            font-family: Arial;
            background-color: #414042;
            color: #ffffff;
            font-size: 14px;
            opacity: 0.5;
        }
        a {
            color: #f7941e;
            text-decoration: none;
        }
        a:hover {
            color: #ffffff;
        }
    </style>
</head>
"""

BODY = """
<body>
    @X3DSCENE@
    <div id="pythonocc_rocks">
        pythonocc-@VERSION@ <a href="https://www.x3dom.org" target="_blank">x3dom</a> renderer
        <br>Check our blog at
        <a href=http://www.pythonocc.org>http://www.pythonocc.org</a>
    </div>
    <div id="commands">
    <b>t</b> view/hide shape<br>
    <b>r</b> reset view<br>
    <b>a</b> show all<br>
    <b>u</b> upright<br>
    </div>
    <script>
    var selected_target_color = null;
    var current_selected_shape = null;
    var current_mat = null;
    function fitCamera()
    {            
        var x3dElem = document.getElementById('pythonocc-x3d-scene');            
        x3dElem.runtime.fitAll();
    }
    function select(the_shape) // called whenever a shape is clicked
    {
        // restore color for previous selected shape
        if (current_mat) {
            current_mat.diffuseColor = selected_target_color;
        }
        // store the shape for future process
        current_selected_shape = the_shape;
        console.log(the_shape);
        // store color, to be restored later
        appear = current_selected_shape.getElementsByTagName("Appearance")[0];
        mat = appear.getElementsByTagName("Material")[0];
        current_mat = mat;
        console.log(mat);
        selected_target_color = mat.diffuseColor;
        mat.diffuseColor = "1, 0.65, 0";
        //console.log(the_shape.getElementsByTagName("Appearance"));//.getAttribute('diffuseColor'));
    }
    function onDocumentKeyPress(event) {
      event.preventDefault();
      if (event.key=="t") {  // t key
         if (current_selected_shape) {
           if (current_selected_shape.render == "true") {
              current_selected_shape.render = "false";
           }
           else {
              current_selected_shape.render = "true";
           }
         }
      }

    }
    // add events
    document.addEventListener('keypress', onDocumentKeyPress, false);
    </script>
</body>
"""

class X3DomRenderer:
    def __init__(self, path=None, display_axes_plane=True, axes_plane_zoom_factor=1.):
        if not path:  # by default, write to a temp directory
            self._path = tempfile.mkdtemp()
        else:
            self._path = path
        self._html_filename = os.path.join(self._path, 'index.html')
        self._x3d_shapes = {}
        self._x3d_edges = {}
        self._axes_plane = display_axes_plane  # display the small RVB axes and the plane
        self._axes_plane_zoom_factor = axes_plane_zoom_factor

        print("## x3dom webgl renderer - render axes/planes : %r - axes/plane zoom factor : %g" % (self._axes_plane,
                                                                                                   self._axes_plane_zoom_factor))
        self._scene = X3DScene()

    def DisplayShape(self,
                     shape,
                     vertex_shader=None,
                     fragment_shader=None,
                     export_edges=False,
                     color=(0.65, 0.65, 0.7),
                     specular_color=(0.2, 0.2, 0.2),
                     shininess=0.9,
                     transparency=0.,
                     line_color=(0, 0., 0.),
                     line_width=2.,
                     mesh_quality=1.):
        """ Adds a shape to the rendering buffer. This class computes the x3d file
        """
        # if the shape is an edge or a wire, use the related functions
        self._scene.add_shape(shape, color)

    def render(self, addr="localhost", server_port=8080, open_webbrowser=False):
        """ Call the render() method to display the X3D scene.
        """
        # first generate the HTML root file
        self.generate_html_file(self._axes_plane, self._axes_plane_zoom_factor)
        # then create a simple web server
        start_server(addr, server_port, self._path, open_webbrowser)

    def generate_html_file(self, display_axes_plane, axes_plane_zoom_factor):
        """ Generate the HTML file to be rendered wy the web browser
        axes_plane: a boolean, telles wether or not display axes
        """
        with open(self._html_filename, "w") as html_file:
            html_file.write("<!DOCTYPE HTML>\n")
            html_file.write('<html lang="en">')
            # write header
            bg_gradient_color1="#ced7de"
            bg_gradient_color2="#808080"

            header_str = HEADER_TEMPLATE.replace('@bg_gradient_color1@', '%s' % bg_gradient_color1)
            header_str = header_str.replace('@bg_gradient_color2@', '%s' % bg_gradient_color2)
            header_str = header_str.replace('@VERSION@', OCC_VERSION)

            html_file.write(header_str)
            # body
            # merge shapes and edges keys
            all_shapes = list(self._x3d_shapes) + list(self._x3d_edges)
            # write HTML Body

            # get the location where pythonocc is running from
            body_str = BODY.replace('@VERSION@', OCC_VERSION)
            x3dcontent = '\n\t<x3d id="pythonocc-x3d-scene" style="width:100%;border: none" >\n\t\t<Scene>\n'
            nb_shape = len(self._x3d_shapes)
            cur_shp = 1
            if display_axes_plane:
                x3dcontent += """
                <transform scale="%g,%g,%g">
                <transform id="plane_smallaxe_Id" rotation="1 0 0 -1.57079632679">
                    <inline url="https://rawcdn.githack.com/x3dom/component-editor/master/static/x3d/plane.x3d" mapDEFToID="true" namespaceName="plane"></inline>
                    <inline url="https://rawcdn.githack.com/x3dom/component-editor/master/static/x3d/axesSmall.x3d" mapDEFToID="true" namespaceName="axesSmall"></inline>
                </transform>
                <inline url="https://rawcdn.githack.com/x3dom/component-editor/master/static/x3d/axes.x3d" mapDEFToID="true" namespaceName="axes"></inline>
                </transform>
                """ % (axes_plane_zoom_factor, axes_plane_zoom_factor, axes_plane_zoom_factor)
                # global rotateso that z is aligne properly
            x3dcontent += '<transform id="glbal_scene_rotation_Id" rotation="1 0 0 -1.57079632679">'
            
            # writes the x3d file for each shape and inline it
            # export to single file
            # this file is generated using a uid to prevent browser to use cache

            x3d_filename = "%s.x3d" % uuid.uuid4().hex
            self._scene.export_to_single_file(os.path.join(self._path, x3d_filename))
            x3dcontent += '\t\t\t<Inline onload="fitCamera()" mapDEFToID="true" url="%s"></Inline>\n' % x3d_filename
            # for shp_uid in self._x3d_shapes:
            #     sys.stdout.write("\r%s meshing shapes... %i%%" % (next(self.spinning_cursor),
            #                                                       round(cur_shp / nb_shape * 100)))
            #     sys.stdout.flush()

            #     x3dcontent += '\t\t\t<Inline onload="fitCamera()" mapDEFToID="true" url="shp%s.x3d"></Inline>\n' % shp_uid
            #     cur_shp += 1
            x3dcontent += '</transform>'
            x3dcontent += "\t\t</Scene>\n\t</x3d>\n"
            body_str = body_str.replace('@X3DSCENE@', x3dcontent)
            
            html_file.write(body_str)

            # end
            html_file.write("</html>\n")
