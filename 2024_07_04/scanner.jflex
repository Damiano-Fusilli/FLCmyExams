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

sep = "****" "**"*

tok1 = "A:!" {binary} | "B:!"{time}
binary = (0|1){4} | (0|1){6} | (0|1){11}
time = "07:21:"1[3-9] | "07:21:"[2-5][0-9] | "07:2"[2-9]":"[0-5][0-9] | "07:"[3-5][0-9]":"[0-5][0-9] |
        "0"[89]":"[0-5][0-9]":"[0-5][0-9] | 1[0-8]":"[0-5][0-9]":"[0-5][0-9] |
        "19:"[0-3][0-9]":"[0-5][0-9] | "19:4"[0-4]":"[0-5][0-9] | "19:45:"[0-4][0-9] | "19:45:5"[0-4]


tok2 = "C:" ({real}| "value") ({symb}{2} | {symb} {10} ) ([a-z] ([a-z]{2})* | ([A-Z]{2})+)
real = 1[12]"."[0-9][0-9] | "10.5"[3-9] | "10."[6-9][0-9] | "13."[0-6][0-9] | "13.7"[0-4]
symb = "@" | "!"


ureal = ((0"."[0-9]*) | [1-9][0-9]*"."[0-9]* | "."[0-9]*)

qstring = \" ~ \"

comment = "[++" ~ "++]"

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
";"             {return sym(sym.SC);}
":"             {return sym(sym.CO);}
","             {return sym(sym.COMMA);}
"+"             {return sym(sym.PLUS);}
"-"             {return sym(sym.MINUS);}
"*"             {return sym(sym.STAR);}
"/"             {return sym(sym.DIV);}
"("             {return sym(sym.RO);}
")"             {return sym(sym.RC);}
"POINTS"            {return sym(sym.POINTS, new String(yytext()));}
"LOW"            {return sym(sym.LOW, new Double(0.0));}
"MEDIUM"            {return sym(sym.MEDIUM, new Double(1.0));}
"HIGH"            {return sym(sym.HIGH, new Double(2.0));}


{qstring}          {return sym(sym.QSTRING, new String(yytext()));}
{ureal}             {return sym(sym.UREAL, new Double(yytext()));}

{comment}          {;}

\r | \n | \r\n | " " | \t   {;}

.                   {System.out.println("Scanner Error: " + yytext());}