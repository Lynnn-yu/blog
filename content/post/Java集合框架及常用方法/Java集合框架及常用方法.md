---
title: "Java集合框架：数据结构及常用操作一览"
date: 2024-09-22T16:15:06+08:00
draft: false 
params: 
  author: Lynn
tags: ["Java", "数据结构"]
categories: ["技术博客"]
description: "Java 集合框架提供了一套综合的接口和类，用于表示和操作数据组，使得数据集的操作更加直观和统一。这个框架包括集合、列表、队列、映射等多种数据结构，每种都有其特定的用途和优化。"
summary: "Java 集合框架提供了一套综合的接口和类，用于表示和操作数据组，使得数据集的操作更加直观和统一。这个框架包括集合、列表、队列、映射等多种数据结构，每种都有其特定的用途和优化。"
image: "/图.jpg"
---

## 核心接口

### 一、 Collection

- **关键方法**: 

  **基本操作：**

  - **add(E e)**: 向集合添加一个元素，如果集合因添加而改变（即添加成功），返回 `true`。
  - **addAll(Collection<? extends E> c)**: 将指定集合中的所有元素添加到此集合（可选操作）。
  - **clear()**: 移除此集合中的所有元素（可选操作）。
  - **contains(Object o)**: 如果此集合包含指定的元素，则返回 `true`。
  - **containsAll(Collection<?> c)**: 如果此集合包含指定集合中的所有元素，则返回 `true`。
  - **isEmpty()**: 如果此集合不包含元素，则返回 `true`。
  - **iterator()**: 返回在此集合的元素上进行迭代的迭代器。
  - **remove(Object o)**: 从此集合中移除一个元素的单个实例，如果存在的话（可选操作）。
  - **removeAll(Collection<?> c)**: 移除此集合中那些也包含在指定集合中的所有元素（可选操作）。
  - **retainAll(Collection<?> c)**: 仅保留此集合中那些也包含在指定集合的元素（可选操作）。
  - **size()**: 返回此集合中的元素数。
  - **toArray()**: 返回包含此集合中所有元素的数组。
  - **toArray(T[] a)**: 返回包含此集合中所有元素的数组；返回数组的运行时类型是指定数组的类型。

  **扩展操作：**

  - **stream()**: 返回一个顺序流，其元素是此集合的元素。
  - **parallelStream()**: 返回可能是并行的流，其元素是此集合的元素。
  - **spliterator()**: 在此集合中创建一个Spliterator。

#### 1. List

- **概述**: `List` 接口扩展自 `Collection` 接口，表示有序的集合。它允许重复的元素并且可以精确控制每个元素的位置。

- **关键方法**: 

  **基本操作：**

  - **get(int index)**: 返回列表中指定位置的元素。
  - **set(int index, E element)**: 替换列表中指定位置的元素，并返回之前在该位置的元素。
  - **add(int index, E element)**: 在列表的指定位置插入指定元素（可选操作）。
  - **remove(int index)**: 移除列表中指定位置的元素，并返回该元素（可选操作）。

  **搜索操作：**

  - **indexOf(Object o)**: 返回列表中首次出现的指定元素的索引，如果列表不包含此元素，则返回 -1。
  - **lastIndexOf(Object o)**: 返回列表中最后出现的指定元素的索引，如果列表不包含此元素，则返回 -1。

  **视图操作：**

  - **listIterator()**: 返回列表中元素的列表迭代器（在列表的所有元素上进行迭代）。
  - **listIterator(int index)**: 返回列表中元素的列表迭代器，迭代器的起始位置是列表中指定的位置。
  - **subList(int fromIndex, int toIndex)**: 返回列表中指定的 fromIndex（包含）和 toIndex（不包含）之间的视图。

- **主要实现**: `ArrayList`, `LinkedList`, `Vector`.

#### 2. Set

- **概述**: `Set` 接口也是扩展自 `Collection`，代表没有重复元素的集合。

