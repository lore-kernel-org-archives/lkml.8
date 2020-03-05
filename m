Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C84C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF43021556
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583390671;
	bh=esHS9I3X4ZdyO/NcBsx/jrRQ2B+LFzjP/5OgDvbH9Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ThEBUIKSV9eEjPhE13/toXwwg7YgYROZVrPiawjUrttCnRdrmHJecDRXaiD/UJIFP
	 GQrPWi+Qj5L30pd43QQQFE+mr0ioOpMpZY1XSyjgrMR+F4TAoRk+bkjyrfNMBWZFS3
	 Kbx5yEqb5WSJTP49JdpDH+vx4tgTIMVxf/4/4Clw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCEGo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:44:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgCEGo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:44:27 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1DEA2146E;
        Thu,  5 Mar 2020 06:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583390665;
        bh=esHS9I3X4ZdyO/NcBsx/jrRQ2B+LFzjP/5OgDvbH9Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gIcLqr+bSCpRbBAYpoJ6F/5ntLyYBs8vt9lPBTH6kFyFiIIZGZVH/wmKaJM6vatVL
         a0cbWcSBe2cIMr+TFUvu8fj6ivG19RqltGBiy9eOsBq7Zy21d7p2rdTcxwS6UaBn7o
         bcUq1TOXs/XeqD5x1ykeYqYnSXcngKhpFPRCxyHI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v5] Documentation: bootconfig: Update boot configuration documentation
Date:   Thu,  5 Mar 2020 15:44:21 +0900
Message-Id: <158339066140.26602.7533299987467005089.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158339065180.26602.26457588086834858.stgit@devnote2>
References: <158339065180.26602.26457588086834858.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update boot configuration documentation.

 - Not using "config" abbreviation but configuration or description.
 - Rewrite descriptions of node and its maxinum number.
 - Add a section of use cases of boot configuration.
 - Move how to use bootconfig to earlier section.
 - Fix some typos, indents and format mistakes.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
Changes in v5:
 - Elaborate the document.
 - Fix some typos.
Changes in v4:
 - Remove O= option from examples.
Changes in v3:
 - Specify that comments also count in size.
 - Fix a confusing sentence.
 - Add O=<builddir> to make command.
Changes in v2:
 - Fixes additional typos (Thanks Markus and Randy!)
 - Change a section title to "Tree Structured Key".
---
 Documentation/admin-guide/bootconfig.rst |  201 +++++++++++++++++++-----------
 Documentation/trace/boottime-trace.rst   |    2 
 2 files changed, 131 insertions(+), 72 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index cf2edcd09183..3bfc9ddf68e1 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -11,25 +11,106 @@ Boot Configuration
 Overview
 ========
 
-The boot configuration expands the current kernel command line to support
-additional key-value data when booting the kernel in an efficient way.
-This allows administrators to pass a structured-Key config file.
+Boot configuration expands the current kernel command line to support
+additional key-value data while booting the kernel in an efficient way.
+This allows administrators to pass a structured key configuration file
+as a way to supplement the kernel command line to pass system boot parameters.
 
-Config File Syntax
-==================
+Compared with the kernel command line, the boot configuration can provide
+scalability (up to 32 KiB configuration data including comments), readability
+(structured configuration with comments) and compact expression of option
+groups.
+
+When to Use the Boot Configuration?
+-----------------------------------
+
+The boot configuration supports kernel command line options and init daemon
+boot options. All sub-keys under "kernel" root key are passed as a part of
+the kernel command line [1]_, and ones under "init" root key are passed as
+a part of the init daemon's command line. For example, ::
+
+   root=UUID=8cd79b08-bda0-4b9d-954c-5d5f34b98c82 ro quiet splash console=ttyS0,115200n8 console=tty0
+
+This can be written as following boot configuration file.::
+
+   kernel {
+      root = "UUID=8cd79b08-bda0-4b9d-954c-5d5f34b98c82" # nvme0n1p3
+      ro       # mount rootfs as read only
+      quiet    # No console log
+      splash   # show splash image on boot screen
+      console = "ttyS0,115200n8" # 1st console to serial device
+      console += tty0            # add 2nd console
+   }
+
+If you think that kernel/init options becomes too long to write in boot-loader
+configuration file or you want to comment on each option, the boot
+configuration may be suitable. If unsure, you can still continue to use the
+legacy kernel command line.
 
