/*
Copyright 2008-2020 Thomas Paviot (tpaviot@gmail.com)

This file is part of pythonOCC.
pythonOCC is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

pythonOCC is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with pythonOCC.  If not, see <http://www.gnu.org/licenses/>.
*/
%define EXPRINTRPDOCSTRING
"ExprIntrp module, see official documentation at
https://www.opencascade.com/doc/occt-7.4.0/refman/html/package_exprintrp.html"
%enddef
%module (package="OCC.Core", docstring=EXPRINTRPDOCSTRING) ExprIntrp


%{
#ifdef WNT
#pragma warning(disable : 4716)
#endif
%}

%include ../common/CommonIncludes.i
%include ../common/ExceptionCatcher.i
%include ../common/FunctionTransformers.i
%include ../common/Operators.i
%include ../common/OccHandle.i


%{
#include<ExprIntrp_module.hxx>

//Dependencies
#include<Standard_module.hxx>
#include<NCollection_module.hxx>
#include<Expr_module.hxx>
#include<TCollection_module.hxx>
#include<TColgp_module.hxx>
#include<TColStd_module.hxx>
#include<TCollection_module.hxx>
#include<Storage_module.hxx>
%};
%import Standard.i
%import NCollection.i
%import Expr.i
%import TCollection.i

%pythoncode {
from enum import IntEnum
from OCC.Core.Exception import *
};

/* public enums */
/* end public enums declaration */

/* python proy classes for enums */
%pythoncode {
};
/* end python proxy for enums */

/* handles */
%wrap_handle(ExprIntrp_Generator)
%wrap_handle(ExprIntrp_GenExp)
%wrap_handle(ExprIntrp_GenFct)
%wrap_handle(ExprIntrp_GenRel)
/* end handles declaration */

/* templates */
%template(ExprIntrp_ListIteratorOfStackOfGeneralExpression) NCollection_TListIterator<opencascade::handle<Expr_GeneralExpression>>;
%template(ExprIntrp_ListIteratorOfStackOfGeneralFunction) NCollection_TListIterator<opencascade::handle<Expr_GeneralFunction>>;
%template(ExprIntrp_ListIteratorOfStackOfGeneralRelation) NCollection_TListIterator<opencascade::handle<Expr_GeneralRelation>>;
%template(ExprIntrp_SequenceOfNamedExpression) NCollection_Sequence<opencascade::handle<Expr_NamedExpression>>;

%extend NCollection_Sequence<opencascade::handle<Expr_NamedExpression>> {
    %pythoncode {
    def __len__(self):
        return self.Size()
    }
};
%template(ExprIntrp_SequenceOfNamedFunction) NCollection_Sequence<opencascade::handle<Expr_NamedFunction>>;

%extend NCollection_Sequence<opencascade::handle<Expr_NamedFunction>> {
    %pythoncode {
    def __len__(self):
        return self.Size()
    }
};
%template(ExprIntrp_StackOfGeneralExpression) NCollection_List<opencascade::handle<Expr_GeneralExpression>>;

%extend NCollection_List<opencascade::handle<Expr_GeneralExpression>> {
    %pythoncode {
    def __len__(self):
        return self.Size()
    }
};
%template(ExprIntrp_StackOfGeneralFunction) NCollection_List<opencascade::handle<Expr_GeneralFunction>>;

%extend NCollection_List<opencascade::handle<Expr_GeneralFunction>> {
    %pythoncode {
    def __len__(self):
        return self.Size()
    }
};
%template(ExprIntrp_StackOfGeneralRelation) NCollection_List<opencascade::handle<Expr_GeneralRelation>>;

%extend NCollection_List<opencascade::handle<Expr_GeneralRelation>> {
    %pythoncode {
    def __len__(self):
        return self.Size()
    }
};
/* end templates declaration */

