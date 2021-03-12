#lang scribble/manual

@title{学习scribble}
 
何为scribble？它是racket所编写的文本标记语言，它能够方便地编写库文档，书籍等文档。racket的所有库的文档都是由它编写的。scribble容易生成pdf（为生成中文需要特别的配置），markdown，latex和html，其默认生成html且如此功能最为全面。

我认为scribble相较于markdown等标记语言的优势在于其@bold{表达力更为全面}，且基于racket，所以易于创建新的标记和运用已有的racket库，并且其语法简单（这也意味着它的代码可能有点繁琐……）。但是其默认的样式实在有些平庸……不过内容比什么都重要，不是吗？而且其不能方便地生成epub等方便kindle等设备阅读的格式，html也并不容易进行做笔记等操作，不提供实时预览等，所以还是有些缺憾的……但是这些困难或许能够自己解决？我不知道。总之开始学习。

关于其表达力，随便来一些示例吧。

@smaller{smaller!
 @smaller{smaller!!
  @smaller{smaller!!!
   @smaller{OMG!!!!}}}}

normal
@larger{big @bold{bold-big}
 @larger{bigger!
  @larger{bigger!!
   @larger{huge!!!
    @larger{OMG!!!!}}}}}

@centered{
  @bold{directed by}
  @italic{YUKI}
}
@itemlist[@item{just for fun}
          @item{lol}]
@margin-note{侧边note}

1 plus 2 is @(number->string (+ 1 2))

其代码如下——
@codeblock|{
@smaller{smaller!
 @smaller{smaller!!
  @smaller{smaller!!!
   @smaller{OMG!!!!}}}}

normal
@larger{big @bold{bold-big}
 @larger{bigger!
  @larger{bigger!!
   @larger{huge!!!
    @larger{OMG!!!!}}}}}

@centered{
  @bold{directed by}
  @italic{YUKI}
}
@itemlist[@item{just for fun}
          @item{lol}]
@margin-note{侧边note}

1 plus 2 is @(number->string (+ 1 2))
}|

我选择优先学习各种用于编写文档的标签（scribble文档称它们是@bold{	High-Level}的）。同时尽量与markdown对照学习。

scribble文件后缀名为scrbl。其第一行应形如#lang scribble/manual，这指定其所具体使用的scribble语言（其实差别只有渲染方式和提供的标签）。

@margin-note{标签的实质是procedure或syntax,不过这里入乡随俗称他们为标签}
一般来说，scribble中的标签的一般形式为——
@codeblock|{
@标签名[参数列表]{内容}
}|

其中，内容不能省略，参数列表一般而言是可以省略的。

@section{基本格式}

@subsection{加粗和斜体}

基本格式指那些给文本于样式的标记。如加粗，斜体，放大等，很多标签都是可以嵌套使用的，比如上面示例中的larger。

加粗标签为@bold{bold}，其同markdown的**标记。

斜体标签为@bold{italic}，同markdown的*标记。

scribble没有直接提供同markdown中***标记等同的标签，但是可以嵌套使用bold和italic标签来实现它。

@bold{加粗} @italic{斜体} @bold{@italic{加粗斜体}}
@codeblock|{@bold{加粗} @italic{斜体} @bold{@italic{加粗斜体}}}|

@subsection{上标和下标}

上标和下标分别是superscript和subscript，markdown虽然提供了这样的语法，但是兼容性不好。

2H@subscript{2}O@subscript{2}=2H@subscript{2}O+O@subscript{2}

(x+y)@superscript{2}=x@superscript{2}+y@superscript{2}+2xy

@codeblock|{
2H@subscript{2}O@subscript{2}=2H@subscript{2}O+O@subscript{2}

(x+y)@superscript{2}=x@superscript{2}+y@superscript{2}+2xy}|

@subsection{放大和缩小}

larger标签和smaller标签能够放大缩小文本。这在markdown里没有直接对应的语法，只能嵌入html标签来实现。

@margin-note{使用[]其实也就意味着item都是itemlist的参数,这和上面的一般形式是相符的。}

@subsection{列表}

列表的语法需要特别注意，itemlist构建一个无序列表，而item则构建列表中的元素，就如html中的ul和li标签。itemlist应当使用[]而非{}包裹内容。

在[]中添加@code{#:style 'ordered}以构建有序列表。

@itemlist[#:style 'ordered
          @item{test}
          @item{another}]

@codeblock|{
@itemlist[#:style 'ordered
          @item{test}
          @item{another}]
}|

@subsection{侧边文字和置中}

margin-note标签顾名思义，能在侧边进行书写，我觉得挺适合用来做注释，吐槽之类的。

@margin-note{markdown做得到吗，做得到吗！}

centered标签将文字置于正中。

@centered{@bold{@larger{My}} @italic{name} is YUKI}

@codeblock|{
@centered{@bold{@larger{My}} @italic{name} is YUKI}
}|

@subsection{图片和超链接}

image标签可用于展示图片，其要求内容为图片文件的相对或绝对位置，一般使用相对位置。
@margin-note{image标签也可使用racket代码构造图片，酷吧。}
@image{1.png}

@codeblock|{
@image{def/1.png}
}|

也可使用这样的形式，以规定如果图片无法显示要显示的文字——

@codeblock|{
@image["def/1.png"]{似乎没加载出来}
}|

与其对应的markdown标签是![似乎没加载出来](def/1.png)。

超链接使用hyperlink标签，其参数为url，内容为url所显示的东西。

@hyperlink["https://www.baidu.com"]{click me！}

@codeblock|{
@hyperlink["https://www.baidu.com"]{click me!}
}|

其形式同markdown标签[click me!](https://www.baidu.com)

@section{结构标签}

结构标签就是会更改或表示文档结构的标签，如markdown的标题标签，目录标签等（这并非是markdown本身的功能，而是其渲染器的）。

@subsection{标题，章节}

scribble使用title标签规定文档的标题，title标签在单个文档中是唯一的，其类似markdown中的#标签，但限制更多。

section标签标记文章的一个部分，如章节等，可以认为其等同于##标签。subsection标签则是标记section的子section，如章中的节，同时也有提供subsubsection标签。

include-section标签将另一个scribble文件作为一个section包括到文档中，其title将会作为section的名称，其中所有section将会变为其子section。

一般而言include-section标签应使用相对路径，如@code|{@include-section{def/abc.scrbl}}|将读取该文档路径下def文件夹中的abc.scrbl文件。

@section{换行}

scribble的换行非常类似markdown的换行。

markdown的换行有三种形式——行尾加两个空格，另起一行；使用<br/>；两行之间空一行。其中第一，二种只是另起一行，第三种是分段。scribble支持后两种形式。其中功能类似<br/>标签的是linebreak标签，其按@code|{@linebreak{}}|使用（有点繁琐，对于不需要参数的标签也必须要使用{}包裹……）。

OVER~


