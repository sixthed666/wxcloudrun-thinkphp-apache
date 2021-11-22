# 写在最前面：强烈建议先阅读官方教程[Dockerfile最佳实践]（https://docs.docker.com/develop/develop-images/dockerfile_best-practices/）
# 选择构建用基础镜像（选择原则：在包含所有用到的依赖前提下尽可能提及小）。如需更换，请到[dockerhub官方仓库](https://hub.docker.com/_/golang?tab=tags)自行选择后替换。
FROM php:7.3-apache-buster

# 安装pdo_mysql
RUN docker-php-ext-install pdo pdo_mysql

# 设定工作目录
WORKDIR /app

# 将当前目录下所有文件拷贝到/app
COPY . /app

# 替换apache配置文件
# 软连接rewrite.load,开启rewrite路径重写模式
# 修改runtime权限
RUN cp /app/conf/apache.conf /etc/apache2/sites-enabled/000-default.conf \
&& ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load \
&& chmod -R 777  /app/runtime

# 暴露端口
EXPOSE 80

# 执行启动命令
CMD ["apachectl", "-DFOREGROUND"]
