Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E4CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEFE2311B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Anf97wS4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wGQQVRo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgHFRN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbgHFRKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2714EC061756;
        Thu,  6 Aug 2020 10:10:01 -0700 (PDT)
Date:   Thu, 06 Aug 2020 17:09:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PsIu52xvpB2E0pPbMCaXwd2OrYEJtJ6fDk9KxR5s5I8=;
        b=Anf97wS4y2fRXDOH+iORz4tPO2P8PZ1oWWLGReRU+uhM/VVkCufezekdOLilUP/nqPF4dI
        X8ad5vBjDbb5+0cLO8bliElkjFf+NyVYzEcQ4gK+Qx1rrhI1Hq+dsEf0DVslEjr/41aB6t
        sAomInBFA/MyWz6vk7vNZ6sRspJjxie1TiKRnlfFtsDHX48DF9MnEVp1Vy7ujDJMtukrod
        At4E2TVw6+OMmWS5REnCj9zmH40sWWvY0v1qHtF/lspwb9GcyC39pQ1AEpy1ByOoGvhw5B
        vJcQ6xN0BwJRb36oro14VnqebpHLUy2PH2YgPvk9MZyRT7HvlOns0Zwwhnm16Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PsIu52xvpB2E0pPbMCaXwd2OrYEJtJ6fDk9KxR5s5I8=;
        b=wGQQVRo2fuWxcgS0hn07SvLoySXgVvGcttwoiC8bZi97sWo16EHGqufm+ePAxjnecOAHsa
        CwLVBOFiNgKlupDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Provide mechanisms to defer
 timer handling to task_work
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200730102337.783470146@linutronix.de>
References: <20200730102337.783470146@linutronix.de>
MIME-Version: 1.0
Message-ID: <159673379865.3192.12239292351353011555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1fb497dd003009be95ce67689ac800c446b7acc5
Gitweb:        https://git.kernel.org/tip/1fb497dd003009be95ce67689ac800c446b7acc5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 30 Jul 2020 12:14:06 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 16:50:59 +02:00

posix-cpu-timers: Provide mechanisms to defer timer handling to task_work

Running posix CPU timers in hard interrupt context has a few downsides:

 - For PREEMPT_RT it cannot work as the expiry code needs to take
   sighand lock, which is a 'sleeping spinlock' in RT. The original RT
   approach of offloading the posix CPU timer handling into a high
   priority thread was clumsy and provided no real benefit in general.

 - For fine grained accounting it's just wrong to run this in context of
   the timer interrupt because that way a process specific CPU time is
   accounted to the timer interrupt.

 - Long running timer interrupts caused by a large amount of expiring
   timers which can be created and armed by unpriviledged user space.

There is no hard requirement to expire them in interrupt context.

If the signal is targeted at the task itself then it won't be delivered
before the task returns to user space anyway. If the signal is targeted at
a supervisor process then it might be slightly delayed, but posix CPU
timers are inaccurate anyway due to the fact that they are tied to the
tick.

Provide infrastructure to schedule task work which allows splitting the
posix CPU timer code into a quick check in interrupt context and a thread
context expiry and signal delivery function. This has to be enabled by
architectures as it requires that the architecture specific KVM
implementation handles pending task work before exiting to guest mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200730102337.783470146@linutronix.de
---
 include/linux/posix-timers.h   |  17 +++-
 include/linux/sched.h          |   4 +-
 kernel/time/Kconfig            |   9 ++-
 kernel/time/posix-cpu-timers.c | 185 +++++++++++++++++++++++++++++---
 kernel/time/timer.c            |   1 +-
 5 files changed, 204 insertions(+), 12 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index e3f0f85..896c16d 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -6,6 +6,7 @@
 #include <linux/list.h>
 #include <linux/alarmtimer.h>
 #include <linux/timerqueue.h>
+#include <linux/task_work.h>
 
 struct kernel_siginfo;
 struct task_struct;
@@ -125,6 +126,16 @@ struct posix_cputimers {
 	unsigned int			expiry_active;
 };
 
