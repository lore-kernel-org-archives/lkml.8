Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DA62075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgESTmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:42:45 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:41006 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726943AbgESTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:42:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5BEBB182CED2A;
        Tue, 19 May 2020 19:42:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: touch60_4a0551226d0f
X-Filterd-Recvd-Size: 2634
Received: from joe-laptop.perches.com (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 May 2020 19:42:41 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH 2/2] init: Allow multi-line output of kernel command line
Date:   Tue, 19 May 2020 12:42:35 -0700
Message-Id: <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1589916689.git.joe@perches.com>
References: <cover.1589916689.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM may have its longest possible command line larger than the longest
possible printk.

If necessary, emit the commend line on multiple lines.

Signed-off-by: Joe Perches <joe@perches.com>
---

compiled, untested

 init/main.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index b63a3c001ac4..b3ebbbc129ae 100644
--- a/init/main.c
+++ b/init/main.c
@@ -826,6 +826,34 @@ void __init __weak arch_call_rest_init(void)
 	rest_init();
 }
 
+static void __init print_cmdline(char *line)
+{
+#ifdef CONFIG_PRINTK
+	const char *prefix = "Kernel command line";
+	size_t len = strlen(line);
+
+	while (len > PRINTK_LOG_LINE_MAX) {
+		char *pos = line;
+		char *last_pos = pos + PRINTK_LOG_LINE_MAX - 1;
+		char saved_char;
+		/* Find last space char within the maximum line length */
+		while ((pos = memchr(pos, ' ', len - (pos - line))) &&
+		       (pos - line) < PRINTK_LOG_LINE_MAX - 1) {
+			last_pos = pos;
+		}
+		saved_char = line[last_pos - line];
+		line[last_pos - line] = 0;
+		pr_notice("%s: %s\n", prefix, line);
+		prefix = "Kernel command line (continued)";
+		line[last_pos - line] = saved_char;
+		len -= pos - line;
+		line += pos - line;
+	}
+
+	pr_notice("%s: %s\n", prefix, line);
+#endif
+}
+
 asmlinkage __visible void __init start_kernel(void)
 {
 	char *command_line;
@@ -859,7 +887,8 @@ asmlinkage __visible void __init start_kernel(void)
 	build_all_zonelists(NULL);
 	page_alloc_init();
 
-	pr_notice("Kernel command line: %s\n", saved_command_line);
+	print_cmdline(saved_command_line);
+
 	/* parameters may set static keys */
 	jump_label_init();
 	parse_early_param();
-- 
2.25.1