/* typedefs */
typedef NCollection_List<opencascade::handle<Expr_GeneralExpression>>::Iterator ExprIntrp_ListIteratorOfStackOfGeneralExpression;
typedef NCollection_List<opencascade::handle<Expr_GeneralFunction>>::Iterator ExprIntrp_ListIteratorOfStackOfGeneralFunction;
typedef NCollection_List<opencascade::handle<Expr_GeneralRelation>>::Iterator ExprIntrp_ListIteratorOfStackOfGeneralRelation;
typedef NCollection_Sequence<opencascade::handle<Expr_NamedExpression>> ExprIntrp_SequenceOfNamedExpression;
typedef NCollection_Sequence<opencascade::handle<Expr_NamedFunction>> ExprIntrp_SequenceOfNamedFunction;
typedef NCollection_List<opencascade::handle<Expr_GeneralExpression>> ExprIntrp_StackOfGeneralExpression;
typedef NCollection_List<opencascade::handle<Expr_GeneralFunction>> ExprIntrp_StackOfGeneralFunction;
typedef NCollection_List<opencascade::handle<Expr_GeneralRelation>> ExprIntrp_StackOfGeneralRelation;
/* end typedefs declaration */

/******************
* class ExprIntrp *
******************/
%rename(exprintrp) ExprIntrp;
class ExprIntrp {
	public:
};


%extend ExprIntrp {
	%pythoncode {
	__repr__ = _dumps_object
	}
};

