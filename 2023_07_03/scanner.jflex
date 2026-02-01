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

sep = "$$$" "$$"* 

tok1 = {exclamation} ({even} | {question})

exclamation = "!!!!" "!!"*
even = -1[02468] | "-"[2468] | [02468] | [1-9][02468] | 1[0-9][02468] | 2[0-8][0246]
question = "?????" "??"*

tok2 = ("2023"("/07/"{july} | "/08/"{august} | "/09/"{september} | "/10/"{october} )) |
    ({july}"/07/2023" | {august}"/08/2023" | {september}"/09/2023" | {october}"/10/2023" )

july = ("0"[2-9] | [12][0-9] | "3"[0-1])
august = ("0"[1-9] | [12][0-9] | "3"[0-1])
september = ("0"[1-9] | [12][0-9] | "3"[0])
october = ("0"[1-6])

tok3 = {hour} ":" {minute} (":" {second})? | 
    "07:"(3[7-9] | [45][0-9])(":" ("19"|[2-5][0-9]))? |
    "22:"(39 | [4-5][0-9])(":"(2[3-9] | [3-5][0-9]))?

hour = "0"[89] | "1"[0-9] | "2"[01]
minute = [0-5][0-9]
second = [0-5][0-9]

uint = 0 | [1-9][0-9]*

qstring = \" ~ \"

comment = "<*" .*  "*>"

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

"house"            {return sym(sym.HOUSE);}
"start"            {return sym(sym.START);}
"end"              {return sym(sym.END);}
"if"               {return sym(sym.IF);}
","                {return sym(sym.COMMA);}
"."                {return sym(sym.DOT);}
"=="               {return sym(sym.EQ);}
"and"              {return sym(sym.AND);}
"or"               {return sym(sym.OR);}
"not"              {return sym(sym.NOT);}
"then"             {return sym(sym.THEN);}
"print"            {return sym(sym.PRINT);}
"fi"               {return sym(sym.FI);}
{qstring}          {return sym(sym.QSTRING, new String(yytext()));}
{uint}             {return sym(sym.UINT, new Integer(yytext()));}

";"             {return sym(sym.SC);}
"("             {return sym(sym.RO);}
")"             {return sym(sym.RC);}

{comment}          {;}

\r | \n | \r\n | " " | \t   {;}

.                   {System.out.println("Scanner Error: " + yytext());}