# 使用 Node.js 官方的轻量级镜像作为基础镜像
FROM node:18-alpine

# 设置工作目录 - 指的是镜像内的工作目录，而非 Dockerfile 所在的目录
WORKDIR /app

# 复制 package.json 和 pnpm-lock.yaml（如果有）
COPY package.json pnpm-lock.yaml ./

# 设置 npm 镜像源
RUN npm config set registry https://registry.npmmirror.com

# 安装 pnpm
RUN npm i -g pnpm

# 使用 pnpm 安装依赖
RUN pnpm i

# 复制项目的其余文件到镜像内
# 注意: 可以通过设置 .dockerignore 来忽略不需要拷贝的文件，与 .gitignore 类似
COPY . .

# 暴露应用程序运行的端口
# 前端项目可能默认只绑定到 localhost。需要确保它绑定到 0.0.0.0 才能让 Docker 外部访问。
# 绑定主机地址到 0.0.0.0 有以下几种方式:
# - vite 中可以设置 `server.host` 为 `0.0.0.0`
# - 在 `package.json` 中, 设置 scripts 设置 "start": "HOST=0.0.0.0 PORT=3000 react-scripts start"
# - 分别执行以下命令:
#   $ docker exec -it my-react-container bash
#   $ export HOST=0.0.0.0
#   $ export PORT=3000
#   $ npm start
#
# NOTE: 检查容器内部服务
# step1: 进入容器内部，确保服务在容器内正常启动
# $ docker exec -it my-react-container bash
# step2: 在容器内使用 curl 测试
# $ curl http://localhost:5173

EXPOSE 5173

# 启动应用程序
# 注意: 这里是需要逗号分隔开
CMD [ "pnpm", "dev" ]

# TODO: 开发模式下
# 在开发模式下，您可能还需要共享您的本地源代码到 Docker 容器中，通常通过使用 Docker 的卷映射功能。
# CMD ["pnpm", "dev", "--watch"]