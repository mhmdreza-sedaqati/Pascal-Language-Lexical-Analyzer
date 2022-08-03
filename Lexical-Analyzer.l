%option	noyywrap
%{
	#include <stdio.h>
%}

DIGIT			[0-9]
BOOLEAN			"false"|"true"
INTEGER			{DIGIT}+
CHARACTER		"'"[^'\n]{1}"'"
FLOAT			{DIGIT}*"."{DIGIT}+
STRING			"'"[^'\n]{2,}"'"
IDENTIFIER		[a-zA-Z_][a-zA-Z0-9_]*
WHITE_SPACE		[ \t\n]+
SL_COMMENTS		"--"[^\n]*"\n"

%x	ML_COMMENT

%%

"\+"			{printf("An Addition Operator: %s\n", yytext);}
"\-"			{printf("A Subtraction Operator: %s\n", yytext);}
"\*"			{printf("A Multiplication Operator: %s\n", yytext);}
"\/"			{printf("A Division Operator: %s\n", yytext);}
"\%"			{printf("A Modulo Operator: %s\n", yytext);}

"\="			{printf("An Equal Operator: %s\n", yytext);}
"\<\>"			{printf("A Not Equal Operator: %s\n", yytext);}
"\<"			{printf("A Less Than Operator: %s\n", yytext);}
"\>"			{printf("A Greater Than Operator: %s\n", yytext);}

"\.\."			{printf("A Range Delimiter Symbol: %s\n", yytext);}
"\."			{printf("A Point Symbol: %s\n", yytext);}
"\,"			{printf("A Comma Symbol: %s\n", yytext);}
"\:"			{printf("A Specifier Symbol: %s\n", yytext);}
"\("			{printf("A Left Parenthese Symbol: %s\n", yytext);}
"\)"			{printf("A Right Parenthese Symbol: %s\n", yytext);}
"\["			{printf("A Left Bracket Symbol: %s\n", yytext);}
"\]"			{printf("A Right Bracket Symbol: %s\n", yytext);}
"\{"			{printf("A Left Braces Symbol: %s\n", yytext);}
"\}"			{printf("A Right Braces Symbol: %s\n", yytext);}
"\:\="			{printf("An Assignment Symbol: %s\n", yytext);}
"\;"			{printf("A Simcolon Symbol: %s\n", yytext);}

{BOOLEAN}		{printf("A Boolean: %s\n", yytext);}
{INTEGER}		{printf("An Integer: %s\n", yytext);}
{CHARACTER}		{printf("A Character: %s\n", yytext);}
{FLOAT}			{printf("A Float: %s\n", yytext);}
{STRING}		{printf("A String: %s\n", yytext);}

"integer"		{printf("An Integer Type: %s\n", yytext);}
"boolean"		{printf("A Boolean Type: %s\n", yytext);}
"char"			{printf("A Char Type: %s\n", yytext);}
"string"		{printf("A String Type: %s\n", yytext);}
"real"			{printf("A Real Type: %s\n", yytext);}
"array"			{printf("An Array Type: %s\n", yytext);}

"while"			{printf("A While Keyword: %s\n", yytext);}
"do"			{printf("A Do Keyword: %s\n", yytext);}
"if"			{printf("An If Keyword: %s\n", yytext);}
"else"			{printf("A Else Keyword: %s\n", yytext);}
"begin"			{printf("A Begin Keyword: %s\n", yytext);}
"end"			{printf("An End Keyword: %s\n", yytext);}
"of"			{printf("An Of Keyword: %s\n", yytext);}
"start"			{printf("A Start Keyword: %s\n", yytext);}
"read"			{printf("A Read Keyword: %s\n", yytext);}
"write"			{printf("A Write Keyword: %s\n", yytext);}
"function"		{printf("A Function Keyword: %s\n", yytext);}
"procedure"		{printf("A Procedure Keyword: %s\n", yytext);}
"return"		{printf("A Return Keyword: %s\n", yytext);}
"var"			{printf("A Var Keyword: %s\n", yytext);}
"program"		{printf("A Program Keyword: %s\n", yytext);}
"type"			{printf("A Type Keyword: %s\n", yytext);}
"const"			{printf("A Const Keyword: %s\n", yytext);}
"not"			{printf("A Not Keyword: %s\n", yytext);}
"eof"			{printf("An EOF Keyword: %s\n", yytext);}
"then"			{printf("A Then Keyword: %s\n", yytext);}

{IDENTIFIER}		{printf("An Identifier: %s\n", yytext);}

{SL_COMMENTS}		{printf("A Single Line Comments: %s", yytext);}
"<--"			{BEGIN(ML_COMMENT);}{printf("A Multiple Line Comments: %s\n", yytext);}
<ML_COMMENT>{
		"-->"	{BEGIN(INITIAL);}{printf("%s\n", yytext);}
	    }

{WHITE_SPACE}		/* Do Nothing */
.			{printf("An Unrecognized Character: %s\n", yytext);}

%%

int main(int argc, char** argv)
{
	++argv, --argc;
	if (argc > 0){
		yyin = fopen(argv[0], "r");
	} else {
		yyin = stdin;
	}
	yylex();
	return 0;
}