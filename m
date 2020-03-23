Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB85C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7937D20732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584934355;
	bh=dEwDTB7aI50sp41aasePK2wzlJCiouMLZUIKc+5DTdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jiYir/uUWflzYx7pxUsJ7PpvBQyvWdiO7vDHO8T2sm9DHtpgqlfOyPJm8z3hPbU9N
	 PRM3FP6jnS6rEeHoQmceFbhhl7ytVdX7/h/8vlPhkDNsvfXocs0v4/ehJb7vC4662t
	 g9t2aCxaKP0+BwhdtHAy3rYV+hXD2DGI9adYfcHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgCWDcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 23:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgCWDcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 23:32:24 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5B2B20753;
        Mon, 23 Mar 2020 03:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584934343;
        bh=dEwDTB7aI50sp41aasePK2wzlJCiouMLZUIKc+5DTdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XdVx7sHZ0RGXKivqHch2Tp6V6bRB0tyo94rVXHt9s+6DcyDB/XcVS4J838/JRSMLJ
         FLaHssrIVazo1ahtHvTHVIx1StnLWcfAjuWA4vs3ASVyyyDkgbGGkWT1w09KWVrreU
         lAU5MrDa6BY8rfOs9RaaoK4i0c4e6uHwbTLnDjOg=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 2/3] lockdep: Merge hardirq_threaded and irq_config together
Date:   Mon, 23 Mar 2020 04:32:06 +0100
Message-Id: <20200323033207.32370-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200323033207.32370-1-frederic@kernel.org>
References: <20200323033207.32370-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fields describe the same state: a code block running in hardirq
that might be threaded under specific configurations.

Merge them together in the same field. Also rename the result as
"hardirq_threadable" as we are talking about a possible state and not
an actual one.

While at it remove the posix cpu timer lockdep functions since we can
call into trace_hardirq_[un]threadable() directly. The need for hrtimer
binders is debatable as well.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irqflags.h       | 70 ++++++++++++++--------------------
 include/linux/sched.h          |  3 +-
 kernel/irq/handle.c            |  4 +-
 kernel/locking/lockdep.c       |  2 +-
 kernel/time/posix-cpu-timers.c |  6 +--
 5 files changed, 35 insertions(+), 50 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 28481702460e..f69f93839760 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -45,14 +45,14 @@ do {						\
 	current->hardirq_context--;		\
 } while (0)
 
-# define trace_hardirq_threaded()		\
+# define trace_hardirq_threadable()		\
 do {						\
-	current->hardirq_threaded = 1;		\
+	current->hardirq_threadable = 1;	\
 } while (0)
 
-# define trace_hardirq_unthreaded()		\
+# define trace_hardirq_unthreadable()		\
 do {						\
-	current->hardirq_threaded = 0;		\
+	current->hardirq_threadable = 0;	\
 } while (0)
 
 # define lockdep_softirq_enter()		\
@@ -64,38 +64,16 @@ do {						\
 	current->softirq_context--;		\
 } while (0)
 
-# define lockdep_hrtimer_enter(__hrtimer)		\
-	  do {						\
-		  if (!__hrtimer->is_hard)		\
-			current->irq_config = 1;	\
-	  } while (0)
-
-# define lockdep_hrtimer_exit(__hrtimer)		\
-	  do {						\
-		  if (!__hrtimer->is_hard)		\
-			current->irq_config = 0;	\
-	  } while (0)
-
-# define lockdep_posixtimer_enter()				\
-	  do {							\
-		  current->irq_config = 1;			\
-	  } while (0)
-
-# define lockdep_posixtimer_exit()				\
-	  do {							\
-		  current->irq_config = 0;			\
-	  } while (0)
-
 # define lockdep_irq_work_enter(__work)					\
-	  do {								\
-		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
-			current->irq_config = 1;			\
-	  } while (0)
+do {									\
+	if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))		\
+		trace_hardirq_threadable();				\
+} while (0)
 # define lockdep_irq_work_exit(__work)					\
-	  do {								\
-		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
-			current->irq_config = 0;			\
-	  } while (0)
+do {									\
+	if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))		\
+		trace_hardirq_unthreadable();				\
+} while (0)
 
 #else
 # define trace_hardirqs_on()		do { } while (0)
