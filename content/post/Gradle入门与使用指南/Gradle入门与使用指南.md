---
title: "Gradle入门与使用指南"
date: 2024-09-25T18:38:41+08:00
draft: false 
params: 
  author: Lynn
tags: ["Gradle", "构建工具"]
categories: ["技术博客"]
description: "Gradle是一个基于Apache Ant和Apache Maven概念的项目自动化构建开源工具。它使用一种基于Groovy的特定领域语言(DSL)来声明项目设置，也增加了基于Kotlin语言的kotlin-based DSL，抛弃了基于XML的各种繁琐配置。"
summary: "Gradle是一个基于Apache Ant和Apache Maven概念的项目自动化构建开源工具。它使用一种基于Groovy的特定领域语言(DSL)来声明项目设置，也增加了基于Kotlin语言的kotlin-based DSL，抛弃了基于XML的各种繁琐配置。"
image:  "/图.jpg"
hideImage: true
typora-root-url: ./..\..\..\static
---

## 介绍

### 1.1 什么是Gradle？

Gradle是一个开源构建自动化工具，专为大型项目设计。它基于DSL（领域特定语言）编写，该语言是用Groovy编写的，使得构建脚本更加简洁和强大。Gradle不仅可以构建Java应用程序，还支持多种语言和技术，例如C++、Python、Android等。