- **关键方法**: 与 `Collection` 接口共享大多数方法，没有额外的特殊方法，但强调了不允许有重复元素的特性。

  例如：

  - **add(E e)**：添加一个元素 `e` 到集合中，如果集合已经包含了该元素，则不进行添加操作，并且返回 `false`。这与 `Collection` 接口的 `add` 方法不同，后者允许添加重复的元素。
  - **equals(Object o)** 和 **hashCode()**：`Set` 接口也特别重视这两个方法的实现，以保持与 `Set` 语义的一致性。这意味着两个 `Set` 对象相等的条件是它们包含相同的元素。

- **主要实现**: `HashSet`, `LinkedHashSet`, `TreeSet`.

#### 3. Queue

- **概述**: `Queue` 接口扩展自 `Collection` 用于存储一组元素，元素的添加和移除遵循特定的顺序，比如先进先出（FIFO）。

- **关键方法**: 

  **添加元素：**

  - **offer(E e)**: 尝试将元素 `e` 添加到队列中。如果成功，则返回 `true`；如果由于容量限制无法添加，则返回 `false`。这提供了一种比 `add(E e)` 更优雅的方式来添加元素，因为 `add` 方法在无法添加元素时会抛出异常。

  **移除元素：**

  - **poll()**: 移除并返回队列头部的元素。如果队列为空，返回 `null`。这是一个非阻塞的队列操作，不会抛出异常。
  - **remove()**: 从队列中移除并返回头部元素。这个方法与 `poll` 的区别在于，如果队列为空，它会抛出 `NoSuchElementException`。

  **检查元素：**

  - **peek()**: 检索但不移除队列的头部元素。如果队列为空，则返回 `null`。这个方法允许用户在不改变队列状态的情况下查看队列的头部元素。
  - **element()**: 检索但不移除队列的头部元素。这个方法与 `peek` 的区别在于，如果队列为空，它会抛出 `NoSuchElementException`。

- **主要实现**: `LinkedList`, `PriorityQueue`.

### 二、 Map

- **概述**: `Map` 不是 `Collection` 接口的一部分，它表示键值对的映射。每个键最多只能映射到一个值。

- **关键方法**: 

  **基本操作：**

  - **put(K key, V value)**: 将指定的值与此映射中的指定键关联（可选操作）。如果映射以前包含了该键的映射，则旧值将被替换。
  - **get(Object key)**: 返回指定键所映射的值，如果此映射不包含该键的映射关系，则返回 `null`。
  - **remove(Object key)**: 如果存在一个键的映射关系，则将其从映射中移除（可选操作）。

  **批量操作：**

  - **putAll(Map<? extends K, ? extends V> m)**: 将所有的映射关系从指定的映射复制到此映射中（可选操作）。
  - **clear()**: 从此映射中移除所有的映射关系（可选操作）。

  **查询操作：**

  - **containsKey(Object key)**: 如果此映射包含指定键的映射关系，则返回 `true`。
  - **containsValue(Object value)**: 如果此映射将一个或多个键映射到指定值，则返回 `true`。
  - **isEmpty()**: 如果此映射不包含键-值映射关系，则返回 `true`。
  - **size()**: 返回此映射中的键-值映射关系的数量。

  **视图操作：**

  - **keySet()**: 返回此映射中包含的键的 `Set` 视图。
  - **values()**: 返回此映射中包含的值的 `Collection` 视图。
  - **entrySet()**: 返回此映射中包含的映射关系的 `Set` 视图。该 `Set` 中的每个元素都是一个实现了 `Map.Entry` 接口的键值对对象。

  **`Map.Entry` 接口**

  `Map` 还定义了一个内部接口 `Map.Entry`，这个接口表示 `Map` 中的一个键值对（一个映射关系）。

  - **getKey()**: 返回与此项对应的键。
  - **getValue()**: 返回与此项对应的值。
  - **setValue(V value)**: 将此项的值替换为指定的值（可选操作）。

- **主要实现**: `HashMap`, `TreeMap`, `LinkedHashMap`.



## 数据结构

### 1. 数组 (Array)

- **静态数组**：Java 中的数组是固定长度的数据结构，用于存储相同类型的数据。它们提供快速的索引访问，但大小不可变。

