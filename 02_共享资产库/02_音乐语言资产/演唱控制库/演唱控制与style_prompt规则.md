# 演唱控制与 Style Prompt 规则

本文件是老胡音乐关于最终音乐提示词、演唱控制、声音设计和平台投喂格式的专项规则库。

它比 `laohu_sing_control` skill 更细，负责补充 style prompt 颗粒度、段落级控制、关键行控制、人声距离、动态、和声、声场和格式校验。

演唱控制不是堆标签，而是把歌词里的传播资产声音化。

最终 style prompt 也不是曲风复述，而是一份可直接指导成曲的人声、编曲、声场和段落动态的制作 brief。

## 0. 执行前置判断

正式写 style prompt 和 controlled lyrics 前，必须先内部判断：

- 这首歌的音乐任务是什么：叙事型、倾诉型、释放型、宣言型、氛围型、驱动型，还是传播 hook 型。
- 作品发动机是什么：关系代价、情绪债务、人物尊严、叙事现场、传播 hook，还是代际转交。
- 歌名句、副歌核心句、评论区引用句、短视频切片句、现场合唱句、outro 回收句分别在哪里。
- 哪些句子需要贴耳、停顿、咬字、声场打开、和声回应、重复或最后一次变体。
- 哪些句子必须保持克制，不能被编曲和唱法过度放大。

先判断这些，再决定 groove、arrangement、vocal、space、dynamics 和 harmony。不能先套 generic 曲风模板。

## 1. 最终 Style Prompt 的目标

最终 style prompt 要让 AI 音乐平台知道：

- 这是什么细分风格。
- groove、BPM、拍号、鼓贝关系和节奏身体性是什么。
- 编曲主导乐器、辅助乐器、密度和减法位置是什么。
- 人声身份、音色、音区、距离、唱法、咬字、气口和动态是什么。
- Verse / Pre / Chorus / Bridge / Outro 的能量如何变化。
- 哪一句核心歌词需要被声音让位，用停顿、前景人声、重复、和声或声场打开中的哪一种方式放大。
- 和声 / backing vocal 何时进入，何时必须让开主唱。
- 声场和混响如何服务人物和情绪。

不要只写：

```text
emotional pop song, piano, warm, cinematic
```

这类提示词太 generic。

## 2. Style Prompt 推荐顺序

```text
细分音乐风格
→ groove / BPM
→ 风格内乐器
→ 编曲密度
→ 人声音色与身份
→ 人声距离与唱法
→ 段落动态
→ 声场空间
→ hook 放大策略
→ 需要避免的模板漂移风险
```

其中“需要避免”尽量在说明里写，最终 prompt 优先用正向限定，不靠一堆否定词控制。

### 硬门槛

- 必须具体到细分音乐风格、groove、乐器分工、人声画像、段落动态和空间质感。
- 必须能回答：听起来是谁在唱、站在多远、伴奏哪里让开、核心句哪里被听见。
- 最终人声版 prompt 不能只是纯音乐 prompt 加一句 `warm vocal`。
- 英文最终 prompt 推荐 650-900 字符，硬上限 900 字符；如果信息很多，优先保留风格、groove、乐器、人声、段落动态、hook 放大和空间。
- 必须明确防止 generic pop ballad、generic piano ballad、generic cinematic swell、宣传片式弦乐、晚会式合唱等模板漂移。

## 3. 纯音乐骨架升级为最终人声版本

如果前一步是纯音乐 style prompt，最终阶段不能推翻它。

必须保留：

- 律动。
- 空间。
- 段落能量。
- hook space。
- 主风格。
- 编曲取舍。

必须补齐：

- vocal identity。
- vocal timbre。
- range / register。
- delivery。
- phrasing。
- diction。
- breath。
- vocal dynamics。
- harmony / backing vocal strategy。
- chorus vocal lift。
- vocal distance / reverb space。

如果最终 prompt 没有人声音色、音区、距离、唱法或和声策略，判失败。

如果 controlled lyrics 另起一套曲式，判失败。

如果演唱控制阶段改写已确认歌词，判失败。

## 4. 段落级控制优先

先建立 section-level 控制，再做少量关键行控制。

常用段落控制：

