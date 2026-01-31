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
january = "01-" ("0"[1-9] | [12][0-9] | "3"[01])
february = "02-" ("0"[1-9] | "1"[0-9] | "2"[0-8])
february_leap = "02-" ("0"[1-9] | [12][0-9]) 
march = "03-" ("0"[1-9] | [12][0-9] | "3"[0-1])
april = "04-" ("0"[1-9] | [12][0-9] | "3"[0])
may = "05-" ("0"[1-9] | [12][0-9] | "3"[0-1])
june = "06-" ("0"[1-9] | [12][0-9] | "3"[0])
july = "07-" ("0"[1-9] | [12][0-9] | "3"[0-1])
august = "08-" ("0"[1-9] | [12][0-9] | "3"[0-1])
september = "09-" ("0"[1-9] | [12][0-9] | "3"[0])0)
october = "10-" ("0"[1-9] | [12][0-9] | "3"[0-1])
november = "11-" ("0"[1-9] | [12][0-9] | "3"[0])
december = "12-" ("0"[1-9] | [12][0-9] | "3"[0-1])

year = [0-9]{4}
date = {day} "/" {month} "/" {year}
*/

sep = ("***")

tok1 = {hexa} "*" {alpha} "-" {tok1_end}?

hexa = 27[a-fA-F] | 2[89][0-9a-fA-F] | [3-9a-fA-F][0-9a-fA-F]{2} | 1([01][0-9a-fA-F]{2} | 2([0-9aA][0-9a-fA-F] | [bB][0-3]))
alpha = [a-zA-Z]{5} ([a-zA-Z]{2})*
tok1_end = ("****" "**"*) | "Y" "X" "XX"* "Y"

tok2 = {ip} "-" {date}
ipnum = [0-9] | [1-9][0-9] | 1[0-9]{2} | 2[0-4][0-9] | 25[0-5]
ip = {ipnum} "." {ipnum} "." {ipnum} "." {ipnum}
date = {october_2023} | {november_2023} | {december_2023} | {january_2024} | {february_2024} | {march_2024}

october_2023 = ("0"[5-9] | [12][0-9] | "3"[0-1]) "/10/2023"
november_2023 = ("0"[1-9] | [12][0-9] | "30") "/11/2023"
december_2023 = ("0"[1-9] | [12][0-9] | "3"[0-1]) "/12/2023"
january_2024 = ("0"[1-9] | [12][0-9] | "3"[0-1]) "/01/2024"
february_2024 = ("0"[1-9] | [12][0-9]) "/02/2024"
march_2024 = "0"[1-3] "/03/2024" 

tok3 = {num} {sepn} {num} {sepn} {num} ({sepn} {num} {sepn} {num})?
num = [0-9]{4} | [0-9]{6}
sepn = "-" | "+"


price = [0-9]+ "." [0-9]{2}
uint = 0 | [1-9][0-9]*
qstring = \" ~ \"

comment = ("{{" ~ "}}") | "//" ~ {nl}

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


{tok1}          {return sym(sym.TOK1);}
{tok2}          {return sym(sym.TOK2);}
{tok3}          {return sym(sym.TOK3);}
"euro"             {return sym(sym.EURO);}
{qstring}          {return sym(sym.QSTRING, new String(yytext()));}
{price}            {return sym(sym.PRICE, new Float(yytext()));}
{uint}             {return sym(sym.UINT, new Integer(yytext()));}
"-"                {return sym(sym.MINUS);}
";"                {return sym(sym.SC);}
","                {return sym(sym.CM);}
"%"                {return sym(sym.PERC);}


{sep}            {return sym(sym.SEP);}

{comment}          {;}

\r | \n | \r\n | " " | \t   {;}

.                   {System.out.println("Scanner Error: " + yytext());}