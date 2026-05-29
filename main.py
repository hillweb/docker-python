import pyautogui
import datetime
import time
import os

# ==================== 配置 ====================
# 保存截图的文件夹
SAVE_DIR = "screenshots"
# 延迟时间（秒），给页面加载或操作留时间
DELAY_BEFORE_SHOT = 2

# 创建保存目录
os.makedirs(SAVE_DIR, exist_ok=True)

def take_screenshot(filename=None, region=None):
    """
    截取屏幕并保存
    
    参数:
        filename: 自定义文件名（不含扩展名）
        region: 指定截取区域 (left, top, width, height)
    """
    print("正在准备截屏...")

    # 延迟等待
    time.sleep(DELAY_BEFORE_SHOT)

    # 截图
    if region:
        screenshot = pyautogui.screenshot(region=region)
        print(f"已截取指定区域: {region}")
    else:
        screenshot = pyautogui.screenshot()
        print("已截取全屏")

    # 生成文件名
    if not filename:
        timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = f"screenshot_{timestamp}"
    
    filepath = os.path.join(SAVE_DIR, f"{filename}.png")
    
    # 保存图片
    screenshot.save(filepath)
    print(f"✅ 截图保存成功！")
    print(f"   文件路径: {filepath}")
    
    return filepath


# ==================== 使用示例 ====================

if __name__ == "__main__":
    print("PyAutoGUI 截屏示例启动...\n")
    
    # 示例1：全屏截图
    take_screenshot("full_screen")
    
    # 示例2：带时间戳的默认截图
    # take_screenshot()
    
    # 示例3：截取指定区域（左上角x, y, 宽度, 高度）
    # take_screenshot("region_shot", region=(100, 100, 800, 600))
    
    print("\n所有截图已保存到 ./screenshots/ 目录")
