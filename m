Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F22AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 20:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D99F20787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 20:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390100AbgEYUWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 16:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389889AbgEYUWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 16:22:53 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5F8C061A0E;
        Mon, 25 May 2020 13:22:52 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 4742C453AC;
        Mon, 25 May 2020 20:22:47 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "GitAuthor: Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Kees Cook <keescook@chromium.org>,
        David Miller <davem@davemloft.net>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Replace HTTP links with HTTPS ones: Documentation/translations/zh_CN
Date:   Mon, 25 May 2020 22:21:19 +0200
Message-Id: <20200525202119.23948-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  For each line:
    If doesn't contain `\bxmlns\b`:
      For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
        If both the HTTP and HTTPS versions
        return 200 OK and serve the same content:
          Replace HTTP with HTTPS.
---
 .../translations/zh_CN/process/2.Process.rst   |  8 ++++----
 .../translations/zh_CN/process/4.Coding.rst    |  2 +-
 .../zh_CN/process/7.AdvancedTopics.rst         |  6 +++---
 .../zh_CN/process/8.Conclusion.rst             | 10 +++++-----
 .../zh_CN/process/coding-style.rst             |  2 +-
 .../translations/zh_CN/process/howto.rst       | 12 ++++++------
 .../zh_CN/process/submitting-drivers.rst       | 18 +++++++++---------
 .../zh_CN/process/submitting-patches.rst       |  4 ++--
 .../process/volatile-considered-harmful.rst    |  4 ++--
 9 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/2.Process.rst b/Documentation/translations/zh_CN/process/2.Process.rst
index ceb733bb0294..ebe2e0254b3e 100644
--- a/Documentation/translations/zh_CN/process/2.Process.rst
+++ b/Documentation/translations/zh_CN/process/2.Process.rst
@@ -212,7 +212,7 @@ Next 树
 
 当前-mm 补丁可在“mmotm”（-mm of the moment）目录中找到，地址：
 
-        http://www.ozlabs.org/~akpm/mmotm/
+        https://www.ozlabs.org/~akpm/mmotm/
 
 然而，使用mmotm树可能是一种令人沮丧的体验；它甚至可能无法编译。
 
@@ -220,7 +220,7 @@ Next 树
 linux-next 是下一个合并窗口关闭后主线的快照。linux-next树在Linux-kernel 和
 Linux-next 邮件列表中发布，可从以下位置下载：
 
-        http://www.kernel.org/pub/linux/kernel/next/
+        https://www.kernel.org/pub/linux/kernel/next/
 
 Linux-next 已经成为内核开发过程中不可或缺的一部分；在一个给定的合并窗口中合并
 的所有补丁都应该在合并窗口打开之前的一段时间内找到进入Linux-next 的方法。
@@ -260,7 +260,7 @@ staging驱动程序。因此，在成为一名合适的主线驱动的路上，s
 
 现在几乎所有的Linux发行版都打包了Git。主页位于：
 
-        http://git-scm.com/
+        https://git-scm.com/
 
 那个页面有指向文档和教程的指针。
 
@@ -272,7 +272,7 @@ Mercurial与Git共享许多特性，但它提供了一个界面，许多人觉
 
 另一个值得了解的工具是quilt:
 
-        http://savannah.nongnu.org/projects/quilt
+        https://savannah.nongnu.org/projects/quilt
 
 Quilt 是一个补丁管理系统，而不是源代码管理系统。它不会随着时间的推移跟踪历史；
 相反，它面向根据不断发展的代码库跟踪一组特定的更改。一些主要的子系统维护人员
diff --git a/Documentation/translations/zh_CN/process/4.Coding.rst b/Documentation/translations/zh_CN/process/4.Coding.rst
index b82b1dde3122..959a06ba025c 100644
--- a/Documentation/translations/zh_CN/process/4.Coding.rst
+++ b/Documentation/translations/zh_CN/process/4.Coding.rst
@@ -224,7 +224,7 @@ scripts/coccinelle目录下已经打包了相当多的内核“语义补丁”
 或Blackfin开发板，您仍然可以执行编译步骤。可以在以下位置找到一组用于x86系统的
 大型交叉编译器：
 
