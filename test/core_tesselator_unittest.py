##Copyright 2009-2016 Thomas Paviot (tpaviot@gmail.com)
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

""" This module provides unittests for the visualization wrapper
Usage :
$ python core_visualization_unittest.python """

import json
import os
import unittest
from xml.etree import ElementTree as ET

from OCC.Core.BRepPrimAPI import (BRepPrimAPI_MakeBox,
                                  BRepPrimAPI_MakeTorus,
                                  BRepPrimAPI_MakeSphere)
from OCC.Core.Tesselator import ShapeTesselator

from OCC.Extend.DataExchange import read_step_file

class TestTesselator(unittest.TestCase):
    """ A class for testing tesselation algorithm """
    def test_tesselate_box(self):
        """ 1st test : tesselation of a box """
        a_box = BRepPrimAPI_MakeBox(10, 20, 30).Shape()
        tess = ShapeTesselator(a_box)
        tess.Compute()
        self.assertEqual(tess.ObjGetTriangleCount(), 12)
        self.assertEqual(tess.ObjGetNormalCount(), 24)

    def test_tesselate_torus(self):
        """ 2st test : tesselation of a torus """
        a_torus = BRepPrimAPI_MakeTorus(10, 4).Shape()
        tess = ShapeTesselator(a_torus)
        tess.Compute()
        self.assertGreater(tess.ObjGetTriangleCount(), 100)
        self.assertGreater(tess.ObjGetNormalCount(), 100)

    def test_tesselate_torus_with_edges(self):
        """ 2st test : tesselation of a torus """
        a_torus = BRepPrimAPI_MakeTorus(10, 4).Shape()
        tess = ShapeTesselator(a_torus)
        tess.Compute(compute_edges=True)
        self.assertGreater(tess.ObjGetTriangleCount(), 100)
        self.assertGreater(tess.ObjGetNormalCount(), 100)

    def test_tesselate_torus_with_bad_quality(self):
        """ 2st test : tesselation of a torus """
        a_torus = BRepPrimAPI_MakeTorus(10, 4).Shape()
        tess = ShapeTesselator(a_torus)
        tess.Compute(mesh_quality=40.)
        # since mesh quality is much lower, we should count less vertices and
        # triangles
        self.assertGreater(tess.ObjGetTriangleCount(), 10)
        self.assertLess(tess.ObjGetTriangleCount(), 100)
        self.assertGreater(tess.ObjGetNormalCount(), 10)
        self.assertLess(tess.ObjGetNormalCount(), 100)

    def test_export_to_3js_JSON(self):
        a_box = BRepPrimAPI_MakeBox(10, 20, 30).Shape()
        tess = ShapeTesselator(a_box)
        tess.Compute()
        # get the JSON string
        JSON_str = tess.ExportShapeToThreejsJSONString("myshapeid")
        # check the python JSON parser can decode the string
        # i.e. the JSON string is well formed
        dico = json.loads(JSON_str)
        # after that, check that the number of vertices is ok
        self.assertEqual(len(dico["data"]["attributes"]["position"]["array"]), 36*3)

    def test_tesselate_STEP_file(self):
        """ loads a step file, tesselate. The as1_pe_203 contains
        free edges"""
        stp_file = os.path.join(os.path.join("test_io", "as1_pe_203.stp"))
        stp_file_shape = read_step_file(stp_file)
        stp_file_tesselator = ShapeTesselator(stp_file_shape)

        # free edges have been excluded, then should work as expected
        stp_file_tesselator.Compute(compute_edges=True)

    def test_tesselate_twice(self):
        """ calling Compte() many times should no raise an exception
        """
        another_torus = BRepPrimAPI_MakeTorus(10, 4).Shape()
        torus_tess = ShapeTesselator(another_torus)
        torus_tess.Compute()
        torus_tess.Compute()


def suite():
    """ builds the test suite """
    test_suite = unittest.TestSuite()
    test_suite.addTest(unittest.makeSuite(TestTesselator))
    return test_suite

if __name__ == '__main__':
    unittest.main()
