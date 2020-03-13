Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2FCC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD58206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCMRr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:47:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47725 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgCMRrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:47:23 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jCoP2-00017r-Tg; Fri, 13 Mar 2020 18:47:21 +0100
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
Subject: [PATCH 7/9] lockdep: Add hrtimer context tracing bits
Date:   Fri, 13 Mar 2020 18:46:59 +0100
Message-Id: <20200313174701.148376-8-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313174701.148376-1-bigeasy@linutronix.de>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set current->irq_config =3D 1 for hrtimers which are not marked to expire in
hard interrupt context during hrtimer_init(). These timers will expire in
softirq context on PREEMPT_RT.

Setting this allows lockdep to differentiate these timers. If a timer is
marked to expire in hard interrupt context then the timer callback is not
supposed to acquire a regular spinlock instead of a raw_spinlock in the
expiry callback.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irqflags.h | 15 +++++++++++++++
 include/linux/sched.h    |  1 +
 kernel/locking/lockdep.c |  2 +-
 kernel/time/hrtimer.c    |  6 +++++-
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index fdaf28601cbe1..9c17f9c827aac 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -56,6 +56,19 @@ do {						\
 do {						\
 	current->softirq_context--;		\
 } while (0)
+
+# define lockdep_hrtimer_enter(__hrtimer)		\
+	  do {						\
+		  if (!__hrtimer->is_hard)		\
+			current->irq_config =3D 1;	\
+	  } while (0)
+
+# define lockdep_hrtimer_exit(__hrtimer)		\
+	  do {						\
+		  if (!__hrtimer->is_hard)		\
+			current->irq_config =3D 0;	\
+	  } while (0)
+
 #else
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
@@ -68,6 +81,8 @@ do {						\
 # define trace_hardirq_exit()		do { } while (0)
 # define lockdep_softirq_enter()	do { } while (0)
 # define lockdep_softirq_exit()		do { } while (0)
+# define lockdep_hrtimer_enter(__hrtimer)		do { } while (0)
+# define lockdep_hrtimer_exit(__hrtimer)		do { } while (0)
 #endif
=20
 #if defined(CONFIG_IRQSOFF_TRACER) || \
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4d3b9ecce0742..933914cdf2197 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -983,6 +983,7 @@ struct task_struct {
 	unsigned int			softirq_enable_event;
 	int				softirqs_enabled;
 	int				softirq_context;
+	int				irq_config;
 #endif
=20
 #ifdef CONFIG_LOCKDEP
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4a9abf8bd9d15..df74531fd9f85 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3879,7 +3879,7 @@ static int check_wait_context(struct task_struct *cur=
r, struct held_lock *next)
 		/*
 		 * Check if force_irqthreads will run us threaded.
 		 */
-		if (curr->hardirq_threaded)
+		if (curr->hardirq_threaded || curr->irq_config)
 			curr_inner =3D LD_WAIT_CONFIG;
 		else
 			curr_inner =3D LD_WAIT_SPIN;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3a609e7344f3d..8cce72501aea5 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1404,7 +1404,7 @@ static void __hrtimer_init(struct hrtimer *timer, clo=
ckid_t clock_id,
 	base =3D softtimer ? HRTIMER_MAX_CLOCK_BASES / 2 : 0;
 	base +=3D hrtimer_clockid_to_base(clock_id);
 	timer->is_soft =3D softtimer;
-	timer->is_hard =3D !softtimer;
+	timer->is_hard =3D !!(mode & HRTIMER_MODE_HARD);
 	timer->base =3D &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
 }
@@ -1514,7 +1514,11 @@ static void __run_hrtimer(struct hrtimer_cpu_base *c=
pu_base,
 	 */
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 	trace_hrtimer_expire_entry(timer, now);
+	lockdep_hrtimer_enter(timer);
+
 	restart =3D fn(timer);
+
+	lockdep_hrtimer_exit(timer);
 	trace_hrtimer_expire_exit(timer);
 	raw_spin_lock_irq(&cpu_base->lock);
=20
--=20
2.25.1