-        http://www.kernel.org/pub/tools/crosstool/
+        https://www.kernel.org/pub/tools/crosstool/
 
 花一些时间安装和使用这些编译器将有助于避免以后的尴尬。
 
diff --git a/Documentation/translations/zh_CN/process/7.AdvancedTopics.rst b/Documentation/translations/zh_CN/process/7.AdvancedTopics.rst
index 956815edbd18..2f0ef750746f 100644
--- a/Documentation/translations/zh_CN/process/7.AdvancedTopics.rst
+++ b/Documentation/translations/zh_CN/process/7.AdvancedTopics.rst
@@ -25,9 +25,9 @@
 将是Git如何特别适合内核开发过程。想要加快Git的开发人员可以在以下网站上找到
 更多信息：
 
-	http://git-scm.com/
+	https://git-scm.com/
 
-	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
+	https://www.kernel.org/pub/software/scm/git/docs/user-manual.html
 
 在尝试使用它使补丁可供其他人使用之前，第一要务是阅读上述站点，对Git的工作
 方式有一个扎实的了解。使用Git的开发人员应该能够获得主线存储库的副本，探索
@@ -42,7 +42,7 @@
 如果您有一个可以访问Internet的系统，那么使用git守护进程设置这样的服务器相
 对简单。否则，免费的公共托管网站（例如github）开始出现在网络上。成熟的开发
 人员可以在kernel.org上获得一个帐户，但这些帐户并不容易找到；有关更多信息，
-请参阅 http://kernel.org/faq/
+请参阅 https://kernel.org/faq/
 
 正常的Git工作流程涉及到许多分支的使用。每一条开发线都可以分为单独的“主题
 分支”，并独立维护。Git的分支机构很便宜，没有理由不免费使用它们。而且，在
diff --git a/Documentation/translations/zh_CN/process/8.Conclusion.rst b/Documentation/translations/zh_CN/process/8.Conclusion.rst
index 2bbd76161e10..90cec3de6106 100644
--- a/Documentation/translations/zh_CN/process/8.Conclusion.rst
+++ b/Documentation/translations/zh_CN/process/8.Conclusion.rst
@@ -17,16 +17,16 @@
 记录的；“make htmldocs”或“make pdfdocs”可用于以HTML或PDF格式生成这些文档（
 尽管某些发行版提供的tex版本会遇到内部限制，无法正确处理文档）。
 
-不同的网站在各个细节层次上讨论内核开发。您的作者想谦虚地建议用 http://lwn.net/
+不同的网站在各个细节层次上讨论内核开发。您的作者想谦虚地建议用 https://lwn.net/
 作为来源；有关许多特定内核主题的信息可以通过以下网址的lwn内核索引找到：
 
         http://lwn.net/kernel/index/
 
 除此之外，内核开发人员的一个宝贵资源是：
 
-        http://kernelnewbies.org/
+        https://kernelnewbies.org/
 
-当然，我们不应该忘记 http://kernel.org/ 这是内核发布信息的最终位置。
+当然，我们不应该忘记 https://kernel.org/ 这是内核发布信息的最终位置。
 
 关于内核开发有很多书：
 
@@ -42,9 +42,9 @@
 
 有关git的文档，请访问：
 
-        http://www.kernel.org/pub/software/scm/git/docs/
+        https://www.kernel.org/pub/software/scm/git/docs/
 
-        http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
+        https://www.kernel.org/pub/software/scm/git/docs/user-manual.html
 
 结论
 ====
diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/Documentation/translations/zh_CN/process/coding-style.rst
index eae10bc7f86f..406d43a02c02 100644
--- a/Documentation/translations/zh_CN/process/coding-style.rst
+++ b/Documentation/translations/zh_CN/process/coding-style.rst
@@ -946,7 +946,7 @@ Addison-Wesley, Inc., 1999.
 ISBN 0-201-61586-X.
 
 GNU 手册 - 遵循 K&R 标准和此文本 - cpp, gcc, gcc internals and indent,
