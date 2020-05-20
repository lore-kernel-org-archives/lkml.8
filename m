Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012F8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE401207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgETKWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:22:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:36640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgETKWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:22:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 29739AEC2;
        Wed, 20 May 2020 10:22:37 +0000 (UTC)
Date:   Wed, 20 May 2020 12:22:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v2] printk/kdb: Redirect printk messages into kdb in any
 context
Message-ID: <20200520102233.GC3464@linux-b0ei>
References: <20200512142533.ta4uejwmq5gchtlx@holly.lan>
 <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei>
 <20200515103308.GD42471@jagdpanzerIV.localdomain>
 <20200515134806.5cw4xxnxw7k3223l@holly.lan>
 <20200518092139.GK7340@linux-b0ei>
 <20200520042102.GA938@jagdpanzerIV.localdomain>
 <20200520093557.lwwxnhvgmacipdce@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520093557.lwwxnhvgmacipdce@holly.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdb has to get messages on consoles even when the system is stopped.
It uses kdb_printf() internally and calls console drivers on its own.

It uses a hack to reuse an existing code. It sets "kdb_trap_printk"
global variable to redirect even the normal printk() into the
kdb_printf() variant.

The variable "kdb_trap_printk" is checked in printk_default() and
it is ignored when printk is redirected to printk_safe in NMI context.
Solve this by moving the check into printk_func().

It is obvious that it is not fully safe. But it does not make things
worse. The console drivers are already called in this context by
db_printf() direct calls.

Reported-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
Changes in v2:

   + more detailed commit message

 kernel/printk/printk.c      | 14 +-------------
 kernel/printk/printk_safe.c |  7 +++++++
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9a9b6156270b..63a1aa377cd9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -35,7 +35,6 @@
 #include <linux/memblock.h>
 #include <linux/syscalls.h>
 #include <linux/crash_core.h>
-#include <linux/kdb.h>
 #include <linux/ratelimit.h>
 #include <linux/kmsg_dump.h>
 #include <linux/syslog.h>
@@ -2036,18 +2035,7 @@ EXPORT_SYMBOL(vprintk);
 
 int vprintk_default(const char *fmt, va_list args)
 {
-	int r;
-
-#ifdef CONFIG_KGDB_KDB
-	/* Allow to pass printk() to kdb but avoid a recursion. */
-	if (unlikely(kdb_trap_printk && kdb_printf_cpu < 0)) {
-		r = vkdb_printf(KDB_MSGSRC_PRINTK, fmt, args);
-		return r;
-	}
-#endif
-	r = vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
-
-	return r;
+	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
 }
 EXPORT_SYMBOL_GPL(vprintk_default);
 
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index d9a659a686f3..7ccb821d0bfe 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -6,6 +6,7 @@
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
 #include <linux/debug_locks.h>
+#include <linux/kdb.h>
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/irq_work.h>
@@ -359,6 +360,12 @@ void __printk_safe_exit(void)
 
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 {
+#ifdef CONFIG_KGDB_KDB
+	/* Allow to pass printk() to kdb but avoid a recursion. */
+	if (unlikely(kdb_trap_printk && kdb_printf_cpu < 0))
+		return vkdb_printf(KDB_MSGSRC_PRINTK, fmt, args);
+#endif
+
 	/*
 	 * Try to use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
-- 
2.26.1

