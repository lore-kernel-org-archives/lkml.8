Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA92C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D342166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgBDOZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:25:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbgBDOZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:25:38 -0500
Received: from oasis.local.home (unknown [212.187.182.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E88D2192A;
        Tue,  4 Feb 2020 14:25:33 +0000 (UTC)
Date:   Tue, 4 Feb 2020 09:25:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] bootconfig: Only load bootconfig if "config=bootconfig"
 is on the kernel cmdline (was: bootconfig: Add "disable_bootconfig" cmdline
 option to  disable bootconfig)
Message-ID: <20200204092528.2dc8fba4@oasis.local.home>
In-Reply-To: <20200204084642.450b6ebd@oasis.local.home>
References: <20200204053155.127c3f1e@oasis.local.home>
        <CAHk-=wjfjO+h6bQzrTf=YCZA53Y3EDyAs3Z4gEsT7icA3u_Psw@mail.gmail.com>
        <20200204072856.0da60613@oasis.local.home>
        <CAHk-=wg2Wk9ZgVBDCBHa3-b0fSfByiRJnGA_F8snMy=3HHg_gw@mail.gmail.com>
        <20200204084642.450b6ebd@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
kernel cmdline. The loading of the bootconfig is only done if
"config=bootconfig" is on the kernel command line. This will let admins know
that the kernel command line is extended.

Note, after adding printk()s for when the size is too great or the checksum
is wrong, exposed that the current method always looked for the boot config,
and if this size and checksum matched, it would parse it (as if either is
wrong a printk has been added to show this). It's better to only check this
if the boot config is asked to be looked for.

Link: https://lore.kernel.org/r/CAHk-=wjfjO+h6bQzrTf=YCZA53Y3EDyAs3Z4gEsT7icA3u_Psw@mail.gmail.com

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst      |  2 ++
 .../admin-guide/kernel-parameters.txt         |  6 ++++
 init/main.c                                   | 28 ++++++++++++++-----
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 4d617693c0c8..850c06f5b909 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -123,6 +123,8 @@ To remove the config from the image, you can use -d option as below::
 
  # tools/bootconfig/bootconfig -d /boot/initrd.img-X.Y.Z
 
+Then add "config=bootconfig" on the normal kernel command line to tell
+the kernel to look for the bootconfig at the end of the initrd file.
 
 Config File Limitation
 ======================
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..b1972ddf597c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -608,6 +608,12 @@
 	condev=		[HW,S390] console device
 	conmode=
 
+	config=bootconfig [KNL]
+			Extended command line options can be added to an initrd
+			and this will cause the kernel to look for it.
+
+			See Documentation/admin-guide/bootconfig.rst
+
 	console=	[KNL] Output console device and options.
 
 		tty<n>	Use the virtual console device <n>.
diff --git a/init/main.c b/init/main.c
index dd7da62d99a5..de3bc0a038e0 100644
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
+	p = strstr(cmdline, "config=bootconfig");
+	if (!p || (p != cmdline && !isspace(*(p-1))) ||
+	    (p[17] && !isspace(p[17])))
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
+	pr_err("config=bootconfig on command line, but no bootconfig found\n");
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
2.20.1