- **常用方法：**

  虽然数组自身的方法有限，Java 类库提供了一些工具类，如 `Arrays` 类，以支持更复杂的数组操作：

  - **排序**: `Arrays.sort(array)` 方法可以对数组进行排序。
  - **搜索**: 使用 `Arrays.binarySearch(sortedArray, key)` 在已排序的数组中查找特定的元素。
  - **比较**: `Arrays.equals(array1, array2)` 用来比较两个数组的内容是否相等。
  - **填充**: `Arrays.fill(array, value)` 方法可以将特定的值赋给数组中的每个元素。
  - **转换为列表**: `Arrays.asList(array)` 将数组转换为一个固定大小的列表。
  - **复制**: `Arrays.copyOf(array, newLength)` 复制数组到新的数组，可以指定新数组的长度。
  - **打印**: `Arrays.toString(array)` 返回数组内容的字符串表示，便于打印输出。

### 2. 动态数组 (ArrayList)

```java
List<Integer> list = new ArrayList<>();
```

- **动态扩容**：是 `List` 接口的一个实现。基于数组实现，但能动态地扩展和缩减大小。主要优点是提供快速的随机访问，同时允许在列表末尾高效地添加或删除元素。

- **常用方法：**

  - **add(E e)**: 在列表末尾添加一个元素，返回 `true`。
  - **add(int index, E element)**: 在列表的指定位置添加一个元素。

  - **remove(Object o)**: 删除列表中首次出现的指定元素，如果列表包含该元素则返回 `true`。
  - **remove(int index)**: 删除指定索引处的元素，返回被删除的元素。

  - **get(int index)**: 返回列表中指定位置的元素。

  - **set(int index, E element)**: 替换指定索引处的元素，返回之前在该位置的元素。

  - **size()**: 返回列表中的元素数。
  - **isEmpty()**: 检查列表是否为空，为空返回 `true`。

  - **contains(Object o)**: 如果列表包含指定的元素，则返回 `true`。

  - **indexOf(Object o)**: 返回列表中首次出现的指定元素的索引，如果此列表不包含该元素，则返回 -1。
  - **lastIndexOf(Object o)**: 返回列表中最后出现的指定元素的索引，如果列表不包含该元素，则返回 -1。

  - **addAll(Collection<? extends E> c)**: 将指定集合中的所有元素添加到列表的末尾。
  - **addAll(int index, Collection<? extends E> c)**: 将指定集合中的所有元素插入到列表中的指定位置。
  - **clear()**: 移除列表中的所有元素。
  - **removeAll(Collection<?> c)**: 移除列表中包含在指定集合中的所有元素。
  - **retainAll(Collection<?> c)**: 仅保留列表中那些也包含在指定集合中的元素。

  - **iterator()**: 返回一个在列表元素上进行迭代的迭代器。
  - **listIterator()**: 返回列表中元素的列表迭代器（可以从任意位置开始迭代）。
  - **forEach(Consumer<? super E> action)**: 对每个元素执行给定的操作，这是 Java 8 引入的方法，支持 Lambda 表达式。

  - **toArray()**: 返回一个包含列表中所有元素的数组。
  - **toArray(T[] a)**: 返回一个包含列表中所有元素的数组；返回的数组的运行时类型是指定数组的类型。

### 3. 链表 (LinkedList)
```java
List<Integer> list = new LinkedList<>();
//或者，如果你需要使用 LinkedList 作为双端队列（deque）：
Deque<Integer> deque = new LinkedList<>();
```
- **双向链表**：是 `List` 接口的一个实现，也实现了 `Deque` 接口，使其能够作为一个双向链表使用。每个元素包含两个指针，分别指向前一个和后一个元素，使得在任何位置的插入和删除操作都很高效，尤其适用于实现队列和栈。

