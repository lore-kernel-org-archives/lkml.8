Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85564C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6440424658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgANVDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbgANVDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AB3F2467C;
        Tue, 14 Jan 2020 21:03:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLc-000D1i-He; Tue, 14 Jan 2020 16:03:36 -0500
Message-Id: <20200114210336.423422704@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 05/26] bootconfig: Load boot config from the tail of initrd
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Load the extended boot config data from the tail of initrd
image. If there is an SKC data there, it has
[(u32)size][(u32)checksum] header (in really, this is a
footer) at the end of initrd. If the checksum (simple sum
of bytes) is match, this starts parsing it from there.

Link: http://lkml.kernel.org/r/157867222435.17873.9936667353335606867.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/Kconfig |  1 +
 init/main.c  | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 63450d3bbf12..ffd240fb88c3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1217,6 +1217,7 @@ endif
 
 config BOOT_CONFIG
 	bool "Boot config support"
+	depends on BLK_DEV_INITRD
 	select LIBXBC
 	default y
 	help
diff --git a/init/main.c b/init/main.c
index 2cd736059416..59c418a57f92 100644
--- a/init/main.c
+++ b/init/main.c
@@ -28,6 +28,7 @@
 #include <linux/initrd.h>
 #include <linux/memblock.h>
 #include <linux/acpi.h>
+#include <linux/bootconfig.h>
 #include <linux/console.h>
 #include <linux/nmi.h>
 #include <linux/percpu.h>
@@ -245,6 +246,58 @@ static int __init loglevel(char *str)
 
 early_param("loglevel", loglevel);
 
+#ifdef CONFIG_BOOT_CONFIG
+u32 boot_config_checksum(unsigned char *p, u32 size)
+{
+	u32 ret = 0;
+
+	while (size--)
+		ret += *p++;
+
+	return ret;
+}
+
+static void __init setup_boot_config(void)
+{
+	u32 size, csum;
+	char *data, *copy;
+	u32 *hdr;
+
+	if (!initrd_end)
+		return;
+
+	hdr = (u32 *)(initrd_end - 8);
+	size = hdr[0];
+	csum = hdr[1];
+
+	if (size >= XBC_DATA_MAX)
+		return;
+
+	data = ((void *)hdr) - size;
+	if ((unsigned long)data < initrd_start)
+		return;
+
+	if (boot_config_checksum((unsigned char *)data, size) != csum)
+		return;
+
+	copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);
+	if (!copy) {
+		pr_err("Failed to allocate memory for boot config\n");
+		return;
+	}
+
+	memcpy(copy, data, size);
+	copy[size] = '\0';
+
+	if (xbc_init(copy) < 0)
+		pr_err("Failed to parse boot config\n");
+	else
+		pr_info("Load boot config: %d bytes\n", size);
+}
+#else
+#define setup_boot_config()	do { } while (0)
+#endif
+
 /* Change NUL term back to "=", to make "param" the whole string. */
 static int __init repair_env_string(char *param, char *val,
 				    const char *unused, void *arg)
@@ -595,6 +648,7 @@ asmlinkage __visible void __init start_kernel(void)
 	pr_notice("%s", linux_banner);
 	early_security_init();
 	setup_arch(&command_line);
+	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
 	setup_per_cpu_areas();
-- 
2.24.1


