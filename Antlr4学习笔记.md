## 语法模式

### 序列模式

```java
'[' INT+ ']' // Matlab的整数向量
(statement ';')*
(row '\n')*
exprList:expr(',' expr)*

```



### 选择模式

```java
field: INT | STIRNG; // 字段中可以有整数或字符串

```



### 词法符号依赖

```java
vector: '[' INT+ ']'; // [1], [1,2]
functionDecl
    : type ID '{' formalParameters? '}'
        ;
formalParameters
    : formalParameter (',' formalParameter)*
        ;
formalParameter
    : type ID
        ;
```



### 嵌套结构（递归自定义）

```java
expr: ID '[' expr ']' // a[1], a[b[1]], a[(b[1])]
    | '(' expr ')'
    | INT
    ;

classDef
    : 'class' ID '{' (classDef | method | field) '}'
        ;

```

词法分析器(Lexer)的Token定义 建议 全大写字母

parser rule 建议 首字母小写的驼峰

## ANTLR4语法整体结构

```java
grammar Name; // 创建名为 Name 的语法规则
options{
    
}
impotr ... ;
tokens{ // 字符串序列转换为的标记
    
}
channels{ // 
    
}// lexer only
@actionName{ // 一些行为
    
}
// 转换规则
rule1 // parser and lexer rules, possibly intermingled
...
ruleN
```

一般语法若很复杂，会分为 Lexer（词法） 和 Parser（语法） 两个文件

```C
#include <stdio.h>
#include <String>

using namespace std;

int main(int argc,char* argv[]){
    String name = "world";
    cout << "hello " << name << endl;
    return 0;
}

```

```java
prog: expr  EOF;
expr:
    item '=' item ';'|

;
item
    : Int
    | Float
    | Double
    | String
    | ConstString
;
Int: [0-9]+;
Float: [1-9][0-9]*'.'[0-9]*;
Double: [1-9][0-9]*'..'[0-9]*;
String: [a-zA-Z0-9 ]+ ;
ConstString:(' ')*'"' [a-zA-Z0-9 ]+ '"'(' ')*; // 常量字符串，含有空格
WS: [\n\t] -> skip;
// string = "world";
// string =1; 数字必须贴着=写才会被识别，同时后面也不能有空格
// 
```

实现如下结构

![image-20240105185329243](C:\Users\people\AppData\Roaming\Typora\typora-user-images\image-20240105185329243.png)

```java
LibFileName: '<' [a-zA-Z]+('.' [a-zA-Z]+)*  '>'; // 形如<stdio.h.a>的才行，即.后头一定得跟字母
LibFileNameCurrently:'"' [a-zA-Z]+('.' [a-zA-Z]+)*  '"';
IncludeDeclare:'#include'[ ]+; // 包含声明，可以#include后面加0+个数的空格
includeStatement
    : includeStatement ('\n')+ includeStatement
    | IncludeDeclare LibFileName
    | IncludeDeclare LibFileNameCurrently
    ; // 包含语句,递归声明
//#include "stdio.h"
//#include <String>
```

实现如下结构

![image-20240106152928407](C:\Users\people\AppData\Roaming\Typora\typora-user-images\image-20240106152928407.png)

