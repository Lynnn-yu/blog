---
title: "Maven 与 Gradle 的区别与迁移"
date: 2024-09-25T18:44:57+08:00
draft: false 
params: 
  author: Lynn
tags: ["Maven ", "Gradle","构建工具"]
categories: ["技术博客"]
description: "Maven 与 Gradle 的区别与迁移"
summary: "Maven 与 Gradle 的区别与迁移"
image:  "/图.jpg"
typora-root-url: ./..\..\..\static
---

## Maven 与 Gradle 的区别

Java 世界中主要有三大构建工具：Ant、Maven 和 Gradle。经过几年的发展，Ant 几乎销声匿迹、Maven 也日薄西山，而 Gradle 的发展则如日中天。Maven 的主要功能主要分为 5 点，分别是依赖管理系统、多模块构建、一致的项目结构、一致的构建模型和插件机制。Maven 与 Gradle 在使用中各有千秋，根据使用场景择优用之。



### 1. Maven 与 Gradle 对比

maven 要引入依赖 pom.xml

```
<!-- https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-starter-web -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
    <version>2.1.5.RELEASE</version>
</dependency>
```

而 Gradle 引入 build.gradle

```
implementation 'org.springframework.boot:spring-boot-starter-web'
```

优点: Gradle 相当于 Maven 与 Ant 的合体 
缺点：对于微服务多项目的子类引用，不如 Maven

Maven

- 项目结构 / 依赖由 pom.xml 定义
- 生产代码存放在 src/main/java 下
- 测试代码存放在 src/test/java 下

Gradle

- 项目结构 / 依赖由 build.gradle 定义
- 生产代码存放在 src/main/java 下
- 测试代码存放在 src/test/java 下

 

### 2. 构建流程和生命周期

- Maven
  - 三个标准的生命周期 (lifecycle)
  - 最小的运行单元是目标 (goal)
  - 插件可以把自己的目标绑定在生命周期的某个阶段 (phase) 上
- Gradle
  - 没有显示的生命周期
  - 最小的运行单元是任务 (task)，任务之间可以相互依赖
  - 可以动态地创建任务



###   3. 包管理和传递性依赖

- Maven

  - 一个包由 groupId/artifactId/version 确定唯一坐标
  - 包来源于中央仓库
  - 传递性依赖
    - 当某个包的的使用依赖于其他包时，Maven 会自动导入所有的依赖包

- Gradle

  - 使用 Ivy 的构件系统，是 Maven 的构件系统的超集

    > Ant ivy 是一个比 Maven 仓库更加广阔的仓库

  - 与 Maven 仓库兼容

- 当出现依赖冲突时

  - Maven 依赖解调遵循两个原则，**路径最近**原则以及**定义顺序**原则

  ![img](/up-981b4f8bfc766b8cc478b6de580fb4b4.jpg)

  Mavenc 依赖冲突.png

- Gradle 的冲突解析则是选用**新的版本** (新的版本一般都会向下兼容)

总结：

Maven

- 稳定可靠，插件众多。(这么多年版本一直维持在 3.XX，而且很久才发布一次小更新，说明他稳定且 bug 较少)

![img](/up-2aee9dfdfe6bad6c11f1ec0b15c85d4d.png)

- 略显啰嗦，自定义逻辑较麻烦 (Maven 使用 xml 的方式进行配置，xml 的劣势繁琐就会体现在 Maven 上)

![img](/up-7942de7f32da9512c13374f50d3330e6.png)

- 大型项目会逐渐遇到性能问题
  - 使用 Maven 构建的项目都会经过几个生命流程，内部没有缓存机制，项目越来越大重新构建所花费的时间也就越长。
- 由于 Maven 的开发基本靠社区支持，没有更多的资金用于继续开发维护 Maven，导致开发基本停泻。
- Gradle
  - Gradle 采用代码逻辑的方式进行构建，使得它能更加的灵活。

- Gradle 内部存在缓存机制 (当文件输入和输出都没改变的情况下，认为这就是没变的代码，直接进行输出。但当你改变的依赖包版本，它有时并没更新，也是缓存机制的问题)，相比会快些。
- 开发活跃，版本太多



## **从maven迁移到gradle**

因为maven出现的时间比较早，所以基本上所有的java项目都支持maven，但是并不是所有的项目都支持gradle。如果你有需要把maven项目迁移到gradle的想法，那么就一起来看看吧。