@@ -106,18 +84,26 @@ do {						\
 # define trace_softirqs_enabled(p)	0
 # define trace_hardirq_enter()		do { } while (0)
 # define trace_hardirq_exit()		do { } while (0)
-# define trace_hardirq_threaded()	do { } while (0)
-# define trace_hardirq_unthreaded()	do { } while (0)
+# define trace_hardirq_threadable()	do { } while (0)
+# define trace_hardirq_unthreadable()	do { } while (0)
 # define lockdep_softirq_enter()	do { } while (0)
 # define lockdep_softirq_exit()		do { } while (0)
-# define lockdep_hrtimer_enter(__hrtimer)		do { } while (0)
-# define lockdep_hrtimer_exit(__hrtimer)		do { } while (0)
-# define lockdep_posixtimer_enter()		do { } while (0)
-# define lockdep_posixtimer_exit()		do { } while (0)
-# define lockdep_irq_work_enter(__work)		do { } while (0)
-# define lockdep_irq_work_exit(__work)		do { } while (0)
+# define lockdep_irq_work_enter(__work)	do { } while (0)
+# define lockdep_irq_work_exit(__work)	do { } while (0)
 #endif
 
+# define lockdep_hrtimer_enter(__hrtimer)	\
+do {						\
+	if (!__hrtimer->is_hard)		\
+		trace_hardirq_threadable();	\
+} while (0)
+
+# define lockdep_hrtimer_exit(__hrtimer)	\
+do {						\
+	if (!__hrtimer->is_hard)		\
+		trace_hardirq_unthreadable();	\
+} while (0)
+
 #if defined(CONFIG_IRQSOFF_TRACER) || \
 	defined(CONFIG_PREEMPT_TRACER)
  extern void stop_critical_timings(void);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 933914cdf219..9918d23b53e7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -970,7 +970,7 @@ struct task_struct {
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	unsigned int			irq_events;
-	unsigned int			hardirq_threaded;
+	unsigned int			hardirq_threadable;
 	unsigned long			hardirq_enable_ip;
 	unsigned long			hardirq_disable_ip;
 	unsigned int			hardirq_enable_event;
@@ -983,7 +983,6 @@ struct task_struct {
 	unsigned int			softirq_enable_event;
 	int				softirqs_enabled;
 	int				softirq_context;
-	int				irq_config;
 #endif
 
 #ifdef CONFIG_LOCKDEP
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 39d6cf9f5853..55405879b8ad 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -153,14 +153,14 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
 			      !(action->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT)));
 
 		if (threadable)
-			trace_hardirq_threaded();
+			trace_hardirq_threadable();
 
 		trace_irq_handler_entry(irq, action);
 		res = action->handler(irq, action->dev_id);
 		trace_irq_handler_exit(irq, action, res);
 
 		if (threadable)
-			trace_hardirq_unthreaded();
+			trace_hardirq_unthreadable();
 
 		if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pS enabled interrupts\n",
 			      irq, action->handler))
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0ebf9807d971..1cebaeb790a0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4025,7 +4025,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 		/*
 		 * Check if force_irqthreads will run us threaded.
 		 */
-		if (curr->hardirq_threaded || curr->irq_config)
+		if (curr->hardirq_threadable)
 			curr_inner = LD_WAIT_CONFIG;
 		else
 			curr_inner = LD_WAIT_SPIN;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 2c48a7233b19..d29a06d60206 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1126,9 +1126,9 @@ void run_posix_cpu_timers(void)
 	if (!fastpath_timer_check(tsk))
 		return;
 
-	lockdep_posixtimer_enter();
+	trace_hardirq_threadable();
 	if (!lock_task_sighand(tsk, &flags)) {
-		lockdep_posixtimer_exit();
+		trace_hardirq_unthreadable();
 		return;
 	}
 	/*
@@ -1172,7 +1172,7 @@ void run_posix_cpu_timers(void)
 			cpu_timer_fire(timer);
 		spin_unlock(&timer->it_lock);
 	}
-	lockdep_posixtimer_exit();
+	trace_hardirq_unthreadable();
 }
 
 /*
-- 
2.25.0

