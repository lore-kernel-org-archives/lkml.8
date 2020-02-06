Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD7EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A640220661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgBFECb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 23:02:31 -0500
Received: from kernel.crashing.org ([76.164.61.194]:50560 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgBFECb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 23:02:31 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 01642I1O017458
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 Feb 2020 22:02:22 -0600
Message-ID: <e6b63bc26108c6e3645f9ea9e03aba38fd8b8464.camel@kernel.crashing.org>
Subject: [PATCH v3 1/3] printk: Move console matching logic into a separate
 function
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 06 Feb 2020 15:02:18 +1100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the loop that tries to match a newly registered console
with the command line or add_preferred_console list into a separate
helper, in order to be able to call it multiple times in subsequent
patches.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Sorry for the delay, I got ... distracted :-)

I ended up going for the int return codes instead of the enum, there
aren't enough interesting cases anyways. I *hope* the logic doesn't
change from the eixsting code. There might be subtle differences
if a console is marked as brailled and fails to initialize but I doubt
it matters.

 kernel/printk/printk.c | 107 +++++++++++++++++++++++++----------------
 1 file changed, 66 insertions(+), 41 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1ef6f75d92f1..17602d7b7ffc 100644
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
+         * Some consoles, such as pstore and netconsole, can be enabled even
+         * without matching.
+         */
+        if (newcon->flags & CON_ENABLED)
+                return 0;
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
@@ -2694,48 +2747,20 @@ void register_console(struct console *newcon)
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
+        err = try_enable_new_console(newcon);
 
-		newcon->flags |= CON_ENABLED;
-		if (i == preferred_console) {
-			newcon->flags |= CON_CONSDEV;
-			has_preferred = true;
-		}
-		break;
-	}
-
-	if (!(newcon->flags & CON_ENABLED))
-		return;
+        /* printk() messages are not printed to the Braille console. */
+        if (err || newcon->flags & CON_BRL)
+                return;
 
 	/*
 	 * If we have a bootconsole, and are switching to a real console,


