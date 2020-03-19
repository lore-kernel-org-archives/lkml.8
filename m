Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30634C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010A02076C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCSDVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:21:53 -0400
Received: from m177134.mail.qiye.163.com ([123.58.177.134]:47524 "EHLO
        m177134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSDVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 23:21:52 -0400
Received: from lcc-VirtualBox.vivo.xyz (unknown [58.251.74.227])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 35C64261B7F;
        Thu, 19 Mar 2020 11:21:04 +0800 (CST)
From:   Chucheng Luo <luochucheng@vivo.com>
To:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Chucheng Luo <luochucheng@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH v3] Translate Documentation/filesystems/debugfs.txt into Chinese
Date:   Thu, 19 Mar 2020 11:20:43 +0800
Message-Id: <20200319032057.29833-1-luochucheng@vivo.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZTVVDS0tCQkJNT0pPSkNPTVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBQ6HQw6MzgwMCtRUVFRLzFI
        DBgaC0pVSlVKTkNPTkNDS01PTEpJVTMWGhIXVRcOFBgTDhgTHhUcOw0SDRRVGBQWRVlXWRILWUFZ
        TkNVSU5KVUxPVUlJTFlXWQgBWUFKSEhDQzcG
X-HM-Tid: 0a70f0cf06ed9375kuws35c64261b7f
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate debugfs.txt into Chinese and link it to the index.

Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
Acked-by: Jonathan Corbet <corbet@lwn.net>
---
 .../zh_CN/filesystems/debugfs.rst             | 257 ++++++++++++++++++
 .../translations/zh_CN/filesystems/index.rst  |  21 ++
 Documentation/translations/zh_CN/index.rst    |   2 +
 3 files changed, 280 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/debugfs.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/index.rst

