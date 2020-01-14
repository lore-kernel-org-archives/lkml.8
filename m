Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DFAC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCBF24658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgANVEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:04:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgANVDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FDD824680;
        Tue, 14 Jan 2020 21:03:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLd-000D4o-EC; Tue, 14 Jan 2020 16:03:37 -0500
Message-Id: <20200114210337.319197276@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 11/26] bootconfig: init: Allow admin to use bootconfig for init command line
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since the current kernel command line is too short to describe
long and many options for init (e.g. systemd command line options),
this allows admin to use boot config for init command line.

All init command line under "init." keywords will be passed to
init.

For example,

init.systemd {
	unified_cgroup_hierarchy = 1
	debug_shell
	default_timeout_start_sec = 60
}

Link: http://lkml.kernel.org/r/157867229521.17873.654222294326542349.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index c0017d9d16e7..dd7da62d99a5 100644
--- a/init/main.c
+++ b/init/main.c
@@ -139,6 +139,8 @@ char *saved_command_line;
 static char *static_command_line;
 /* Untouched extra command line */
 static char *extra_command_line;
+/* Extra init arguments */
+static char *extra_init_args;
 
 static char *execute_command;
 static char *ramdisk_execute_command;
@@ -372,6 +374,8 @@ static void __init setup_boot_config(void)
 		pr_info("Load boot config: %d bytes\n", size);
 		/* keys starting with "kernel." are passed via cmdline */
 		extra_command_line = xbc_make_cmdline("kernel");
+		/* Also, "init." keys are init arguments */
+		extra_init_args = xbc_make_cmdline("init");
 	}
 }
 #else
@@ -507,16 +511,18 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
  */
 static void __init setup_command_line(char *command_line)
 {
-	size_t len, xlen = 0;
+	size_t len, xlen = 0, ilen = 0;
 
 	if (extra_command_line)
 		xlen = strlen(extra_command_line);
+	if (extra_init_args)
+		ilen = strlen(extra_init_args) + 4; /* for " -- " */
 
 	len = xlen + strlen(boot_command_line) + 1;
 
-	saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
+	saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
 	if (!saved_command_line)
-		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
 
 	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!static_command_line)
@@ -533,6 +539,22 @@ static void __init setup_command_line(char *command_line)
 	}
 	strcpy(saved_command_line + xlen, boot_command_line);
 	strcpy(static_command_line + xlen, command_line);
+
+	if (ilen) {
+		/*
+		 * Append supplemental init boot args to saved_command_line
+		 * so that user can check what command line options passed
+		 * to init.
+		 */
+		len = strlen(saved_command_line);
+		if (!strstr(boot_command_line, " -- ")) {
+			strcpy(saved_command_line + len, " -- ");
+			len += 4;
+		} else
+			saved_command_line[len++] = ' ';
+
+		strcpy(saved_command_line + len, extra_init_args);
+	}
 }
 
 /*
@@ -759,6 +781,9 @@ asmlinkage __visible void __init start_kernel(void)
 	if (!IS_ERR_OR_NULL(after_dashes))
 		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
 			   NULL, set_init_arg);
+	if (extra_init_args)
+		parse_args("Setting extra init args", extra_init_args,
+			   NULL, 0, -1, -1, NULL, set_init_arg);
 
 	/*
 	 * These use large bootmem allocations and must precede
-- 
2.24.1


