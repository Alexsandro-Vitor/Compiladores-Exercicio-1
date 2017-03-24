
%%

//------ PARTES COPIADAS DO TESTE.JFLEX ------

/* 
A linha atual pode ser acessada por yyline 
e a coluna atual com yycolumn. 
*/ 
%line
%column

/* Se quisermos 'interfacear' com um parser gerado pelo sistema CUP
%cup
*/ 

//encoding
%unicode

// faz com que a classe tenha uma função main e torna possivel que a classe gerada seja usada como reconhecedor
%standalone

//nomeia a classe
%class MiniJavaLexer

/* 
Declarações

código dentro de %{ e %}, é copiado para a classe gerada. 
a ideia é utilizar este recurso para declarar atributos e métodos usados nas ações 
*/ 
%{
int qtdeID=0;
%}


%eof{
System.out.println("Quantidade de Identificadores encontrados: "+qtdeID);
%eof}

//------ PARTES IMPLEMENTADAS POR MIM ------

//PADROES NOMEADOS:

espaco      = [ \t]
quebraLinha = [\n\r\f]
whitespace  = {espaco} | {quebraLinha}

qualquerCoisa   = {espaco} | {operador} | {pontuacao} | {delimitador} | {identificador} | {inteiro} | "//" | "/*"
comentarioLinha = "//"({qualquerCoisa}|"*/")*{quebraLinha}
comentarioMulti = "/*"({qualquerCoisa}|{quebraLinha})*"*/"

booleano        = "true" | "false"

operadorInteiro = "+" | "-" | "*"
operador        = "&&" | "!" | "<" | {operadorInteiro} | "==" | "!="

pontuacao = ";" | "." | "," | "="

delimitador = "(" | ")" | "{" | "}" | "[" | "]"

identificador = [_a-zA-Z]([_a-zA-Z0-9]*)

inteiro = "0" | ([1-9][0-9]*)

%%
//REGRAS LEXICAS:

{whitespace} {/* Ignorando o whitespace */}

{comentarioLinha} {System.out.print("Comentario de linha: "+yytext());}
{comentarioMulti} {System.out.println("Comentario multi linha: "+yytext());}

"boolean"            {System.out.println("Classe primitiva: boolean");}
"String"             {System.out.println("Classe primitiva: String");}
"int"                {System.out.println("Classe primitiva: int");}
"public"             {System.out.println("Modificador: public");}
"static"             {System.out.println("Modificador: static");}
{booleano}           {System.out.println("Valor booleano: "+yytext());}
"class"              {System.out.println("Palavra reservada: class");}
"extends"            {System.out.println("Palavra reservada: extends");}
"void"               {System.out.println("Palavra reservada: void");}
"main"               {System.out.println("Palavra reservada: main");}
"while"              {System.out.println("Palavra reservada: while");}
"if"                 {System.out.println("Palavra reservada: if");}
"else"               {System.out.println("Palavra reservada: else");}
"return"             {System.out.println("Palavra reservada: return");}
"length"             {System.out.println("Palavra reservada: length");}
"this"               {System.out.println("Palavra reservada: this");}
"new"                {System.out.println("Palavra reservada: new");}
"System.out.println" {System.out.println("Palavra reservada: System.out.println");}

"&&"              {System.out.println("Operador (booleano, booleano) -> booleano &&");}
"!"               {System.out.println("Operador booleano -> booleano !");}
{operadorInteiro} {System.out.println("Operador (inteiro, inteiro) -> inteiro "+yytext());}
"<"               {System.out.println("Operador (inteiro, inteiro) -> booleano <");}
{operador}        {System.out.println("Operador generico "+yytext());}

";" {System.out.println("Pontuacao ;");}
"." {System.out.println("Pontuaçao .");}
"," {System.out.println("Pontuacao ,");}
"=" {System.out.println("Pontuacao =");}

"(" {System.out.println("Delimitador (");}
")" {System.out.println("Delimitador )");}
"{" {System.out.println("Delimitador {");}
"}" {System.out.println("Delimitador }");}
"[" {System.out.println("Delimitador [");}
"]" {System.out.println("Delimitador ]");}

{identificador} {qtdeID++; System.out.println("Identificador: "+yytext());}

{inteiro} {System.out.println("Inteiro: "+yytext());}

. {throw new RuntimeException("Caractere ilegal! '" + yytext() + "' na linha: " + yyline + ", coluna: " + yycolumn);}