根据我们之前的介绍，大家可以发现gradle和maven从本质上来说就是不同的，gradle通过task的DAG图来组织任务，而maven则是通过attach到phases的goals来执行任务。

虽然两者的构建有很大的不同，但是得益于gradle和maven相识的各种约定规则，从maven移植到gradle并不是那么难。

要想从maven移植到gradle，首先要了解下maven的build生命周期，maven的生命周期包含了clean，compile，test，package，verify，install和deploy这几个phase。

我们需要将maven的生命周期phase转换为gradle的生命周期task。这里需要使用到gradle的Base Plugin，Java Plugin和Maven Publish Plugin。

先看下怎么引入这三个plugin：

```bash
plugins {
    id 'base'
    id 'java'
    id 'maven-publish'
}
```

clean会被转换成为clean task，compile会被转换成为classes task，test会被转换成为test task，package会被转换成为assemble task，verify 会被转换成为check task，install会被转换成为 Maven Publish Plugin 中的publishToMavenLocal task，deploy 会被转换成为Maven Publish Plugin 中的publish task。

有了这些task之间的对应关系，我们就可以尝试进行maven到gradle的转换了。

### **自动转换**

我们除了可以使用 gradle init 命令来创建一个gradle的架子之外，还可以使用这个命令来将maven项目转换成为gradle项目，gradle init命令会去读取pom文件，并将其转换成为gradle项目。

### **转换依赖**

gradle和maven的依赖都包含了group ID, artifact ID 和版本号。两者本质上是一样的，只是形式不同，我们看一个转换的例子：

```xml
<dependencies>
    <dependency>
        <groupId>log4j</groupId>
        <artifactId>log4j</artifactId>
        <version>1.2.12</version>
    </dependency>
</dependencies>
```

上是一个maven的例子，我们看下gradle的例子怎写：

```bash
dependencies {
    implementation 'log4j:log4j:1.2.12'  
}
```

可以看到gradle比maven写起来要简单很多。

注意这里的implementation实际上是由 Java Plugin 来实现的。

我们在maven的依赖中有时候还会用到scope选项，用来表示依赖的范围，我们看下这些范围该如何进行转换：

- compile：

在gradle可以有两种配置来替换compile，我们可以使用implementation或者api。

前者在任何使用Java Plugin的gradle中都可以使用，而api只能在使用Java Library Plugin的项目中使用。

当然两者是有区别的，如果你是构建应用程序或者webapp，那么推荐使用implementation，如果你是在构建Java libraries，那么推荐使用api。

- runtime：

可以替换成 runtimeOnly 。

- test：

gradle中的test分为两种，一种是编译test项目的时候需要，那么可以使用testImplementation，一种是运行test项目的时候需要，那么可以使用testRuntimeOnly。

- provided：

可以替换成为compileOnly。

- import：

在maven中，import经常用在dependencyManagement中，通常用来从一个pom文件中导入依赖项，从而保证项目中依赖项目版本的一致性。

在gradle中，可以使用 platform() 或者 enforcedPlatform() 来导入pom文件：

```bash
dependencies {
    implementation platform('org.springframework.boot:spring-boot-dependencies:1.5.8.RELEASE') 

    implementation 'com.google.code.gson:gson' 
    implementation 'dom4j:dom4j'
}
```

比如上面的例子中，我们导入了spring-boot-dependencies。因为这个pom中已经定义了依赖项的版本号，所以我们在后面引入gson的时候就不需要指定版本号了。

platform和enforcedPlatform的区别在于，enforcedPlatform会将导入的pom版本号覆盖其他导入的版本号：

```php
dependencies {
    // import a BOM. The versions used in this file will override any other version found in the graph
    implementation enforcedPlatform('org.springframework.boot:spring-boot-dependencies:1.5.8.RELEASE')

    // define dependencies without versions
    implementation 'com.google.code.gson:gson'
    implementation 'dom4j:dom4j'

    // this version will be overridden by the one found in the BOM
    implementation 'org.codehaus.groovy:groovy:1.8.6'
}
```

### **转换repositories仓库**

gradle可以兼容使用maven或者lvy的repository。gradle没有默认的仓库地址，所以你必须手动指定一个。

你可以在gradle使用maven的仓库：

```undefined
repositories {
    mavenCentral()
}
```

我们还可以直接指定maven仓库的地址：

```bash
repositories {
    maven {
        url "http://repo.mycompany.com/maven2"
    }
}
```

如果你想使用maven本地的仓库，则可以这样使用：

```undefined
repositories {
    mavenLocal()
}
```