+/**
+ * posix_cputimers_work - Container for task work based posix CPU timer expiry
+ * @work:	The task work to be scheduled
+ * @scheduled:  @work has been scheduled already, no further processing
+ */
+struct posix_cputimers_work {
+	struct callback_head	work;
+	unsigned int		scheduled;
+};
+
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
 {
 	memset(pct, 0, sizeof(*pct));
@@ -165,6 +176,12 @@ static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
 #endif
 
+#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
+void posix_cputimers_init_work(void);
+#else
+static inline void posix_cputimers_init_work(void) { }
+#endif
+
 #define REQUEUE_PENDING 1
 
 /**
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 06ec604..e9942ce 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -889,6 +889,10 @@ struct task_struct {
 	/* Empty if CONFIG_POSIX_CPUTIMERS=n */
 	struct posix_cputimers		posix_cputimers;
 
+#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
+	struct posix_cputimers_work	posix_cputimers_work;
+#endif
+
 	/* Process credentials: */
 
 	/* Tracer's credentials at attach: */
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index fcc4235..a09b1d6 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -52,6 +52,15 @@ config GENERIC_CLOCKEVENTS_MIN_ADJUST
 config GENERIC_CMOS_UPDATE
 	bool
 
+# Select to handle posix CPU timers from task_work
+# and not from the timer interrupt context
+config HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	bool
+
+config POSIX_CPU_TIMERS_TASK_WORK
+	bool
+	default y if POSIX_TIMERS && HAVE_POSIX_CPU_TIMERS_TASK_WORK
+
 if GENERIC_CLOCKEVENTS
 menu "Timers subsystem"
 
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index e5ad873..a71758e 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -377,6 +377,7 @@ static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
  */
 static int posix_cpu_timer_create(struct k_itimer *new_timer)
 {
+	static struct lock_class_key posix_cpu_timers_key;
 	struct pid *pid;
 
 	rcu_read_lock();
@@ -386,6 +387,17 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 		return -EINVAL;
 	}
 
+	/*
+	 * If posix timer expiry is handled in task work context then
+	 * timer::it_lock can be taken without disabling interrupts as all
+	 * other locking happens in task context. This requires a seperate
+	 * lock class key otherwise regular posix timer expiry would record
+	 * the lock class being taken in interrupt context and generate a
+	 * false positive warning.
+	 */
+	if (IS_ENABLED(CONFIG_POSIX_CPU_TIMERS_TASK_WORK))
+		lockdep_set_class(&new_timer->it_lock, &posix_cpu_timers_key);
+
 	new_timer->kclock = &clock_posix_cpu;
 	timerqueue_init(&new_timer->it.cpu.node);
 	new_timer->it.cpu.pid = get_pid(pid);
@@ -1080,26 +1092,163 @@ static inline bool fastpath_timer_check(struct task_struct *tsk)
 	return false;
 }
 