更多信息和详细文档可以在[Gradle官方网站]([Gradle Build Tool](https://link.zhihu.com/?target=https%3A//gradle.org/))上找到。



### 1.2 为什么选择Gradle？

与其他流行的构建工具（如Maven和Ant）相比，Gradle提供了以下优势：

- **性能**：Gradle使用它的[守护程序](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=1&q=守护程序&zhida_source=entity)和增量构建技术来提高构建速度。

![img](./v2-cb071de90026a743e6d7b92e97f00974_1440w.webp)



- **灵活性**：Gradle的DSL使你可以编写高度定制化的构建脚本。
- **可扩展性**：Gradle可以通过插件机制轻松扩展，有着丰富的插件生态系统。
- **Android官方支持**：对于Android开发，Google官方推荐使用Gradle作为构建工具。

------

## 安装和设置

### 2.1 前提条件

在安装Gradle之前，你需要确保满足以下前提条件：

- 一个有效的Java Development Kit (JDK)安装。Gradle 7.0及以上版本需要JDK版本为8到16。
- `JAVA_HOME` [环境变量](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=1&q=环境变量&zhida_source=entity)已正确设置，指向JDK的安装目录。



### 2.2 下载和安装Gradle

1. **直接下载**：你可以从[Gradle官方下载页面]([Gradle | Releases](https://link.zhihu.com/?target=https%3A//gradle.org/releases/))下载最新版本的Gradle[分发包](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=1&q=分发包&zhida_source=entity)。选择合适的分发包，通常我们使用二进制分发包。
2. **使用[包管理器](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=1&q=包管理器&zhida_source=entity)**：对于某些操作系统，如macOS，你可以使用Homebrew包管理器来安装：

```bash
brew install gradle
```

对于Linux用户，可以使用SDKMAN:

```bash
sdk install gradle
```



3. 解压下载的文件到一个合适的安装位置。
4. 将解压后的路径添加到你的操作系统的PATH变量中，以便从任何位置运行Gradle命令。



### 2.3 验证安装

要验证你的Gradle安装是否成功，可以在命令行或终端中运行以下命令：

```bash
gradle -v
```

会显示Gradle的版本、Groovy的版本以及JVM版本等详细信息，如下图所示：

![img](./v2-5ac115a4193a6f2198b5093b1cb5ecc9_1440w.webp)



\---



## Gradle基础概念

### 3.1 项目和任务

在Gradle中，构建是由**项目**和**任务**组成的。

- **项目**：代表你正在构建的东西，可以是一个库、应用程序或者是一个更大的单元，如多模块项目。一个构建可以有一个或多个项目。
- **任务**：表示一个原子的构建操作，例如编译类或创建JAR文件。



### 3.2 构建脚本

Gradle使用**构建脚本**来配置和控制构建过程。这些脚本默认使用`Groovy`或`Kotlin DSL`编写，并具有特定的文件名，如`build.gradle`或`build.gradle.kts`。

构建脚本定义了项目和任务以及它们之间的关系。

### 3.3 依赖管理

Gradle不仅仅是一个构建工具，它还有一个强大的**依赖管理**系统，允许你声明你的项目依赖的[外部库](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=1&q=外部库&zhida_source=entity)，并自动下载和管理它们。



### 3.4 插件

插件扩展了Gradle的功能，使得常见的构建任务和配置变得简单。例如，Java插件为Java项目添加了常见的任务，如编译和打包。

使用插件通常是通过在构建脚本中声明它们来完成的。例如：

```groovy
plugins {
    id 'java'
}
```

### 3.5 生命周期

Gradle任务有一个生命周期，包括三个阶段：

1. **初始化**：在此阶段，Gradle决定要处理哪些项目。
2. **配置**：在此阶段，Gradle构建所有的项目的任务对象。
3. **执行**：在此阶段，Gradle运行实际的任务。

------



## 创建和运行你的第一个Gradle项目

### 4.1 初始化项目

你可以使用Gradle的命令行界面创建一个新的项目。例如，要创建一个新的Java应用程序，可以运行以下命令：

```bash
gradle init --type java-application
```

指定一些版本号，就会在[当前目录](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=1&q=当前目录&zhida_source=entity)下生成一个新的Java项目。

![img](./v2-8ac66ab60aa3a6756d3ae65a9720b811_1440w.webp)



### 4.2 项目结构

上面的命令执行完毕后，会在目录下创建这样的一个结构：

![img](./v2-fecdfdf8c1114bda1acaa2ab0a3f370c_1440w.webp)



### 4.3 编写代码

它默认会在`app/src/main/java`目录中添加一个简单的`App`类。



```java
public class App {
    public String getGreeting() {
        return "Hello World!";
    }
    public static void main(String[] args) {
        System.out.println(new App().getGreeting());
    }
}
```



### 4.4 构建项目

在项目的[根目录](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=1&q=根目录&zhida_source=entity)中，运行以下命令来构建项目：

```bash
gradle build
```



这会编译Java类、运行任何测试（如果有的话）并创建一个JAR文件。

![img](./v2-313b4e0d7d11b3bc119b810c1192c8b0_1440w.webp)



### 4.5 运行应用

如果你已经使用`--type java-application`来初始化项目，你可以使用以下命令来运行你的应用：

```bash
gradle run
```



你应该会看到`Hello World!`的输出。

![img](./v2-9bab11a6ac5f31898dd77a83a5f8bec0_1440w.webp)





\---



## Gradle构建脚本基础

### 5.1 build.gradle文件的作用

`build.gradle`是Gradle构建的核心。它是一个用Groovy或Kotlin DSL编写的脚本，用于定义项目的构建逻辑。它描述了如何编译和打包代码，如何运行测试，以及如何发布成果物。



### 5.2 任务（Tasks）

任务是构建的[原子操作](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=1&q=原子操作&zhida_source=entity)。每个任务都代表了构建过程中的一个步骤。例如，编译源代码、运行[单元测试](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=1&q=单元测试&zhida_source=entity)、生成文档等。

```groovy
tasks.register('myTask') {
    doLast {
        println 'This is a custom task.'
    }
}
```

上面的代码定义了一个名为`myTask`的任务，当其被执行时，会在控制台上打印出消息。我们把这段话复制到刚刚的build.gradle下，然后执行就会打印这句话：

![img](./v2-85c238ce15c222a031a7191958054938_1440w.webp)

### 5.3 依赖（Dependencies）

任务之间可能存在依赖关系。这意味着一个任务可能依赖于其他一个或多个任务的成功执行。



```groovy
tasks.register('taskA') {
    doLast {
        println 'Task A is executed.'
    }
}

tasks.register('taskB') {
    dependsOn 'taskA'
    doLast {
        println 'Task B is executed.'
    }
}
```

在上面的例子中，`taskB`依赖于`taskA`。当你执行`taskB`时，首先会执行`taskA`。如图所示：

![img](./v2-dae9b9abb8d7f40dae3f943ea391ced8_1440w.webp)



### 5.4 插件（Plugins）

插件是一种强大的扩展Gradle功能的方式。它们可以提供额外的构建任务，增强现有任务，甚至改变Gradle的核心行为。下面列举了一些常用的插件和它们的作用。

```groovy
plugins {
    id 'java' // Java插件，为Java项目提供编译、测试和打包的任务
    id 'application' // Application插件，可以创建可运行的应用程序，提供了‘run’任务来运行应用
    id 'war' // War插件，用于构建Java Web应用程序，提供了生成WAR文件的任务
}
```



### Java插件

`java`插件是最基础的插件之一，提供了用于Java项目的核心任务，如`compileJava`来编译Java源代码和`test`来运行测试。



### Application插件

`application`插件扩展了`java`插件，提供了创建可执行Java应用程序所需的功能。最重要的是，它添加了`run`任务，允许你直接从Gradle运行你的应用。

### War插件

`war`插件是为Java Web应用程序设计的，用于生成WAR文件，这是Java EE和Servlet容器通常使用的部署格式。

### 其他插件

Gradle拥有丰富的插件生态系统，包括但不限于Android开发、Spring Boot集成、Docker构建等。你可以浏览[Gradle Plugin Portal]([Gradle - Plugins](https://link.zhihu.com/?target=https%3A//plugins.gradle.org/))来查找更多可用的[插件](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=23&q=插件&zhida_source=entity)。

每个插件都有其独特的配置和用法，因此在使用新插件时，请务必查阅其官方文档，以了解如何正确配置和使用它们。

不同的插件解决了不同的问题，但它们都遵循着同样的设计原则和配置方式，一旦你熟悉了几个常用插件的用法，就能快速学会使用新的插件。



------



## 常用的Gradle任务

在Gradle中，每一个构建动作都是通过执行一个或多个任务来完成的。当我们引入插件时，这些插件通常会为我们预定义一些任务。以下，我们将深入探讨一些常用的Gradle任务。



### 6.1 清理

任务名称: `clean`

这是一个非常常用的任务。当执行此任务时，Gradle会删除构建目录，确保下一次构建是从干净的状态开始的。

使用命令：

```groovy
gradle clean
```

### 6.2 构建

任务名称: `build`

此任务是Java插件提供的。当执行此任务时，Gradle会执行完整的构建周期，包括编译、测试等。

使用命令：

```groovy
gradle build
```

### 6.3 测试

任务名称: `test`

该任务也是Java插件提供的。它负责运行项目的单元测试。

使用命令：

```groovy
gradle test
```



### 6.4 运行

任务名称: `run`

为了使用此任务，我们需要引入`application`插件，并设置主类。

```groovy
plugins {
    id 'application'
}
mainClassName = 'com.example.Main'
```



然后，可以使用以下命令来运行应用：

```groovy
gradle run
```

------

## 依赖管理

在大多数软件项目中，我们通常依赖于第三方库来完成某些功能。Gradle提供了一个强大的依赖管理系统，使得声明、解析和使用这些第三方库变得轻而易举。

### 7.1 声明仓库

要使用外部依赖，首先需要告诉Gradle从哪里获取它们。最常用的仓库是Maven Central和JCenter。

例如，要添加Maven Central仓库，你可以这样写：

```groovy
repositories {
    mavenCentral()
}
```

如果你想使用JCenter仓库：

```groovy
repositories {
    jcenter()
}
```



### 7.2 声明和使用依赖

一旦设置了仓库，就可以开始添加依赖了。

例如，要在Java项目中使用Google的Gson库，可以如下添加：

```groovy
dependencies {
    implementation 'com.google.code.gson:gson:2.8.6'
}
```

其中，`implementation`表示这是一个主要的运行时依赖。

### 7.3 依赖冲突解决

有时，当你的项目依赖于多个库，并且这些库依赖于相同库的不同版本时，就会发生冲突。Gradle有强大的冲突解决策略，通常会选择最新的版本。

但如果你需要更精确的控制，可以这样做：

```groovy
configurations.all {
    resolutionStrategy {
        force 'com.google.code.gson:gson:2.8.5'
    }
}
```

这将确保项目中使用的Gson库版本为2.8.5，即使其他依赖可能请求了一个不同的版本。

------

## 使用插件

Gradle插件为构建和管理项目提供了额外的功能。从Java到Android，再到Spring Boot，几乎所有的现代框架和平台都有自己的Gradle插件来简化相关任务。



### 8.1 常见的插件

- **Java 插件**: 这是最常用的插件之一，它为Java项目提供了编译、测试和打包的功能。

```groovy
    plugins {
        id 'java'
    }
```

- **Application 插件**: 如果你正在构建一个应用程序，这个插件可以帮助你打包并运行它。

```groovy
    plugins {
        id 'application'
    }
```

- **War 插件:** 为Web应用程序提供支持，使你能够构建WAR文件。

```groovy
    plugins {
        id 'war'
    }
```

### 8.2 如何应用插件

你已经看到了如何应用一个插件，那么我们将更深入地了解它。插件可以从Gradle插件门户、Maven仓库或本地文件应用。

- **从Gradle插件门户应用（目前主流做法，简洁）**:

```groovy
    plugins {
        id 'org.springframework.boot' version '2.5.4'
    }
```

- **从Maven仓库应用**:

```groovy
    buildscript {
        repositories {
            mavenCentral()
        }
        dependencies {
            classpath("org.springframework.boot:spring-boot-gradle-plugin:2.5.4")
        }
    }
    apply plugin: 'org.springframework.boot'
```

- **从本地文件应用**:

```groovy
    apply from: 'other.gradle'
```

### 8.3 插件的配置

大多数插件都提供了一组可配置的属性来定制它们的行为。例如，`application`插件允许你指定应用的主类：

```groovy
application {
    mainClassName = 'com.example.Main'
}
```

建议查看官方文档或插件的文档来了解所有可用的配置选项。

------



## 多项目构建

大型应用程序和库通常不仅仅是一个孤立的项目。它们可能由多个子项目组成，每个子项目都负责特定的功能。Gradle支持多项目构建，允许你在一个构建中管理和编译多个项目。

### 9.1 设置子项目

在你的主项目目录下，创建一个`settings.gradle`文件（如果尚未存在），并声明子项目：

```groovy
include 'subproject1', 'subproject2'
```

此处的`subproject1`和`subproject2`是子项目的目录名。

### 9.2 配置和执行跨项目的任务

每个子项目都可以有自己的`[build.gradle](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=6&q=build.gradle&zhida_source=entity)`文件，其中定义了该子项目的构建逻辑。但在根项目中，你可以定义影响所有子项目的构建逻辑：

```groovy
subprojects {
    apply plugin: 'java'

    repositories {
        mavenCentral()
    }

    dependencies {
        testImplementation 'junit:junit:4.12'
    }
}
```

上面的[代码片段](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=1&q=代码片段&zhida_source=entity)将Java插件、Maven Central仓库和JUnit依赖添加到所有子项目中。

要在所有子项目上执行任务，只需在根目录下运行该任务。例如，运行`gradle build`将构建所有子项目。

如果只想在一个特定的子项目上执行任务，可以这样：

```bash
gradle :subproject1:build
```

多项目构建是Gradle的强大特性之一，尤其是对于大型的代码库。通过合适地组织和配置，你可以确保整个代码库的一致性和可维护性。

------

## 自定义任务和扩展

### 10.1 编写自己的任务

在创建自定义任务时，推荐使用`tasks.register`方法来注册新的任务。这是一个[懒加载](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=1&q=懒加载&zhida_source=entity)的方法，意味着任务只有在真正需要时才会创建。

```groovy
abstract class HelloTask extends DefaultTask {
    @TaskAction
    def sayHello() {
        println 'Hello, Gradle!'
    }
}
tasks.register('hello', HelloTask)
```

此处使用`abstract`关键字是因为Gradle会为任务生成具体的实现。

运行`gradle hello`将输出`Hello, Gradle!`。

![img](./v2-515742949a17e8bc706ac49b928ae9f5_1440w.webp)



### 10.2 使用Gradle的API

对于现有的任务，我们通常使用`tasks.withType`来对某种特定类型的所有任务进行配置：

```groovy
tasks.withType(HelloTask).configureEach {
    // 这里可以为每个HelloTask类型的任务进行配置
}
```

### 10.3 扩展的概念

Gradle扩展依然是为项目定义自定义属性的推荐方式。但在新的API中，推荐使用`extensions.create`的方式：

```groovy
extensions.create('myExtension', MyExtension)

abstract class MyExtension {
    String customProperty = 'default value'
}
```

通过自定义任务和扩展，你可以使Gradle构建过程更加灵活和强大。它们提供了一种机制，使你可以适应项目的特定需求，同时还能保持构建脚本的可读性和组织性。

------

## 构建缓存和增量构建

构建优化对于大型项目和频繁的构建操作非常关键。Gradle 提供了两个强大的特性来加速构建：构建缓存和增量构建。

### 11.1 为什么需要缓存？

每次运行构建时，都有很多任务是重复的，尤其是在没有对代码或资源做任何修改的情况下。构建缓存的作用是存储已经执行过的任务的输出，以便在将来的构建中重用，从而避免不必要的工作。



### 11.2 构建缓存的使用和配置

默认情况下，Gradle 使用本地构建缓存。你可以通过以下方式在项目的 `settings.gradle` 或 `settings.gradle.kts` 文件中启用或禁用它：

```groovy
buildCache {
    local {
        enabled = true
    }
}
```

此外，Gradle 也支持远程构建缓存，这在团队开发中非常有用，因为它允许团队成员之间共享构建的输出。



### 11.3 增量构建

增量构建是指只对自上次构建以来发生变化的部分进行构建。为了使任务支持增量构建，你需要确保：

- 使用`@Input`和`@Output`注解来声明任务的输入和输出。
- 使用`@Incremental`注解在`TaskAction`方法上。

Gradle 会自动跟踪这些输入和输出之间的变化，并在可能的情况下只执行所需的工作。

### 11.4 示例：增量构建

假设我们有一个任务，该任务将源文件从一个目录复制到另一个目录，并将所有文件的扩展名更改为 `.txt`。我们可以这样做：

### 11.4.1添加一个自定义任务

在 `build.gradle` 文件的顶部，添加以下内容：

```groovy
import org.gradle.work.InputChanges
abstract class IncrementalCopyTask extends DefaultTask {
    @InputDirectory
    abstract DirectoryProperty getSourceDir()

    @OutputDirectory
    abstract DirectoryProperty getTargetDir()
    @TaskAction
    void executeIncremental(InputChanges inputChanges) {
        inputChanges.getFileChanges(getSourceDir()).each { change ->
            switch (change.changeType.name()) {
                case "ADDED":
                case "MODIFIED":
                    def targetFile = new File(getTargetDir().asFile, change.file.name + '.txt')
                    change.file.copyTo(targetFile)
                    break
                case "REMOVED":
                    new File(getTargetDir().asFile, change.file.name + '.txt').delete()
                    break
            }
        }
    }
}
```

在 `build.gradle` 的底部，注册这个任务：

```groovy
tasks.register('incrementalCopy', IncrementalCopyTask) {
    sourceDir = file('src/main/resources')
    targetDir = file("$buildDir/output")
}
```

这样，我们就为 `src/main/resources` 目录中的文件定义了一个增量复制任务，输出目录是 `build/output`。

### 11.4.2运行任务

为了测试这个任务，你可以首先在 `src/main/resources` 中创建一些文件，然后运行：

```bash
$ gradle incrementalCopy
```

你会看到这些文件被复制到 `build/output` 目录，并且它们的扩展名都被更改为 `.txt`。

如果你再次运行该任务，不做任何改动，Gradle 会检测到没有任何变化，因此不会执行任何复制操作，这就是增量构建的威力。试试在 `src/main/resources` 中添加、修改或删除文件，然后再次运行任务。你会看到只有发生变化的文件才会被处理。这就是一个简单的增量构建示例。你可以在此基础上进一步扩展或修改来满足你的实际需求。

------

## Gradle Wrapper的使用

### 12.1 什么是Gradle Wrapper？

Gradle Wrapper是一个工具，允许你在没有预先安装Gradle的情况下执行构建。这样做的好处是可以确保每个开发者和持续集成工具都使用相同版本的Gradle，避免了“在我的机器上可以运行”这样的问题。Wrapper由一个小的`gradlew`（Unix系统）或`gradlew.bat`（Windows系统）脚本和一些库文件组成。

### 12.2 为什么要使用Gradle Wrapper？

1. **版本一致性**：确保每个开发者和CI环境都使用相同的Gradle版本。
2. **简化构建过程**：开发者无需手动安装特定版本的Gradle。
3. **灵活性**：项目可以很容易地切换到新的Gradle版本，只需修改Wrapper配置即可。



### 12.3 如何设置Gradle Wrapper？

大部分通过`gradle init`初始化的新项目默认就包含了Wrapper。但如果你的项目还没有Wrapper，可以很容易地添加：

```bash
$ gradle wrapper --gradle-version=7.2
```

这会为你的项目生成Wrapper脚本和相关配置。



### 12.4 如何使用Gradle Wrapper？

一旦你的项目配置了Wrapper，你应该使用Wrapper脚本来运行所有Gradle任务，而不是直接使用`gradle`命令。例如：

在Unix或macOS上：

```bash
$ ./gradlew <task>
```

在Windows上：

```bash
> gradlew.bat <task>
```

如果你看到有人在项目的README或构建指南中推荐使用`gradlew`而不是`gradle`，这就是为什么。

### 12.5更新Gradle Wrapper的版本

随着Gradle的发展，你可能想要更新项目中的Gradle版本。使用Wrapper，这变得很容易。例如，要更新到Gradle 7.3，你可以运行：

```bash
$ ./gradlew wrapper --gradle-version=7.3
```

这会更新Wrapper使用的Gradle版本，并下载必要的文件。



### 总结

Gradle Wrapper是Gradle的一个强大特性，它确保了构建的一致性和简化了开发和CI环境的配置。为你的项目使用Wrapper是一个[最佳实践](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=1&q=最佳实践&zhida_source=entity)，无论项目大小都推荐这样做。

------

## 参考文献

1. [云原生—Gradle和Maven性能对比及技术选型]([云原生-Gradle和Maven性能对比及技术选型 - 掘金](https://link.zhihu.com/?target=https%3A//juejin.cn/post/7209178782657675319)) - [稀土掘金](https://zhida.zhihu.com/search?content_id=234482716&content_type=Article&match_order=1&q=稀土掘金&zhida_source=entity)
2. [Gradle | Releases]([Gradle | Releases](https://link.zhihu.com/?target=https%3A//gradle.org/releases/)) - 官方文档
3. [Gradle | Plugins]([Gradle - Plugins](https://link.zhihu.com/?target=https%3A//plugins.gradle.org/)) - 官方文档
4. [Gradle 比 Maven 好为什么用的人少？]([Gradle 比 Maven 好为什么用的人少？](https://www.zhihu.com/question/276078446)) - 知乎
5. [Gradle 快速入门]([Gradle 快速入门 - 掘金](https://link.zhihu.com/?target=https%3A//juejin.cn/post/6995737350869368845))
6. [Gradle 详细手册（从入门到入土）]([Gradle 详细手册（从入门到入土）](https://link.zhihu.com/?target=https%3A//juejin.cn/post/6932813521344430094)) - 稀土掘金
7. [如何使用Gradle管理多模块Java项目]([Joey：如何使用Gradle管理多模块Java项目](https://zhuanlan.zhihu.com/p/372585663)) - 知乎
8. [Android—Gradle教程（一）]([Android-Gradle教程（一） - 掘金](https://link.zhihu.com/?target=https%3A//juejin.cn/post/7022954104670388254)) - 稀土掘金
9. [GradleUserGuide]([GitHub - DONGChuan/GradleUserGuide: "Gradle User Guide" Chinese version](https://link.zhihu.com/?target=https%3A//github.com/DONGChuan/GradleUserGuide)) - GitHub
10. [Github Actions]([https://docs.github.com/zh/actions/automating-builds-and-tests/building-and-testing-java-with-gradle](https://link.zhihu.com/?target=https%3A//docs.github.com/zh/actions/automating-builds-and-tests/building-and-testing-java-with-gradle)) - GitHub