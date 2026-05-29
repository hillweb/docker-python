FROM python:3.11-slim-bookworm

# ==================== 系统依赖安装 ====================
RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    chromium-driver \
    xvfb \
    x11-utils \
    libx11-6 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libwayland-client0 \
    libxshmfence1 \
    fonts-liberation \
    fonts-noto-cjk \
    fonts-wqy-zenhei \
    && rm -rf /var/lib/apt/lists/*

# ==================== Python 依赖 ====================
WORKDIR /app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

# ==================== 环境变量 ====================
ENV PYTHONUNBUFFERED=1 \
    # Chromium 路径（系统安装的）
    PYPPEETEER_EXECUTABLE_PATH=/usr/bin/chromium \
    # PyAutoGUI 需要虚拟显示
    DISPLAY=:99 \
    # 禁用沙箱（Docker 环境下常用）
    CHROME_BIN=/usr/bin/chromium \
    CHROMIUM_FLAGS="--no-sandbox --disable-setuid-sandbox --disable-dev-shm-usage"

# ==================== 启动脚本 ====================
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