-static void __run_posix_cpu_timers(struct task_struct *tsk)
+static void handle_posix_cpu_timers(struct task_struct *tsk);
+
+#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
+static void posix_cpu_timers_work(struct callback_head *work)
+{
+	handle_posix_cpu_timers(current);
+}
+
+/*
+ * Initialize posix CPU timers task work in init task. Out of line to
+ * keep the callback static and to avoid header recursion hell.
+ */
+void __init posix_cputimers_init_work(void)
+{
+	init_task_work(&current->posix_cputimers_work.work,
+		       posix_cpu_timers_work);
+}
+
+/*
+ * Note: All operations on tsk->posix_cputimer_work.scheduled happen either
+ * in hard interrupt context or in task context with interrupts
+ * disabled. Aside of that the writer/reader interaction is always in the
+ * context of the current task, which means they are strict per CPU.
+ */
+static inline bool posix_cpu_timers_work_scheduled(struct task_struct *tsk)
+{
+	return tsk->posix_cputimers_work.scheduled;
+}
+
+static inline void __run_posix_cpu_timers(struct task_struct *tsk)
+{
+	if (WARN_ON_ONCE(tsk->posix_cputimers_work.scheduled))
+		return;
+
+	/* Schedule task work to actually expire the timers */
+	tsk->posix_cputimers_work.scheduled = true;
+	task_work_add(tsk, &tsk->posix_cputimers_work.work, TWA_RESUME);
+}
+
+static inline bool posix_cpu_timers_enable_work(struct task_struct *tsk,
+						unsigned long start)
+{
+	bool ret = true;
+
+	/*
+	 * On !RT kernels interrupts are disabled while collecting expired
+	 * timers, so no tick can happen and the fast path check can be
+	 * reenabled without further checks.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		tsk->posix_cputimers_work.scheduled = false;
+		return true;
+	}
+
+	/*
+	 * On RT enabled kernels ticks can happen while the expired timers
+	 * are collected under sighand lock. But any tick which observes
+	 * the CPUTIMERS_WORK_SCHEDULED bit set, does not run the fastpath
+	 * checks. So reenabling the tick work has do be done carefully:
+	 *
+	 * Disable interrupts and run the fast path check if jiffies have
+	 * advanced since the collecting of expired timers started. If
+	 * jiffies have not advanced or the fast path check did not find
+	 * newly expired timers, reenable the fast path check in the timer
+	 * interrupt. If there are newly expired timers, return false and
+	 * let the collection loop repeat.
+	 */
+	local_irq_disable();
+	if (start != jiffies && fastpath_timer_check(tsk))
+		ret = false;
+	else
+		tsk->posix_cputimers_work.scheduled = false;
+	local_irq_enable();
+
+	return ret;
+}
+#else /* CONFIG_POSIX_CPU_TIMERS_TASK_WORK */
+static inline void __run_posix_cpu_timers(struct task_struct *tsk)
+{
+	lockdep_posixtimer_enter();
+	handle_posix_cpu_timers(tsk);
+	lockdep_posixtimer_exit();
+}
+
+static inline bool posix_cpu_timers_work_scheduled(struct task_struct *tsk)
+{
+	return false;
+}
+
+static inline bool posix_cpu_timers_enable_work(struct task_struct *tsk,
+						unsigned long start)
+{
+	return true;
+}
+#endif /* CONFIG_POSIX_CPU_TIMERS_TASK_WORK */
+
+static void handle_posix_cpu_timers(struct task_struct *tsk)
 {
 	struct k_itimer *timer, *next;
-	unsigned long flags;
+	unsigned long flags, start;
 	LIST_HEAD(firing);
 
 	if (!lock_task_sighand(tsk, &flags))
 		return;
 
-	/*
-	 * Here we take off tsk->signal->cpu_timers[N] and
-	 * tsk->cpu_timers[N] all the timers that are firing, and
-	 * put them on the firing list.
-	 */
-	check_thread_timers(tsk, &firing);
+	do {
+		/*
+		 * On RT locking sighand lock does not disable interrupts,
+		 * so this needs to be careful vs. ticks. Store the current
+		 * jiffies value.
+		 */
+		start = READ_ONCE(jiffies);
+		barrier();
 
-	check_process_timers(tsk, &firing);
+		/*
+		 * Here we take off tsk->signal->cpu_timers[N] and
+		 * tsk->cpu_timers[N] all the timers that are firing, and
+		 * put them on the firing list.
+		 */
+		check_thread_timers(tsk, &firing);
+
+		check_process_timers(tsk, &firing);
+
+		/*
+		 * The above timer checks have updated the exipry cache and
+		 * because nothing can have queued or modified timers after
+		 * sighand lock was taken above it is guaranteed to be
+		 * consistent. So the next timer interrupt fastpath check
+		 * will find valid data.
+		 *
+		 * If timer expiry runs in the timer interrupt context then
+		 * the loop is not relevant as timers will be directly
+		 * expired in interrupt context. The stub function below
+		 * returns always true which allows the compiler to
+		 * optimize the loop out.
+		 *
+		 * If timer expiry is deferred to task work context then
+		 * the following rules apply:
+		 *
+		 * - On !RT kernels no tick can have happened on this CPU
+		 *   after sighand lock was acquired because interrupts are
+		 *   disabled. So reenabling task work before dropping
+		 *   sighand lock and reenabling interrupts is race free.
+		 *
+		 * - On RT kernels ticks might have happened but the tick
+		 *   work ignored posix CPU timer handling because the
+		 *   CPUTIMERS_WORK_SCHEDULED bit is set. Reenabling work
+		 *   must be done very carefully including a check whether
+		 *   ticks have happened since the start of the timer
+		 *   expiry checks. posix_cpu_timers_enable_work() takes
+		 *   care of that and eventually lets the expiry checks
+		 *   run again.
+		 */
+	} while (!posix_cpu_timers_enable_work(tsk, start));
 
 	/*
-	 * We must release these locks before taking any timer's lock.
+	 * We must release sighand lock before taking any timer's lock.
 	 * There is a potential race with timer deletion here, as the
 	 * siglock now protects our private firing list.  We have set
 	 * the firing flag in each timer, so that a deletion attempt
@@ -1117,6 +1266,13 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 	list_for_each_entry_safe(timer, next, &firing, it.cpu.elist) {
 		int cpu_firing;
 
+		/*
+		 * spin_lock() is sufficient here even independent of the
+		 * expiry context. If expiry happens in hard interrupt
+		 * context it's obvious. For task work context it's safe
+		 * because all other operations on timer::it_lock happen in
+		 * task context (syscall or exit).
+		 */
 		spin_lock(&timer->it_lock);
 		list_del_init(&timer->it.cpu.elist);
 		cpu_firing = timer->it.cpu.firing;
@@ -1144,15 +1300,20 @@ void run_posix_cpu_timers(void)
 	lockdep_assert_irqs_disabled();
 
 	/*
+	 * If the actual expiry is deferred to task work context and the
+	 * work is already scheduled there is no point to do anything here.
+	 */
+	if (posix_cpu_timers_work_scheduled(tsk))
+		return;
+
+	/*
 	 * The fast path checks that there are no expired thread or thread
 	 * group timers.  If that's so, just return.
 	 */
 	if (!fastpath_timer_check(tsk))
 		return;
 
-	lockdep_posixtimer_enter();
 	__run_posix_cpu_timers(tsk);
-	lockdep_posixtimer_exit();
 }
 
 /*
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index ae5029f..a16764b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2017,6 +2017,7 @@ static void __init init_timer_cpus(void)
 void __init init_timers(void)
 {
 	init_timer_cpus();
+	posix_cputimers_init_work();
 	open_softirq(TIMER_SOFTIRQ, run_timer_softirq);
 }
 
