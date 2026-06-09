#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"

required_files=(
  "$ROOT/AGENTS.md"
  "$ROOT/README.md"
  "$ROOT/输入输出索引.md"
  "$ROOT/02_共享资产库/00_核心规则/老胡音乐核心规则手册.md"
  "$ROOT/02_共享资产库/05_工具流程/音乐创作阶段交接合约.md"
  "$ROOT/02_共享资产库/05_工具流程/音乐创作多角色协作流程.md"
  "$ROOT/02_共享资产库/05_工具流程/新音乐作品创建与归位流程.md"
  "$ROOT/02_共享资产库/05_工具流程/经验材料吸收与本地资产更新闭环.md"
  "$ROOT/02_共享资产库/03_质量评估与预测系统/老胡音乐质量评估与预测总协议.md"
  "$ROOT/02_共享资产库/03_质量评估与预测系统/音乐作品质量rubric.md"
  "$ROOT/02_共享资产库/03_质量评估与预测系统/音乐创作盲预测协议.md"
  "$ROOT/02_共享资产库/03_质量评估与预测系统/音乐候选池schema.md"
  "$ROOT/02_共享资产库/03_质量评估与预测系统/音乐复盘与规则进化协议.md"
  "$ROOT/02_共享资产库/03_质量评估与预测系统/规则进化备忘录.md"
  "$ROOT/02_共享资产库/02_音乐语言资产/题眼与副歌hook库/题眼与副歌核心句规则.md"
  "$ROOT/02_共享资产库/02_音乐语言资产/题眼与副歌hook库/灵感关键词到音乐创作维度映射规则.md"
  "$ROOT/02_共享资产库/02_音乐语言资产/曲式结构库/曲式结构与乐段功能规则.md"
  "$ROOT/02_共享资产库/02_音乐语言资产/风格流派映射库/风格流派与情绪题材映射初版.md"
  "$ROOT/02_共享资产库/02_音乐语言资产/韵脚与唱感库/韵脚与唱感安全规则.md"
  "$ROOT/02_共享资产库/02_音乐语言资产/演唱控制库/演唱控制与style_prompt规则.md"
  "$ROOT/skills/laohu_music/SKILL.md"
  "$ROOT/skills/laohu_music/scripts/create_music_project.sh"
  "$ROOT/skills/laohu_music_topic/SKILL.md"
  "$ROOT/skills/laohu_music_structure/SKILL.md"
  "$ROOT/skills/laohu_lyrics_writer/SKILL.md"
  "$ROOT/skills/laohu_lyrics_repair/SKILL.md"
  "$ROOT/skills/laohu_sing_control/SKILL.md"
  "$ROOT/skills/laohu_music_review/SKILL.md"
)

missing=0
for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "missing: $file"
    missing=1
  fi
done

required_dirs=(
  "$ROOT/00_输入原料"
  "$ROOT/01_作品项目/进行中"
  "$ROOT/01_作品项目/已完成"
  "$ROOT/01_作品项目/已发布"
  "$ROOT/02_共享资产库/02_音乐语言资产/题眼与副歌hook库"
  "$ROOT/02_共享资产库/02_音乐语言资产/曲式结构库"
  "$ROOT/02_共享资产库/02_音乐语言资产/风格流派映射库"
  "$ROOT/02_共享资产库/02_音乐语言资产/韵脚与唱感库"
  "$ROOT/02_共享资产库/02_音乐语言资产/演唱控制库"
  "$ROOT/02_共享资产库/03_质量评估与预测系统"
  "$ROOT/02_共享资产库/04_案例经验库/成功案例"
  "$ROOT/02_共享资产库/04_案例经验库/失败案例"
  "$ROOT/03_发布与课程化"
  "$ROOT/04_诊断与系统日志"
)

for dir in "${required_dirs[@]}"; do
  if [[ ! -d "$dir" ]]; then
    echo "missing dir: $dir"
    missing=1
  fi
done

if find "$ROOT" -name '.DS_Store' -print -quit | grep -q .; then
  echo "found .DS_Store files; please clean project directory"
  find "$ROOT" -name '.DS_Store' -print
  missing=1
fi

forbidden_ext="$(printf 'js%s' 'on')"
if find "$ROOT/02_共享资产库" -name "*.${forbidden_ext}" -type f -print -quit | grep -q .; then
  echo "found forbidden structured files in shared assets; creative rules should be Markdown only"
  find "$ROOT/02_共享资产库" -name "*.${forbidden_ext}" -type f | sort
  missing=1
fi

while IFS= read -r sing_file; do
  style_len="$(awk '
    /^## 最终 style prompt/ { in_section=1; next }
    in_section && /^```text/ { in_block=1; next }
    in_section && in_block && /^```/ { exit }
    in_section && in_block { printf "%s", $0 }
  ' "$sing_file" | wc -m | tr -d ' ')"
  if [[ "${style_len:-0}" -gt 900 ]]; then
    echo "style prompt too long (${style_len} chars): $sing_file"
    missing=1
  fi

  line_control_count="$(grep -c '^\[(' "$sing_file" || true)"
  if [[ "${line_control_count:-0}" -gt 9 ]]; then
    echo "too many line-level controls (${line_control_count}): $sing_file"
    missing=1
  fi
done < <(find "$ROOT/01_作品项目" -path '*/05_演唱控制/文本/*_最终style_prompt与演唱控制.md' -type f | sort)

tmp_name="__check_tmp_$$"
tmp_date="2099-01-01"
tmp_project_dir="$ROOT/01_作品项目/进行中/${tmp_date}_${tmp_name}"
trap 'rm -rf "$tmp_project_dir"' EXIT

if [[ -e "$tmp_project_dir" ]]; then
  echo "temporary check dir already exists: $tmp_project_dir"
  missing=1
else
  created_path="$("$ROOT/skills/laohu_music/scripts/create_music_project.sh" "$tmp_name" "$tmp_date")"
  if [[ "$created_path" != "$tmp_project_dir" ]]; then
    echo "create script returned unexpected path: $created_path"
    missing=1
  fi

  generated_paths=(
    "$tmp_project_dir/00_项目总览.md"
    "$tmp_project_dir/00_阶段确认记录.md"
    "$tmp_project_dir/09_归档复盘.md"
    "$tmp_project_dir/00_原始输入/文本"
    "$tmp_project_dir/01_选题题眼/文本"
    "$tmp_project_dir/02_曲式与风格/文本"
    "$tmp_project_dir/03_歌词/文本"
    "$tmp_project_dir/04_歌词优化/文本"
    "$tmp_project_dir/05_演唱控制/文本"
    "$tmp_project_dir/06_生成素材/音频"
    "$tmp_project_dir/07_发布包装/文本"
  )

  for generated in "${generated_paths[@]}"; do
    if [[ ! -e "$generated" ]]; then
      echo "create script missing generated path: $generated"
      missing=1
    fi
  done
fi

if [[ "$missing" -ne 0 ]]; then
  echo "老胡音乐项目检查失败"
  exit 1
fi

echo "老胡音乐项目检查通过"