-都可以从 http://www.gnu.org/manual/ 找到
+都可以从 https://www.gnu.org/manual/ 找到
 
 WG14 是 C 语言的国际标准化工作组，URL: http://www.open-std.org/JTC1/SC22/WG14/
 
diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index a8e6ab818983..ee3dee476d57 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -69,7 +69,7 @@ Linux内核源代码都是在GPL（通用公共许可证）的保护下发布的
 邮件组里的人并不是律师，不要期望他们的话有法律效力。
 
 对于GPL的常见问题和解答，请访问以下链接：
-	http://www.gnu.org/licenses/gpl-faq.html
+	https://www.gnu.org/licenses/gpl-faq.html
 
 
 文档
@@ -109,7 +109,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
     其他关于如何正确地生成补丁的优秀文档包括：
     "The Perfect Patch"
 
-        http://www.ozlabs.org/~akpm/stuff/tpp.txt
+        https://www.ozlabs.org/~akpm/stuff/tpp.txt
 
     "Linux kernel patch submission format"
 
@@ -163,7 +163,7 @@ ReST格式的文档会生成在 Documentation/output. 目录中。
 ------------------
 如果你对Linux内核开发一无所知，你应该访问“Linux内核新手”计划：
 
-	http://kernelnewbies.org
+	https://kernelnewbies.org
 
 它拥有一个可以问各种最基本的内核开发问题的邮件列表（在提问之前一定要记得
 查找已往的邮件，确认是否有人已经回答过相同的问题）。它还拥有一个可以获得
@@ -176,7 +176,7 @@ ReST格式的文档会生成在 Documentation/output. 目录中。
 如果你想加入内核开发社区并协助完成一些任务，却找不到从哪里开始，可以访问
 “Linux内核房管员”计划：
 
-	http://kernelnewbies.org/KernelJanitors
+	https://kernelnewbies.org/KernelJanitors
 
 这是极佳的起点。它提供一个相对简单的任务列表，列出内核代码中需要被重新
 整理或者改正的地方。通过和负责这个计划的开发者们一同工作，你会学到将补丁
@@ -212,7 +212,7 @@ ReST格式的文档会生成在 Documentation/output. 目录中。
   - 每当一个新版本的内核被发布，为期两周的集成窗口将被打开。在这段时间里
     维护者可以向Linus提交大段的修改，通常这些修改已经被放到-mm内核中几个
     星期了。提交大量修改的首选方式是使用git工具（内核的代码版本管理工具
-    ，更多的信息可以在 http://git-scm.com/ 获取），不过使用普通补丁也是
+    ，更多的信息可以在 https://git-scm.com/ 获取），不过使用普通补丁也是
     可以的。
   - 两个星期以后-rc1版本内核发布。之后只有不包含可能影响整个内核稳定性的
     新功能的补丁才可能被接受。请注意一个全新的驱动程序（或者文件系统）有
@@ -472,7 +472,7 @@ Linux内核社区并不喜欢一下接收大段的代码。修改需要被恰当
 
 想了解它具体应该看起来像什么，请查阅以下文档中的“ChangeLog”章节：
   “The Perfect Patch”
-  	 http://www.ozlabs.org/~akpm/stuff/tpp.txt
+  	 https://www.ozlabs.org/~akpm/stuff/tpp.txt
 
 
 这些事情有时候做起来很难。要在任何方面都做到完美可能需要好几年时间。这是
diff --git a/Documentation/translations/zh_CN/process/submitting-drivers.rst b/Documentation/translations/zh_CN/process/submitting-drivers.rst
index d99885c27aed..98341e7cd812 100644
--- a/Documentation/translations/zh_CN/process/submitting-drivers.rst
+++ b/Documentation/translations/zh_CN/process/submitting-drivers.rst
@@ -19,8 +19,8 @@
 =============================
 
 这篇文档将会解释如何向不同的内核源码树提交设备驱动程序。请注意，如果你感
