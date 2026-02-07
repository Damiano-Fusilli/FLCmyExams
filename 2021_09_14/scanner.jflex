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

nl = \r|\n|\r\n
ws = [ \t]


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

tok1 = "I_" {date} (":"{hour})?
date = {september}"/09/2021" | 
        {october}"/10/2021" |
        {november}"/11/2021" |
        {december}"/12/2021" |
        {january}"/01/2022" |
        {february}"/02/2022" |
        {march}"/03/2022"
hour = 0[89]":"[0-5][0-9] | 1[0-6]":"[0-5][0-9] | 17":"[0-2][0-9] | 17":"3[0-5]
september = ("0"[3-9] | [12][0-9] | "3"[0-0])
october = ("0"[1-9] | [12][0-9] | "3"[0-1])
november = ("0"[1-9] | [12][0-9] | "3"[0])
december = ("0"[1-9] | [12][0-9] | "3"[0-1])
january = ("0"[1-9] | [12][0-9] | "3"[01])
february = ("0"[1-9] | "1"[0-9] | "2"[0-8])
march = ("0"[1-5])

tok2 ="J_" ({hexa} {separ}){5} {hexa} ({separ} {hexa} {separ} {hexa})*
hexa = 3[b-fB-F] | [4-9a-fA-F][0-9a-fA-F] | [0-9][0-9a-fA-F]{2}
        | [aA][0-9a-dA-D][0-9a-fA-F] | [aA][eE][0-3]
separ = "+" | "-" | "*"

tok3 = "K_" {word} ({numbers} {numbers} {numbers} {numbers}*)?
word = [a-zA-Z]{5} ([a-zA-Z][a-zA-Z])*
numbers = 00 | 11 | 01 | 10

uint = 0 | [1-9][0-9]*

qstring = \" ~ \"

comment = "+--" ~ "--+"

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
";"             {return sym(sym.SC);}
","             {return sym(sym.COMMA);}
"["             {return sym(sym.BO);}
"]"             {return sym(sym.BC);}
"="             {return sym(sym.EQ);}
"=="            {return sym(sym.EQEQ);}
">"             {return sym(sym.GT);}
"INIT"          {return sym(sym.INIT);}
"HEIGHT"        {return sym(sym.HEIGHT);}
"SPEED"         {return sym(sym.SPEED);}
"SUM"           {return sym(sym.SUM);}
"MUL"           {return sym(sym.MUL);}
"COND"          {return sym(sym.COND);}
"UPDATE"        {return sym(sym.UPDATE);}
"DONE"          {return sym(sym.DONE);}

{qstring}          {return sym(sym.QSTRING, new String(yytext()));}
{uint}             {return sym(sym.UINT, new Integer(yytext()));}

{comment}          {;}

\r | \n | \r\n | " " | \t   {;}

.                   {System.out.println("Scanner Error: " + yytext());}