#!/bin/bash

# 使用 curl 获取 JSON 数据
data=$(curl -s "https://api-launcher-static.mihoyo.com/hkrpg_cn/mdk/launcher/api/resource?key=6KcVuOkbcqjJomjZ&launcher_id=33")

# 解析 JSON 数据并获取 'latest' 部分
latest=$(echo $data | jq '.data.game.latest')

# 将 'game' 部分写入 package.txt 文件
echo "# game\n" > package.txt
echo "\n## path\n $(echo $latest | jq -r '.path')" >> package.txt
echo "\n## md5\n $(echo $latest | jq -r '.md5')" >> package.txt
echo "\n# voice_packs\n" >> package.txt

# 遍历 'voice_packs' 数组
for i in $(echo $latest | jq -c '.voice_packs[]'); do
    echo "\n***\n## $(echo $i | jq -r '.language')" >> package.txt
    echo "\n### path\n$(echo $i | jq -r '.path')" >> package.txt
    echo "\n### md5 \n$(echo $i | jq -r '.md5')" >> package.txt
    echo "\n" >> package.txt
done

# 获取 'diffs' 部分的第一个元素
diffs=$(echo $data | jq '.data.game.diffs[0]')

# 将 'diff' 部分写入 package.txt 文件
echo "\n# diff\n" >> package.txt
echo "## game\n" >> package.txt
echo "\n### path\n $(echo $diffs | jq -r '.path')"  >> package.txt
echo "\n### md5\n $(echo $diffs | jq -r '.md5')" >> package.txt
echo "\n## voice_packs\n" >> package.txt

# 遍历 'diffs.voice_packs' 数组
for i in $(echo $diffs | jq -c '.voice_packs[]'); do
    echo "\n***\n### $(echo $i | jq -r '.language')" >> package.txt
    echo "\n#### path\n$(echo $i | jq -r '.path')" >> package.txt
    echo "\n#### md5 \n$(echo $i | jq -r '.md5')" >> package.txt
    echo "\n" >> package.txt
done
