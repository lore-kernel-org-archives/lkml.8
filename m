Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F25C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1790A20873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgBJOpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbgBJOph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB37324672;
        Mon, 10 Feb 2020 14:45:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j1AJb-001Vz8-Ni; Mon, 10 Feb 2020 09:45:35 -0500
Message-Id: <20200210144535.610003291@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 10 Feb 2020 09:44:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 4/4] bootconfig: Use parse_args() to find bootconfig and --
References: <20200210144455.531096382@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The current implementation does a naive search of "bootconfig" on the kernel
command line. But this could find "bootconfig" that is part of another
option in quotes (although highly unlikely). But it also needs to find '--'
on the kernel command line to know if it should append a '--' or not when a
bootconfig in the initrd file has an "init" section. The check uses the
naive strstr() to find to see if it exists. But this can return a false
positive if it exists in an option and then the "init" section in the initrd
will not be appended properly.

Using parse_args() to find both of these will solve both of these problems.

Link: https://lore.kernel.org/r/202002070954.C18E7F58B@keescook

Fixes: 7495e0926fdf3 ("bootconfig: Only load bootconfig if "bootconfig" is on the kernel cmdline")
Fixes: 1319916209ce8 ("bootconfig: init: Allow admin to use bootconfig for init command line")
Reported-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/init/main.c b/init/main.c
index 491f1cdb3105..59248717c925 100644
--- a/init/main.c
+++ b/init/main.c
@@ -142,6 +142,15 @@ static char *extra_command_line;
 /* Extra init arguments */
 static char *extra_init_args;
 
+#ifdef CONFIG_BOOT_CONFIG
+/* Is bootconfig on command line? */
+static bool bootconfig_found;
+static bool initargs_found;
+#else
+# define bootconfig_found false
+# define initargs_found false
+#endif
+
 static char *execute_command;
 static char *ramdisk_execute_command;
 
@@ -336,17 +345,30 @@ u32 boot_config_checksum(unsigned char *p, u32 size)
 	return ret;
 }
 
+static int __init bootconfig_params(char *param, char *val,
+				    const char *unused, void *arg)
+{
+	if (strcmp(param, "bootconfig") == 0) {
+		bootconfig_found = true;
+	} else if (strcmp(param, "--") == 0) {
+		initargs_found = true;
+	}
+	return 0;
+}
+
 static void __init setup_boot_config(const char *cmdline)
 {
+	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
 	u32 size, csum;
 	char *data, *copy;
-	const char *p;
 	u32 *hdr;
 	int ret;
 
-	p = strstr(cmdline, "bootconfig");
-	if (!p || (p != cmdline && !isspace(*(p-1))) ||
-	    (p[10] && !isspace(p[10])))
+	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
+		   bootconfig_params);
+
+	if (!bootconfig_found)
 		return;
 
 	if (!initrd_end)
@@ -563,11 +585,12 @@ static void __init setup_command_line(char *command_line)
 		 * to init.
 		 */
 		len = strlen(saved_command_line);
-		if (!strstr(boot_command_line, " -- ")) {
+		if (initargs_found) {
+			saved_command_line[len++] = ' ';
+		} else {
 			strcpy(saved_command_line + len, " -- ");
 			len += 4;
-		} else
-			saved_command_line[len++] = ' ';
+		}
 
 		strcpy(saved_command_line + len, extra_init_args);
 	}
-- 
2.24.1


