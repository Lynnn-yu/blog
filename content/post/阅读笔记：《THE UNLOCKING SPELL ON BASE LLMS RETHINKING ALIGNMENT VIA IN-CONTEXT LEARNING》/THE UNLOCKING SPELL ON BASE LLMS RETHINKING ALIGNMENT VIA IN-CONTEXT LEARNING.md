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



## 做了哪些事情？

1.对齐调整究竟如何改变基础 LLM？我们通过检查基础 LLM 与其对齐对应物（例如 Llama-2 和 Llama2-chat）之间的标记分布偏移来分析对齐调整的效果=>对齐调整主要学习采用 AI 助手的语言风格，而回答用户查询所需的知识主要来自基础 LLM 本身。=>验证“表面对齐假说”

2.URIAL (Untuned LLMs with Restyled In-context ALignment)

3.为了严格评估不同的对齐方法，我们设计了一个多方面、可解释的评估协议。

## 对齐调整(常用SFT+RLHF)究竟如何改变基础 LLM？

### Motivation

**“表面对齐假设”**(《LIMA: Less Is More for Alignment》：仅使用 1K 个 SFT 示例也可以实现显着的对齐性能，这表明对齐调整的效果可能是“表面的”)，该假设认为对齐调整可能只是教会基础 LLM 选择一组数据格式来与用户交互。

**<u>=>Question：对齐调整(常用SFT+RLHF)究竟如何改变基础 LLM？</u>**

### Method

检查基础 LLM 和其对齐LLM之间的**token distribution shift**来分析对齐调整的效果。

用户的输入为$q = \{q_1, q_2, \dots\}$ ，对齐后模型的输出为 $o = \{o_1, o_2, \dots\}$。  $P_{\text{align}}$ 表示在该位置的每一个 token 的概率分布。  在位置 $t$的 token 上下文表示为 $x_t = q + \{o_1, \dots, o_{t-1}\}$。 然后将$x_t$ 代入 Base LLM 中，生成一个概率分布 $P_{\text{base}}$。

=>如果基础模型学会通过对齐调整来修改其在此上下文中的行为，我们应该观察到 $P_{\text{base}} $和$P_{\text{align}}$之间的分布在此位置发生变化。另一方面，如果这两个分布彼此非常相似，则意味着对齐调整对此位置的影响微乎其微。

### Analysis

![image-20241014191835066](/image-20241014191835066.png)

- 知识密集型内容源自未调整的 LLM。


推广：

![image-20241014193408511](/image-20241014193408511.png)

- 对齐仅影响很小一部分 token，主要涉及风格 token，例如话语标记、过渡词和安全免责声明，这些 token 仅占总 token 位置的很小一部分。


![image-20241014194007734](/image-20241014194007734.png)

- 对齐对于较早的 token 更为关键。


- base LLM 已经获得了足够的知识来遵循指令。当给出适当的上下文作为前缀时，它们的结果与对齐的 LLM 非常相似。


=>对齐调整主要学习采用 AI 助手的语言风格，而回答用户查询所需的知识主要来自基础 LLM 本身。

## URIAL  (Untuned LLMs with Restyled In-context ALignment)

### Motivation

对齐调整(SFT+RLHF)：1.需要大量资源 2.可能会导致忘记基础 LLM 中先前获得的知识

Q:能在不进行调整的情况下实现对齐吗？

Q:提示和上下文学习方法能多好地对齐基础 LLM？

基线无调整对齐方法：零样本模板提示、原始上下文学习 (Few-shot) 、检索增强型 ICL。<img src="/image-20241014210043982.png" alt="image-20241014210043982" style="zoom:33%;" />

### Method

URIAL 可以看作是原始ICL的扩展，分为两个部分：ICL 示例的风格输出和上下文对齐的系统提示。

![image-20241014202530297](/image-20241014202530297.png)

简单地说如图所示，作者就是在设计了系统提示，并选择了几组问答示例。这些示例作为上下文提示，被用来指导和改善基础LLMs生成的回答，使其在风格上更符合人类用户的偏好，并且在内容上更加安全、有帮助和具有社会责任感。这些ICL旨在不需要对LLM进行额外的调整训练的前提下，通过精心设计的静态上下文示例来实现改善输出的目的。

## Experiment

### just-eval-instruct 数据集

为了评估 LLM 在多样化示例集上的对齐情况，我们合并了五个现有数据集：（1）AlpacaEval2，（2）MT-Bench，（3）LIMA，（4）HH-RLHF-redteam和（5）MaliciousInstruct。

![image-20241014210240828](/image-20241014210240828.png)

### Analysis

人工评估：

<img src="/image-20241014210415705.png" alt="image-20241014210415705" style="zoom: 67%;" />

GPT评估：

GPT-4                                                                                         GPT-3.5

<img src="/image-20241014210529046.png" alt="image-20241014210529046" style="zoom:50%;" /><img src="/image-20241014210543573.png" alt="image-20241014210543573" style="zoom: 40%;" />

<img src="/image-20241014210847693.png" alt="image-20241014210847693" style="zoom:67%;" />

- URIAL 的表现优于无需调整对齐的基线方法。

- 当基础 LLM 很强时，URIAL 甚至比 SFT 和 RLHF 表现更好。

- 对齐的 LLM 可能会忘记知识并变得过于敏感。如图B.1、B.2

<img src="/image-20241015161735736.png" alt="image-20241015161735736" style="zoom: 50%;" /><img src="/image-20241015161829145.png" alt="image-20241015161829145" style="zoom:75%;" />

Q：URIAL 对上下文示例的选择敏感吗？

使用 Mistral-7b 对 URIAL 进行了三个不同示例的测试。我们发现整体性能甚至比默认版本（4.63 vs. 4.64）还要好一点。这表明 URIAL 对所提供的 ICL 示例的变化具有鲁棒性。

Q：URIAL 能处理多轮对话吗？

只需将之前的聊天记录作为新的上下文示例附加到 URIAL 中，即可促进多轮聊天。我们在附录 B.3 中提供了一个使用 URIAL 进行多轮对话的案例研究。这表明对齐 LLM 的对话能力可能主要来自基础模型本身。

<img src="/image-20241015161911467.png" alt="image-20241015161911467" style="zoom:60%;" />

## 总结

-  URIAL 是一种无需调整即可对齐基础 LLM 的强大基线方法。它极其易于实现且完全可重现，从而有助于开发和评估未来无需调整和基于调整的对齐方法。
-  URIAL 可以用最小的努力对齐极大的 LM（例如 Llama-2-70b、Falcon-180b）。 对这种极大的模型进行微调需要大量的计算资源和时间；URIAL 无需调整即可对齐它们，从而节省了两者。
-  URIAL 可用于在预训练过程中频繁评估基础 LLM。它使我们能够在基础 LLM 的预训练阶段监控基础 LLM 的质量。 
-  URIAL 能够根据不同基础 LLM 的对齐潜力对其进行公平比较。 对齐的 LLM 之间的比较不能直接反映其基础对应物的质量，因为调整过程可能有很大差异（例如，数据、超参数等）。
-  URIAL 可用于探索 LLM 对齐的科学性。它表明我们应该重新考虑当前的对齐实践并提倡更有效的方法。URIAL 使我们能够探测基础 LLM——分析基础 LLM 在预训练期间已经获得的知识和技能，以确定对齐缺少什么，而不是盲目地使用大量数据进行微调并产生不必要的计算成本。