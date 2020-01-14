Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF46C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4541A24690
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgANVDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:03:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbgANVDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:40 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5979724684;
        Tue, 14 Jan 2020 21:03:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLd-000D4I-9X; Tue, 14 Jan 2020 16:03:37 -0500
Message-Id: <20200114210337.173522962@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 10/26] bootconfig: init: Allow admin to use bootconfig for kernel command
 line
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since the current kernel command line is too short to describe
many options which supported by kernel, allow user to use boot
config to setup (add) the command line options.

All kernel parameters under "kernel." keywords will be used
for setting up extra kernel command line.

For example,

kernel {
	audit = on
	audit_backlog_limit = 256
}

Note that you can not specify some early parameters
(like console etc.) by this method, since it is
loaded after early parameters parsed.

Link: http://lkml.kernel.org/r/157867228333.17873.11962796367032622466.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 5 deletions(-)

diff --git a/init/main.c b/init/main.c
index 0b4e0c8ccf16..c0017d9d16e7 100644
--- a/init/main.c
+++ b/init/main.c
@@ -137,6 +137,8 @@ char __initdata boot_command_line[COMMAND_LINE_SIZE];
 char *saved_command_line;
 /* Command line for parameter parsing */
 static char *static_command_line;
+/* Untouched extra command line */
+static char *extra_command_line;
 
 static char *execute_command;
 static char *ramdisk_execute_command;
@@ -245,6 +247,83 @@ static int __init loglevel(char *str)
 early_param("loglevel", loglevel);
 
 #ifdef CONFIG_BOOT_CONFIG
+
+char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
+
+#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
+
+static int __init xbc_snprint_cmdline(char *buf, size_t size,
+				      struct xbc_node *root)
+{
+	struct xbc_node *knode, *vnode;
+	char *end = buf + size;
+	char c = '\"';
+	const char *val;
+	int ret;
+
+	xbc_node_for_each_key_value(root, knode, val) {
+		ret = xbc_node_compose_key_after(root, knode,
+					xbc_namebuf, XBC_KEYLEN_MAX);
+		if (ret < 0)
+			return ret;
+
+		vnode = xbc_node_get_child(knode);
+		ret = snprintf(buf, rest(buf, end), "%s%c", xbc_namebuf,
+				vnode ? '=' : ' ');
+		if (ret < 0)
+			return ret;
+		buf += ret;
+		if (!vnode)
+			continue;
+
+		c = '\"';
+		xbc_array_for_each_value(vnode, val) {
+			ret = snprintf(buf, rest(buf, end), "%c%s", c, val);
+			if (ret < 0)
+				return ret;
+			buf += ret;
+			c = ',';
+		}
+		if (rest(buf, end) > 2)
+			strcpy(buf, "\" ");
+		buf += 2;
+	}
+
+	return buf - (end - size);
+}
+#undef rest
+
+/* Make an extra command line under given key word */
+static char * __init xbc_make_cmdline(const char *key)
+{
+	struct xbc_node *root;
+	char *new_cmdline;
+	int ret, len = 0;
+
+	root = xbc_find_node(key);
+	if (!root)
+		return NULL;
+
+	/* Count required buffer size */
+	len = xbc_snprint_cmdline(NULL, 0, root);
+	if (len <= 0)
+		return NULL;
+
+	new_cmdline = memblock_alloc(len + 1, SMP_CACHE_BYTES);
+	if (!new_cmdline) {
+		pr_err("Failed to allocate memory for extra kernel cmdline.\n");
+		return NULL;
+	}
+
+	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root);
+	if (ret < 0 || ret > len) {
+		pr_err("Failed to print extra kernel cmdline.\n");
+		return NULL;
+	}
+
+	return new_cmdline;
+}
+
 u32 boot_config_checksum(unsigned char *p, u32 size)
 {
 	u32 ret = 0;
@@ -289,8 +368,11 @@ static void __init setup_boot_config(void)
 
 	if (xbc_init(copy) < 0)
 		pr_err("Failed to parse boot config\n");
-	else
+	else {
 		pr_info("Load boot config: %d bytes\n", size);
+		/* keys starting with "kernel." are passed via cmdline */
+		extra_command_line = xbc_make_cmdline("kernel");
+	}
 }
 #else
 #define setup_boot_config()	do { } while (0)
@@ -425,7 +507,12 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
  */
 static void __init setup_command_line(char *command_line)
 {
-	size_t len = strlen(boot_command_line) + 1;
+	size_t len, xlen = 0;
+
+	if (extra_command_line)
+		xlen = strlen(extra_command_line);
+
+	len = xlen + strlen(boot_command_line) + 1;
 
 	saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!saved_command_line)
@@ -435,8 +522,17 @@ static void __init setup_command_line(char *command_line)
 	if (!static_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
 
-	strcpy(saved_command_line, boot_command_line);
-	strcpy(static_command_line, command_line);
+	if (xlen) {
+		/*
+		 * We have to put extra_command_line before boot command
+		 * lines because there could be dashes (separator of init
+		 * command line) in the command lines.
+		 */
+		strcpy(saved_command_line, extra_command_line);
+		strcpy(static_command_line, extra_command_line);
+	}
+	strcpy(saved_command_line + xlen, boot_command_line);
+	strcpy(static_command_line + xlen, command_line);
 }
 
 /*
@@ -652,7 +748,7 @@ asmlinkage __visible void __init start_kernel(void)
 	build_all_zonelists(NULL);
 	page_alloc_init();
 
-	pr_notice("Kernel command line: %s\n", boot_command_line);
+	pr_notice("Kernel command line: %s\n", saved_command_line);
 	/* parameters may set static keys */
 	jump_label_init();
 	parse_early_param();
-- 
2.24.1


