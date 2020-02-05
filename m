Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49558C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A9321927
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgBEKvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 05:51:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbgBEKvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:51:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BD3C2072B;
        Wed,  5 Feb 2020 10:51:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1izIH2-001Nrz-Va; Wed, 05 Feb 2020 05:51:12 -0500
Message-Id: <20200205105112.862375803@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Feb 2020 05:49:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-next][PATCH 1/4] bootconfig: Only load bootconfig if "bootconfig" is on the kernel
 cmdline
References: <20200205104929.313040579@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As the bootconfig is appended to the initrd it is not as easy to modify as
the kernel command line. If there's some issue with the kernel, and the
developer wants to boot a pristine kernel, it should not be needed to modify
the initrd to remove the bootconfig for a single boot.

As bootconfig is silently added (if the admin does not know where to look
they may not know it's being loaded). It should be explicitly added to the
kernel cmdline. The loading of the bootconfig is only done if "bootconfig"
is on the kernel command line. This will let admins know that the kernel
command line is extended.

Note, after adding printk()s for when the size is too great or the checksum
is wrong, exposed that the current method always looked for the boot config,
and if this size and checksum matched, it would parse it (as if either is
wrong a printk has been added to show this). It's better to only check this
if the boot config is asked to be looked for.

Link: https://lore.kernel.org/r/CAHk-=wjfjO+h6bQzrTf=YCZA53Y3EDyAs3Z4gEsT7icA3u_Psw@mail.gmail.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst      |  2 ++
 .../admin-guide/kernel-parameters.txt         |  6 ++++
 init/main.c                                   | 28 ++++++++++++++-----
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 4d617693c0c8..b342a6796392 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -123,6 +123,8 @@ To remove the config from the image, you can use -d option as below::
 
  # tools/bootconfig/bootconfig -d /boot/initrd.img-X.Y.Z
 
+Then add "bootconfig" on the normal kernel command line to tell the
+kernel to look for the bootconfig at the end of the initrd file.
 
 Config File Limitation
 ======================
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..b48c70ba9841 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -437,6 +437,12 @@
 			no delay (0).
 			Format: integer
 
+	bootconfig	[KNL]
+			Extended command line options can be added to an initrd
+			and this will cause the kernel to look for it.
+
+			See Documentation/admin-guide/bootconfig.rst
+
 	bert_disable	[ACPI]
 			Disable BERT OS support on buggy BIOSes.
 
diff --git a/init/main.c b/init/main.c
index dd7da62d99a5..f174a59d3903 100644
--- a/init/main.c
+++ b/init/main.c
@@ -336,28 +336,39 @@ u32 boot_config_checksum(unsigned char *p, u32 size)
 	return ret;
 }
 
-static void __init setup_boot_config(void)
+static void __init setup_boot_config(const char *cmdline)
 {
 	u32 size, csum;
 	char *data, *copy;
+	const char *p;
 	u32 *hdr;
 
-	if (!initrd_end)
+	p = strstr(cmdline, "bootconfig");
+	if (!p || (p != cmdline && !isspace(*(p-1))) ||
+	    (p[10] && !isspace(p[10])))
 		return;
 
+	if (!initrd_end)
+		goto not_found;
+
 	hdr = (u32 *)(initrd_end - 8);
 	size = hdr[0];
 	csum = hdr[1];
 
-	if (size >= XBC_DATA_MAX)
+	if (size >= XBC_DATA_MAX) {
+		pr_err("bootconfig size %d greater than max size %d\n",
+			size, XBC_DATA_MAX);
 		return;
+	}
 
 	data = ((void *)hdr) - size;
 	if ((unsigned long)data < initrd_start)
-		return;
+		goto not_found;
 
-	if (boot_config_checksum((unsigned char *)data, size) != csum)
+	if (boot_config_checksum((unsigned char *)data, size) != csum) {
+		pr_err("bootconfig checksum failed\n");
 		return;
+	}
 
 	copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);
 	if (!copy) {
@@ -377,9 +388,12 @@ static void __init setup_boot_config(void)
 		/* Also, "init." keys are init arguments */
 		extra_init_args = xbc_make_cmdline("init");
 	}
+	return;
+not_found:
+	pr_err("'bootconfig' found on command line, but no bootconfig found\n");
 }
 #else
-#define setup_boot_config()	do { } while (0)
+#define setup_boot_config(cmdline)	do { } while (0)
 #endif
 
 /* Change NUL term back to "=", to make "param" the whole string. */
@@ -760,7 +774,7 @@ asmlinkage __visible void __init start_kernel(void)
 	pr_notice("%s", linux_banner);
 	early_security_init();
 	setup_arch(&command_line);
-	setup_boot_config();
+	setup_boot_config(command_line);
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
 	setup_per_cpu_areas();
-- 
2.24.1


