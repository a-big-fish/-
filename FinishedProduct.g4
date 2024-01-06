grammar FinishedProduct;

prog: expr (' ')* ('\n') (' ')* EOF; // 整个写完以后多加一行空行做结束标志，参考python的推荐写法

expr
    : programmer
;


EQ : '=' ;
COMMA : ',' ;
ENDL : ';' ;



// 包含语句一定得在定义语句上边
programmer
    : programmer (' ')*  ('\n')+ programmer
    | includeStatement (' ')*  ('\n')+ defineStatement
    | includeStatement (' ')*  ('\n')+ useFunctionStatement
    | defineStatement (' ')*  ('\n')+ defineStatement
    | useFunctionStatement (' ')*  ('\n')+ defineStatement
    | useFunctionStatement (' ')*  ('\n')+ useFunctionStatement
    | defineStatement (' ')*  ('\n')+ useFunctionStatement
    ;

LibFileName: '<' [a-zA-Z]+('.' [a-zA-Z]+)*  '>'; // 形如<stdio.h.a>的才行，即.后头一定得跟字母
//LibFileNameCurrently:'"' [a-zA-Z]+('.' [a-zA-Z]+)*  '"'; 这个有BUG，删了
IncludeDeclare:'#include'[ ]+; // 包含声明，可以#include后面加0+个数的空格
includeStatement
    : includeStatement (' ')* ('\n')+ includeStatement
    | IncludeDeclare LibFileName
//    | IncludeDeclare LibFileNameCurrently
    ; // 包含语句,递归声明
Parameter
    : (' ')* VariableName (' ')*
    | (' ')* '"' [a-zA-Z@!#$%^&*_+-= ]+ '"' (' ')*
    ;
VariableType:'Int'|'Float'|'Double'|'String';
VariableName:(' ')* [a-z]+ [a-zA-Z_]* (' ')*; // 小写字母开头的,可以带下划线的字符串，变量名前后都可以有空格
VariableVlaue
    : (' ')* [1-9]+ [0-9]* (' ')* // 数值
    | ConstString
;
VariableTypeAndName:VariableType (' ')* VariableName;
defineStatement
    : VariableTypeAndName '=' Parameter ';'
    | VariableTypeAndName '=' VariableVlaue ';'
    | VariableName '=' VariableName ';'
    | VariableName '=' VariableVlaue ';'
    ;

FunctionName:(' ')* [A-Z] [a-z0-9_]* ([A-Z] [a-z0-9_]*)* (' ')*; // 函数名，大写字母开头的大驼峰命名，函数名前后都可以有空格
useFunctionStatement
    : FunctionName '(' Parameter (',' Parameter)*')' ';'
    | FunctionName '(' VariableVlaue ')' ';'
    ;

ConstString: (' ')* '"' [a-zA-Z0-9 ]+ '"' (' ')*; // 常量字符串，前后含有空格
WS: [\n\t] -> skip;
