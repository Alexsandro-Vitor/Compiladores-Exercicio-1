
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

espaco          = [ \t]
quebraLinha     = [\n\r\f]
whitespace      = {espaco}|{quebraLinha}
reservada       = "boolean"|"class"|"public"|"extends"|"static"|"void"|"main"|"String"|"int"|"while"|"if"|"else"|"return"|"length"|"true"|"false"|"this"|"new"|"System.out.println"
operador        = "&&" | "<" | "==" | "!=" | "+" | "-" | "*" | "!"
pontuacao       = ";" | "." | "," | "="
delimitador     = "(" | ")" | "{" | "}" | "[" | "]"
identificador   = [_a-zA-Z]([_a-zA-Z0-9]*)
inteiro         = 0|([1-9][0-9]*)
qualquerCoisa   = {espaco}|{reservada}|{operador}|{pontuacao}|{delimitador}|{identificador}|{inteiro}
comentarioLinha = "//"({qualquerCoisa}*){quebraLinha}
comentarioMulti = "/*"({quebraLinha}|{qualquerCoisa})*"*/"

%%
//REGRAS LEXICAS:

{whitespace}      {/* Ignorando o whitespace */}
{comentarioLinha} {System.out.println("Comentario de linha: "+yytext());}
{comentarioMulti} {System.out.println("Comentario multi linha: "+yytext());}
{reservada}       {System.out.println("Palavra reservada: "+yytext());}
{operador}        {System.out.println("Operador "+yytext());}
{pontuacao}       {System.out.println("Pontuacao "+yytext());}
{delimitador}     {System.out.println("Delimitador "+yytext());}
{identificador}   {qtdeID++; System.out.println("Identificador "+yytext());}
{inteiro}         {System.out.println("Inteiro: "+yytext());}
.                 {System.out.println("Caractere ilegal! '" + yytext() + "' na linha: " + yyline + ", coluna: " + yycolumn);}