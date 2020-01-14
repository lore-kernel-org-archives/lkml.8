Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF15C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C04E24658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgANVEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:04:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbgANVDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A705B24681;
        Tue, 14 Jan 2020 21:03:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLd-000D5K-J9; Tue, 14 Jan 2020 16:03:37 -0500
Message-Id: <20200114210337.472405913@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 12/26] Documentation: bootconfig: Add a doc for extended boot config
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a documentation for extended boot config under
admin-guide, since it is including the syntax of boot config.

Link: http://lkml.kernel.org/r/157867230658.17873.9309879174829924324.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst | 184 +++++++++++++++++++++++
 Documentation/admin-guide/index.rst      |   1 +
 MAINTAINERS                              |   1 +
 3 files changed, 186 insertions(+)
 create mode 100644 Documentation/admin-guide/bootconfig.rst

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
new file mode 100644
index 000000000000..f7475df2a718
--- /dev/null
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -0,0 +1,184 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+Boot Configuration
+==================
+
+:Author: Masami Hiramatsu <mhiramat@kernel.org>
+
+Overview
+========
+
+The boot configuration is expanding current kernel cmdline to support
+additional key-value data when boot the kernel in an efficient way.
+This allows adoministrators to pass a structured-Key config file.
+
+Config File Syntax
+==================
+
+The boot config syntax is a simple structured key-value. Each key consists
+of dot-connected-words, and key and value are connected by "=". The value
+has to be terminated by semi-colon (``;``) or newline (``\n``).
+For array value, array entries are separated by comma (``,``). ::
+
+KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
+
+Each key word must contain only alphabets, numbers, dash (``-``) or underscore
+(``_``). And each value only contains printable characters or spaces except
+for delimiters such as semi-colon (``;``), new-line (``\n``), comma (``,``),
+hash (``#``) and closing brace (``}``).
+
+If you want to use those delimiters in a value, you can use either double-
+quotes (``"VALUE"``) or single-quotes (``'VALUE'``) to quote it. Note that
+you can not escape these quotes.
+
+There can be a key which doesn't have value or has an empty value. Those keys
+are used for checking the key exists or not (like a boolean).
+
+Key-Value Syntax
+----------------
+
+The boot config file syntax allows user to merge partially same word keys
+by brace. For example::
+
+ foo.bar.baz = value1
+ foo.bar.qux.quux = value2
+
+These can be written also in::
+
+ foo.bar {
+    baz = value1
+    qux.quux = value2
+ }
+
+Or more shorter, written as following::
+
+ foo.bar { baz = value1; qux.quux = value2 }
+
+In both styles, same key words are automatically merged when parsing it
+at boot time. So you can append similar trees or key-values.
+
+Comments
+--------
+
+The config syntax accepts shell-script style comments. The comments start
+with hash ("#") until newline ("\n") will be ignored.
+
+::
+
+ # comment line
+ foo = value # value is set to foo.
+ bar = 1, # 1st element
+       2, # 2nd element
+       3  # 3rd element
+
+This is parsed as below::
+
+ foo = value
+ bar = 1, 2, 3
+
+Note that you can not put a comment between value and delimiter(``,`` or
+``;``). This means following config has a syntax error ::
+
+ key = 1 # comment
+       ,2
+
+
+/proc/bootconfig
+================
+
+/proc/bootconfig is a user-space interface of the boot config.
+Unlike /proc/cmdline, this file shows the key-value style list.
+Each key-value pair is shown in each line with following style::
+
+ KEY[.WORDS...] = "[VALUE]"[,"VALUE2"...]
+
+
+Boot Kernel With a Boot Config
+==============================
+
+Since the boot configuration file is loaded with initrd, it will be added
+to the end of the initrd (initramfs) image file. The Linux kernel decodes
+the last part of the initrd image in memory to get the boot configuration
+data.
+Because of this "piggyback" method, there is no need to change or
+update the boot loader and the kernel image itself.
+
+To do this operation, Linux kernel provides "bootconfig" command under
+tools/bootconfig, which allows admin to apply or delete the config file
+to/from initrd image. You can build it by follwoing command::
+
+ # make -C tools/bootconfig
+
+To add your boot config file to initrd image, run bootconfig as below
+(Old data is removed automatically if exists)::
+
+ # tools/bootconfig/bootconfig -a your-config /boot/initrd.img-X.Y.Z
+
+To remove the config from the image, you can use -d option as below::
+
+ # tools/bootconfig/bootconfig -d /boot/initrd.img-X.Y.Z
+
+
+C onfig File Limitation
+======================
+
+Currently the maximum config size size is 32KB and the total key-words (not
+key-value entries) must be under 1024 nodes.
+Note: this is not the number of entries but nodes, an entry must consume
+more than 2 nodes (a key-word and a value). So theoretically, it will be
+up to 512 key-value pairs. If keys contains 3 words in average, it can
+contain 256 key-value pairs. In most cases, the number of config items
+will be under 100 entries and smaller than 8KB, so it would be enough.
+If the node number exceeds 1024, parser returns an error even if the file
+size is smaller than 32KB.
+Anyway, since bootconfig command verifies it when appending a boot config
+to initrd image, user can notice it before boot.
+
+
+Bootconfig APIs
+===============
+
+User can query or loop on key-value pairs, also it is possible to find
+a root (prefix) key node and find key-values under that node.
+
+If you have a key string, you can query the value directly with the key
+using xbc_find_value(). If you want to know what keys exist in the SKC
+tree, you can use xbc_for_each_key_value() to iterate key-value pairs.
+Note that you need to use xbc_array_for_each_value() for accessing
+each arraies value, e.g.::
+
+ vnode = NULL;
+ xbc_find_value("key.word", &vnode);
+ if (vnode && xbc_node_is_array(vnode))
+    xbc_array_for_each_value(vnode, value) {
+      printk("%s ", value);
+    }
+
+If you want to focus on keys which has a prefix string, you can use
+xbc_find_node() to find a node which prefix key words, and iterate
+keys under the prefix node with xbc_node_for_each_key_value().
+
+But the most typical usage is to get the named value under prefix
+or get the named array under prefix as below::
+
+ root = xbc_find_node("key.prefix");
+ value = xbc_node_find_value(root, "option", &vnode);
+ ...
+ xbc_node_for_each_array_value(root, "array-option", value, anode) {
+    ...
+ }
+
+This accesses a value of "key.prefix.option" and an array of
+"key.prefix.array-option".
+
+Locking is not needed, since after initialized, the config becomes readonly.
+All data and keys must be copied if you need to modify it.
+
+
+Functions and structures
+========================
+
+.. kernel-doc:: include/linux/bootconfig.h
+.. kernel-doc:: lib/bootconfig.c
+
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 4405b7485312..9e0f1e3fd152 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -64,6 +64,7 @@ configure specific aspects of kernel behavior to your liking.
    binderfs
    binfmt-misc
    blockdev/index
+   bootconfig
    braille-console
    btmrvl
    cgroup-v1/index
diff --git a/MAINTAINERS b/MAINTAINERS
index 903e8a7ed0bf..47873f2e6696 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15777,6 +15777,7 @@ F:	lib/bootconfig.c
 F:	fs/proc/bootconfig.c
 F:	include/linux/bootconfig.h
 F:	tools/bootconfig/*
+F:	Documentation/admin-guide/bootconfig.rst
 
 SUN3/3X
 M:	Sam Creasey <sammy@sammy.net>
-- 
2.24.1


