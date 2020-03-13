Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC2EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5E3206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgCMRrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:47:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47731 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgCMRrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:47:24 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jCoP3-00017r-Dx; Fri, 13 Mar 2020 18:47:21 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 8/9] lockdep: Annotate irq_work
Date:   Fri, 13 Mar 2020 18:47:00 +0100
Message-Id: <20200313174701.148376-9-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313174701.148376-1-bigeasy@linutronix.de>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark irq_work items with IRQ_WORK_HARD_IRQ which should be invoked in
hardirq context even on PREEMPT_RT. IRQ_WORK without this flag will be
invoked in softirq context on PREEMPT_RT.

Set ->irq_config to 1 for the IRQ_WORK items which are invoked in softirq
context so lockdep knows that these can safely acquire a spinlock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irq_work.h |  2 ++
 include/linux/irqflags.h | 13 +++++++++++++
 kernel/irq_work.c        |  2 ++
 kernel/rcu/tree.c        |  1 +
 kernel/time/tick-sched.c |  1 +
 5 files changed, 19 insertions(+)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 02da997ad12ce..3b752e80c017d 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -18,6 +18,8 @@
=20
 /* Doesn't want IPI, wait for tick: */
 #define IRQ_WORK_LAZY		BIT(2)
+/* Run hard IRQ context, even on RT */
+#define IRQ_WORK_HARD_IRQ	BIT(3)
=20
 #define IRQ_WORK_CLAIMED	(IRQ_WORK_PENDING | IRQ_WORK_BUSY)
=20
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 9c17f9c827aac..f23f540e0ebba 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -69,6 +69,17 @@ do {						\
 			current->irq_config =3D 0;	\
 	  } while (0)
=20
+# define lockdep_irq_work_enter(__work)					\
+	  do {								\
+		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+			current->irq_config =3D 1;			\
+	  } while (0)
+# define lockdep_irq_work_exit(__work)					\
+	  do {								\
+		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+			current->irq_config =3D 0;			\
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
=20
 #if defined(CONFIG_IRQSOFF_TRACER) || \
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 828cc30774bc4..48b5d1b6af4d3 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -153,7 +153,9 @@ static void irq_work_run_list(struct llist_head *list)
 		 */
 		flags =3D atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
=20
+		lockdep_irq_work_enter(work);
 		work->func(work);
+		lockdep_irq_work_exit(work);
 		/*
 		 * Clear the BUSY bit and return to the free state if
 		 * no-one else claimed it meanwhile.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d91c9156fab2e..5066d1dd30777 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1113,6 +1113,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *=
rdp)
 		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq !=3D rnp->gp_seq &&
 		    (rnp->ffmask & rdp->grpmask)) {
 			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
+			atomic_set(&rdp->rcu_iw.flags, IRQ_WORK_HARD_IRQ);
 			rdp->rcu_iw_pending =3D true;
 			rdp->rcu_iw_gp_seq =3D rnp->gp_seq;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 4be756b88a48e..3e2dc9b8858c7 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -245,6 +245,7 @@ static void nohz_full_kick_func(struct irq_work *work)
=20
 static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) =3D {
 	.func =3D nohz_full_kick_func,
+	.flags =3D ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
 };
=20
 /*
--=20
2.25.1