- **常用方法：**

  **List：**
  
  
    - **add(E e)**: 将元素添加到列表末尾。
    - **add(int index, E element)**: 在指定位置插入元素。
  
    - **get(int index)**: 访问指定位置的元素。
  
    - **set(int index, E element)**: 替换指定位置的元素，返回被替换的元素。
  
    - **remove(int index)**: 移除指定位置的元素，返回被移除的元素。
    - **remove(Object o)**: 删除列表中首次出现的指定元素。
  
    - **iterator()** 和 **listIterator()**: 提供顺序访问列表的迭代器。
  
  **Deque：**
  
    - **offer(E e)**: 在队列尾部添加元素，返回是否成功。
    - **offerFirst(E e)** 和 **offerLast(E e)**: 分别在队列的头部和尾部添加元素。
  
    - **poll()** 和 **pollFirst()**: 移除并返回队列头部的元素；如果队列为空，则返回 `null`。
    - **pollLast()**: 移除并返回队列尾部的元素；如果队列为空，则返回 `null`。
  
    - **peek()** 和 **peekFirst()**: 查看但不移除队列头部的元素；如果队列为空，则返回 `null`。
    - **peekLast()**: 查看但不移除队列尾部的元素；如果队列为空，则返回 `null`。
  
    - **push(E e)**: 将元素推入栈顶（队列头部）。
    - **pop()**: 移除并返回栈顶（队列头部）的元素。
  
  
  
  **使用场景：**
  
    - **List 使用场景**: 当你需要频繁地在列表中间插入或删除元素时，使用 `LinkedList` 比 `ArrayList` 更高效。
    - **Deque 使用场景**: 当你需要在两端动态地添加或移除元素，或者实现栈的行为时，`LinkedList` 提供了必要的操作。
  

### 4. 栈 (Stack)

```java
Stack<String> stack = new Stack<>();
```

- **后进先出 (LIFO)**：继承自 `Vector` 类继承自 `Vector` 类。栈是一种后进先出的数据结构，适合处理具有嵌套结构的数据，如表达式求值和语法解析。

- **常用方法：**

  - **push(E item)**: 将一个元素压入栈顶。此方法将元素添加到栈的顶部，并返回压入的元素。
  - **pop()**: 移除栈顶元素，并作为此函数的值返回该对象。
  - **peek()**: 查看栈顶对象而不移除它。返回栈顶元素，但不从栈中移除它。
  - **empty()**: 测试堆栈是否为空。
  - **search(Object o)**: 返回对象在堆栈中的位置，以 1 为基数。如果对象 `o` 作为一个项存在于此堆栈中，则返回距离栈顶最近的位置；栈顶位置为 1。如果不在栈中，则返回 `-1`。
  
  尽管 `Stack` 类在 Java 中广泛使用，但 Java 官方文档推荐更倾向于使用 `Deque` 接口来实现栈的功能，例如通过 `ArrayDeque` 类，因为 `Stack` 类本身继承自 `Vector`，其所有的操作都是同步的，这可能在不需要线程安全的应用场景中导致不必要的性能损失。使用 `ArrayDeque` 可以获得更好的性能：
  
  ```java
  Deque<Integer> stack = new ArrayDeque<>();
  stack.push(1); // 压入元素
  Integer top = stack.peek(); // 查看栈顶元素
  Integer element = stack.pop(); // 移除栈顶元素
  ```

### 5. 优先队列/堆 (PriorityQueue)

- **基于堆结构**：元素按优先级排序，允许快速访问当前最高（或最低）优先级的元素，常用于任务调度和带优先级的数据处理。

- **常用方法：**

  - **add(E e) / offer(E e)**: 向优先队列添加一个元素。这两个方法在功能上几乎相同，用于在优先队列中插入元素。

  - **peek()**: 返回队列头部的元素而不移除它，如果队列为空，则返回 `null`。
  - **element()**: 类似于 `peek()`，但如果队列为空时会抛出异常。

  - **poll()**: 移除并返回队列头部的元素，如果队列为空，则返回 `null`。
  - **remove()**: 类似于 `poll()`，但如果队列为空时会抛出异常。
  - **remove(Object o)**: 移除队列中的一个特定元素，返回 `true` 如果元素被成功移除。

  - **size()**: 返回队列中的元素数量。
  - **isEmpty()**: 检查队列是否为空，为空则返回 `true`。
  - **clear()**: 清除队列中的所有元素，使队列变为空。

  - **comparator()**: 返回当前用于比较队列元素的比较器，如果队列按照元素的自然顺序排序，则可能返回 `null`。

  

  `PriorityQueue` 是基于二叉堆实现的，这使得它在插入和删除最小元素（或根据 `Comparator` 定义的其他顺序）的操作中非常高效，这些操作的时间复杂度为 O(log n)。这种数据结构适合用于需要快速访问最“优先”元素的场合，如任务调度、带优先级的任务处理等。

