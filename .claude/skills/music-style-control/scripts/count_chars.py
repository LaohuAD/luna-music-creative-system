from __future__ import annotations

import argparse
from pathlib import Path
import sys


def normalize_newlines(text: str) -> str:
    return text.replace("\r\n", "\n").replace("\r", "\n")


def decode_marker(marker: str | None) -> str | None:
    if marker is None:
        return None
    if "\\" not in marker:
        return marker
    return marker.encode("utf-8").decode("unicode_escape")


def preset_markers(name: str | None) -> tuple[str | None, str | None]:
    if name is None:
        return None, None
    if name == "style-md":
        return "### 最终 style prompt\n", "\n\n### 可替换建议"
    raise ValueError(f"Unknown preset: {name}")


def load_text(args: argparse.Namespace) -> str:
    if args.text is not None:
        return args.text
    if args.file is not None:
        return Path(args.file).read_text(encoding="utf-8")
    return sys.stdin.read()


def slice_text(text: str, start_marker: str | None, end_marker: str | None) -> str:
    text = normalize_newlines(text)
    start_marker = decode_marker(start_marker)
    end_marker = decode_marker(end_marker)
    start = 0
    end = len(text)

    if start_marker is not None:
        start = text.index(start_marker) + len(start_marker)
    if end_marker is not None:
        end = text.index(end_marker, start)

    return text[start:end]


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Count characters with luna music style-control rules."
    )
    src = parser.add_mutually_exclusive_group()
    src.add_argument("--text", help="Text to count directly")
    src.add_argument("--file", help="Path to a UTF-8 text file to count")
    parser.add_argument("--preset", choices=["style-md"], help="Use a built-in extraction preset")
    parser.add_argument("--start-marker", help="Count text after this marker")
    parser.add_argument("--end-marker", help="Stop counting before this marker")
    args = parser.parse_args()

    raw = load_text(args)
    preset_start, preset_end = preset_markers(args.preset)
    start_marker = args.start_marker if args.start_marker is not None else preset_start
    end_marker = args.end_marker if args.end_marker is not None else preset_end
    sliced = slice_text(raw, start_marker, end_marker)
    count = len(sliced)

    print(f"characters={count}")
    print("rule=python-len-after-newline-normalization")
    print("notes=counts every visible char, space, punctuation, and newline")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
