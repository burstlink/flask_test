# 使用官方 Python 运行时作为基础镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 设置环境变量，避免 Python 缓存写入容器层
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 复制 requirements 文件并安装依赖（先装依赖可利用 Docker 层缓存）
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制应用代码
COPY . .

# 暴露端口（Flask 默认 5000）
EXPOSE 5000

# 启动命令：使用 Gunicorn 提升生产性能（可选，但推荐）
# 如果你不想引入 Gunicorn，也可以直接用 flask run（见下方注释）

# 安装 Gunicorn（推荐用于生产）
RUN pip install gunicorn

# 使用 Gunicorn 启动（更稳定、支持并发）
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]

# —— 或者，如果你坚持用 Flask 内置服务器（仅限开发/测试）——
# CMD ["flask", "--app", "app", "run", "--host=0.0.0.0", "--port=5000"]