Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9125C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F6424658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgANVEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgANVDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 167E324676;
        Tue, 14 Jan 2020 21:03:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLd-000D3G-07; Tue, 14 Jan 2020 16:03:37 -0500
Message-Id: <20200114210336.887523301@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 08/26] proc: bootconfig: Add /proc/bootconfig to show boot config list
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add /proc/bootconfig which shows the list of key-value pairs
in boot config. Since after boot, all boot configs and tree
are removed, this interface just keep a copy of key-value
pairs in text.

Link: http://lkml.kernel.org/r/157867225967.17873.12155805787236073787.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 MAINTAINERS          |  1 +
 fs/proc/Makefile     |  1 +
 fs/proc/bootconfig.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 fs/proc/bootconfig.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 06005006de7c..903e8a7ed0bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15774,6 +15774,7 @@ EXTRA BOOT CONFIG
 M:	Masami Hiramatsu <mhiramat@kernel.org>
 S:	Maintained
 F:	lib/bootconfig.c
+F:	fs/proc/bootconfig.c
 F:	include/linux/bootconfig.h
 F:	tools/bootconfig/*
 
diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index ead487e80510..bd08616ed8ba 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -33,3 +33,4 @@ proc-$(CONFIG_PROC_KCORE)	+= kcore.o
 proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
 proc-$(CONFIG_PRINTK)	+= kmsg.o
 proc-$(CONFIG_PROC_PAGE_MONITOR)	+= page.o
+proc-$(CONFIG_BOOT_CONFIG)	+= bootconfig.o
diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
new file mode 100644
index 000000000000..9955d75c0585
--- /dev/null
+++ b/fs/proc/bootconfig.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * /proc/bootconfig - Extra boot configuration
+ */
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/printk.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/bootconfig.h>
+#include <linux/slab.h>
+
+static char *saved_boot_config;
+
+static int boot_config_proc_show(struct seq_file *m, void *v)
+{
+	if (saved_boot_config)
+		seq_puts(m, saved_boot_config);
+	return 0;
+}
+
+/* Rest size of buffer */
+#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
+
+/* Return the needed total length if @size is 0 */
+static int __init copy_xbc_key_value_list(char *dst, size_t size)
+{
+	struct xbc_node *leaf, *vnode;
+	const char *val;
+	char *key, *end = dst + size;
+	int ret = 0;
+
+	key = kzalloc(XBC_KEYLEN_MAX, GFP_KERNEL);
+
+	xbc_for_each_key_value(leaf, val) {
+		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
+		if (ret < 0)
+			break;
+		ret = snprintf(dst, rest(dst, end), "%s = ", key);
+		if (ret < 0)
+			break;
+		dst += ret;
+		vnode = xbc_node_get_child(leaf);
+		if (vnode && xbc_node_is_array(vnode)) {
+			xbc_array_for_each_value(vnode, val) {
+				ret = snprintf(dst, rest(dst, end), "\"%s\"%s",
+					val, vnode->next ? ", " : "\n");
+				if (ret < 0)
+					goto out;
+				dst += ret;
+			}
+		} else {
+			ret = snprintf(dst, rest(dst, end), "\"%s\"\n", val);
+			if (ret < 0)
+				break;
+			dst += ret;
+		}
+	}
+out:
+	kfree(key);
+
+	return ret < 0 ? ret : dst - (end - size);
+}
+
+static int __init proc_boot_config_init(void)
+{
+	int len;
+
+	len = copy_xbc_key_value_list(NULL, 0);
+	if (len < 0)
+		return len;
+
+	if (len > 0) {
+		saved_boot_config = kzalloc(len + 1, GFP_KERNEL);
+		if (!saved_boot_config)
+			return -ENOMEM;
+
+		len = copy_xbc_key_value_list(saved_boot_config, len + 1);
+		if (len < 0) {
+			kfree(saved_boot_config);
+			return len;
+		}
+	}
+
+	proc_create_single("bootconfig", 0, NULL, boot_config_proc_show);
+
+	return 0;
+}
+fs_initcall(proc_boot_config_init);
-- 
2.24.1


