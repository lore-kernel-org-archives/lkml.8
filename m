Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C65FC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE43F2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgBMJvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:51:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:41188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729805AbgBMJvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:51:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0B73FB196;
        Thu, 13 Feb 2020 09:51:53 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] printk: Move console matching logic into a separate function
Date:   Thu, 13 Feb 2020 10:51:31 +0100
Message-Id: <20200213095133.23176-2-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200213095133.23176-1-pmladek@suse.com>
References: <20200213095133.23176-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This moves the loop that tries to match a newly registered console
with the command line or add_preferred_console list into a separate
helper, in order to be able to call it multiple times in subsequent
patches.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 105 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 40 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fada22dc4ab6..0ebcdf53e75d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -280,6 +280,7 @@ static struct console *exclusive_console;
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 
 static int preferred_console = -1;
+static bool has_preferred_console;
 int console_set_on_cmdline;
 EXPORT_SYMBOL(console_set_on_cmdline);
 
@@ -2626,6 +2627,60 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+/*
+ * This is called by register_console() to try to match
+ * the newly registered console with any of the ones selected
+ * by either the command line or add_preferred_console() and
+ * setup/enable it.
+ *
+ * Care need to be taken with consoles that are statically
+ * enabled such as netconsole
+ */
+static int try_enable_new_console(struct console *newcon)
+{
+	struct console_cmdline *c;
+	int i;
+
+	for (i = 0, c = console_cmdline;
+	     i < MAX_CMDLINECONSOLES && c->name[0];
+	     i++, c++) {
+		if (!newcon->match ||
+		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
+			/* default matching */
+			BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
+			if (strcmp(c->name, newcon->name) != 0)
+				continue;
+			if (newcon->index >= 0 &&
+			    newcon->index != c->index)
+				continue;
+			if (newcon->index < 0)
+				newcon->index = c->index;
+
+			if (_braille_register_console(newcon, c))
+				return 0;
+
+			if (newcon->setup &&
+			    newcon->setup(newcon, c->options) != 0)
+				return -EIO;
+		}
+		newcon->flags |= CON_ENABLED;
+		if (i == preferred_console) {
+			newcon->flags |= CON_CONSDEV;
+			has_preferred_console = true;
+		}
+		return 0;
+	}
+
+	/*
+	 * Some consoles, such as pstore and netconsole, can be enabled even
+	 * without matching.
+	 */
+	if (newcon->flags & CON_ENABLED)
+		return 0;
+
+	return -ENOENT;
+}
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -2647,11 +2702,9 @@ early_param("keep_bootcon", keep_bootcon_setup);
  */
 void register_console(struct console *newcon)
 {
-	int i;
 	unsigned long flags;
 	struct console *bcon = NULL;
-	struct console_cmdline *c;
-	static bool has_preferred;
+	int err;
 
 	if (console_drivers)
 		for_each_console(bcon)
@@ -2678,15 +2731,15 @@ void register_console(struct console *newcon)
 	if (console_drivers && console_drivers->flags & CON_BOOT)
 		bcon = console_drivers;
 
-	if (!has_preferred || bcon || !console_drivers)
-		has_preferred = preferred_console >= 0;
+	if (!has_preferred_console || bcon || !console_drivers)
+		has_preferred_console = preferred_console >= 0;
 
 	/*
 	 *	See if we want to use this console driver. If we
 	 *	didn't select a console we take the first one
 	 *	that registers here.
 	 */
-	if (!has_preferred) {
+	if (!has_preferred_console) {
 		if (newcon->index < 0)
 			newcon->index = 0;
 		if (newcon->setup == NULL ||
@@ -2694,47 +2747,19 @@ void register_console(struct console *newcon)
 			newcon->flags |= CON_ENABLED;
 			if (newcon->device) {
 				newcon->flags |= CON_CONSDEV;
-				has_preferred = true;
+				has_preferred_console = true;
 			}
 		}
 	}
 
 	/*
-	 *	See if this console matches one we selected on
-	 *	the command line.
+	 * See if this console matches one we selected on
+	 * the command line or if it was statically enabled
 	 */
-	for (i = 0, c = console_cmdline;
-	     i < MAX_CMDLINECONSOLES && c->name[0];
-	     i++, c++) {
-		if (!newcon->match ||
-		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
-			/* default matching */
-			BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
-			if (strcmp(c->name, newcon->name) != 0)
-				continue;
-			if (newcon->index >= 0 &&
-			    newcon->index != c->index)
-				continue;
-			if (newcon->index < 0)
-				newcon->index = c->index;
-
-			if (_braille_register_console(newcon, c))
-				return;
-
-			if (newcon->setup &&
-			    newcon->setup(newcon, c->options) != 0)
-				break;
-		}
-
-		newcon->flags |= CON_ENABLED;
-		if (i == preferred_console) {
-			newcon->flags |= CON_CONSDEV;
-			has_preferred = true;
-		}
-		break;
-	}
+	err = try_enable_new_console(newcon);
 
-	if (!(newcon->flags & CON_ENABLED))
+	/* printk() messages are not printed to the Braille console. */
+	if (err || newcon->flags & CON_BRL)
 		return;
 
 	/*
-- 
2.16.4

