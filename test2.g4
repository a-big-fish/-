grammar test2;
/*
    可以识别形似如下的结构
    Function("hello", a);
*/
prog: expr EOF;
expr:
    useFunctionStatement
;

ENDL:';';

FunctionName:(' ')* [A-Z] [a-z0-9_]* ([A-Z] [a-z0-9_]*)* (' ')*; // 函数名，大写字母开头的大驼峰命名，函数名前后都可以有空格
Parameter
    : (' ')* VariableName (' ')*
    | (' ')* '"' [a-zA-Z@!#$%^&*_+-= ]+ '"' (' ')*
    ;
VariableName:(' ')* [a-z]+ [a-zA-Z0-9_]* (' ')*; // 小写字母开头的,可以带下划线的字符串，变量名前后都可以有空格


useFunctionStatement
    : FunctionName '(' Parameter (',' Parameter)*')' ';'
    ;

NEWLINE : [\r\n]+ -> skip;