-The boot config syntax is a simple structured key-value. Each key consists
-of dot-connected-words, and key and value are connected by ``=``. The value
-has to be terminated by semi-colon (``;``) or newline (``\n``).
-For array value, array entries are separated by comma (``,``). ::
+Also, some features may depend on the boot configuration, and each such
+feature has its own root key. For example, ftrace boot-time tracer uses
+"ftrace" root key to describe its options [2]_. If you want to use such
+features, you need to enable the boot configuration.
 
-KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
+.. [1] See :ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
+.. [2] See :ref:`Documentation/trace/boottime-trace.rst <boottimetrace>`
+
+
+How to Use the Boot Configuration?
+----------------------------------
+
+To enable the boot configuration support on your kernel, it must be built with
+``CONFIG_BOOT_CONFIG=y`` and ``CONFIG_BLK_DEV_INITRD=y``.
+
+Next, you can write a boot configuration file and attach it to initrd image.
+
+The boot configuration file is attached to the end of the initrd (initramfs)
+image file with size, checksum and 12-byte magic word as below.
+
+[initrd][bootconfig][size(u32)][checksum(u32)][#BOOTCONFIG\n]
+
+The Linux kernel decodes the last part of the initrd image in memory to
+get the boot configuration data.
+Because of this "piggyback" method, there is no need to change or
+update the boot loader or the kernel image itself.
+
+To do this operation, Linux kernel provides the "bootconfig" command under
+tools/bootconfig, which allows admin to apply or delete the configuration
+file to/from an initrd image. You can build it by the following command::
+
+ # make -C tools/bootconfig
+
+To add your boot configuration file to an initrd image, run bootconfig as
+below (Old bootconfig is removed automatically if it exists)::
+
+ # tools/bootconfig/bootconfig -a your-config /boot/initrd.img-X.Y.Z
+
+To remove the configuration from the image, you can use the ``-d`` option
+as below::
+
+ # tools/bootconfig/bootconfig -d /boot/initrd.img-X.Y.Z
+
+At last, add ``bootconfig`` on the normal kernel command line to tell the
+kernel to look for the bootconfig at the end of the initrd file. For example::
+
+  GRUB_CMDLINE_LINUX="bootconfig"
+
+
+Boot Configuration Syntax
+=========================
+
+The boot configuration syntax is a simple structured key-value. Each key
+consists of dot-connected-words, and key and value are connected by ``=``.
+The value has to be terminated by semicolon (``;``) or newline (``\n``).
+For an array, its entries are separated by comma (``,``). ::
+
+  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
 
 Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
 
 Each key word must contain only alphabets, numbers, dash (``-``) or underscore
 (``_``). And each value only contains printable characters or spaces except
-for delimiters such as semi-colon (``;``), new-line (``\n``), comma (``,``),
+for delimiters such as semicolon (``;``), new-line (``\n``), comma (``,``),
 hash (``#``) and closing brace (``}``).
 
 If you want to use those delimiters in a value, you can use either double-
@@ -39,25 +120,29 @@ you can not escape these quotes.
 There can be a key which doesn't have value or has an empty value. Those keys
 are used for checking if the key exists or not (like a boolean).
 
-Key-Value Syntax
-----------------
+Tree Structured Key
+-------------------
 
-The boot config file syntax allows user to merge partially same word keys
-by brace. For example::
+The user can group identical parent keys together and use braces to list child
+keys under them. For example::
 
  foo.bar.baz = value1
  foo.bar.qux.quux = value2
+ foo.bar.qux.quuz = value3
 
 These can be written also in::
 
  foo.bar {
-    baz = value1
-    qux.quux = value2
+   baz = value1
+   qux {
+      quux = value2
+      quuz = value3
+   }
  }
 
 Or more shorter, written as following::
 
- foo.bar { baz = value1; qux.quux = value2 }
+ foo.bar { baz = value1; qux { quux = value2; quuz = value3 } }
 
 In both styles, same key words are automatically merged when parsing it
 at boot time. So you can append similar trees or key-values.
@@ -80,19 +165,18 @@ you can use ``+=`` operator. For example::
 In this case, the key ``foo`` has ``bar``, ``baz`` and ``qux``.
 
 However, a sub-key and a value can not co-exist under a parent key.
-For example, following config is NOT allowed.::
+For example, the following configuration is NOT allowed.::
 
  foo = value1
- foo.bar = value2 # !ERROR! subkey "bar" and value "value1" can NOT co-exist
+ foo.bar = value2 # !ERROR! sub-key "bar" and value "value1" can NOT co-exist
 
 
 Comments
 --------
 
-The config syntax accepts shell-script style comments. The comments starting
-with hash ("#") until newline ("\n") will be ignored.
-
-::
+The boot configuration accepts shell-script style comments. The comments,
+beginning with hash (``#``) continues until newline (``\n``), will be
+skipped.::
 
  # comment line
  foo = value # value is set to foo.
@@ -100,74 +184,47 @@ with hash ("#") until newline ("\n") will be ignored.
        2, # 2nd element
        3  # 3rd element
 
-This is parsed as below::
+This is parsed as below.::
 
  foo = value
  bar = 1, 2, 3
 
 Note that you can not put a comment between value and delimiter(``,`` or
-``;``). This means following config has a syntax error ::
+``;``). This means the following description has a syntax error. ::
 
- key = 1 # comment
+ key = 1 # !ERROR! comment is not allowed before delimiter
        ,2
 
 
 /proc/bootconfig
 ================
 
-/proc/bootconfig is a user-space interface of the boot config.
+The file /proc/bootconfig is a user-space interface to the configuration
+of system boot parameters.
 Unlike /proc/cmdline, this file shows the key-value style list.
 Each key-value pair is shown in each line with following style::
 
  KEY[.WORDS...] = "[VALUE]"[,"VALUE2"...]
 
 
-Boot Kernel With a Boot Config
-==============================
-
-Since the boot configuration file is loaded with initrd, it will be added
-to the end of the initrd (initramfs) image file with size, checksum and
-12-byte magic word as below.
-
-[initrd][bootconfig][size(u32)][checksum(u32)][#BOOTCONFIG\n]
-
-The Linux kernel decodes the last part of the initrd image in memory to
-get the boot configuration data.
-Because of this "piggyback" method, there is no need to change or
-update the boot loader and the kernel image itself.
-
-To do this operation, Linux kernel provides "bootconfig" command under
-tools/bootconfig, which allows admin to apply or delete the config file
-to/from initrd image. You can build it by the following command::
-
- # make -C tools/bootconfig
-
-To add your boot config file to initrd image, run bootconfig as below
-(Old data is removed automatically if exists)::
-
- # tools/bootconfig/bootconfig -a your-config /boot/initrd.img-X.Y.Z
-
-To remove the config from the image, you can use -d option as below::
-
- # tools/bootconfig/bootconfig -d /boot/initrd.img-X.Y.Z
-
-Then add "bootconfig" on the normal kernel command line to tell the
-kernel to look for the bootconfig at the end of the initrd file.
-
 Config File Limitation
 ======================
 
-Currently the maximum config size size is 32KB and the total key-words (not
-key-value entries) must be under 1024 nodes.
-Note: this is not the number of entries but nodes, an entry must consume
-more than 2 nodes (a key-word and a value). So theoretically, it will be
-up to 512 key-value pairs. If keys contains 3 words in average, it can
-contain 256 key-value pairs. In most cases, the number of config items
-will be under 100 entries and smaller than 8KB, so it would be enough.
-If the node number exceeds 1024, parser returns an error even if the file
-size is smaller than 32KB.
-Anyway, since bootconfig command verifies it when appending a boot config
-to initrd image, user can notice it before boot.
+Currently the maximum configuration file size (including comments) is 32 KiB
+and the total number of key-words and values must be under 1024 nodes.
+(Note: Each key consists of words separated by dot, and value also consists
+of values separated by comma. Here, each word and each value is generally
+called a "node".)
+
+Theoretically, it will be up to 512 key-value pairs. If keys contain 3
+words in average, it can contain 256 key-value pairs. In most cases,
+the number of configuration items will be under 100 entries and smaller
+than 8 KiB, so it would be enough.
+If the node number exceeds 1024, the parser returns an error even if the
+file size is smaller than 32 KiB.
+Anyway, since the bootconfig command verifies it when appending a boot
+configuration to an initrd image, the user needs to fix any errors
+before boot.
 
 
 Bootconfig APIs
@@ -206,7 +263,7 @@ or get the named array under prefix as below::
 This accesses a value of "key.prefix.option" and an array of
 "key.prefix.array-option".
 
-Locking is not needed, since after initialization, the config becomes
+Locking is not needed, since after initialization, the configuration becomes
 read-only. All data and keys must be copied if you need to modify it.
 
 
diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index dcb390075ca1..e6cbe22361e9 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. _boottimetrace:
+
 =================
 Boot-time tracing
 =================

