---
name: video-ltx2-creation
description: 根据简略的分镜故事版（简单的画面描述）生成符合LTX2.3规范的完整视频提示词。分析用户输入的画面描述，扩写成详细的视频生成提示词，包含镜头设定、场景描述、动作流程、角色定义、镜头运动和音频元素。输出markdown格式的详细提示词列表到workspace。当用户提供分镜描述、故事版、画面草稿，或要求生成视频提示词时使用此skill。
---

# LTX2.3 视频提示词生成器

## 概述

这个skill帮助你将简略的分镜故事版（简单的画面描述）扩写成符合LTX2.3规范的完整视频提示词。

**核心功能**：
- 分析简略的画面描述
- 理解用户的创作意图
- 扩写成详细的LTX2.3视频提示词
- 提供完整的分析过程
- 输出markdown格式的结果到workspace

## 工作流程

### 步骤1：理解用户输入

用户会提供：
- **简略的分镜描述**：可能是几句话的画面描述
- **故事版草稿**：简单的场景说明
- **创作意图**：想要表达的情感或效果

你需要：
1. 仔细阅读用户的描述
2. 识别关键元素（人物、场景、动作、情感）
3. 理解创作意图和风格偏好
4. 确定需要生成的分镜数量

### 步骤2：分析过程（必须展示）

在生成提示词之前，必须进行详细分析并展示给用户：

**分析内容包括**：

1. **场景识别**
   - 主要场景和环境
   - 室内/室外
   - 时间（白天/夜晚/黄昏等）
   - 氛围基调

2. **角色分析**
   - 主要角色及其特征
   - 年龄、外貌、服装
   - 情感状态
   - 角色关系

3. **动作流程**
   - 核心动作序列
   - 动作的起承转合
   - 时间顺序

4. **视觉风格**
   - 电影类型（cinematic, documentary, thriller等）
   - 光照风格
   - 色彩基调
   - 特殊效果

5. **镜头策略**
   - 推荐的镜头类型
   - 镜头运动方式
   - 景别选择（特写/中景/远景）

6. **音频设计**
   - 环境音效
   - 对话内容
   - 音乐风格

### 步骤3：生成LTX2.3提示词

根据分析结果，为每个分镜生成符合LTX2.3规范的提示词。

**必须遵循的LTX2.3规则**（详见references/LTX2.3 提示词书写规则技巧与懒人提示词.txt）：

#### 关键要素（按顺序）

1. **建立镜头（Establish the shot）**
   - 使用电影摄影术语
   - 指定镜头类型和风格

2. **设定场景（Set the scene）**
   - 光照条件
   - 色彩调色板
   - 表面纹理
   - 氛围元素

3. **描述动作（Describe the action）**
   - 使用现在时动词
   - 从开始到结束的自然流动

4. **定义角色（Define characters）**
   - 年龄、发型、服装
   - 通过肢体语言表达情感

5. **镜头运动（Camera movements）**
   - 明确何时移动、如何移动
   - 描述运动后的呈现

6. **音频描述（Audio）**
   - 环境音
   - 对话（用引号包裹）
   - 音乐

#### 写作规范

- **单段落流畅叙述**：所有内容写成一个连贯段落
- **现在时动词**：描述动作时使用现在时
- **4-8个描述性句子**：覆盖所有关键要素
- **清晰的镜头语言**：使用准确的摄影术语

#### 避免事项

❌ **不要使用**：
- 情感标签（"sad", "confused"）→ 改用视觉线索
- 文字和标志（LTX-2不生成可读文字）
- 复杂物理运动（杂耍、快速扭转）
- 过多角色和动作

✅ **应该使用**：
- 肢体语言和面部表情
- 清晰的单一动作序列
- 合理的光照设置
- 简洁明确的指令

### 步骤4：输出结果

将生成的提示词保存到workspace，格式如下：

