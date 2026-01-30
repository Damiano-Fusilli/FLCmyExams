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
day = "0"[1-9] | [12][0-9] | "3"[01]
month = "0"[1-9] | "1"[0-2]
year = [0-9]{4}
date = {day} "/" {month} "/" {year}
*/

sep = 

tok1 =

tok2 =

tok3 =

comment = "<*" ~ "*>"

//comment = "/*" ~  "*/"
//comment = "//" ~ 
//comment = "#" ~ 

%%

// Strings part
// "str"            {return sym(sym.STR, new String(yytext()));}

// "."             {return sym(sym.DOT);}
// ":"             {return sym(sym.CO);}
// ","             {return sym(sym.CM);}
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
// "|"             {return sym(sym.PIPE);}
// "&&"            {return sym(sym.AND);}
// "||"            {return sym(sym.OR);}

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
// \\              {return sym(sym.BSL);}

// \'              {return sym(sym.QU);}
// \"              {return sym(sym.DQU);}
// \`              {return sym(sym.GRAVE);}
// "~"             {return sym(sym.TIL);}
// "|"             {return sym(sym.PIPE);}
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


{sep}            {return sym(sym.SEP);}

{comment}          {;}

\r | \n | \r\n | " " | \t   {;}

.                   {System.out.println("Scanner Error: " + yytext());}