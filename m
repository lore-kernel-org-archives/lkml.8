Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3BEC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA75120786
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbgCUPae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:30:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38860 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgCUPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg51-0004wK-6C; Sat, 21 Mar 2020 16:30:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B640C1C22E6;
        Sat, 21 Mar 2020 16:30:30 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:30 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] lockdep: Rename trace_hardirq_{enter,exit}()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320115859.060481361@infradead.org>
References: <20200320115859.060481361@infradead.org>
MIME-Version: 1.0
Message-ID: <158480463041.28353.16689826264585245749.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     2502ec37a7b228b34c1e2e89480f98b92f53046a
Gitweb:        https://git.kernel.org/tip/2502ec37a7b228b34c1e2e89480f98b92f53046a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 12:56:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:53 +01:00

lockdep: Rename trace_hardirq_{enter,exit}()

Continue what commit:

  d820ac4c2fa8 ("locking: rename trace_softirq_[enter|exit] => lockdep_softirq_[enter|exit]")

started, rename these to avoid confusing them with tracepoints.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200320115859.060481361@infradead.org

---
 include/linux/hardirq.h        | 8 ++++----
 include/linux/irqflags.h       | 8 ++++----
 kernel/softirq.c               | 7 ++++---
 tools/include/linux/irqflags.h | 4 ++--
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index da0af63..7c8b82f 100644
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
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 21619c9..7c4e645 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -35,11 +35,11 @@
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
@@ -58,8 +58,8 @@ do {						\
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
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 0427a86..b328689 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -226,7 +226,7 @@ static inline bool lockdep_softirq_start(void)
 
 	if (trace_hardirq_context(current)) {
 		in_hardirq = true;
-		trace_hardirq_exit();
+		lockdep_hardirq_exit();
 	}
 
 	lockdep_softirq_enter();
@@ -239,7 +239,7 @@ static inline void lockdep_softirq_end(bool in_hardirq)
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
diff --git a/tools/include/linux/irqflags.h b/tools/include/linux/irqflags.h
index e734da3..ced6f64 100644
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
