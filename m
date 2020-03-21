Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EF5C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6908520757
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgCUPxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:53:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39001 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCUPxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:53:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFgRV-0005Pv-Tz; Sat, 21 Mar 2020 16:53:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8107D1C22EF;
        Sat, 21 Mar 2020 16:53:45 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:53:45 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Annotate irq_work
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321113242.643576700@linutronix.de>
References: <20200321113242.643576700@linutronix.de>
MIME-Version: 1.0
Message-ID: <158480602510.28353.4851999853077941579.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     49915ac35ca7b07c54295a72d905be5064afb89e
Gitweb:        https://git.kernel.org/tip/49915ac35ca7b07c54295a72d905be5064afb89e
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sat, 21 Mar 2020 12:26:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Mar 2020 16:00:24 +01:00

lockdep: Annotate irq_work

Mark irq_work items with IRQ_WORK_HARD_IRQ which should be invoked in
hardirq context even on PREEMPT_RT. IRQ_WORK without this flag will be
invoked in softirq context on PREEMPT_RT.

Set ->irq_config to 1 for the IRQ_WORK items which are invoked in softirq
context so lockdep knows that these can safely acquire a spinlock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200321113242.643576700@linutronix.de
---
 include/linux/irq_work.h |  2 ++
 include/linux/irqflags.h | 13 +++++++++++++
 kernel/irq_work.c        |  2 ++
 kernel/rcu/tree.c        |  1 +
 kernel/time/tick-sched.c |  1 +
 5 files changed, 19 insertions(+)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 02da997..3b752e8 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -18,6 +18,8 @@
 
 /* Doesn't want IPI, wait for tick: */
 #define IRQ_WORK_LAZY		BIT(2)
+/* Run hard IRQ context, even on RT */
+#define IRQ_WORK_HARD_IRQ	BIT(3)
 
 #define IRQ_WORK_CLAIMED	(IRQ_WORK_PENDING | IRQ_WORK_BUSY)
 
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 9c17f9c..f23f540 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -69,6 +69,17 @@ do {						\
 			current->irq_config = 0;	\
 	  } while (0)
 
+# define lockdep_irq_work_enter(__work)					\
+	  do {								\
+		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+			current->irq_config = 1;			\
+	  } while (0)
+# define lockdep_irq_work_exit(__work)					\
+	  do {								\
+		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+			current->irq_config = 0;			\
+	  } while (0)
+
 #else
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
@@ -83,6 +94,8 @@ do {						\
 # define lockdep_softirq_exit()		do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)		do { } while (0)
 # define lockdep_hrtimer_exit(__hrtimer)		do { } while (0)
+# define lockdep_irq_work_enter(__work)		do { } while (0)
+# define lockdep_irq_work_exit(__work)		do { } while (0)
 #endif
 
 #if defined(CONFIG_IRQSOFF_TRACER) || \
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 828cc30..48b5d1b 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -153,7 +153,9 @@ static void irq_work_run_list(struct llist_head *list)
 		 */
 		flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
 
+		lockdep_irq_work_enter(work);
 		work->func(work);
+		lockdep_irq_work_exit(work);
 		/*
 		 * Clear the BUSY bit and return to the free state if
 		 * no-one else claimed it meanwhile.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d91c915..5066d1d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1113,6 +1113,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
 		    (rnp->ffmask & rdp->grpmask)) {
 			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
+			atomic_set(&rdp->rcu_iw.flags, IRQ_WORK_HARD_IRQ);
 			rdp->rcu_iw_pending = true;
 			rdp->rcu_iw_gp_seq = rnp->gp_seq;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 4be756b..3e2dc9b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -245,6 +245,7 @@ static void nohz_full_kick_func(struct irq_work *work)
 
 static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
 	.func = nohz_full_kick_func,
+	.flags = ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
 };
 
 /*
