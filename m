Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38793C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6F020786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m9pZXOsR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IA5mV85B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgH0H4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:56:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36744 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgH0Hya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:30 -0400
Date:   Thu, 27 Aug 2020 07:54:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GJ0AmpRzhk0Hi2kdoNAyyiBxBdZrB41FDdHi2Y21Jtw=;
        b=m9pZXOsRrp5ZO+HdQINIPcR9gtleQDzDtr/nnMJEI/6Eim5XudbubfqNMWJ+szd0Zhrzj6
        FPVBQ9VJ84Drx+GbcLOydKWKTA7HVDyG8o9MF/jRDvz/r8wH/JBYI25gE06T3qWr4zC0YP
        GSp6F7rh3VeoVEqq10NsGgrpmXiKiQv6/E5Sl00209FKiEmJai+DONwufIYkSDg3heJGNO
        IytAzRuWaKkF4vyiepcvT0Olc4oG+MqiDcGeERg1JBqP3c/pOwfKKbxLG+IC0HrpZm+eKX
        tndX8NjDWvMlfcRIStq/j4gnlyMPodnBpUgX46hBQE+i6SPrhsVMN+lKrsZoaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GJ0AmpRzhk0Hi2kdoNAyyiBxBdZrB41FDdHi2Y21Jtw=;
        b=IA5mV85Ba1wVhxKkzBgiCPXgo41xly4v7AHnXZR725I9gwUy/Wh77d8sh2oi9roSkXM/a3
        5YA3elxN6IBJRiAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Cleanup
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821085348.546087214@infradead.org>
References: <20200821085348.546087214@infradead.org>
MIME-Version: 1.0
Message-ID: <159851486636.20229.9494858646362997006.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     00b0ed2d4997af6d0a93edef820386951fd66d94
Gitweb:        https://git.kernel.org/tip/00b0ed2d4997af6d0a93edef820386951fd66d94
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 12 Aug 2020 19:28:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:54 +02:00

locking/lockdep: Cleanup

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200821085348.546087214@infradead.org
---
 include/linux/irqflags.h | 54 +++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index d7e50a2..00d553d 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -49,10 +49,11 @@ struct irqtrace_events {
 DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 
-  extern void trace_hardirqs_on_prepare(void);
-  extern void trace_hardirqs_off_finish(void);
-  extern void trace_hardirqs_on(void);
-  extern void trace_hardirqs_off(void);
+extern void trace_hardirqs_on_prepare(void);
+extern void trace_hardirqs_off_finish(void);
+extern void trace_hardirqs_on(void);
+extern void trace_hardirqs_off(void);
+
 # define lockdep_hardirq_context()	(raw_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
 # define lockdep_hardirqs_enabled()	(this_cpu_read(hardirqs_enabled))
@@ -120,17 +121,17 @@ do {						\
 #else
 # define trace_hardirqs_on_prepare()		do { } while (0)
 # define trace_hardirqs_off_finish()		do { } while (0)
-# define trace_hardirqs_on()		do { } while (0)
-# define trace_hardirqs_off()		do { } while (0)
-# define lockdep_hardirq_context()	0
-# define lockdep_softirq_context(p)	0
-# define lockdep_hardirqs_enabled()	0
-# define lockdep_softirqs_enabled(p)	0
-# define lockdep_hardirq_enter()	do { } while (0)
-# define lockdep_hardirq_threaded()	do { } while (0)
-# define lockdep_hardirq_exit()		do { } while (0)
-# define lockdep_softirq_enter()	do { } while (0)
-# define lockdep_softirq_exit()		do { } while (0)
+# define trace_hardirqs_on()			do { } while (0)
+# define trace_hardirqs_off()			do { } while (0)
+# define lockdep_hardirq_context()		0
+# define lockdep_softirq_context(p)		0
+# define lockdep_hardirqs_enabled()		0
+# define lockdep_softirqs_enabled(p)		0
+# define lockdep_hardirq_enter()		do { } while (0)
+# define lockdep_hardirq_threaded()		do { } while (0)
+# define lockdep_hardirq_exit()			do { } while (0)
+# define lockdep_softirq_enter()		do { } while (0)
+# define lockdep_softirq_exit()			do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)	false
 # define lockdep_hrtimer_exit(__context)	do { } while (0)
 # define lockdep_posixtimer_enter()		do { } while (0)
@@ -181,17 +182,25 @@ do {						\
  * if !TRACE_IRQFLAGS.
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
-#define local_irq_enable() \
-	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
-#define local_irq_disable() \
-	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
+
+#define local_irq_enable()				\
+	do {						\
+		trace_hardirqs_on();			\
+		raw_local_irq_enable();			\
+	} while (0)
+
+#define local_irq_disable()				\
+	do {						\
+		raw_local_irq_disable();		\
+		trace_hardirqs_off();			\
+	} while (0)
+
 #define local_irq_save(flags)				\
 	do {						\
 		raw_local_irq_save(flags);		\
 		trace_hardirqs_off();			\
 	} while (0)
 
-
 #define local_irq_restore(flags)			\
 	do {						\
 		if (raw_irqs_disabled_flags(flags)) {	\
@@ -214,10 +223,7 @@ do {						\
 
 #define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
 #define local_irq_disable()	do { raw_local_irq_disable(); } while (0)
-#define local_irq_save(flags)					\
-	do {							\
-		raw_local_irq_save(flags);			\
-	} while (0)
+#define local_irq_save(flags)	do { raw_local_irq_save(flags); } while (0)
 #define local_irq_restore(flags) do { raw_local_irq_restore(flags); } while (0)
 #define safe_halt()		do { raw_safe_halt(); } while (0)
 
