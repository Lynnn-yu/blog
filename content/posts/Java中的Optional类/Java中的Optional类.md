---
title: "Java中的Optional类"
date: 2024/9/20 17:15:06
draft: false 
params:
  author: Lynn
tags: ["容器类", "Java"]
categories: ["技术博客"]
description: "Optional<T> 是 Java 8 引入的一个容器类，用来解决 `null` 引用的问题。它可以包含或不包含一个非空值。"
summary: "Optional<T> 是 Java 8 引入的一个容器类，用来解决 `null` 引用的问题。它可以包含或不包含一个非空值。"
---

`Optional<T>` 是 Java 8 引入的一个容器类，用来解决 `null` 引用的问题。它可以包含或不包含一个非空值。`Optional` 主要用于避免 `NullPointerException`，使代码更加安全和可读。

### 创建 Optional 对象

有几种方式可以创建一个 `Optional` 对象：

#### 1. `Optional.of(T value)`

这个方法用于创建包含非空值的 `Optional` 对象。如果传入的值为 `null`，它会抛出 `NullPointerException`。

```java
Optional<String> optional = Optional.of("Hello");
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

#### 2. `Optional.ofNullable(T value)`

这个方法允许传入一个可能为 `null` 的值。如果值为 `null`，它会返回一个空的 `Optional` 对象；否则返回一个包含该值的 `Optional`。

```java
Optional<String> optional = Optional.ofNullable(null); // 空的 Optional Optional<String> optional2 = Optional.ofNullable("Hello"); // 包含 "Hello" 的 Optional
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

#### 3. `Optional.empty()`

创建一个空的 `Optional` 对象，不包含任何值。

```java
Optional<String> optional = Optional.empty();
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

### 使用 Optional 的常用方法

#### 1. `isPresent()`

检查 `Optional` 是否包含值。如果值存在，返回 `true`，否则返回 `false`。

```java
Optional<String> optional = Optional.of("Hello"); 
if (optional.isPresent()) { 
    System.out.println(optional.get()); // 输出 "Hello" 
}
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

#### 2. `ifPresent(Consumer<? super T> action)`

如果 `Optional` 中包含值，就执行给定的 `Consumer` 操作，否则不执行。

```java
optional.ifPresent(value -> System.out.println(value)); // 输出 "Hello"
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

#### 3. `orElse(T other)`

如果 `Optional` 中包含值，返回该值；如果为空，则返回一个默认值。

```java
String value = optional.orElse("Default Value"); 
System.out.println(value); // 输出 "Hello" 或 "Default Value"
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

#### 4. `orElseGet(Supplier<? extends T> other)`

类似于 `orElse()`，但可以通过传递 `Supplier` 来动态生成默认值。

```java
String value = optional.orElseGet(() -> "Generated Value");
System.out.println(value);  // 输出 "Hello" 或 "Generated Value"
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

#### 5. `orElseThrow(Supplier<? extends X> exceptionSupplier)`

如果 `Optional` 中包含值，返回该值；如果为空，抛出自定义的异常。

```java
String value = optional.orElseThrow(() -> new IllegalArgumentException("No value present"));
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

#### 6. `get()`

返回 `Optional` 中包含的值。如果为空，则抛出 `NoSuchElementException`。

```java
Optional<String> optional = Optional.of("Hello");
System.out.println(optional.get());  // 输出 "Hello"
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

**注意**：使用 `get()` 之前应当确保 `Optional` 中有值，可以配合 `isPresent()` 或者 `ifPresent()` 来避免异常。

#### 7. `map(Function<? super T,? extends U> mapper)`

如果 `Optional` 中存在值，则对其应用 `Function` 并返回新的 `Optional`，否则返回空的 `Optional`。

```java
Optional<String> optional = Optional.of("Hello");
Optional<Integer> length = optional.map(String::length);
System.out.println(length.get());  // 输出 5
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

#### 8. `flatMap(Function<? super T, Optional<U>> mapper)`

与 `map()` 类似，但 `mapper` 返回的是一个 `Optional`，而不是直接返回值，用于嵌套的 `Optional` 解包。

```java
Optional<String> optional = Optional.of("Hello");
Optional<String> result = optional.flatMap(value -> Optional.of(value.toUpperCase()));
System.out.println(result.get());  // 输出 "HELLO"
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

### 示例

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        // 创建一个 Optional 包含 "Hello"
        Optional<String> optional = Optional.of("Hello");

        // 检查值是否存在
        if (optional.isPresent()) {
            System.out.println("Value is present: " + optional.get());
        }

        // 使用 orElse 方法获取值或默认值
        String value = optional.orElse("Default Value");
        System.out.println("The value is: " + value);

        // 使用 map 转换值
        Optional<Integer> length = optional.map(String::length);
        System.out.println("Length of the string is: " + length.get());

        // 使用 flatMap 链式操作
        Optional<String> result = optional.flatMap(val -> Optional.of(val.toUpperCase()));
        System.out.println("Uppercased value: " + result.get());
    }
}
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

### 总结

`Optional` 是一个非常有用的工具，可以有效避免 `null` 引用问题，增强代码的可读性和健壮性。通过合理使用 `Optional` 的各种方法，你可以更好地管理代码中的空值处理逻辑。