diff --git a/Documentation/translations/zh_CN/filesystems/debugfs.rst b/Documentation/translations/zh_CN/filesystems/debugfs.rst
new file mode 100644
index 000000000000..02f639445d3d
--- /dev/null
+++ b/Documentation/translations/zh_CN/filesystems/debugfs.rst
@@ -0,0 +1,257 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/filesystems/debugfs.txt<debugfs_index>`
+
+==========================
+Debugfs
+==========================
+
+译者
+::
+
+	中文版维护者： 罗楚成 Chucheng Luo <luochucheng@vivo.com>
+	中文版翻译者： 罗楚成 Chucheng Luo <luochucheng@vivo.com>
+	中文版校译者:  罗楚成 Chucheng Luo <luochucheng@vivo.com>
+
+
+
+
+版权所有2009 Jonathan Corbet <corbet@lwn.net>
+
+介绍
+====
+
+Debugfs是内核开发人员在用户空间获取信息的简单方法。
+与/proc不同，proc只提供进程信息。也不像sysfs,具有严格的“每个文件一个值“的规则。
+debugfs根本没有规则。开发人员可以放置他们想要的任何信息在那里。
+debugfs文件系统也不能用作稳定的
+ABI接口到用户空间；从理论上讲，文件在debugfs里导出没有任何稳定性的约束。
+尽管[1]现实世界并不总是那么简单。
+即使是debugfs接口，也最好根据需要进行设计
+永远保持下去。
+
+用法
+====
+
+Debugfs通常使用以下命令安装::
+
+    mount -t debugfs none /sys/kernel/debug
+
+（或等效的/etc/fstab行）。
+debugfs根目录默认仅可由root用户访问。
+要更改对树的访问，请使用“ uid”，“ gid”和“ mode”挂载选项。
+
+请注意，debugfs API仅导出为GPL到模块。
+
+使用debugfs的代码应包含<linux/debugfs.h>。然后，第一阶
+业务将是创建至少一个目录来保存一组debugfs文件::
+
+    struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
+
+如果成功，此调用将在指定的父目录目录下创建一个名为name的目录。
+如果parent为NULL，则目录为
+在debugfs根目录中创建。成功时，返回值是一个结构
+dentry指针，可用于在目录中创建文件（以及
+最后将其清理干净）。 ERR_PTR（-ERROR）返回值表面出错。如果返回ERR_PTR（-ENODEV），则为
+表明内核是在没有debugfs支持的情况下构建的，并且下述函数都不会起作用。
+
+在debugfs目录中创建文件的最通用方法是::
+
+    struct dentry *debugfs_create_file(const char *name, umode_t mode,
+				       struct dentry *parent, void *data,
+				       const struct file_operations *fops);
+
+在这里，name是要创建的文件的名称，mode描述了访问
+文件应具有的权限，parent指向应该保存文件的目录
+，data将存储在产生的inode结构的i_private字段中
+，而fops是一组文件操作，其中
+实现文件的行为。至少，read（）和/或write（）
+操作应提供；其他可以根据需要包括在内。再次，
+返回值将是指向创建文件的dentry指针，
+错误时显示ERR_PTR（-ERROR），不支持debugfs时返回值为ERR_PTR（-ENODEV）。
+
+创建一个初始大小的文件，可以使用以下函数代替::
+
+    struct dentry *debugfs_create_file_size(const char *name, umode_t mode,
+				struct dentry *parent, void *data,
+				const struct file_operations *fops,
+				loff_t file_size);
+
+file_size是初始文件大小。其他参数跟函数debugfs_create_file的相同。
+
+在许多情况下，创建一组文件操作不是
+实际必要的，对于简单的情况。debugfs代码提供了许多帮助函数
+。包含单个整数值的文件可以使用以下任何一项创建::
+
+    void debugfs_create_u8(const char *name, umode_t mode,
+			   struct dentry *parent, u8 *value);
+    void debugfs_create_u16(const char *name, umode_t mode,
+			    struct dentry *parent, u16 *value);
+    struct dentry *debugfs_create_u32(const char *name, umode_t mode,
+				      struct dentry *parent, u32 *value);
+    void debugfs_create_u64(const char *name, umode_t mode,
+			    struct dentry *parent, u64 *value);
+
+这些文件支持读取和写入给定值。如果具体
+不应写入文件，只需相应地设置模式位。的
+这些文件中的值以十进制表示；如果十六进制更合适，
+可以使用以下功能::
+
+    void debugfs_create_x8(const char *name, umode_t mode,
+			   struct dentry *parent, u8 *value);
+    void debugfs_create_x16(const char *name, umode_t mode,
+			    struct dentry *parent, u16 *value);
+    void debugfs_create_x32(const char *name, umode_t mode,
+			    struct dentry *parent, u32 *value);
+    void debugfs_create_x64(const char *name, umode_t mode,
+			    struct dentry *parent, u64 *value);
+
+只要开发人员知道导出值的大小，这些功能就很有用。
+某些类型在不同的架构上可以具有不同的宽度
+但是，这样会使情况变得有些复杂。有
+在以下特殊情况下可以提供帮助的功能::
+
+    void debugfs_create_size_t(const char *name, umode_t mode,
+			       struct dentry *parent, size_t *value);
+
+不出所料，此函数将创建一个debugfs文件来表示
+类型为size_t的变量。
+
+同样地，也有无符号长整型型变量的助手，以十进制表示
+和十六进制::
+
+    struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
+					struct dentry *parent,
+					unsigned long *value);
+    void debugfs_create_xul(const char *name, umode_t mode,
+			    struct dentry *parent, unsigned long *value);
+
+布尔值可以通过以下方式放置在debugfs中::
+
+    struct dentry *debugfs_create_bool(const char *name, umode_t mode,
+				       struct dentry *parent, bool *value);
+
+
+读取结果文件将产生Y（对于非零值）或
+N，后跟换行符。如果写入，它将接受大写或
+小写值或1或0。任何其他输入将被忽略。
+
+同样，可以使用以下命令将atomic_t值放置在debugfs中::
+
+    void debugfs_create_atomic_t(const char *name, umode_t mode,
+				 struct dentry *parent, atomic_t *value)
+
+读取此文件将获得atomic_t值，并写入该文件
+将设置atomic_t值。
+
+另一个选择是导出一个任意二进制数据块，
+这个结构和功能::
+
+    struct debugfs_blob_wrapper {
+	void *data;
+	unsigned long size;
+    };
+
+    struct dentry *debugfs_create_blob(const char *name, umode_t mode,
+				       struct dentry *parent,
+				       struct debugfs_blob_wrapper *blob);
+
+读取此文件将返回由指针指向debugfs_blob_wrapper结构
+的数据。一些驱动使用“blobs”作为一种简单的方法
+返回几行（静态）格式化文本输出。这个功能
+可用于导出二进制信息，但似乎没有
+在主线中执行此操作的任何代码。请注意，使用debugfs_create_blob（）命令创建的所有文件
+是只读的。
+
+如果您要转储一个寄存器块（发生的事情相当
+通常在开发过程中，即使很少有这样的代码到达主线。
+Debugfs提供两个功能：一个用于创建仅寄存器文件，另一个
+把一个寄存器块插入一个顺序文件中::
+
+    struct debugfs_reg32 {
+	char *name;
+	unsigned long offset;
+    };
+
+    struct debugfs_regset32 {
+	struct debugfs_reg32 *regs;
+	int nregs;
+	void __iomem *base;
+    };
+
+    struct dentry *debugfs_create_regset32(const char *name, umode_t mode,
+				     struct dentry *parent,
+				     struct debugfs_regset32 *regset);
+
+    void debugfs_print_regs32(struct seq_file *s, struct debugfs_reg32 *regs,
+			 int nregs, void __iomem *base, char *prefix);
+
+“base”参数可能为0，但您可能需要构建reg32数组
+使用__stringify，实际上有许多寄存器名称（宏）
+寄存器块的基址上的字节偏移量。
+
+如果要在debugfs中转储u32数组，可以使用以下命令创建文件::
+
+     void debugfs_create_u32_array(const char *name, umode_t mode,
+			struct dentry *parent,
+			u32 *array, u32 elements);
+
+“array”参数提供数据，而“elements”参数为
+数组中元素的数量。注意：建立数组后，
+大小无法更改。
+
+有一个帮助函数来创建与设备相关的seq_file::
+
+   struct dentry *debugfs_create_devm_seqfile(struct device *dev,
+				const char *name,
+				struct dentry *parent,
+				int (*read_fn)(struct seq_file *s,
+					void *data));
+
+“dev”参数是与此debugfs文件相关的设备，并且
+“read_fn”是一个函数指针，将被调用以打印
+seq_file内容。
+
+还有一些其他的面向目录的帮助器功能::
+
+    struct dentry *debugfs_rename(struct dentry *old_dir,
+		                  struct dentry *old_dentry,
+		                  struct dentry *new_dir,
+				  const char *new_name);
+
+    struct dentry *debugfs_create_symlink(const char *name,
+                                          struct dentry *parent,
+                                          const char *target);
+
+调用debugfs_rename()将为现有的debugfs文件提供一个新名称，
+可能在其他目录中。 new_name函数调用之前不能存在；
+返回值为old_dentry，其中包含更新的信息。
+可以使用debugfs_create_symlink（）创建符号链接。
+
+所有debugfs用户必须考虑的一件事是：
+没有自动清除在debugfs中创建的任何目录。如果一个
+在不显式删除debugfs条目的情况下卸载模块，结果
+将会有很多陈旧的指针，和没完没了的高度反社会行为。
+因此，所有debugfs用户-至少是那些可以作为模块构建的用户-必须
+准备删除在此创建的所有文件和目录。一份文件
+可以通过以下方式删除::
+
+    void debugfs_remove(struct dentry *dentry);
+
+dentry值可以为NULL或错误值，在这种情况下，不会有任何结果
+被删除。
+
+从前，debugfs用户需要记住该dentry
+他们创建的每个debugfs文件的指针，以便所有文件都可以
+清理。但是，我们现在生活在更加文明的时代，并且debugfs用户
+能调用::
+
+    void debugfs_remove_recursive(struct dentry *dentry);
+
+如果传递了此函数，则对应于
+顶层目录，该目录下的整个层次结构将会被删除。
+
+注意：
+[1] http://lwn.net/Articles/309298/
diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
new file mode 100644
index 000000000000..3a7f5233767d
--- /dev/null
+++ b/Documentation/translations/zh_CN/filesystems/index.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+Linux 内核中的文件系统
+===============================
+
+这个不完整的指南在某一天将会提供关于Linux 虚拟文件系统(VFS)层如何工作的
+完整信息。以及VFS以下的的文件系统。目前为止，我们提供了以下信息。
+
+
+
+
+文件系统
+===========
+
+关于文件系统实现的文档.
+
+.. toctree::
+   :maxdepth: 2
+
+   debugfs
diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index d3165535ec9e..770f886d081c 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -1,3 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0
 .. raw:: latex
 
 	\renewcommand\thesection*
@@ -14,6 +15,7 @@
    :maxdepth: 2
 
    process/index
+   filesystems/index
 
 目录和表格
 ----------
-- 
2.17.1

