@echo off
cd /d %~dp0

hugo 

echo add new blog...
git add .

echo commit...
git commit -m "update blog"

echo push....
git push origin master

echo ok!
pause
