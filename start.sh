#!/bin/bash

# 启动 Xvfb 虚拟显示（PyAutoGUI 需要）
Xvfb :99 -screen 0 1920x1080x24 -ac +extension GLX +render -noreset > /dev/null 2>&1 &
sleep 1

echo "Xvfb started on DISPLAY=:99"

# 执行你的 Python 脚本
exec python "$@"
