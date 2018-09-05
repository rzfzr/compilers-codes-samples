grammar Prog;

@header{
package parser;
}

@members{
    
}

prog : (cmd EOL)+
     ;

cmd  : atrib
     | write
     | read
     | expr
     ;
atrib: VAR '=' expr           {Util.atrib($VAR.text, $expr.value);}
     ; 
write: WRITE expr             {Util.print($expr.value);}   
     | WRITE STR              {Util.print($STR.text);}
     ;
read : READ VAR               {Util.readSymbol($VAR.text);}
     ;
expr returns [Double value]
     : e1=expr '+' e2=expr    {$value = $e1.value + $e2.value;}
     | e1=expr '-' e2=expr    {$value = $e1.value - $e2.value;}
     | term                   {$value = $term.value;}
     ;

term returns [Double value]
     : t1=term '*' t2=term    {$value = $t1.value * $t2.value;}
     | t1=term '/' t2=term    {$value = $t1.value / $t2.value;}
     | fact                   {$value = $fact.value;}
     ;
fact returns [Double value]
     : NUM                    {$value = Double.parseDouble($NUM.text);}
     | VAR                    {$value = Util.getValue($VAR.text);}
     | '(' expr ')'           {$value = $expr.value;}
     ;

STR     : '"'[a-zA-Z0-9\t ]*'"';
READ    : [rR][eE][aA][dD];
WRITE   : [wW][rR][iI][tT][eE];
VAR     : [_a-zA-Z][_a-zA-Z0-9]*;
MULT    : '*';
SUM     : '+';
MIN     : '-';
DIV     : '/';
OPEN    : '(';
CLOSE   : ')';
EOL     : [\r\n]+ ;
NUM     : [0-9]+ ('.'[0-9]+)?;
WS      : [ \t]+ -> skip;