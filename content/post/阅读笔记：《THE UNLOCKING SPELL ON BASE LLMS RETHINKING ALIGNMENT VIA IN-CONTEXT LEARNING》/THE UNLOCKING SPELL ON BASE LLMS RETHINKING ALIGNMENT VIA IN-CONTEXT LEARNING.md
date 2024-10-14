---
title: "阅读笔记：《THE UNLOCKING SPELL ON BASE LLMS RETHINKING ALIGNMENT VIA IN-CONTEXT LEARNING》"
date: 2024-10-12T20:13:28+08:00
draft: false 
params: 
  author: Lynn
tags: ["LLM", "大模型对齐","ICLR 2024"]
categories: ["阅读笔记"]
description: "ICLR 2024 | 大模型对齐 | URIAL： Untuned LLMs with Restyled In-context ALignment（未调优LLM与重新风格化的上下文对齐）"
summary: "ICLR 2024 | 大模型对齐 | URIAL：Untuned LLMs with Restyled In-context ALignment（未调优LLM与重新风格化的上下文对齐）"
image:  "/v2-98655f9c2f3260a467bec871b16a9cff_r.jpg"
typora-root-url: ./..\..\..\static
---



做了哪些事情？

1.对齐调整究竟如何改变基础 LLM？我们通过检查基础 LLM 与其对齐对应物（例如 Llama-2 和 Llama2-chat）之间的标记分布偏移来分析对齐调整的效果=>对齐调整主要学习采用 AI 助手的语言风格，而回答用户查询所需的知识主要来自基础 LLM 本身。=>验证“表面对齐假说”

2.URIAL (Untuned LLMs with Restyled In-context ALignment)

3.为了严格评估不同的对齐方法，我们设计了一个多方面、可解释的评估协议。

1.对齐调整(常用SFT+RLHF)究竟如何改变基础 LLM？

“表面对齐假设”(《LIMA: Less Is More for Alignment》：仅使用 1K 个 SFT 示例也可以实现显着的对齐性能，这表明对齐调整的效果可能是“表面的”)，该假设认为对齐调整可能只是教会基础 LLM 选择一组数据格式来与用户交互。

=>问题：对齐调整(常用SFT+RLHF)究竟如何改变基础 LLM？

Method：检查基础 LLM 和其对齐LLM之间的**token distribution shift**来分析对齐调整的效果。

用户的输入为 \(q = \{q_1, q_2, \dots\}\)，对齐后模型的输出为 \(o = \{o_1, o_2, \dots\}\)。  
\(P_{\text{align}}\) 表示在该位置的每一个 token 的概率分布。  

在位置 \(t\) 的 token 上下文表示为 \(x_t = q + \{o_1, \dots, o_{t-1}\}\)。  
然后将 \(x_t\) 代入 Base LLM 中，生成一个概率分布 \(P_{\text{base}}\)。

=>如果基础模型学会通过对齐调整来修改其在此上下文中的行为，我们应该观察到  \( P_{\text{base}} \)和( P_{\text{align}} \) 之间的分布在此位置发生变化。另一方面，如果这两个分布彼此非常相似，则意味着对齐调整对此位置的影响微乎其微。

Analysis：

![image-20241014191835066](/image-20241014191835066.png)

知识密集型内容源自未调整的 LLM。

推广：

![image-20241014193408511](/image-20241014193408511.png)

对齐仅影响很小一部分 token，主要涉及风格 token，例如话语标记、过渡词和安全免责声明，这些 token 仅占总 token 位置的很小一部分。

![image-20241014194007734](/image-20241014194007734.png)

 对齐对于较早的 token 更为关键。

 base LLM 已经获得了足够的知识来遵循指令。当给出适当的上下文作为前缀时，它们的结果与对齐的 LLM 非常相似。

=>对齐调整主要学习采用 AI 助手的语言风格，而回答用户查询所需的知识主要来自基础 LLM 本身。

2.URIAL 

第 2 节中的分析促使我们重新思考对齐调整（SFT 和/或 RLHF）的必要性，因为对齐调整仅影响基础 LLM 的很小一部分。我们能在不进行调整的情况下实现对齐吗？提示和上下文学习方法能多好地对齐基础 LLM？为了研究这些研究问题，我们首先介绍基线无调整对齐方法，然后介绍 URIAL，这是一种强大而简单的无调整对齐基线。



URIAL 可以看作是 vanilla ICL 的扩展，分为两个部分：ICL 示例的风格输出和上下文对齐的系统提示。

研究目的

模型内容

数据集

实验结果