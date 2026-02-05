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

nl = \r|\n|\r\n | \0
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

sep = "%%%%" "%%"*

tok1 = "A_" {binary} | "A_" {sequence}

binary = 1* 0 1* 0 1* |  1* 0 1* 0 1* 0 1* 0 1* 0 1*
sequence = "*" | "+" | "*+"* "*"? | "+*"* "+"?

tok2 = "B_" {words}
words = ({word}{separ}){3} (({word} {separ})* {word}) ?
word = "-" ([3][02] | [12][02468] | [02468]) | ([02468] | [1-9][02468] | [1-9][0-9][02468] | 1[01][0-9][02468] | 12[0-3][02468] | 124[0246])

separ = "+" | "$" | "*"

uint = 0 | [1-9][0-9]*
float = ("+"|"-")? ((0\.[0-9]*) | [1-9][0-9]*\.[0-9]* | [1-9][0-9]*)

qstring = \" ~ \"

comment = "(((-" ~ "-)))" | "---" .* {nl}*

%%

// Strings part
// "str"            {return sym(sym.STR, new String(yytext()));}

// "."             {return sym(sym.DOT);}
// ":"             {return sym(sym.CO);}
// ","             {return sym(sym.COMMA);}
// 

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


"START"            {return sym(sym.START, new String(yytext()));}
"BATTERY"          {return sym(sym.BATTERY, new String(yytext()));}
"FUEL"             {return sym(sym.FUEL, new String(yytext()));}
"kWh"              {return sym(sym.KWH, new String(yytext()));}
"liters"           {return sym(sym.LITERS, new String(yytext()));}
"-"                {return sym(sym.MINUS);}
"USE"              {return sym(sym.USE, new String(yytext()));}
"DO"               {return sym(sym.DO, new String(yytext()));}
"DONE"             {return sym(sym.DONE, new String(yytext()));}
"PLUS"             {return sym(sym.PLUS, new String(yytext()));}
"MAX"              {return sym(sym.MAX, new String(yytext()));}
"STAR"             {return sym(sym.STAR, new String(yytext()));}
"MOD"              {return sym(sym.MOD, new String(yytext()));}
"km"               {return sym(sym.KM, new String(yytext()));}
"units/km"         {return sym(sym.UNITS_KM, new String(yytext()));}
{qstring}          {return sym(sym.QSTRING, new String(yytext()));}
{float}            {return sym(sym.FLOAT, new Float(yytext()));}


";"             {return sym(sym.SC);}
","             {return sym(sym.COMMA);}
"("             {return sym(sym.RO);}
")"             {return sym(sym.RC);}


{comment}          {;}

\r | \n | \r\n | " " | \t   {;}

.                   {System.out.println("Scanner Error: " + yytext());}