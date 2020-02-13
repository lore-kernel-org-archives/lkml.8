Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D873FC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E762073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgBMJv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:51:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:41218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729805AbgBMJv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:51:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 381B5B240;
        Thu, 13 Feb 2020 09:51:56 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] printk: Correctly set CON_CONSDEV even when preferred console was not registered
Date:   Thu, 13 Feb 2020 10:51:33 +0100
Message-Id: <20200213095133.23176-4-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200213095133.23176-1-pmladek@suse.com>
References: <20200213095133.23176-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

CON_CONSDEV flag was historically used to put/keep the preferred console
first in console_drivers list. Where the preferred console is the last
on the command line.

The ordering is important only when opening /dev/console:

  + tty_kopen()
    + tty_lookup_driver()
      + console_device()

The flag was originally an implementation detail. But it was later
made accessible from userspace via /proc/consoles. It was used,
for example, by the tool "showconsole" to show the real tty
accessible via /dev/console, see
https://github.com/bitstreamout/showconsole

Now, the current code sets CON_CONSDEV only for the preferred
console or when a fallback console is added. The flag is not
set when the preferred console is defined on the command line
but it is not registered from some reasons.

Simple solution is to set CON_CONSDEV flag for the first
registered console. It will work most of the time because:

  + Most real consoles have console->device defined.

  + Boot consoles are removed in printk_late_init().

  + unregister_console() moves CON_CONSDEV flag to the next
    console.

Clean solution would require checking con->device when the
preferred console is registered and in unregister_console().

Conclusion:

Use the simple solution for now. It is better than the current
state and good enough.

The clean solution is not worth it. It would complicate the already
complicated code without too much gain. Instead the code would deserve
a complete rewrite.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[pmladek@suse.com: Correct reasoning in the commit message, comment update.]
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 2 +-
 kernel/printk/printk.c  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index f33016b3a401..57ae2dedb51f 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -134,7 +134,7 @@ static inline int con_debug_leave(void)
  */
 
 #define CON_PRINTBUFFER	(1)
-#define CON_CONSDEV	(2) /* Last on the command line */
+#define CON_CONSDEV	(2) /* Preferred console, /dev/console */
 #define CON_ENABLED	(4)
 #define CON_BOOT	(8)
 #define CON_ANYTIME	(16) /* Safe to call when cpu is offline */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f76ef3f0efca..cf0ceacdae2f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2788,6 +2788,8 @@ void register_console(struct console *newcon)
 		console_drivers = newcon;
 		if (newcon->next)
 			newcon->next->flags &= ~CON_CONSDEV;
+		/* Ensure this flag is always set for the head of the list */
+		newcon->flags |= CON_CONSDEV;
 	} else {
 		newcon->next = console_drivers->next;
 		console_drivers->next = newcon;
-- 
2.16.4

