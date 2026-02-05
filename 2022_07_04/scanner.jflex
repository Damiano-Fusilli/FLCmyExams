import java_cup.runtime.*;

%%

%unicode
%cup
%line
%column

%{
    private Symbol sym(int type){
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol sym(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
%}


/*
uint = 0 | [1-9][0-9]*
id = [a-zA-Z_][a-zA-Z0-9_]*
hexnum = [0-9a-fA-F]
float = ("+"|"-")? ((0\.[0-9]*) | [1-9][0-9]*\.[0-9]* | [1-9][0-9]*)
double = ([0-9]+\.[0-9]* | ([0-9]*\.[0-9]+)) ([e|E] ("+"|"-")? [0-9]+)?
qstring = \" ~ \"


ipnum = [0-9] | [1-9][0-9] | 1[0-9]{2} | 2[0-4][0-9] | 25[0-5]
ip = {ipnum} "." {ipnum} "." {ipnum} "." {ipnum}


january = ("0"[1-9] | [12][0-9] | "3"[01])
february = ("0"[1-9] | "1"[0-9] | "2"[0-8])
february_leap = ("0"[1-9] | [12][0-9]) 
march = ("0"[1-9] | [12][0-9] | "3"[0-1])
april = ("0"[1-9] | [12][0-9] | "3"[0])
may = ("0"[1-9] | [12][0-9] | "3"[0-1])
june = ("0"[1-9] | [12][0-9] | "3"[0])
july = ("0"[1-9] | [12][0-9] | "3"[0-1])
august = ("0"[1-9] | [12][0-9] | "3"[0-1])
september = ("0"[1-9] | [12][0-9] | "3"[0-0])
october = ("0"[1-9] | [12][0-9] | "3"[0-1])
november = ("0"[1-9] | [12][0-9] | "3"[0])
december = ("0"[1-9] | [12][0-9] | "3"[0-1])

*/

sep = "===="

tok1 = "D-" {date} ("-" {date})?
date = ("0"[4-9] | [12][0-9] | "3"[0-1]) "/July/2022" |
        ("0"[1-9] | [12][0-9] | "3"[0-1]) "/August/2022" |
        ("0"[1-9] | [12][0-9] | "3"[0-0]) "/September/2022" |
        ("0"[1-9] | [12][0-9] | "3"[0-1]) "/October/2022" |
        ("0"[1-9] | [12][0-9] | "3"[0]) "/November/2022" |
        ("0"[1-9] | [12][0-9] | "3"[0-1]) "/December/2022"|
        ("0"[1-9] | [1][0-5]) "/January/2023"


tok2 = "R-" {word}{4,15} ("????" "??"*)?
word = "XX" | "YY" | "ZZ"

tok3 = "N-" ({hexa} {separ}) {4} {hexa} ({separ} {hexa} {separ} {hexa})*
hexa = 2([a-fA-F]) | [3-9a-fA-F]{2} | [1-9aA][0-9a-fA-F]{2} | [bB][0-9abAB][0-9a-fA-F] | [bB][cC][0-3]
separ = ("+" | "/" | "*")

uint = 0 | [1-9][0-9]*

qstring = \" ~ \"

comment = "[[--" ~ "--]]"
var = [a-zA-Z_][a-zA-Z0-9_]*

//comment = "/*" ~  "*/"
//comment = "//" ~ {nl}
//comment = "#" ~ {nl}

%%

// Strings part
// "str"            {return sym(sym.STR, new String(yytext()));}

// "."             {return sym(sym.DOT);}
// ":"             {return sym(sym.CO);}
// ","             {return sym(sym.COMMA);}
// ";"             {return sym(sym.SC);}

// "("             {return sym(sym.RO);}
// ")"             {return sym(sym.RC);}
// "["             {return sym(sym.BO);}
// "]"             {return sym(sym.BC);}
// "{"             {return sym(sym.CO);}
// "}"             {return sym(sym.CC);}


// "+"             {return sym(sym.PLUS);}
// "-"             {return sym(sym.MINUS);}
// "*"             {return sym(sym.STAR);}
// "/"             {return sym(sym.DIV);}
// "="             {return sym(sym.EQ);}
// "=="            {return sym(sym.EQEQ);}
// "!="            {return sym(sym.NEQ);}


// "&"             {return sym(sym.AND);}
// "|"             {return sym(sym.OR);}
// "&&"            {return sym(sym.ANDAND);}
// "||"            {return sym(sym.OROR);}

// "%"             {return sym(sym.PERC);}
// "?"             {return sym(sym.QUM);}
// "!"             {return sym(sym.EXM);}
// "@"             {return sym(sym.ATM);}
// "#"             {return sym(sym.HAM);}
// "$"             {return sym(sym.DOL);}
// "^"             {return sym(sym.CIM);}


// ">"             {return sym(sym.GT);}
// "<"             {return sym(sym.LT);}
// ">="            {return sym(sym.GTE);}
// "<="            {return sym(sym.LTE);}
// "\\"          {return sym(sym.BSL);}

// \'              {return sym(sym.QU);}
// \"              {return sym(sym.DQU);}
// \`              {return sym(sym.GRAVE);}
// "~"             {return sym(sym.TIL);}
// "_"             {return sym(sym.US);}



// {uint}             {return sym(sym.UINT, new Integer(yytext()));}
// {hexnum}          {return sym(sym.HEXNUM, new Integer(yytext(),16));}
// {float}            {return sym(sym.FLOAT, new Float(yytext()));}
// {double}          {return sym(sym.DOUBLE, new Double(yytext()));}
// {ip}              {return sym(sym.IP, new String(yytext()));}
// {date}            {return sym(sym.DATE, new String(yytext()));}
// {qstring}          {return sym(sym.QSTRING, new String(yytext()));}


// {token_1}          {return sym(sym.TOK1);}
// {token_2}          {return sym(sym.TOK2);}
// {token_3}          {return sym(sym.TOK3);}

//{id}              {return sym(sym.ID, yytext());}


{sep}           {return sym(sym.SEP);}
{tok1}          {return sym(sym.TOK1);}
{tok2}          {return sym(sym.TOK2);}
{tok3}          {return sym(sym.TOK3);}


"="             {return sym(sym.EQ);}
{uint}             {return sym(sym.UINT, new Integer(yytext()));}
";"             {return sym(sym.SC);}
"&"             {return sym(sym.AND);}
"|"             {return sym(sym.OR);}
"!"            {return sym(sym.NOT);}
"("             {return sym(sym.RO);}
")"             {return sym(sym.RC);}
"TRUE"          {return sym(sym.TRUE, new String(yytext()));}
"FALSE"         {return sym(sym.FALSE, new String(yytext()));}
"IF"            {return sym(sym.IF, new String(yytext()));}
"FI"            {return sym(sym.FI, new String(yytext()));}
"DO"            {return sym(sym.DO, new String(yytext()));}
"DONE"          {return sym(sym.DONE, new String(yytext()));}
"PRINT"         {return sym(sym.PRINT, new String(yytext()));}
"AND"           {return sym(sym.ANDs, new String(yytext()));}
"OR"            {return sym(sym.ORs, new String(yytext()));}

{qstring}          {return sym(sym.QSTRING, new String(yytext()));}
{var}           {return sym(sym.VAR, new String(yytext()));}

{comment}          {;}

\r | \n | \r\n | " " | \t   {;}

.                   {System.out.println("Scanner Error: " + yytext());}