/***************************
* class ExprIntrp_Analysis *
***************************/
class ExprIntrp_Analysis {
	public:
		/****************** ExprIntrp_Analysis ******************/
		%feature("compactdefaultargs") ExprIntrp_Analysis;
		%feature("autodoc", "No available documentation.

Returns
-------
None
") ExprIntrp_Analysis;
		 ExprIntrp_Analysis();

		/****************** GetFunction ******************/
		%feature("compactdefaultargs") GetFunction;
		%feature("autodoc", "No available documentation.

Parameters
----------
name: TCollection_AsciiString

Returns
-------
opencascade::handle<Expr_NamedFunction>
") GetFunction;
		opencascade::handle<Expr_NamedFunction> GetFunction(const TCollection_AsciiString & name);

		/****************** GetNamed ******************/
		%feature("compactdefaultargs") GetNamed;
		%feature("autodoc", "No available documentation.

Parameters
----------
name: TCollection_AsciiString

Returns
-------
opencascade::handle<Expr_NamedExpression>
") GetNamed;
		opencascade::handle<Expr_NamedExpression> GetNamed(const TCollection_AsciiString & name);

		/****************** IsExpStackEmpty ******************/
		%feature("compactdefaultargs") IsExpStackEmpty;
		%feature("autodoc", "No available documentation.

Returns
-------
bool
") IsExpStackEmpty;
		Standard_Boolean IsExpStackEmpty();

		/****************** IsRelStackEmpty ******************/
		%feature("compactdefaultargs") IsRelStackEmpty;
		%feature("autodoc", "No available documentation.

Returns
-------
bool
") IsRelStackEmpty;
		Standard_Boolean IsRelStackEmpty();

		/****************** Pop ******************/
		%feature("compactdefaultargs") Pop;
		%feature("autodoc", "No available documentation.

Returns
-------
opencascade::handle<Expr_GeneralExpression>
") Pop;
		opencascade::handle<Expr_GeneralExpression> Pop();

		/****************** PopFunction ******************/
		%feature("compactdefaultargs") PopFunction;
		%feature("autodoc", "No available documentation.

Returns
-------
opencascade::handle<Expr_GeneralFunction>
") PopFunction;
		opencascade::handle<Expr_GeneralFunction> PopFunction();

		/****************** PopName ******************/
		%feature("compactdefaultargs") PopName;
		%feature("autodoc", "No available documentation.

Returns
-------
TCollection_AsciiString
") PopName;
		TCollection_AsciiString PopName();

		/****************** PopRelation ******************/
		%feature("compactdefaultargs") PopRelation;
		%feature("autodoc", "No available documentation.

Returns
-------
opencascade::handle<Expr_GeneralRelation>
") PopRelation;
		opencascade::handle<Expr_GeneralRelation> PopRelation();

		/****************** PopValue ******************/
		%feature("compactdefaultargs") PopValue;
		%feature("autodoc", "No available documentation.

Returns
-------
int
") PopValue;
		Standard_Integer PopValue();

		/****************** Push ******************/
		%feature("compactdefaultargs") Push;
		%feature("autodoc", "No available documentation.

Parameters
----------
exp: Expr_GeneralExpression

Returns
-------
None
") Push;
		void Push(const opencascade::handle<Expr_GeneralExpression> & exp);

		/****************** PushFunction ******************/
		%feature("compactdefaultargs") PushFunction;
		%feature("autodoc", "No available documentation.

Parameters
----------
func: Expr_GeneralFunction

Returns
-------
None
") PushFunction;
		void PushFunction(const opencascade::handle<Expr_GeneralFunction> & func);

		/****************** PushName ******************/
		%feature("compactdefaultargs") PushName;
		%feature("autodoc", "No available documentation.

Parameters
----------
name: TCollection_AsciiString

Returns
-------
None
") PushName;
		void PushName(const TCollection_AsciiString & name);

		/****************** PushRelation ******************/
		%feature("compactdefaultargs") PushRelation;
		%feature("autodoc", "No available documentation.

Parameters
----------
rel: Expr_GeneralRelation

Returns
-------
None
") PushRelation;
		void PushRelation(const opencascade::handle<Expr_GeneralRelation> & rel);

		/****************** PushValue ******************/
		%feature("compactdefaultargs") PushValue;
		%feature("autodoc", "No available documentation.

Parameters
----------
degree: int

Returns
-------
None
") PushValue;
		void PushValue(const Standard_Integer degree);

		/****************** ResetAll ******************/
		%feature("compactdefaultargs") ResetAll;
		%feature("autodoc", "No available documentation.

Returns
-------
None
") ResetAll;
		void ResetAll();

		/****************** SetMaster ******************/
		%feature("compactdefaultargs") SetMaster;
		%feature("autodoc", "No available documentation.

Parameters
----------
agen: ExprIntrp_Generator

Returns
-------
None
") SetMaster;
		void SetMaster(const opencascade::handle<ExprIntrp_Generator> & agen);

		/****************** Use ******************/
		%feature("compactdefaultargs") Use;
		%feature("autodoc", "No available documentation.

Parameters
----------
func: Expr_NamedFunction

Returns
-------
None
") Use;
		void Use(const opencascade::handle<Expr_NamedFunction> & func);

		/****************** Use ******************/
		%feature("compactdefaultargs") Use;
		%feature("autodoc", "No available documentation.

Parameters
----------
named: Expr_NamedExpression

Returns
-------
None
") Use;
		void Use(const opencascade::handle<Expr_NamedExpression> & named);

};


%extend ExprIntrp_Analysis {
	%pythoncode {
	__repr__ = _dumps_object
	}
};

/****************************
* class ExprIntrp_Generator *
****************************/
%nodefaultctor ExprIntrp_Generator;
class ExprIntrp_Generator : public Standard_Transient {
	public:
		/****************** GetFunction ******************/
		%feature("compactdefaultargs") GetFunction;
		%feature("autodoc", "Returns namedfunction with name <name> already interpreted if it exists. returns a null handle if not.

Parameters
----------
name: TCollection_AsciiString

Returns
-------
opencascade::handle<Expr_NamedFunction>
") GetFunction;
		opencascade::handle<Expr_NamedFunction> GetFunction(const TCollection_AsciiString & name);

		/****************** GetFunctions ******************/
		%feature("compactdefaultargs") GetFunctions;
		%feature("autodoc", "No available documentation.

Returns
-------
ExprIntrp_SequenceOfNamedFunction
") GetFunctions;
		const ExprIntrp_SequenceOfNamedFunction & GetFunctions();

		/****************** GetNamed ******************/
		%feature("compactdefaultargs") GetNamed;
		%feature("autodoc", "No available documentation.

Returns
-------
ExprIntrp_SequenceOfNamedExpression
") GetNamed;
		const ExprIntrp_SequenceOfNamedExpression & GetNamed();

		/****************** GetNamed ******************/
		%feature("compactdefaultargs") GetNamed;
		%feature("autodoc", "Returns namedexpression with name <name> already interpreted if it exists. returns a null handle if not.

Parameters
----------
name: TCollection_AsciiString

Returns
-------
opencascade::handle<Expr_NamedExpression>
") GetNamed;
		opencascade::handle<Expr_NamedExpression> GetNamed(const TCollection_AsciiString & name);

		/****************** Use ******************/
		%feature("compactdefaultargs") Use;
		%feature("autodoc", "No available documentation.

Parameters
----------
func: Expr_NamedFunction

Returns
-------
None
") Use;
		void Use(const opencascade::handle<Expr_NamedFunction> & func);

		/****************** Use ******************/
		%feature("compactdefaultargs") Use;
		%feature("autodoc", "No available documentation.

Parameters
----------
named: Expr_NamedExpression

Returns
-------
None
") Use;
		void Use(const opencascade::handle<Expr_NamedExpression> & named);

};


%make_alias(ExprIntrp_Generator)

%extend ExprIntrp_Generator {
	%pythoncode {
	__repr__ = _dumps_object
	}
};

/*************************
* class ExprIntrp_GenExp *
*************************/
%nodefaultctor ExprIntrp_GenExp;
class ExprIntrp_GenExp : public ExprIntrp_Generator {
	public:
		/****************** Create ******************/
		%feature("compactdefaultargs") Create;
		%feature("autodoc", "No available documentation.

Returns
-------
opencascade::handle<ExprIntrp_GenExp>
") Create;
		static opencascade::handle<ExprIntrp_GenExp> Create();

		/****************** Expression ******************/
		%feature("compactdefaultargs") Expression;
		%feature("autodoc", "Returns expression generated. raises an exception if isdone answers false.

Returns
-------
opencascade::handle<Expr_GeneralExpression>
") Expression;
		opencascade::handle<Expr_GeneralExpression> Expression();

		/****************** IsDone ******************/
		%feature("compactdefaultargs") IsDone;
		%feature("autodoc", "Returns false if any syntax error has occurred during process.

Returns
-------
bool
") IsDone;
		Standard_Boolean IsDone();

		/****************** Process ******************/
		%feature("compactdefaultargs") Process;
		%feature("autodoc", "Processes given string.

Parameters
----------
str: TCollection_AsciiString

Returns
-------
None
") Process;
		void Process(const TCollection_AsciiString & str);

};


%make_alias(ExprIntrp_GenExp)

%extend ExprIntrp_GenExp {
	%pythoncode {
	__repr__ = _dumps_object
	}
};

/*************************
* class ExprIntrp_GenFct *
*************************/
%nodefaultctor ExprIntrp_GenFct;
class ExprIntrp_GenFct : public ExprIntrp_Generator {
	public:
		/****************** Create ******************/
		%feature("compactdefaultargs") Create;
		%feature("autodoc", "No available documentation.

Returns
-------
opencascade::handle<ExprIntrp_GenFct>
") Create;
		static opencascade::handle<ExprIntrp_GenFct> Create();

		/****************** IsDone ******************/
		%feature("compactdefaultargs") IsDone;
		%feature("autodoc", "No available documentation.

Returns
-------
bool
") IsDone;
		Standard_Boolean IsDone();

		/****************** Process ******************/
		%feature("compactdefaultargs") Process;
		%feature("autodoc", "No available documentation.

Parameters
----------
str: TCollection_AsciiString

Returns
-------
None
") Process;
		void Process(const TCollection_AsciiString & str);

};


%make_alias(ExprIntrp_GenFct)

%extend ExprIntrp_GenFct {
	%pythoncode {
	__repr__ = _dumps_object
	}
};

/*************************
* class ExprIntrp_GenRel *
*************************/
%nodefaultctor ExprIntrp_GenRel;
class ExprIntrp_GenRel : public ExprIntrp_Generator {
	public:
		/****************** Create ******************/
		%feature("compactdefaultargs") Create;
		%feature("autodoc", "No available documentation.

Returns
-------
opencascade::handle<ExprIntrp_GenRel>
") Create;
		static opencascade::handle<ExprIntrp_GenRel> Create();

		/****************** IsDone ******************/
		%feature("compactdefaultargs") IsDone;
		%feature("autodoc", "Returns false if any syntax error has occurred during process.

Returns
-------
bool
") IsDone;
		Standard_Boolean IsDone();

		/****************** Process ******************/
		%feature("compactdefaultargs") Process;
		%feature("autodoc", "Processes given string.

Parameters
----------
str: TCollection_AsciiString

Returns
-------
None
") Process;
		void Process(const TCollection_AsciiString & str);

		/****************** Relation ******************/
		%feature("compactdefaultargs") Relation;
		%feature("autodoc", "Returns relation generated. raises an exception if isdone answers false.

Returns
-------
opencascade::handle<Expr_GeneralRelation>
") Relation;
		opencascade::handle<Expr_GeneralRelation> Relation();

};


%make_alias(ExprIntrp_GenRel)

%extend ExprIntrp_GenRel {
	%pythoncode {
	__repr__ = _dumps_object
	}
};

/* harray1 classes */
/* harray2 classes */
/* hsequence classes */
