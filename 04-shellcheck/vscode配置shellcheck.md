## 1 vscode安装shellcheck

1. 升级 powershell 

检查powershell版本，3.0以下的，需要升级：微软网站上找到并安装NetFramwork 4.0以上版本，Windows Management Framework 3.0以上版本（现在已经5了）Management Framework里面是带着powershell的。

```powershell
PS C:\WINDOWS\system32> $PSVersionTable
Name                           Value
----                           -----
PSVersion                      5.1.18362.752
```

2. 安装scoop

```powershell
powershell中修改执行策略执行：set-ExecutionPolicy RemoteSigned -scope CurrentUser
再执行命令：
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')  进行下载安装
```

3. 安装shellcheck

```powershell
PS C:\WINDOWS\system32> scoop install shellcheck
Scoop uses Git to update itself. Run 'scoop install git' and try again.
Installing 'shellcheck' (0.7.1) [64bit]
Loading shellcheck-v0.7.1.zip from cache
Checking hash of shellcheck-v0.7.1.zip ... ok.
Extracting shellcheck-v0.7.1.zip ... done.
Running pre-install script...
Linking ~\scoop\apps\shellcheck\current => ~\scoop\apps\shellcheck\0.7.1
Creating shim for 'shellcheck'.
'shellcheck' (0.7.1) was installed successfully!
```

4. 安装vscode的shellcheck插件

打开vscode，快捷键ctrl+shift+P打开命令面板，输入[`Install Extension`](https://code.visualstudio.com/docs/editor/extension-gallery#_install-an-extension) 定位到extensions：Install Extensions，并点击在出现的左边面板搜索框输入shellcheck，找到插件，点击安装

5.  安装完成后，写shell代码的时候就会出现提示了。 

## 2 安装过程问题解决

1. 安装过程环境变量问题

* 问题：vscode提示 cannot shellcheck the shell script

```
Cannot shellcheck the shell script. The shellcheck program was not found. Use the 'shellcheck.executablePath' setting to configure the location of 'shellcheck' ...
```

* 解决方法：设置环境变量

```powershell
scoop install xxx,
1. 安装位置: Linking ~\scoop\apps\shellcheck\current => ~\scoop\apps\shellcheck\0.7.1
   C:\Users\Administrator\scoop\apps\shellcheck\0.7.1
2. 设置环境变量重启生效
```

## 3 新知识

1. Powershell

* Windows PowerShell 是一种命令行外壳程序和脚本环境，使命令行用户和脚本编写者可以利用 .NET Framework的强大功能。相当于linux的shell，它引入了许多非常有用的新概念，从而进一步扩展了您在 Windows 命令提示符

* 在线教程 [Powershell在线教程]( https://www.pstips.net/powershell-online-tutorials )

2. scoop： Scoop is a command-line installer for Windows. 它试图消除

*  https://github.com/lukesampson/scoop 

*  Permission popup windows （允许弹出窗口）、 GUI wizard-style(向导) installers 、 Path pollution from installing lots of programs （安装太多程序导致路径污染）、 Unexpected side-effects（意外副作用） from installing and uninstalling programs 、 The need to find and install dependencies 、 T The need to perform extra setup steps to get a working program 

* 在windows下我们安装软件的一般流程是，找到官网，下载安装包，一步一步进行安装。Linux下我们安装软件的一般流程是，apt-get 或yum，除非找不到想安装的软件或者想装特定的版本之类情况，才会想到去下载二进制文件或者源码编译安装。

* windows下似乎没有这么一个简单省事而且能统一管理的方式。UWP应用倒可以统一管理了，但是支持的应用太少，且限制比较大。之前了解过chocolatey,但是一直没有试试，最近了解到scoop，决定先试试这个。