### 6. 哈希表 (HashSet/HashMap)

```java
HashSet<Type> setName = new HashSet<>();
HashMap<KeyType, ValueType> map = new HashMap<>();
```

- **基于哈希算法**：提供快速的数据存取，适用于需要快速查找、插入和删除的场景。无序，不保证元素的顺序。不允许重复元素。

- **HashSet常用方法：**

  - **add(E e)**: 向集合中添加一个元素，如果元素已存在则不进行添加。

  - **contains(Object o)**: 检查集合是否包含指定的元素，返回 `true` 或 `false`。

  - **remove(Object o)**: 从集合中移除指定元素，返回 `true` 如果元素存在且成功移除，返回 `false` 如果元素不存在。

  - **size()**: 返回集合中元素的数量。
  - **isEmpty()**: 检查集合是否为空，返回 `true` 如果集合为空。

  - **clear()**: 清空集合中的所有元素，使集合变为空。

  - **iterator()**: 返回集合的迭代器，用于遍历集合中的元素。

- **HashMap常用方法：**

  - **put(K key, V value)**: 将指定的键与值关联。如果键已存在，则更新其对应的值。
  - **putAll(Map<? extends K, ? extends V> m)**: 将指定映射中的所有键值对添加到此映射中。

  - **get(Object key)**: 根据指定键返回对应的值，如果键不存在则返回 `null`。
  - **containsKey(Object key)**: 检查映射是否包含指定的键，返回 `true` 或 `false`。
  - **containsValue(Object value)**: 检查映射是否包含指定的值，返回 `true` 或 `false`。

  - **remove(Object key)**: 移除指定键及其对应的值，返回被移除的值（如果存在），否则返回 `null`。

  - **size()**: 返回映射中键值对的数量。
  - **isEmpty()**: 检查映射是否为空，返回 `true` 如果映射为空。

  - **clear()**: 清空映射中的所有键值对。

  - **keySet()**: 返回映射中所有键的集合。
  - **values()**: 返回映射中所有值的集合。
  - **entrySet()**: 返回映射中所有键值对的集合（`Map.Entry` 对象）。

### 7. 红黑树 (TreeSet/TreeMap)

```java
TreeSet<Type> set = new TreeSet<>();
TreeMap<KeyType, ValueType> treeMap = new TreeMap<>();
```

- **红黑树(自平衡的二叉查找树)**：保证数据元素按照排序规则组织，支持有序遍历和快速搜索。不允许重复元素。

- **TreeSet常用方法：**

  - **add(E e)**: 向集合中添加一个元素，如果元素已存在，则不进行添加。

  - **contains(Object o)**: 检查集合是否包含指定的元素，返回 `true` 或 `false`。

  - **remove(Object o)**: 从集合中移除指定元素，返回 `true` 如果元素存在且成功移除，返回 `false` 如果元素不存在。

  - **first()**: 返回集合中的第一个元素（最小元素）。
  - **last()**: 返回集合中的最后一个元素（最大元素）。
  - **higher(E e)**: 返回严格大于指定元素的下一个元素。
  - **lower(E e)**: 返回严格小于指定元素的上一个元素。

  - **subSet(E fromElement, E toElement)**: 返回指定范围内的视图，包含从 `fromElement` 到 `toElement`（不包含 `toElement`）。
  - **headSet(E toElement)**: 返回小于 `toElement` 的所有元素的视图。
  - **tailSet(E fromElement)**: 返回大于或等于 `fromElement` 的所有元素的视图。

  - **size()**: 返回集合中元素的数量。
  - **isEmpty()**: 检查集合是否为空，返回 `true` 如果集合为空。

  - **clear()**: 清空集合中的所有元素，使集合变为空。

  - **iterator()**: 返回集合的迭代器，用于按升序遍历集合中的元素。