但是mavenLocal是不推荐使用的，为什么呢？

mavenLocal只是maven在本地的一个cache，它包含的内容并不完整。比如说一个本地的maven repository module可能只包含了jar包文件，并没有包含source或者javadoc文件。那么我们将不能够在gradle中查看这个module的源代码，因为gradle会首先在maven本地的路径中查找这个module。

并且本地的repository是不可信任的，因为里面的内容可以轻易被修改，并没有任何的验证机制。

### **控制依赖的版本**

如果同一个项目中对同一个模块有不同版本的两个依赖的话，默认情况下Gradle会在解析完DAG之后，选择版本最高的那个依赖包。

但是这样做并不一定就是正确的， 所以我们需要自定义依赖版本的功能。

首先就是上面我们提到的使用platform()和enforcedPlatform() 来导入BOM（packaging类型是POM的）文件。

如果我们项目中依赖了某个module，而这个module又依赖了另外的module，我们叫做传递依赖。在这种情况下，如果我们希望控制传递依赖的版本，比如说将传递依赖的版本升级为一个新的版本，那么可以使用dependency constraints：

```bash
dependencies {
    implementation 'org.apache.httpcomponents:httpclient'
    constraints {
        implementation('org.apache.httpcomponents:httpclient:4.5.3') {
            because 'previous versions have a bug impacting this application'
        }
        implementation('commons-codec:commons-codec:1.11') {
            because 'version 1.9 pulled from httpclient has bugs affecting this application'
        }
    }
}
```

注意，dependency constraints只对传递依赖有效，如果上面的例子中commons-codec并不是传递依赖，那么将不会有任何影响。

同时 Dependency constraints需要Gradle Module Metadata的支持，也就是说只有你的module是发布在gradle中才支持这个特性，如果是发布在maven或者ivy中是不支持的。

上面讲的是传递依赖的版本升级。同样是传递依赖，如果本项目也需要使用到这个传递依赖的module，但是需要使用到更低的版本（因为默认gradle会使用最新的版本），就需要用到版本降级了。

```bash
dependencies {
    implementation 'org.apache.httpcomponents:httpclient:4.5.4'
    implementation('commons-codec:commons-codec') {
        version {
            strictly '1.9'
        }
    }
}
```

我们可以在implementation中指定特定的version即可。

strictly表示的是强制匹配特定的版本号，除了strictly之外，还有require，表示需要的版本号大于等于给定的版本号。prefer，如果没有指定其他的版本号，那么就使用prefer这个。reject，拒绝使用这个版本。

除此之外，你还可以使用Java Platform Plugin来指定特定的platform，从而限制版本号。

最后看一下如何exclude一个依赖：

```csharp
dependencies {
    implementation('commons-beanutils:commons-beanutils:1.9.4') {
        exclude group: 'commons-collections', module: 'commons-collections'
    }
}
```

### **多模块项目**

maven中可以创建多模块项目：

```xml
<modules>
    <module>simple-weather</module>
    <module>simple-webapp</module>
</modules>
```

我们可以在gradle中做同样的事情settings.gradle：

```php
rootProject.name = 'simple-multi-module'  

include 'simple-weather', 'simple-webapp'
```

### **profile和属性**

maven中可以使用profile来区别不同的环境，在gradle中，我们可以定义好不同的profile文件，然后通过脚本来加载他们：

build.gradle：

```bash
if (!hasProperty('buildProfile')) ext.buildProfile = 'default'  

apply from: "profile-${buildProfile}.gradle"  

task greeting {
    doLast {
        println message  
    }
}
```

profile-default.gradle：

```bash
ext.message = 'foobar'
```

profile-test.gradle：

```bash
ext.message = 'testing 1 2 3'
```

我们可以这样来运行：

```bash
> gradle greeting
foobar

> gradle -PbuildProfile=test greeting
testing 1 2 3
```

### **资源处理**

在maven中有一个process-resources阶段，可以执行resources:resources用来进行resource文件的拷贝操作。

在Gradle中的Java plugin的processResources task也可以做相同的事情。

比如我可以执行copy任务：

```csharp
task copyReport(type: Copy) {
    from file("buildDir/reports/my-report.pdf")
    into file("buildDir/toArchive")
}
```

更加复杂的拷贝：

```csharp
task copyPdfReportsForArchiving(type: Copy) {
    from "buildDir/reports"
    include "*.pdf"
    into "buildDir/toArchive"
}
```

当然拷贝还有更加复杂的应用。这里就不详细讲解了。