```markdown
# [项目标题] - LTX2.3 视频提示词

生成日期：[YYYY-MM-DD]

## 原始输入

[用户提供的简略描述]

## 分析过程

### 场景识别
[分析内容]

### 角色分析
[分析内容]

### 动作流程
[分析内容]

### 视觉风格
[分析内容]

### 镜头策略
[分析内容]

### 音频设计
[分析内容]

## 生成的视频提示词

### 分镜 1
[完整的LTX2.3提示词，单段落]

### 分镜 2
[完整的LTX2.3提示词，单段落]

### 分镜 3
[完整的LTX2.3提示词，单段落]

[继续...]

## 使用说明

1. 将每个分镜提示词复制到LTX2.3生成器
2. 根据生成结果调整提示词
3. 迭代优化直到满意

## 优化建议

[针对这组提示词的具体优化建议]
```

**保存路径**：
```
workspace/projects/luna-music-creative-system/video-ltx2-creation/{标题}-{日期}.md
```

例如：
```
workspace/projects/luna-music-creative-system/video-ltx2-creation/咖啡馆场景-2024-03-28.md
```

## 参考资源

### LTX2.3 规则详解

完整的LTX2.3提示词书写规则请参考：
- **references/LTX2.3 提示词书写规则技巧与懒人提示词.txt**

这个文件包含：
- 详细的提示词结构说明
- 大量实际案例
- 最佳实践和避免事项
- 技术术语词汇表

**重要提示**：在生成提示词前，建议先阅读这个参考文件，确保生成的提示词符合LTX2.3的所有规范。

### 常用术语

#### 镜头类型
- Wide shot, medium shot, close-up, extreme close-up
- Over-the-shoulder, POV, establishing shot
- Handheld, static frame, tracking shot

#### 光照条件
- Natural sunlight, golden hour, dramatic shadows
- Soft ambient light, neon glow, flickering candles
- Backlighting, rim light, high-key/low-key lighting

#### 镜头运动
- Dolly in/out, pan left/right, tilt up/down
- Crane up/down, tracking, circling around
- Push in, pull back, handheld movement

#### 氛围元素
- Fog, mist, rain, dust, smoke, particles
- Shallow depth of field, bokeh, motion blur
- Film grain, lens flares

## 示例

### 输入示例

用户输入：
```
一个女孩在咖啡馆看书，阳光从窗户照进来，很温馨的感觉。
需要3个分镜。
```

### 输出示例

