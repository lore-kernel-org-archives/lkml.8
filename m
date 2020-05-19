Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51555C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C040207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgESTxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgESTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745A3C08C5C0;
        Tue, 19 May 2020 12:52:40 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Hw-0007p8-ML; Tue, 19 May 2020 21:52:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 373FD1C047E;
        Tue, 19 May 2020 21:52:32 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:32 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Provide rcu_irq_exit_preempt()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134904.364456424@linutronix.de>
References: <20200505134904.364456424@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795212.17951.14774229487753958998.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8ae0ae6737ad449c8ae21e2bb01d9736f360a933
Gitweb:        https://git.kernel.org/tip/8ae0ae6737ad449c8ae21e2bb01d9736f360a933
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 03 May 2020 15:08:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:51:21 +02:00

rcu: Provide rcu_irq_exit_preempt()

Interrupts and exceptions invoke rcu_irq_enter() on entry and need to
invoke rcu_irq_exit() before they either return to the interrupted code or
invoke the scheduler due to preemption.

The general assumption is that RCU idle code has to have preemption
disabled so that a return from interrupt cannot schedule. So the return
from interrupt code invokes rcu_irq_exit() and preempt_schedule_irq().

If there is any imbalance in the rcu_irq/nmi* invocations or RCU idle code
had preemption enabled then this goes unnoticed until the CPU goes idle or
some other RCU check is executed.

Provide rcu_irq_exit_preempt() which can be invoked from the
interrupt/exception return code in case that preemption is enabled. It
invokes rcu_irq_exit() and contains a few sanity checks in case that
CONFIG_PROVE_RCU is enabled to catch such issues directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134904.364456424@linutronix.de


---
 include/linux/rcutiny.h |  1 +
 include/linux/rcutree.h |  1 +
 kernel/rcu/tree.c       | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 3465ba7..980eb78 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -71,6 +71,7 @@ static inline void rcu_irq_enter(void) { }
 static inline void rcu_irq_exit_irqson(void) { }
 static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
+static inline void rcu_irq_exit_preempt(void) { }
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index fbc2627..02016e0 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -47,6 +47,7 @@ void rcu_idle_enter(void);
 void rcu_idle_exit(void);
 void rcu_irq_enter(void);
 void rcu_irq_exit(void);
+void rcu_irq_exit_preempt(void);
 void rcu_irq_enter_irqson(void);
 void rcu_irq_exit_irqson(void);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9454016..62ee012 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -743,6 +743,28 @@ void noinstr rcu_irq_exit(void)
 	rcu_nmi_exit();
 }
 
+/**
+ * rcu_irq_exit_preempt - Inform RCU that current CPU is exiting irq
+ *			  towards in kernel preemption
+ *
+ * Same as rcu_irq_exit() but has a sanity check that scheduling is safe
+ * from RCU point of view. Invoked from return from interrupt before kernel
+ * preemption.
+ */
+void rcu_irq_exit_preempt(void)
+{
+	lockdep_assert_irqs_disabled();
+	rcu_nmi_exit();
+
+	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) <= 0,
+			 "RCU dynticks_nesting counter underflow/zero!");
+	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) !=
+			 DYNTICK_IRQ_NONIDLE,
+			 "Bad RCU  dynticks_nmi_nesting counter\n");
+	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
+			 "RCU in extended quiescent state!");
+}
+
 /*
  * Wrapper for rcu_irq_exit() where interrupts are enabled.
  *