```text
[Verse 1 | close vocal, restrained delivery, clear consonants]
[Pre-Chorus | tension rising, shorter breaths, slight lift]
[Chorus | vocal forward, wider space, hook phrase held clearly]
[Bridge | stripped arrangement, voice closer, emotional turn]
[Final Chorus | wider harmony only on hook phrase]
[Outro | lower energy, dry vocal tail, leave silence after last line]
```

段落标签规则：

- `[]` 是段落级控制，放在段落开头。
- 同一段的功能、编曲、动态、人声距离、气口要合并在同一个 `[]` 内。
- 不要在一个段落下面额外堆 `[Vocal preview]`、`[Micro phrasing]`、`[Dynamics]` 等独立控制块。

## 5. 关键行控制

line-level 控制只用于：

- hook。
- 转折句。
- 暴露句。
- 传播锚点句。
- 尾句。

不要每行都加控制。每个控制都必须有声学目的：

- 停顿。
- 弱起。
- 拖音。
- 重复。
- 咬字。
- 和声回应。
- 声场打开。
- 编曲让位。

格式：

```text
[(line-level control)]
被控制的歌词
```

整首歌通常 5-9 处关键行控制足够。副歌核心句、bridge 翻面句、final chorus 变体句和 outro 尾句优先。

## 6. 拖音和和声

拖音 `~`：

- 适合副歌实字。
- 适合开口韵、鼻音韵和可共鸣音。
- 不适合轻声助词承担高潮长音。

括号和声：

- 只在 hook、尾句、回答关系或空间扩张处使用。
- 不能遮挡核心传播句。
- 必须服务回应、扩张、记忆点或情绪回声。

## 7. 传播资产声音设计

每首歌至少识别一个传播资产：

- 歌名句。
- 副歌核心句。
- 评论区引用句。
- 短视频切片句。
- 现场合唱句。
- Outro 回收句。

不同资产的声音策略：

```text
短视频切片句：清晰起拍、核心句前留空、8-15 秒可截取。
评论区引用句：人声前景、咬字清楚、不过度和声遮挡。
现场合唱句：稳定韵带、可拖长元音、可重复。
耳机循环句：贴耳、呼吸、口腔细节、不过度爆发。
Outro 回收句：空间后退、尾音留白。
```

## 8. 国内传播与世界可听

国内传播不是口号，要落成声音控制：

- 短视频切片句前要有清晰入点、停顿或节拍留白，8-15 秒内能截取。
- 评论区引用句要人声前景、咬字清楚、不过度戏剧化。
- 现场合唱句要韵带稳定、句尾可落、重复时能抬起来。
- 耳机循环句要保留呼吸、口腔细节、尾音余味和动态层次。

世界可听也不是欧美化：

- 即使不懂中文，也能通过人声姿态、重复 hook、动态弧线、节奏和声场听出情绪关系。
- 不把中文语境洗成泛欧美情绪；保留近景人声、真实空间、节制编曲和本土材料质地。

## 9. 反 AI 声音控制

如果歌词的人味来自笨拙、迟疑、嘴硬、短气口和生活褶皱，声音不能做得过度 polished。

可以保留：

- 贴耳人声。
- 干声边缘。
- 轻微粗粝。
- 短气口。
- 迟疑。
- 克制 vibrato。

避免：

- generic cinematic swell。
- 宣传片式宏大弦乐。
- 过度混响。
- 所有气口都被抹平。
- 编曲淹没歌词。

## 10. Controlled Lyrics 格式

输出 controlled lyrics 时：

- 保留原歌词。
- 不擅自改词。
- 段落标签清楚。
- 段落控制合并进 section 标签。
- 行级控制贴在具体歌词行附近。
- 不混入大段解释。

如果老胡明确要求“只要投喂文件”，就输出最干净的投喂版。

## 11. 输出前自检

- 是否先判断音乐任务和作品发动机？
- style prompt 是否具体到细分风格、groove、乐器、人声和空间？
- 是否避免 generic 模板？
- 是否识别核心传播句？
- style prompt 和 controlled lyrics 是否同时为核心传播句让位？
- 是否补齐人声身份、音色、音区、距离、唱法、动态和和声策略？
- 段落控制是否先于行级控制？
- 行级控制是否只落在关键句？
- 是否保留已确认曲式和风格？
- 是否没有擅自改词？
- 是否没有晚会化、宣传片化、公益腔或过度 polished？
