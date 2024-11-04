---
title: "回溯+深搜DFS+广搜BFS"
date: 2024-11-04T14:43:49+08:00
draft: false 
params: 
  author: Lynn
tags: ["数据结构", "算法","回溯","DFS","BFS"]
categories: ["技术博客"]
description: "介绍算法：回溯+深搜DFS+广搜BFS"
summary: "介绍算法：回溯+深搜DFS+广搜BFS"
image:  " "
typora-root-url: ./..\..\..\static

---

## 回溯

```java
public class PermutationGenerator {
    public List<List<Integer>> permute(int[] nums) {
        List<List<Integer>> list = new ArrayList<>();
        backtrack(list, new ArrayList<>(), nums);
        return list;
    }

    private void backtrack(List<List<Integer>> list, List<Integer> tempList, int[] nums) {
        // 终止条件
        if (tempList.size() == nums.length) {
            // 说明找到一组组合
            list.add(new ArrayList<>(tempList));
            return;
        }

        for (int i = 0; i < nums.length; i++) {
            // 因为不能有重复的，所以有重复的就不能选
            if (tempList.contains(nums[i])) {
                continue;
            }
            // 选择当前值
            tempList.add(nums[i]);
            // 递归
            backtrack(list, tempList, nums);
            // 撤销选择
            tempList.remove(tempList.size() - 1);
        }
    }
}
```

## 深度优先搜索

### 1.递归(回溯思想)

```java
public class GraphPathFinder {
    private List<List<Integer>> result = new ArrayList<>();
    private List<Integer> path = new ArrayList<>();
    
	public void dfs(图，目前搜索的节点) {
    	if (剪枝条件) return; // 剪枝

    	if (终止条件) {
        	result.add(new ArrayList<>(path)); // 存放结果
        	return;
    	}

    	for (选择：本层节点所连接的其他节点) {
        	处理节点;（做选择）
        	dfs(图，选择的节点); // 递归
        	path.remove(path.size() - 1); // 回溯（撤销选择）
    	}
	}
}
```
### 2.栈（见BFS模板，改为栈实现）



## 广度优先搜索

### 1.队列

```java
public class GraphTraversal {
    private static final int[][] dir = {
        {0, 1},   // 右
        {1, 0},   // 下
        {-1, 0},  // 上
        {0, -1}   // 左
    };

    public void bfs(char[][] grid, boolean[][] visited, int x, int y) {
        Queue<int[]> queue = new LinkedList<>(); // 定义队列
        queue.offer(new int[]{x, y}); // 起始节点加入队列
        visited[x][y] = true; // 立刻标记为访问过的节点

        while (!queue.isEmpty()) { // 开始遍历队列里的元素
            int[] cur = queue.poll(); // 从队列取元素
            int curx = cur[0];
            int cury = cur[1]; // 当前节点坐标

            for (int i = 0; i < 4; i++) { // 向四个方向遍历
                int nextx = curx + dir[i][0];
                int nexty = cury + dir[i][1]; // 获取周边四个方向的坐标

                // 检查坐标是否越界
                if (nextx < 0 || nextx >= grid.length || nexty < 0 || nexty >= grid[0].length) {
                    continue; // 坐标越界，跳过
                }

                if (!visited[nextx][nexty]) { // 如果节点没被访问过
                    queue.offer(new int[]{nextx, nexty}); // 添加该节点为下一轮要遍历的节点
                    visited[nextx][nexty] = true; // 标记为已访问
                }
            }
        }
    }
}
```

## 例子：岛屿数量

### **题目描述**

给定一个二维网格，其中 `1` 代表陆地，`0` 代表水，计算岛屿的数量。相邻的陆地（上下左右相连）算作同一个岛屿。

### **深度优先搜索 (DFS) 实现**

#### 方法 1：递归实现

```java
public class IslandCounter {
    public int numIslands(char[][] grid) {
        if (grid == null || grid.length == 0) return 0;
        int count = 0;
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                if (grid[i][j] == '1') {
                    dfs(grid, i, j); // 进行DFS
                    count++;
                }
            }
        }
        return count;
    }

    private void dfs(char[][] grid, int x, int y) {
        if (x < 0 || x >= grid.length || y < 0 || y >= grid[0].length || grid[x][y] == '0') {
            return; // 越界或水域，返回
        }
        grid[x][y] = '0'; // 标记为已访问
        // 递归访问上下左右
        dfs(grid, x + 1, y);
        dfs(grid, x - 1, y);
        dfs(grid, x, y + 1);
        dfs(grid, x, y - 1);
    }
}
```

#### 方法 2：栈实现

```java
import java.util.Stack;

public class IslandCounter {
    public int numIslands(char[][] grid) {
        if (grid == null || grid.length == 0) return 0;
        int count = 0;
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                if (grid[i][j] == '1') {
                    dfsStack(grid, i, j); // 进行栈实现的DFS
                    count++;
                }
            }
        }
        return count;
    }

    private void dfsStack(char[][] grid, int x, int y) {
        Stack<int[]> stack = new Stack<>();
        stack.push(new int[]{x, y});
        grid[x][y] = '0'; // 标记为已访问

        while (!stack.isEmpty()) {
            int[] cur = stack.pop();
            int curx = cur[0];
            int cury = cur[1];

            // 访问上下左右
            if (curx + 1 < grid.length && grid[curx + 1][cury] == '1') {
                stack.push(new int[]{curx + 1, cury});
                grid[curx + 1][cury] = '0'; // 标记为已访问
            }
            if (curx - 1 >= 0 && grid[curx - 1][cury] == '1') {
                stack.push(new int[]{curx - 1, cury});
                grid[curx - 1][cury] = '0'; // 标记为已访问
            }
            if (cury + 1 < grid[0].length && grid[curx][cury + 1] == '1') {
                stack.push(new int[]{curx, cury + 1});
                grid[curx][cury + 1] = '0'; // 标记为已访问
            }
            if (cury - 1 >= 0 && grid[curx][cury - 1] == '1') {
                stack.push(new int[]{curx, cury - 1});
                grid[curx][cury - 1] = '0'; // 标记为已访问
            }
        }
    }
}
```

### 广度优先搜索 (BFS) 实现

```java
import java.util.LinkedList;
import java.util.Queue;

public class IslandCounter {
    public int numIslands(char[][] grid) {
        if (grid == null || grid.length == 0) return 0;
        int count = 0;
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                if (grid[i][j] == '1') {
                    bfs(grid, i, j); // 进行BFS
                    count++;
                }
            }
        }
        return count;
    }

    private void bfs(char[][] grid, int x, int y) {
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{x, y});
        grid[x][y] = '0'; // 标记为已访问

        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}; // 四个方向

        while (!queue.isEmpty()) {
            int[] cur = queue.poll();
            for (int[] dir : directions) {
                int nextx = cur[0] + dir[0];
                int nexty = cur[1] + dir[1];

                // 检查边界和水域
                if (nextx >= 0 && nextx < grid.length && nexty >= 0 && nexty < grid[0].length && grid[nextx][nexty] == '1') {
                    queue.offer(new int[]{nextx, nexty}); // 加入队列
                    grid[nextx][nexty] = '0'; // 标记为已访问
                }
            }
        }
    }
}
```

### 总结

- **DFS 实现**：提供了递归和栈的两种实现方式，遍历并标记岛屿中的所有 `1`。
- **BFS 实现**：使用队列进行层次遍历，同样标记所有相连的 `1`。