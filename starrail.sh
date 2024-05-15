#!/bin/bash

# 使用 curl 获取 JSON 数据
data=$(curl -s "https://api-launcher-static.mihoyo.com/hkrpg_cn/mdk/launcher/api/resource?key=6KcVuOkbcqjJomjZ&launcher_id=33")

# 解析 JSON 数据并获取 'latest' 部分
latest=$(echo $data | jq '.data.game.latest')

# 将 'game' 部分写入 package.md 文件
echo "# game\n" > package.md
echo "\n## path\n $(echo $latest | jq -r '.path')" >> package.md
echo "\n## md5\n $(echo $latest | jq -r '.md5')" >> package.md
echo "\n# voice_packs\n" >> package.md

# 遍历 'voice_packs' 数组
for i in $(echo $latest | jq -c '.voice_packs[]'); do
    echo "\n***\n## $(echo $i | jq -r '.language')" >> package.md
    echo "\n### path\n$(echo $i | jq -r '.path')" >> package.md
    echo "\n### md5 \n$(echo $i | jq -r '.md5')" >> package.md
    echo "\n" >> package.md
done

# 获取 'diffs' 部分的第一个元素
diffs=$(echo $data | jq '.data.game.diffs[0]')

# 将 'diff' 部分写入 package.md 文件
echo "\n# diff\n" >> package.md
echo "## game\n" >> package.md
echo "\n### path\n $(echo $diffs | jq -r '.path')"  >> package.md
echo "\n### md5\n $(echo $diffs | jq -r '.md5')" >> package.md
echo "\n## voice_packs\n" >> package.md

# 遍历 'diffs.voice_packs' 数组
for i in $(echo $diffs | jq -c '.voice_packs[]'); do
    echo "\n***\n### $(echo $i | jq -r '.language')" >> package.md
    echo "\n#### path\n$(echo $i | jq -r '.path')" >> package.md
    echo "\n#### md5 \n$(echo $i | jq -r '.md5')" >> package.md
    echo "\n" >> package.md
done
