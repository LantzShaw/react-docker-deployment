# React Docker Deployment

```bash
# 构建一个名为 react-docker-deployment 的镜像
# `-t`: tag的缩写，用来指定镜像名称和标签（镜像名称:标签），没有显示指定标签，默认会设置标签为latest
# `.`: 表示 Docker 的构建上下文

# 默认标签，不指定标签，默认会设置 react-docker-deployment:latest
$ docker build -t react-docker-deployment .

# 自定义标签，显示指定标签
$ docker build -t react-docker-deployment:v1.0.0 .

# 多个标签
# 使用多个 -t 选项可以为同一镜像添加多个标签
# 该镜像会同时拥有 latest 和 v1.0 两个标签
$ docker build -t react-docker-deployment:latest -t react-docker-deployment:v1.0 .

################################# 分割线 ###############################

# 在后台运行容器
# `-d`: 表示在后台运行容器
# `--name`: 指定容器名称为 react-app
# `-p`: 将本地主机 9000 端口映射到 容器主机 80 端口
# 最后的`react-docker-deployment`: 表示容器所依赖的镜像名
docker run -d --name react-app -p 9000:80 react-docker-deployment

# 也可以直接这么运行
docker run -p 5173:5173 react-docker-deployment
```

## docker 常用命令

### 基础

- **查看容器配置信息**

```bash
# 登录
docker login

# 查看 docker 版本
docker version or docker -v

# 查看容器配置信息，例如镜像配置信息
docker info
```

### 镜像

- **拉取/推送镜像**

```bash
# 拉取镜像
docker pull node:18-alpine

# 推送
docker push
```

- **查看容器**

```bash
# 查看所有镜像
docker images

# `-q`: quiet 的缩写，表示启用简洁模式，只返回 镜像的 ID - 通常会用于 `docker rmi $(docker images -q)` 删除所有镜像时
docker images -q

# 返回所有 nginx 镜像的 ID
docker images -q ngix
```

- **构建镜像**

```bash
# 基于 Dockerfile 构建镜像
docker build -t react-docker-deployment .

# 指定版本
docker build -t react-docker-deployment:v1.0.1 .
```

- **删除镜像**

```bash
# 删除 - 删除无容器依赖的镜像，如果有容器依赖此镜像，将无法删除，需要删除所有依赖此镜像的容器，方可删除该镜像
docker rmi 镜像名称或者镜像ID

# 强制删除
docker rmi -f  <IMAGE_ID or IMAGE_NAME>  (镜像名称或者镜像ID)


# 删除所有镜像，清理docker中的所有停止的镜像
docker rmi $(docker images -q)

# 强制删除所有镜像
docker rmi -f $(docker images -q)
```

### 容器

- **查看容器**

```bash
# 查看运行中的容器
docker ps

# 查看所有的容器，包括停止、运行、崩溃、退出的容器记录
docker ps -a

# 查看所有依赖此镜像的容器
docker ps -a --filter 'ancestor=镜像ID或者镜像名称'
```

- **运行容器**

```bash
# 运行容器
docker run -p 7000:7000 react-docker-deployment
# 后台运行容器
docker run -d --name 容器名称 -p 7000:7000 所依赖的镜像名称

# 重新启动已停止的容器
docker start <CONTAINER_ID或NAME> (容器ID或者容器名称)

# 重启容器
docker restart <CONTAINER_ID或NAME> (容器ID或者容器名称)

# 停止容器
docker stop <CONTAINER_ID或NAME> (容器ID或者容器名称)
# 也可以直接删除容器来停止容器
docker rm <CONTAINER_ID或NAME> (容器ID或者容器名称)

# 强制停止 - 如果容器没有正常停止，可以使用 docker kill 强制停止。
docker kill <CONTAINER_ID或NAME> (容器ID或者容器名称)
```

- **查看容器日志**

```bash
docker logs <CONTAINER_ID或NAME> (容器ID或者容器名称)
```

- **删除容器**

```bash
docker rm <CONTAINER_ID or NAME>  (容器ID或者容器名)
```

### TODO

- 目前还不清楚为什么配置了阿里云镜像，但是还是拉取不到指定镜像

### 相关链接

- [国内镜像](https://github.com/dongyubin/DockerHub)
- [配置阿里云镜像](https://blog.csdn.net/zhuzicc/article/details/117748705)
- [windows 下 docker desktop 一直接处于 stopped 状态的解决方案](https://blog.csdn.net/m0_57396886/article/details/141262407?spm=1001.2101.3001.6650.1&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EYuanLiJiHua%7ECtr-1-141262407-blog-139349687.235%5Ev43%5Epc_blog_bottom_relevance_base1&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EYuanLiJiHua%7ECtr-1-141262407-blog-139349687.235%5Ev43%5Epc_blog_bottom_relevance_base1&utm_relevant_index=2)
- [windows 切换镜像](https://blog.csdn.net/moluzhui/article/details/132287258)
