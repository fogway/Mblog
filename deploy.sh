#!/bin/bash

echo "🚀 开始部署 Vue 电子商城项目..."

# 检查 Node.js 是否安装
if ! command -v node &> /dev/null; then
    echo "❌ Node.js 未安装，请先安装 Node.js"
    exit 1
fi

# 检查 npm 是否安装
if ! command -v npm &> /dev/null; then
    echo "❌ npm 未安装，请先安装 npm"
    exit 1
fi

echo "✅ Node.js 和 npm 已安装"

# 安装依赖
echo "📦 安装项目依赖..."
npm install

if [ $? -ne 0 ]; then
    echo "❌ 依赖安装失败"
    exit 1
fi

echo "✅ 依赖安装完成"

# 构建项目
echo "🔨 构建生产版本..."
npm run build

if [ $? -ne 0 ]; then
    echo "❌ 项目构建失败"
    exit 1
fi

echo "✅ 项目构建完成"

# 检查构建结果
if [ -d "dist" ]; then
    echo "✅ 构建文件已生成在 dist/ 目录"
    echo "📊 构建统计:"
    du -sh dist/
    echo "📁 构建文件列表:"
    ls -la dist/
else
    echo "❌ 构建文件未找到"
    exit 1
fi

echo ""
echo "🎉 部署准备完成！"
echo ""
echo "🌐 部署选项："
echo "1. 将 dist/ 目录内容上传到 Web 服务器"
echo "2. 使用 serve 命令本地预览：npx serve dist"
echo "3. 部署到 Netlify、Vercel 等平台"
echo ""
echo "📖 更多信息请查看 README-ECOMMERCE.md"