```markdown
# 咖啡馆阅读场景 - LTX2.3 视频提示词

生成日期：2024-03-28

## 原始输入

一个女孩在咖啡馆看书，阳光从窗户照进来，很温馨的感觉。
需要3个分镜。

## 分析过程

### 场景识别
- 场景：温馨的咖啡馆室内
- 时间：白天，有自然光
- 氛围：安静、舒适、专注

### 角色分析
- 主角：年轻女孩（20多岁）
- 动作：阅读
- 情感：平静、专注、享受

### 动作流程
1. 女孩坐在窗边阅读
2. 阳光照射营造氛围
3. 可能有翻页、喝咖啡等细节动作

### 视觉风格
- 风格：温馨、文艺、生活化
- 光照：自然光为主，温暖柔和
- 色调：暖色调，金色阳光

### 镜头策略
- 分镜1：中景，展现整体氛围
- 分镜2：特写，聚焦阅读细节
- 分镜3：侧面，展现光影效果

### 音频设计
- 环境音：咖啡馆的轻微背景音
- 可能的音效：翻书声、咖啡杯轻放的声音

## 生成的视频提示词

### 分镜 1：温馨全景
A warm, cinematic medium shot inside a cozy café. Soft afternoon sunlight streams through a large window on the left, casting gentle golden rays across wooden tables and creating a peaceful atmosphere. A young woman in her 20s with long brown hair, wearing a cream-colored sweater, sits by the window absorbed in reading a book. A steaming cup of coffee and a small plate with pastry sit on the table beside her. The camera is static, capturing the serene moment as dust particles float lazily in the sunbeams. Ambient café sounds—soft murmurs, gentle clinking of cups—fill the background. The color palette is warm with golden tones and soft shadows.

### 分镜 2：阅读特写
An intimate close-up shot focusing on the young woman's hands gently holding an open book, with the coffee cup partially visible at the edge of the frame. The camera is positioned at table level, capturing the texture of the book pages and the delicate grip of her fingers. Warm natural light from the nearby window illuminates the pages, creating soft highlights and shadows. The background is softly blurred, showing abstract shapes of the café interior in warm, golden bokeh. The sound of a page turning is crisp and clear, followed by the quiet settling of paper. The composition emphasizes the tactile, intimate nature of reading and the comfort of the moment.

### 分镜 3：侧面光影
A cinematic side profile shot of the young woman reading by the café window, captured from the right side at eye level. The camera is positioned perpendicular to her, showing her complete silhouette against the bright window on her left. Strong natural sunlight creates a beautiful side-lighting effect, highlighting the contours of her face, hair, and the book in her hands. Steam gently rises from the coffee cup on the table. The café interior is softly lit with warm ambient light, creating a contrast between the bright window and the cozy interior. The camera slowly pushes in slightly, drawing the viewer deeper into this peaceful moment. Soft ambient café music plays quietly in the background.

## 使用说明

1. 将每个分镜提示词复制到LTX2.3生成器
2. 根据生成结果调整提示词
3. 可以调整光照强度、角色细节等参数
4. 迭代优化直到满意

## 优化建议

1. **光照调整**：如果需要更强的戏剧性，可以增加"dramatic shadows"或"high contrast lighting"
2. **角色细节**：可以添加更具体的服装描述或面部表情
3. **镜头运动**：如果需要更动态的效果，可以添加"slow dolly in"或"gentle pan"
4. **音频丰富**：可以添加具体的对话或更详细的环境音描述
```

## 质量检查清单

生成提示词后，确保：

- [ ] 每个提示词都是单段落流畅叙述
- [ ] 使用了现在时动词描述动作
- [ ] 包含了所有6个关键要素
- [ ] 使用了准确的电影摄影术语
- [ ] 避免了情感标签，使用视觉线索
- [ ] 没有提及文字或标志
- [ ] 动作序列清晰且可实现
- [ ] 光照逻辑合理
- [ ] 音频描述清晰
- [ ] 提示词长度适中（4-8句话）

## 最佳实践

1. **先分析后生成**：不要直接生成，先展示完整的分析过程
2. **保持一致性**：所有分镜应该在同一个场景/故事中
3. **渐进式细节**：从整体到局部，从远景到特写
4. **考虑连贯性**：分镜之间应该有逻辑联系
5. **迭代优化**：鼓励用户根据生成结果调整提示词

## 常见问题

**Q: 用户只给了一句话的描述怎么办？**
A: 通过分析过程补充细节，但要向用户确认关键信息（如角色特征、情感基调等）

**Q: 如何处理复杂的多角色场景？**
A: 简化场景，或者分成多个分镜，每个分镜聚焦少数角色

**Q: 用户要求的风格不适合LTX2.3怎么办？**
A: 解释LTX2.3的限制，提供替代方案

**Q: 生成的提示词太长怎么办？**
A: 精简描述，保留核心要素，删除冗余细节

## 输出路径说明

所有生成的提示词文件保存在：
```
workspace/projects/luna-music-creative-system/video-ltx2-creation/
```

文件命名格式：
```
{标题}-{日期}.md
```

例如：
- `咖啡馆场景-2024-03-28.md`
- `街头追逐-2024-03-28.md`
- `日落海滩-2024-03-28.md`

**提示用户**：
```
✅ 视频提示词已保存到你的工作区：
workspace/projects/luna-music-creative-system/video-ltx2-creation/{标题}-{日期}.md
```