- **TreeMap常用方法：**

  - **put(K key, V value)**: 将指定的键与值关联。如果键已存在，则更新其对应的值。
  - **putAll(Map<? extends K, ? extends V> m)**: 将指定映射中的所有键值对添加到此映射中。

  - **get(Object key)**: 根据指定键返回对应的值，如果键不存在则返回 `null`。
  - **containsKey(Object key)**: 检查映射是否包含指定的键，返回 `true` 或 `false`。
  - **containsValue(Object value)**: 检查映射是否包含指定的值，返回 `true` 或 `false`。

  - **remove(Object key)**: 移除指定键及其对应的值，返回被移除的值（如果存在），否则返回 `null`。

  - **firstKey()**: 返回映射中的第一个键（最小键）。
  - **lastKey()**: 返回映射中的最后一个键（最大键）。
  - **higher(K key)**: 返回严格大于指定键的下一个键。
  - **lower(K key)**: 返回严格小于指定键的上一个键。
  - **subMap(K fromKey, K toKey)**: 返回指定范围内的视图，包含从 `fromKey` 到 `toKey`（不包含 `toKey`）。
  - **headMap(K toKey)**: 返回小于 `toKey` 的所有键值对的视图。
  - **tailMap(K fromKey)**: 返回大于或等于 `fromKey` 的所有键值对的视图。

  - **size()**: 返回映射中键值对的数量。
  - **isEmpty()**: 检查映射是否为空，返回 `true` 如果映射为空。

  - **clear()**: 清空映射中的所有键值对。

  - **keySet()**: 返回映射中所有键的集合。
  - **values()**: 返回映射中所有值的集合。
  - **entrySet()**: 返回映射中所有键值对的集合（`Map.Entry` 对象）。

### 8. 链式哈希集合(LinkedHashSet)

```java
LinkedHashSet<Type> set = new LinkedHashSet<>();
```

其中，`Type` 是要存储的元素类型（如 `Integer`、`String` 等）

- **基于哈希表和双向链表：**保持元素的插入顺序。不允许重复元素。

- **常用方法：**

  - **add(E e)**: 向集合中添加一个元素，如果元素已存在则不进行添加。

  - **contains(Object o)**: 检查集合是否包含指定的元素，返回 `true` 或 `false`。

  - **remove(Object o)**: 从集合中移除指定元素，返回 `true` 如果元素存在且成功移除，返回 `false` 如果元素不存在。

  - **size()**: 返回集合中元素的数量。
  - **isEmpty()**: 检查集合是否为空，返回 `true` 如果集合为空。

  - **clear()**: 清空集合中的所有元素，使集合变为空。

  - **iterator()**: 返回集合的迭代器，用于按插入顺序遍历集合中的元素。

### 9. 图 (Graph)

- **节点加边的集合**：Java 标准库中没有内置的 `Graph` 类。如果需要使用图数据结构，通常需要自己实现一个图类，或者使用第三方库（如 JGraphT）来处理图的操作。自定义图类可以根据具体需求（如无向图、有向图、加权图等）进行实现和扩展。

- **图的简单实现示例：**

  ```java
  import java.util.*;
  
  class Graph<V> {
      private Map<V, List<V>> adjacencyList;
  
      public Graph() {
          adjacencyList = new HashMap<>();
      }
  
      // 添加顶点
      public void addVertex(V vertex) {
          adjacencyList.putIfAbsent(vertex, new LinkedList<>());
      }
  
      // 添加边
      public void addEdge(V vertex1, V vertex2) {
          addVertex(vertex1);
          addVertex(vertex2);
          adjacencyList.get(vertex1).add(vertex2);
          adjacencyList.get(vertex2).add(vertex1); // 无向图
      }
  
      // 获取所有顶点
      public Set<V> getVertices() {
          return adjacencyList.keySet();
      }
  
      // 获取所有边
      public List<String> getEdges() {
          List<String> edges = new ArrayList<>();
          for (V vertex : adjacencyList.keySet()) {
              for (V neighbor : adjacencyList.get(vertex)) {
                  edges.add(vertex + " - " + neighbor);
              }
          }
          return edges;
      }
  }
  
  // 使用示例
  public class Main {
      public static void main(String[] args) {
          Graph<String> graph = new Graph<>();
          graph.addVertex("A");
          graph.addVertex("B");
          graph.addEdge("A", "B");
          graph.addEdge("A", "C");
  
          System.out.println("Vertices: " + graph.getVertices());
          System.out.println("Edges: " + graph.getEdges());
      }
  }
  ```
