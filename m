Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A01AC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2B72073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgBMJwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:52:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:41202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbgBMJv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:51:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D016FB1F2;
        Thu, 13 Feb 2020 09:51:54 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] printk: Fix preferred console selection with multiple matches
Date:   Thu, 13 Feb 2020 10:51:32 +0100
Message-Id: <20200213095133.23176-3-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200213095133.23176-1-pmladek@suse.com>
References: <20200213095133.23176-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

In the following circumstances, the rule of selecting the console
corresponding to the last "console=" entry on the command line as
the preferred console (CON_CONSDEV, ie, /dev/console) fails. This
is a specific example, but it could happen with different consoles
that have a similar name aliasing mechanism.

  - The kernel command line has both console=tty0 and console=ttyS0
    in that order (the latter with speed etc... arguments).
    This is common with some cloud setups such as Amazon Linux.

  - add_preferred_console is called early to register "uart0". In
    our case that happens from acpi_parse_spcr() on arm64 since the
    "enable_console" argument is true on that architecture. This causes
    "uart0" to become entry 0 of the console_cmdline array.

Now, because of the above, what happens is:

  - add_preferred_console is called by the cmdline parsing for tty0
    and ttyS0 respectively, thus occupying entries 1 and 2 of the
    console_cmdline array (since this happens after ACPI SPCR parsing).
    At that point preferred_console is set to 2 as expected.

  - When the tty layer kicks in, it will call register_console for tty0.
    This will match entry 1 in console_cmdline array. It isn't our
    preferred console but because it's our only console at this point,
    it will end up "first" in the consoles list.

  - When 8250 probes the actual serial port later on, it calls
    register_console for ttyS0. At that point the loop in register_console
    tries to match it with the entries in the console_cmdline array.
    Ideally this should match ttyS0 in entry 2, which is preferred, causing
    it to be inserted first and to replace tty0 as CONSDEV. However, 8250
    provides a "match" hook in its struct console, and that hook will match
    "uart" as an alias to "ttyS". So we match uart0 at entry 0 in the array
    which is not the preferred console and will not match entry 2 which is
    since we break out of the loop on the first match. As a result,
    we don't set CONSDEV and don't insert it first, but second in
    the console list.

    As a result, we end up with tty0 remaining first in the array, and thus
    /dev/console going there instead of the last user specified one which
    is ttyS0.

This tentative fix register_console() to scan first for consoles
specified on the command line, and only if none is found, to then
scan for consoles specified by the architecture.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/console_cmdline.h |  1 +
 kernel/printk/printk.c          | 29 ++++++++++++++++++-----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/console_cmdline.h b/kernel/printk/console_cmdline.h
index 11f19c466af5..3ca74ad391d6 100644
--- a/kernel/printk/console_cmdline.h
+++ b/kernel/printk/console_cmdline.h
@@ -6,6 +6,7 @@ struct console_cmdline
 {
 	char	name[16];			/* Name of the driver	    */
 	int	index;				/* Minor dev. to use	    */
+	bool	user_specified;			/* Specified by command line vs. platform */
 	char	*options;			/* Options for the driver   */
 #ifdef CONFIG_A11Y_BRAILLE_CONSOLE
 	char	*brl_options;			/* Options for braille driver */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0ebcdf53e75d..f76ef3f0efca 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2116,7 +2116,7 @@ asmlinkage __visible void early_printk(const char *fmt, ...)
 #endif
 
 static int __add_preferred_console(char *name, int idx, char *options,
-				   char *brl_options)
+				   char *brl_options, bool user_specified)
 {
 	struct console_cmdline *c;
 	int i;
@@ -2131,6 +2131,8 @@ static int __add_preferred_console(char *name, int idx, char *options,
 		if (strcmp(c->name, name) == 0 && c->index == idx) {
 			if (!brl_options)
 				preferred_console = i;
+			if (user_specified)
+				c->user_specified = true;
 			return 0;
 		}
 	}
@@ -2140,6 +2142,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 		preferred_console = i;
 	strlcpy(c->name, name, sizeof(c->name));
 	c->options = options;
+	c->user_specified = user_specified;
 	braille_set_options(c, brl_options);
 
 	c->index = idx;
@@ -2194,7 +2197,7 @@ static int __init console_setup(char *str)
 	idx = simple_strtoul(s, NULL, 10);
 	*s = 0;
 
-	__add_preferred_console(buf, idx, options, brl_options);
+	__add_preferred_console(buf, idx, options, brl_options, true);
 	console_set_on_cmdline = 1;
 	return 1;
 }
@@ -2215,7 +2218,7 @@ __setup("console=", console_setup);
  */
 int add_preferred_console(char *name, int idx, char *options)
 {
-	return __add_preferred_console(name, idx, options, NULL);
+	return __add_preferred_console(name, idx, options, NULL, false);
 }
 
 bool console_suspend_enabled = true;
@@ -2636,7 +2639,7 @@ early_param("keep_bootcon", keep_bootcon_setup);
  * Care need to be taken with consoles that are statically
  * enabled such as netconsole
  */
-static int try_enable_new_console(struct console *newcon)
+static int try_enable_new_console(struct console *newcon, bool user_specified)
 {
 	struct console_cmdline *c;
 	int i;
@@ -2644,6 +2647,8 @@ static int try_enable_new_console(struct console *newcon)
 	for (i = 0, c = console_cmdline;
 	     i < MAX_CMDLINECONSOLES && c->name[0];
 	     i++, c++) {
+		if (c->user_specified != user_specified)
+			continue;
 		if (!newcon->match ||
 		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
 			/* default matching */
@@ -2673,9 +2678,10 @@ static int try_enable_new_console(struct console *newcon)
 
 	/*
 	 * Some consoles, such as pstore and netconsole, can be enabled even
-	 * without matching.
+	 * without matching. Accept the pre-enabled consoles only when match()
+	 * and setup() had a change to be called.
 	 */
-	if (newcon->flags & CON_ENABLED)
+	if (newcon->flags & CON_ENABLED && c->user_specified ==	user_specified)
 		return 0;
 
 	return -ENOENT;
@@ -2752,11 +2758,12 @@ void register_console(struct console *newcon)
 		}
 	}
 
-	/*
-	 * See if this console matches one we selected on
-	 * the command line or if it was statically enabled
-	 */
-	err = try_enable_new_console(newcon);
+	/* See if this console matches one we selected on the command line */
+	err = try_enable_new_console(newcon, true);
+
+	/* If not, try to match against the platform default(s) */
+	if (err == -ENOENT)
+		err = try_enable_new_console(newcon, false);
 
 	/* printk() messages are not printed to the Braille console. */
 	if (err || newcon->flags & CON_BRL)
-- 
2.16.4