-兴趣的是显卡驱动程序，你也许应该访问 XFree86 项目(http://www.xfree86.org/)
-和／或 X.org 项目 (http://x.org)。
+兴趣的是显卡驱动程序，你也许应该访问 XFree86 项目(https://www.xfree86.org/)
+和／或 X.org 项目 (https://x.org)。
 
 另请参阅 Documentation/translations/zh_CN/process/submitting-patches.rst 文档。
 
@@ -29,7 +29,7 @@
 ----------
 
 块设备和字符设备的主设备号与从设备号是由 Linux 命名编号分配权威 LANANA（
-现在是 Torben Mathiasen）负责分配。申请的网址是 http://www.lanana.org/。
+现在是 Torben Mathiasen）负责分配。申请的网址是 https://www.lanana.org/。
 即使不准备提交到主流内核的设备驱动也需要在这里分配设备号。有关详细信息，
 请参阅 Documentation/admin-guide/devices.rst。
 
@@ -133,22 +133,22 @@ Linux 内核邮件列表：
 	[可通过向majordomo@vger.kernel.org发邮件来订阅]
 
 Linux 设备驱动程序，第三版（探讨 2.6.10 版内核）：
-	http://lwn.net/Kernel/LDD3/ （免费版）
+	https://lwn.net/Kernel/LDD3/ （免费版）
 
 LWN.net:
-	每周内核开发活动摘要 - http://lwn.net/
+	每周内核开发活动摘要 - https://lwn.net/
 
 	2.6 版中 API 的变更：
 
-		http://lwn.net/Articles/2.6-kernel-api/
+		https://lwn.net/Articles/2.6-kernel-api/
 
 	将旧版内核的驱动程序移植到 2.6 版：
 
-		http://lwn.net/Articles/driver-porting/
+		https://lwn.net/Articles/driver-porting/
 
 内核新手(KernelNewbies):
 	为新的内核开发者提供文档和帮助
-	http://kernelnewbies.org/
+	https://kernelnewbies.org/
 
 Linux USB项目：
 	http://www.linux-usb.org/
@@ -157,4 +157,4 @@ Linux USB项目：
 	http://www.fenrus.org/how-to-not-write-a-device-driver-paper.pdf
 
 内核清洁工 (Kernel Janitor):
-	http://kernelnewbies.org/KernelJanitors
+	https://kernelnewbies.org/KernelJanitors
diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
index 1bb4271ab420..2e7dbaad4028 100644
--- a/Documentation/translations/zh_CN/process/submitting-patches.rst
+++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
@@ -91,7 +91,7 @@
 :ref:`cn_split_changes`
 
 如果你用 ``git`` , ``git rebase -i`` 可以帮助你这一点。如果你不用 ``git``,
-``quilt`` <http://savannah.nongnu.org/projects/quilt> 另外一个流行的选择。
+``quilt`` <https://savannah.nongnu.org/projects/quilt> 另外一个流行的选择。
 
 .. _cn_describe_changes:
 
@@ -649,7 +649,7 @@ pull 请求还应该包含一条整体消息，说明请求中将包含什么，
 --------
 
 Andrew Morton, "The perfect patch" (tpp).
-  <http://www.ozlabs.org/~akpm/stuff/tpp.txt>
+  <https://www.ozlabs.org/~akpm/stuff/tpp.txt>
 
 Jeff Garzik, "Linux kernel patch submission format".
   <https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html>
diff --git a/Documentation/translations/zh_CN/process/volatile-considered-harmful.rst b/Documentation/translations/zh_CN/process/volatile-considered-harmful.rst
index 48b32ce58ef1..ded3b5d0c9a8 100644
--- a/Documentation/translations/zh_CN/process/volatile-considered-harmful.rst
+++ b/Documentation/translations/zh_CN/process/volatile-considered-harmful.rst
@@ -94,8 +94,8 @@ bug并且需要对这样的代码额外仔细检查。那些试图使用volatile
 注释
 ----
 
-[1] http://lwn.net/Articles/233481/
-[2] http://lwn.net/Articles/233482/
+[1] https://lwn.net/Articles/233481/
+[2] https://lwn.net/Articles/233482/
 
 致谢
 ----
-- 
2.26.2

