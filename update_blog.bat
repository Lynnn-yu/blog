@echo off
cd /d %~dp0

echo add new blog...
git add .

echo commit...
git commit -m "新增博文"

echo push....
git push origin master

echo ok!
pause
