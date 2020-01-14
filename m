Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078ABC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80BD24692
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgANVDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:03:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbgANVDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3E92467D;
        Tue, 14 Jan 2020 21:03:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLd-000D3m-4q; Tue, 14 Jan 2020 16:03:37 -0500
Message-Id: <20200114210337.031890184@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 09/26] init/main.c: Alloc initcall_command_line in do_initcall() and free it
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since initcall_command_line is used as a temporary buffer,
it could be freed after usage. Allocate it in do_initcall()
and free it after used.

Link: http://lkml.kernel.org/r/157867227145.17873.17513760552008505454.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/init/main.c b/init/main.c
index 59c418a57f92..0b4e0c8ccf16 100644
--- a/init/main.c
+++ b/init/main.c
@@ -137,8 +137,6 @@ char __initdata boot_command_line[COMMAND_LINE_SIZE];
 char *saved_command_line;
 /* Command line for parameter parsing */
 static char *static_command_line;
-/* Command line for per-initcall parameter parsing */
-static char *initcall_command_line;
 
 static char *execute_command;
 static char *ramdisk_execute_command;
@@ -433,10 +431,6 @@ static void __init setup_command_line(char *command_line)
 	if (!saved_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
 
-	initcall_command_line =	memblock_alloc(len, SMP_CACHE_BYTES);
-	if (!initcall_command_line)
-		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
-
 	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!static_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
@@ -1044,13 +1038,12 @@ static const char *initcall_level_names[] __initdata = {
 	"late",
 };
 
-static void __init do_initcall_level(int level)
+static void __init do_initcall_level(int level, char *command_line)
 {
 	initcall_entry_t *fn;
 
-	strcpy(initcall_command_line, saved_command_line);
 	parse_args(initcall_level_names[level],
-		   initcall_command_line, __start___param,
+		   command_line, __start___param,
 		   __stop___param - __start___param,
 		   level, level,
 		   NULL, &repair_env_string);
@@ -1063,9 +1056,20 @@ static void __init do_initcall_level(int level)
 static void __init do_initcalls(void)
 {
 	int level;
+	size_t len = strlen(saved_command_line) + 1;
+	char *command_line;
+
+	command_line = kzalloc(len, GFP_KERNEL);
+	if (!command_line)
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+
+	for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
+		/* Parser modifies command_line, restore it each time */
+		strcpy(command_line, saved_command_line);
+		do_initcall_level(level, command_line);
+	}
 
-	for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++)
-		do_initcall_level(level);
+	kfree(command_line);
 }
 
 /*
-- 
2.24.1


