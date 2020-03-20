Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B705C43332
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C5A20732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="knKwlyuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCTMAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:00:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgCTMAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4nnC3lXdddNEztIbyx6EUAhPT+l/MRH+EZ3xJd0wnu8=; b=knKwlyuzmJda2Bip6b9c+wdk/A
        8yei5A2a3CFcUr9KD6yYLRqAY7yHd2ZRRI/Cw6QKICQWCfiI8flZSrKtcNiAknX3I10qT3/RVJOSn
        ve/dFs5Hh7n+9Bp/A46KGxD//Dnu/8/ACdoRrCzmsnSbw8Jfgbtz1cTEjxm3FU167v19SheGShjwH
        v87ULjsGx6DBSX8zg/eQsrOiWdmflhGa44pxpRcE6quUuaYH+JaucnhhrJD4VnMllx82quU6uvYGX
        cX2/1ufkQLMtj2vFCn+lSKYnRRp/tgcUw7QOWOP3hNrRXzfeyQWF1gDz/zlyRhQmNV/utdRbfCMwm
        OVBzrAwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFGK8-0004CL-5K; Fri, 20 Mar 2020 12:00:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9BCA3012C3;
        Fri, 20 Mar 2020 13:00:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7B35D2858D591; Fri, 20 Mar 2020 13:00:21 +0100 (CET)
Message-Id: <20200320115859.060481361@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 12:56:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, rostedt@goodmis.org, mingo@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, will@kernel.org, peterz@infradead.org
Subject: [PATCH 2/4] lockdep: Rename trace_hardirq_{enter,exit}()
References: <20200320115638.737385408@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Continue what commit:

  d820ac4c2fa8 ("locking: rename trace_softirq_[enter|exit] => lockdep_softirq_[enter|exit]")

started, rename these to avoid confusing them with tracepoints.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/hardirq.h        |    8 ++++----
 include/linux/irqflags.h       |    8 ++++----
 kernel/softirq.c               |    7 ++++---
 tools/include/linux/irqflags.h |    4 ++--
 4 files changed, 14 insertions(+), 13 deletions(-)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -37,7 +37,7 @@ extern void rcu_nmi_exit(void);
 	do {						\
 		account_irq_enter_time(current);	\
 		preempt_count_add(HARDIRQ_OFFSET);	\
-		trace_hardirq_enter();			\
+		lockdep_hardirq_enter();		\
 	} while (0)
 
 /*
@@ -50,7 +50,7 @@ extern void irq_enter(void);
  */
 #define __irq_exit()					\
 	do {						\
-		trace_hardirq_exit();			\
+		lockdep_hardirq_exit();			\
 		account_irq_exit_time(current);		\
 		preempt_count_sub(HARDIRQ_OFFSET);	\
 	} while (0)
@@ -74,12 +74,12 @@ extern void irq_exit(void);
 		BUG_ON(in_nmi());				\
 		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		rcu_nmi_enter();				\
-		trace_hardirq_enter();				\
+		lockdep_hardirq_enter();			\
 	} while (0)
 
 #define nmi_exit()						\
 	do {							\
-		trace_hardirq_exit();				\
+		lockdep_hardirq_exit();				\
 		rcu_nmi_exit();					\
 		BUG_ON(!in_nmi());				\
 		preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -37,11 +37,11 @@
 # define trace_softirq_context(p)	((p)->softirq_context)
 # define trace_hardirqs_enabled(p)	((p)->hardirqs_enabled)
 # define trace_softirqs_enabled(p)	((p)->softirqs_enabled)
-# define trace_hardirq_enter()			\
+# define lockdep_hardirq_enter()		\
 do {						\
 	current->hardirq_context++;		\
 } while (0)
-# define trace_hardirq_exit()			\
+# define lockdep_hardirq_exit()			\
 do {						\
 	current->hardirq_context--;		\
 } while (0)
@@ -62,8 +62,8 @@ do {						\
 # define trace_softirq_context(p)	0
 # define trace_hardirqs_enabled(p)	0
 # define trace_softirqs_enabled(p)	0
-# define trace_hardirq_enter()		do { } while (0)
-# define trace_hardirq_exit()		do { } while (0)
+# define lockdep_hardirq_enter()	do { } while (0)
+# define lockdep_hardirq_exit()		do { } while (0)
 # define lockdep_softirq_enter()	do { } while (0)
 # define lockdep_softirq_exit()		do { } while (0)
 #endif
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -226,7 +226,7 @@ static inline bool lockdep_softirq_start
 
 	if (trace_hardirq_context(current)) {
 		in_hardirq = true;
-		trace_hardirq_exit();
+		lockdep_hardirq_exit();
 	}
 
 	lockdep_softirq_enter();
@@ -239,7 +239,7 @@ static inline void lockdep_softirq_end(b
 	lockdep_softirq_exit();
 
 	if (in_hardirq)
-		trace_hardirq_enter();
+		lockdep_hardirq_enter();
 }
 #else
 static inline bool lockdep_softirq_start(void) { return false; }
@@ -414,7 +414,8 @@ void irq_exit(void)
 
 	tick_irq_exit();
 	rcu_irq_exit();
-	trace_hardirq_exit(); /* must be last! */
+	 /* must be last! */
+	lockdep_hardirq_exit();
 }
 
 /*
--- a/tools/include/linux/irqflags.h
+++ b/tools/include/linux/irqflags.h
@@ -6,8 +6,8 @@
 # define trace_softirq_context(p)	0
 # define trace_hardirqs_enabled(p)	0
 # define trace_softirqs_enabled(p)	0
-# define trace_hardirq_enter()		do { } while (0)
-# define trace_hardirq_exit()		do { } while (0)
+# define lockdep_hardirq_enter()	do { } while (0)
+# define lockdep_hardirq_exit()		do { } while (0)
 # define lockdep_softirq_enter()	do { } while (0)
 # define lockdep_softirq_exit()		do { } while (0)
 # define INIT_TRACE_IRQFLAGS


