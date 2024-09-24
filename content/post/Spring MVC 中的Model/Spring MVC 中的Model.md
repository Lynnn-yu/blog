---
title: "Spring MVC 中的Model"
date: 2024-09-20T20:15:06+08:00
draft: false 
params: 
  author: Lynn
tags: ["SpringBoot", "Spring MVC", "Java"]
categories: ["技术博客"]
description: "Spring MVC中，Model实现控制器与视图的数据传递与绑定。"
summary: "Spring MVC中，Model实现控制器与视图的数据传递与绑定。"
image: "/图.jpg"
---



在 Spring MVC 中，`Model` 用于在控制器和视图之间传递数据。当你在控制器方法中使用 `model.addAttribute()` 添加数据时，这些数据会自动被传递到视图（如 Thymeleaf、JSP 等），并在视图中通过模型属性的名字进行访问。

### `Model` 传参的具体流程

**1.控制器方法传递数据到视图**：

- 在控制器中，使用 `model.addAttribute()` 方法将一个对象添加到 `Model`。
- Spring MVC 会将这个对象作为请求属性传递给视图（比如 Thymeleaf 模板）。
- 视图渲染时，可以通过模型中提供的属性来访问并显示数据。

#### 示例代码：

```java
@GetMapping("/types/input") 
public String input(Model model) { 
    // 创建一个新的 Type 对象，并通过 addAttribute 将其放入 Model 中 
    model.addAttribute("type", new Type()); 
    return "admin/types-input"; // 返回视图名 
}
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

​    在上面的代码中，`model.addAttribute("type", new Type())` 将一个 `Type` 对象存储在模型中，键名为 `"type"`。

**2.视图中获取和使用模型数据**：

- 在视图模板中（例如 Thymeleaf），你可以通过指定的键名来访问 `Model` 中的数据。键名是 `addAttribute` 中的第一个参数（如 `"type"`），通过这个键名，视图可以使用绑定的对象进行显示或表单字段的初始化。

#### 示例 Thymeleaf 视图（`admin/types-input.html`）：

```html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Type Input</title>
</head>
<body>
    <h1>Input Type</h1>
    
    <!-- 表单绑定到 type 对象的 name 属性 -->
    <form th:action="@{/types/save}" method="post">
        <label for="name">Type Name:</label>
        <input type="text" id="name" th:field="*{name}" placeholder="Enter type name">
        <button type="submit">Submit</button>
    </form>
</body>
</html>
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

- `th:field="*{name}"`

  : 	

  - 这里的 `*{name}` 表示从 `Model` 中绑定的 `type` 对象的 `name` 属性。
  - Spring MVC 自动将 `Type` 对象放入 `Model` 中，所以 Thymeleaf 模板能够直接访问 `Type` 对象的属性。
  - 当页面加载时，`th:field` 会预先将 `type.name` 的值显示在表单中（如果有值）。在提交表单时，输入的数据会绑定到 `Type` 对象的 `name` 属性。

### `Model` 的传递过程

#### 1. **数据存入 `Model`**：

- 在控制器方法中调用 `model.addAttribute("type", new Type())`，将键值对存入 `Model`。
- 这里 `"type"` 是键，`new Type()` 是对应的值（对象）。

#### 2. **传递到视图**：

- Spring MVC 将模型中的所有键值对放入 HTTP 请求的属性中，传递到视图层。
- 模型中的数据自动与视图解析器（如 Thymeleaf、JSP）关联，视图模板可以通过模型中的键名来访问对象。

#### 3. **视图访问模型数据**：

- 在视图模板中，可以通过 `type` 键名直接访问绑定的 `Type` 对象，并且可以使用这个对象来填充表单字段、显示数据，或进行其他操作。

### 具体示例：完整的控制器与视图交互

#### 1. 控制器

```java
@Controller
public class TypeController {

    @GetMapping("/types/input")
    public String input(Model model) {
        // 创建一个新的 Type 对象，传递给视图
        model.addAttribute("type", new Type());
        return "admin/types-input";  // 返回视图名称
    }

    @PostMapping("/types/save")
    public String save(@ModelAttribute Type type) {
        // 在这里处理保存操作，Type 对象会自动绑定表单提交的数据
        System.out.println("Saved Type: " + type.getName());
        return "redirect:/types/list";  // 重定向到类型列表页面
    }
}
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

#### 2. 视图模板（`admin/types-input.html`）

```html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Type Input</title>
</head>
<body>
    <h1>Input Type</h1>
    
    <!-- 使用 th:field 来绑定 type 对象的 name 属性 -->
    <form th:action="@{/types/save}" method="post">
        <label for="name">Type Name:</label>
        <input type="text" id="name" th:field="*{name}" placeholder="Enter type name">
        <button type="submit">Submit</button>
    </form>
</body>
</html>
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

### 总结

- `Model` 在控制器和视图之间扮演了数据传递的桥梁。
- 在控制器中，你可以通过 `model.addAttribute()` 将数据传递给视图，视图模板可以通过指定的键名访问这些数据。
- 这种方式通常用于表单提交的场景，视图层会根据控制器传递的对象进行表单数据的绑定和显示。