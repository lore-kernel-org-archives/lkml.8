Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E76C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33EF20781
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCUPxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:53:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39005 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgCUPxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:53:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFgRW-0005QM-CU; Sat, 21 Mar 2020 16:53:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F2DDC1C22EE;
        Sat, 21 Mar 2020 16:53:45 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:53:45 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Add hrtimer context tracing bits
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321113242.534508206@linutronix.de>
References: <20200321113242.534508206@linutronix.de>
MIME-Version: 1.0
Message-ID: <158480602563.28353.10602717934482974041.tip-bot2@tip-bot2>
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

Commit-ID:     40db173965c05a1d803451240ed41707d5bd978d
Gitweb:        https://git.kernel.org/tip/40db173965c05a1d803451240ed41707d5bd978d
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sat, 21 Mar 2020 12:26:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Mar 2020 16:00:24 +01:00

lockdep: Add hrtimer context tracing bits

Set current->irq_config = 1 for hrtimers which are not marked to expire in
hard interrupt context during hrtimer_init(). These timers will expire in
softirq context on PREEMPT_RT.

Setting this allows lockdep to differentiate these timers. If a timer is
marked to expire in hard interrupt context then the timer callback is not
supposed to acquire a regular spinlock instead of a raw_spinlock in the
expiry callback.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200321113242.534508206@linutronix.de
---
 include/linux/irqflags.h | 15 +++++++++++++++
 include/linux/sched.h    |  1 +
 kernel/locking/lockdep.c |  2 +-
 kernel/time/hrtimer.c    |  6 +++++-
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index fdaf286..9c17f9c 100644
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
+			current->irq_config = 1;	\
+	  } while (0)
+
+# define lockdep_hrtimer_exit(__hrtimer)		\
+	  do {						\
+		  if (!__hrtimer->is_hard)		\
+			current->irq_config = 0;	\
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
 
 #if defined(CONFIG_IRQSOFF_TRACER) || \
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4d3b9ec..933914c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -983,6 +983,7 @@ struct task_struct {
 	unsigned int			softirq_enable_event;
 	int				softirqs_enabled;
 	int				softirq_context;
+	int				irq_config;
 #endif
 
 #ifdef CONFIG_LOCKDEP
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6b9f9f3..0ebf980 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4025,7 +4025,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 		/*
 		 * Check if force_irqthreads will run us threaded.
 		 */
-		if (curr->hardirq_threaded)
+		if (curr->hardirq_threaded || curr->irq_config)
 			curr_inner = LD_WAIT_CONFIG;
 		else
 			curr_inner = LD_WAIT_SPIN;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3a609e7..8cce725 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1404,7 +1404,7 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 	base = softtimer ? HRTIMER_MAX_CLOCK_BASES / 2 : 0;
 	base += hrtimer_clockid_to_base(clock_id);
 	timer->is_soft = softtimer;
-	timer->is_hard = !softtimer;
+	timer->is_hard = !!(mode & HRTIMER_MODE_HARD);
 	timer->base = &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
 }
@@ -1514,7 +1514,11 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	 */
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 	trace_hrtimer_expire_entry(timer, now);
+	lockdep_hrtimer_enter(timer);
+
 	restart = fn(timer);
+
+	lockdep_hrtimer_exit(timer);
 	trace_hrtimer_expire_exit(timer);
 	raw_spin_lock_irq(&cpu_base->lock);
 
