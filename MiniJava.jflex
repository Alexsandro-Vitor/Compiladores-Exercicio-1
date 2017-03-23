
%%

//ESSA PARTE FOI COPIADA DO TESTE.JFLEX

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
%class TesteLexer

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

//A PARTIR DAQUI EU QUE FIZ

//PADROES NOMEADOS:

espaco          = [ \t]
quebraLinha     = [\n\r\f]
whitespace      = {espaco}|{quebraLinha}
qualquerCoisa   = {espaco}
comentarioLinha = "//"{qualquerCoisa}*{quebraLinha}
comentarioMulti = "/*"({quebraLinha}|{qualquerCoisa})*"*/"
reservada       = "boolean"|"class"|"public"|"extends"|"static"|"void"|"main"|"String"|"int"|"while"|"if"|"else"|"return"|"length"|"true"|"false"|"this"|"new"|"System.out.println"
identificador   = [_a-zA-Z][_a-zA-Z0-9]*
inteiro         = 0|([1-9][0-9]*)

%%
//REGRAS LEXICAS:

{whitespace} {/* Ignorando o whitespace */}

{comentarioLinha} {System.out.println("Comentário de linha: "+yytext());}
{comentarioMulti} {System.out.println("Comentário multi linha: "+yytext());}

{reservada} {System.out.println("Palavra reservada: "+yytext());}

"&&" {System.out.println("Operador &&");}
"<" {System.out.println("Operador <");}
"==" {System.out.println("Operador ==");}
"!=" {System.out.println("Operador !=");}
"+" {System.out.println("Operador +");}
"-" {System.out.println("Operador -");}
"*" {System.out.println("Operador *");}
"!" {System.out.println("Operador !");}

";" {System.out.println("Token ;");}
"." {System.out.println("Token .");}
"," {System.out.println("Token ,");}
"=" {System.out.println("Token =");}
"(" {System.out.println("Token (");}
")" {System.out.println("Token )");}
"{" {System.out.println("Token {");}
"}" {System.out.println("Token }");}
"[" {System.out.println("Token [");}
"]" {System.out.println("Token ]");}

{identificador} {qtdeID++; System.out.println("Identificador "+yytext());}

{inteiro} {System.out.println("Inteiro: "+yytext());}

. {System.out.println("Caractere ilegal! '" + yytext() + "' na linha: " + yyline + ", coluna: " + yycolumn);}