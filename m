Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230C8C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB05B24680
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582788359;
	bh=PhxdXUn2MorRzDr2BKm4L9ONQa9aDYfWy8HW/pnKaao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=re3rvUQBROHQydhqlHNcW4VvdOnhF6EFSnTEZNoFbab2CshE/C3r5xXyDz9SwngSm
	 ySLRRvMw8jk5WIUmEXs39gaZEyc46+VCMPtd3kWvm3elMVQJhdyP/aSQtB327mpFMl
	 pwq9Zw3uVhScEX8u0OlrqXtzmpZHsKfi8y67asNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgB0HZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 02:25:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgB0HZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 02:25:57 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF7452467F;
        Thu, 27 Feb 2020 07:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582788356;
        bh=PhxdXUn2MorRzDr2BKm4L9ONQa9aDYfWy8HW/pnKaao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GA2tMn9C7LB+XkKqn5G3MWLpD9OG4cARam8qMVFBIt3QioVst+Zu55zvwAlHpY5h0
         ApxH0PmPf9oEnUYnPBtVKD8IjyKpyAh2sijZ7a7wUqY0QjYNgXd8YAEnuQZwLUFVyj
         CewKwfW/c+ORLqN5sJKiBJi97JQsG++BP0Bs/BB0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 1/2] Documentation: bootconfig: Update boot configuration documentation
Date:   Thu, 27 Feb 2020 16:25:52 +0900
Message-Id: <158278835238.14966.16157216423901327777.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158278834245.14966.6179457011671073018.stgit@devnote2>
References: <158278834245.14966.6179457011671073018.stgit@devnote2>
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
 Documentation/admin-guide/bootconfig.rst |  172 +++++++++++++++++++-----------
 Documentation/trace/boottime-trace.rst   |    2 
 2 files changed, 112 insertions(+), 62 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index cf2edcd09183..4bac98250bc0 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -11,19 +11,98 @@ Boot Configuration
 Overview
 ========
 
-The boot configuration expands the current kernel command line to support
+Boot configuration expands the current kernel command line to support
 additional key-value data when booting the kernel in an efficient way.
-This allows administrators to pass a structured-Key config file.
+This allows administrators to pass a structured-Key configuration file
+as a way to supplement the kernel command line to pass system boot parameters.
 
-Config File Syntax
-==================
+Compared with the kernel command line, the boot configuration can provide
+scalability (up to 32 KiB configurations), readability (structured
+configuration with comments) and compact expression of option groups.
+
+When to Use the Boot Configuration?
+-----------------------------------
+
+The boot configuration supports kernel command line options and init daemon
+boot options. All sub-keys under "kernel" root key are passed as a part of
+kernel command line [1]_, and one under "init" root key are passed as a part
+of init command line. For example, ::
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
+configuration file or want to comment on each options, you can use this
+boot configuration. If unsure, you can still continue to use the legacy
+kernel command line.
+
+Also, some subsystem may depend on the boot configuration, and it has own
+root key. For example, ftrace boot-time tracer uses "ftrace" root key to
+describe their options [2]_. In this case, you need to use the boot
+configuration.
+
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
+update the boot loader and the kernel image itself.
+
+To do this operation, Linux kernel provides "bootconfig" command under
+tools/bootconfig, which allows admin to apply or delete the configuration
+file to/from initrd image. You can build it by the following command::
+
+ # make -C tools/bootconfig
+
+To add your boot configuration file to initrd image, run bootconfig as below
+(Old data is removed automatically if exists)::
+
+ # tools/bootconfig/bootconfig -a your-config /boot/initrd.img-X.Y.Z
 
-The boot config syntax is a simple structured key-value. Each key consists
-of dot-connected-words, and key and value are connected by ``=``. The value
-has to be terminated by semi-colon (``;``) or newline (``\n``).
+To remove the configuration from the image, you can use -d option as below::
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
+The value has to be terminated by semi-colon (``;``) or newline (``\n``).
 For array value, array entries are separated by comma (``,``). ::
 
-KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
+  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
 
 Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
 
@@ -42,7 +121,7 @@ are used for checking if the key exists or not (like a boolean).
 Key-Value Syntax
 ----------------
 
-The boot config file syntax allows user to merge partially same word keys
+The boot configuration syntax allows user to merge partially same word keys
 by brace. For example::
 
  foo.bar.baz = value1
@@ -80,19 +159,17 @@ you can use ``+=`` operator. For example::
 In this case, the key ``foo`` has ``bar``, ``baz`` and ``qux``.
 
 However, a sub-key and a value can not co-exist under a parent key.
-For example, following config is NOT allowed.::
+For example, following configuration is NOT allowed.::
 
  foo = value1
- foo.bar = value2 # !ERROR! subkey "bar" and value "value1" can NOT co-exist
+ foo.bar = value2 # !ERROR! sub-key "bar" and value "value1" can NOT co-exist
 
 
 Comments
 --------
 
-The config syntax accepts shell-script style comments. The comments starting
-with hash ("#") until newline ("\n") will be ignored.
-
-::
+The boot configuration accepts shell-script style comments. The comments
+starting with hash (``#``) until newline (``\n``), will be skipped.::
 
  # comment line
  foo = value # value is set to foo.
@@ -100,74 +177,45 @@ with hash ("#") until newline ("\n") will be ignored.
        2, # 2nd element
        3  # 3rd element
 
-This is parsed as below::
+This is parsed as below.::
 
  foo = value
  bar = 1, 2, 3
 
 Note that you can not put a comment between value and delimiter(``,`` or
-``;``). This means following config has a syntax error ::
+``;``). This means following description has a syntax error. ::
 
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
+Currently the maximum configuration size is 32 KiB and the total number
+of key-words and values must be under 1024 nodes.
+(Note: Each key consists of words separated by dot, and value also consists
+of values separated by comma. Here, each word and each value is generally
+called a "node".)
+Theoretically, it will be up to 512 key-value pairs. If keys contains 3
+words in average, it can contain 256 key-value pairs. In most cases,
+the number of configuration items will be under 100 entries and smaller
+than 8 KiB, so it would be enough.
 If the node number exceeds 1024, parser returns an error even if the file
-size is smaller than 32KB.
-Anyway, since bootconfig command verifies it when appending a boot config
-to initrd image, user can notice it before boot.
+size is smaller than 32 KiB.
+Anyway, since bootconfig command verifies it when appending a boot
+configuration to initrd image, user need to fix it before boot.
 
 
 Bootconfig APIs
@@ -206,7 +254,7 @@ or get the named array under prefix as below::
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

