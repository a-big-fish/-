grammar Expr;		
prog:	expr EOF ;
expr:	expr ('*'|'/') expr
    |   expr ('\n')+ expr
    |	expr ('+'|'-') expr
    |	INT
    |	'(' expr ')'
    ;
NEWLINE : [\r\n]+ -> skip;
INT     : [0-9]+ ;