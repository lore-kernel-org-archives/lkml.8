Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7788C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C68206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgELNXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729866AbgELNXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:23:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EBF207DD;
        Tue, 12 May 2020 13:23:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jYUsu-0006PA-4k; Tue, 12 May 2020 09:23:48 -0400
Message-ID: <20200512132348.029291894@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 12 May 2020 09:23:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 3/3] bootconfig: Fix to prevent warning message if no bootconfig option
References: <20200512132317.343672858@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Commit de462e5f1071 ("bootconfig: Fix to remove bootconfig
data from initrd while boot") causes a cosmetic regression
on dmesg, which warns "no bootconfig data" message without
bootconfig cmdline option.

Fix setup_boot_config() by moving no bootconfig check after
commandline option check.

Link: http://lkml.kernel.org/r/9b1ba335-071d-c983-89a4-2677b522dcc8@molgen.mpg.de
Link: http://lkml.kernel.org/r/158916116468.21787.14558782332170588206.stgit@devnote2

Fixes: de462e5f1071 ("bootconfig: Fix to remove bootconfig data from initrd while boot")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/init/main.c b/init/main.c
index 1a5da2c2660c..5803ecb411ab 100644
--- a/init/main.c
+++ b/init/main.c
@@ -400,9 +400,8 @@ static void __init setup_boot_config(const char *cmdline)
 	char *data, *copy;
 	int ret;
 
+	/* Cut out the bootconfig data even if we have no bootconfig option */
 	data = get_boot_config_from_initrd(&size, &csum);
-	if (!data)
-		goto not_found;
 
 	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
@@ -411,6 +410,11 @@ static void __init setup_boot_config(const char *cmdline)
 	if (!bootconfig_found)
 		return;
 
+	if (!data) {
+		pr_err("'bootconfig' found on command line, but no bootconfig found\n");
+		return;
+	}
+
 	if (size >= XBC_DATA_MAX) {
 		pr_err("bootconfig size %d greater than max size %d\n",
 			size, XBC_DATA_MAX);
@@ -446,8 +450,6 @@ static void __init setup_boot_config(const char *cmdline)
 		extra_init_args = xbc_make_cmdline("init");
 	}
 	return;
-not_found:
-	pr_err("'bootconfig' found on command line, but no bootconfig found\n");
 }
 
 #else
-- 
2.26.2


