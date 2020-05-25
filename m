Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46093C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0613C20723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OAAG7QQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389699AbgEYKX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbgEYKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:23:10 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867AFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 03:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CUCzywxlQPfTJH07MoobY6XdozNA/Q0uVio6a4uyL9w=; b=OAAG7QQO/CrcAW4BgPE68NTtUF
        96fwnxM/mLS3h418EBPlCGxuSyfOXsU5IIMtdnkTRR+y85BK6B/cdG+/kUaomJoecz3aM+PpEQhQ0
        FmtyRfbhc5RMYAo5jnYD3O3ryv5GxUlt8chunvdYaObvJSoxZVMtXDT0Ov1u5zPTF5qTVmpfjrPPh
        t+TdYSlnuvQ1hfi6LAuCPlvXTZCRRInUyTEH892aNIwKVRw2IHD4W9l0ouDX9oGKTH2hJXAT1wFjw
        aXzXLl/jm0aZEr1pC4/xdFb1F6oG72jnOfoBFZBv0l5fww9k2Dgy8KaJ8On7t5pIlQPAhHosKuyDW
        CfTYuJVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdAFo-0004Jz-8W; Mon, 25 May 2020 10:22:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DE403011E6;
        Mon, 25 May 2020 12:22:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22375286BFC16; Mon, 25 May 2020 12:22:41 +0200 (CEST)
Date:   Mon, 25 May 2020 12:22:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Sebastian A. Siewior" <bigeasy@linutronix.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 07/25] lockdep: Add preemption disabled assertion API
Message-ID: <20200525102241.GF325303@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-8-a.darwish@linutronix.de>
 <20200522175503.GQ325280@hirez.programming.kicks-ass.net>
 <20200523145942.vjk3z6pbj6yicqa4@linutronix.de>
 <20200523224132.GD2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523224132.GD2483@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 12:41:32AM +0200, Peter Zijlstra wrote:
> On Sat, May 23, 2020 at 04:59:42PM +0200, Sebastian A. Siewior wrote:
> > On 2020-05-22 19:55:03 [+0200], Peter Zijlstra wrote:
> 
> > > That is both more consistent with the things you claim it's modelled
> > > after and also completely avoids that header dependency.
> > 
> > So we need additionally: 
> > 
> > - #include <linux/sched.h> in include/linux/flex_proportions.h
> >   and I think un another file as well.
> > 
> > - write_seqcount_t_begin_nested() as a define
> > 
> > - write_seqcount_t_begin() as a define
> > 
> > Any "static inline" in the header file using
> > lockdep_assert_preemption_disabled() will tro to complain about missing
> > current-> define. But yes, it will work otherwise.
> 
> Because...? /me rummages around.. Ah you're proposing sticking this in
> seqcount itself and then header hell.
> 
> Moo.. ok I'll go have another look on Monday.

How's this?

---

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index d7f7e436c3af..459ae7a6c207 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -14,6 +14,7 @@
 
 #include <linux/typecheck.h>
 #include <asm/irqflags.h>
+#include <asm/percpu.h>
 
 /* Currently lockdep_softirqs_on/off is used only by lockdep */
 #ifdef CONFIG_PROVE_LOCKING
@@ -31,18 +32,22 @@
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
+
+DECLARE_PER_CPU(int, hardirqs_enabled);
+DECLARE_PER_CPU(int, hardirq_context);
+
   extern void trace_hardirqs_on_prepare(void);
   extern void trace_hardirqs_off_prepare(void);
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
-# define lockdep_hardirq_context(p)	((p)->hardirq_context)
+# define lockdep_hardirq_context(p)	(this_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
-# define lockdep_hardirqs_enabled(p)	((p)->hardirqs_enabled)
+# define lockdep_hardirqs_enabled(p)	(this_cpu_read(hardirqs_enabled))
 # define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
-# define lockdep_hardirq_enter()		\
-do {						\
-	if (!current->hardirq_context++)	\
-		current->hardirq_threaded = 0;	\
+# define lockdep_hardirq_enter()			\
+do {							\
+	if (!this_cpu_inc_return(hardirq_context))	\
+		current->hardirq_threaded = 0;		\
 } while (0)
 # define lockdep_hardirq_threaded()		\
 do {						\
@@ -50,7 +55,7 @@ do {						\
 } while (0)
 # define lockdep_hardirq_exit()			\
 do {						\
-	current->hardirq_context--;		\
+	this_cpu_dec(hardirq_context);		\
 } while (0)
 # define lockdep_softirq_enter()		\
 do {						\
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 8fce5c98a4b0..754c31e30a83 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -20,6 +20,7 @@ extern int lock_stat;
 #define MAX_LOCKDEP_SUBCLASSES		8UL
 
 #include <linux/types.h>
+#include <asm/percpu.h>
 
 enum lockdep_wait_type {
 	LD_WAIT_INV = 0,	/* not checked, catch all */
@@ -703,28 +704,29 @@ do {									\
 	lock_release(&(lock)->dep_map, _THIS_IP_);			\
 } while (0)
 
-#define lockdep_assert_irqs_enabled()	do {				\
-		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
-			  !current->hardirqs_enabled,			\
-			  "IRQs not enabled as expected\n");		\
-	} while (0)
+DECLARE_PER_CPU(int, hardirqs_enabled);
+DECLARE_PER_CPU(int, hardirq_context);
 
-#define lockdep_assert_irqs_disabled()	do {				\
-		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
-			  current->hardirqs_enabled,			\
-			  "IRQs not disabled as expected\n");		\
-	} while (0)
+#define lockdep_assert_irqs_enabled()					\
+do {									\
+	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirqs_enabled));	\
+} while (0)
 
-#define lockdep_assert_in_irq() do {					\
-		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
-			  !current->hardirq_context,			\
-			  "Not in hardirq as expected\n");		\
-	} while (0)
+#define lockdep_assert_irqs_disabled()					\
+do {									\
+	WARN_ON_ONCE(debug_locks && this_cpu_read(hardirqs_enabled));	\
+} while (0)
+
+#define lockdep_assert_in_irq()						\
+do {									\
+	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirq_context));	\
+} while (0)
 
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
 # define might_lock_nested(lock, subclass) do { } while (0)
+
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
 # define lockdep_assert_in_irq() do { } while (0)
@@ -734,7 +736,7 @@ do {									\
 
 # define lockdep_assert_RT_in_threaded_ctx() do {			\
 		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
-			  current->hardirq_context &&			\
+			  lockdep_hardirq_context(current) &&		\
 			  !(current->hardirq_threaded || current->irq_config),	\
 			  "Not in threaded context on PREEMPT_RT as expected\n");	\
 } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1d68ee36c583..3d48f80848db 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -990,8 +990,6 @@ struct task_struct {
 	unsigned long			hardirq_disable_ip;
 	unsigned int			hardirq_enable_event;
 	unsigned int			hardirq_disable_event;
-	int				hardirqs_enabled;
-	int				hardirq_context;
 	u64				hardirq_chain_key;
 	unsigned long			softirq_disable_ip;
 	unsigned long			softirq_enable_ip;
diff --git a/kernel/fork.c b/kernel/fork.c
index 96eb4b535ced..5e0e4918dc9f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1946,8 +1946,8 @@ static __latent_entropy struct task_struct *copy_process(
 
 	rt_mutex_init_task(p);
 
+	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_PROVE_LOCKING
-	DEBUG_LOCKS_WARN_ON(!p->hardirqs_enabled);
 	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
 #endif
 	retval = -EAGAIN;
@@ -2028,7 +2028,6 @@ static __latent_entropy struct task_struct *copy_process(
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	p->irq_events = 0;
-	p->hardirqs_enabled = 0;
 	p->hardirq_enable_ip = 0;
 	p->hardirq_enable_event = 0;
 	p->hardirq_disable_ip = _THIS_IP_;
@@ -2038,7 +2037,6 @@ static __latent_entropy struct task_struct *copy_process(
 	p->softirq_enable_event = 0;
 	p->softirq_disable_ip = 0;
 	p->softirq_disable_event = 0;
-	p->hardirq_context = 0;
 	p->softirq_context = 0;
 #endif
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bdea09b365b6..b113941f579e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2062,9 +2062,9 @@ print_bad_irq_dependency(struct task_struct *curr,
 	pr_warn("-----------------------------------------------------\n");
 	pr_warn("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] is trying to acquire:\n",
 		curr->comm, task_pid_nr(curr),
-		curr->hardirq_context, hardirq_count() >> HARDIRQ_SHIFT,
+		lockdep_hardirq_context(curr), hardirq_count() >> HARDIRQ_SHIFT,
 		curr->softirq_context, softirq_count() >> SOFTIRQ_SHIFT,
-		curr->hardirqs_enabled,
+		lockdep_hardirqs_enabled(curr),
 		curr->softirqs_enabled);
 	print_lock(next);
 
@@ -3649,7 +3649,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
-	if (unlikely(current->hardirqs_enabled)) {
+	if (unlikely(lockdep_hardirqs_enabled(current))) {
 		/*
 		 * Neither irq nor preemption are disabled here
 		 * so this is racy by nature but losing one hit
@@ -3677,7 +3677,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 	 * Can't allow enabling interrupts while in an interrupt handler,
 	 * that's general bad form and such. Recursion, limited stack etc..
 	 */
-	if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
+	if (DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context(current)))
 		return;
 
 	current->hardirq_chain_key = current->curr_chain_key;
@@ -3695,7 +3695,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 	if (unlikely(!debug_locks || curr->lockdep_recursion))
 		return;
 
-	if (curr->hardirqs_enabled) {
+	if (lockdep_hardirqs_enabled(curr)) {
 		/*
 		 * Neither irq nor preemption are disabled here
 		 * so this is racy by nature but losing one hit
@@ -3721,7 +3721,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 			    current->curr_chain_key);
 
 	/* we'll do an OFF -> ON transition: */
-	curr->hardirqs_enabled = 1;
+	this_cpu_write(hardirqs_enabled, 1);
 	curr->hardirq_enable_ip = ip;
 	curr->hardirq_enable_event = ++curr->irq_events;
 	debug_atomic_inc(hardirqs_on_events);
@@ -3745,11 +3745,11 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return;
 
-	if (curr->hardirqs_enabled) {
+	if (lockdep_hardirqs_enabled(curr)) {
 		/*
 		 * We have done an ON -> OFF transition:
 		 */
-		curr->hardirqs_enabled = 0;
+		this_cpu_write(hardirqs_enabled, 0);
 		curr->hardirq_disable_ip = ip;
 		curr->hardirq_disable_event = ++curr->irq_events;
 		debug_atomic_inc(hardirqs_off_events);
@@ -3794,7 +3794,7 @@ void lockdep_softirqs_on(unsigned long ip)
 	 * usage bit for all held locks, if hardirqs are
 	 * enabled too:
 	 */
-	if (curr->hardirqs_enabled)
+	if (lockdep_hardirqs_enabled(curr))
 		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
 	lockdep_recursion_finish();
 }
@@ -3843,7 +3843,7 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 	 */
 	if (!hlock->trylock) {
 		if (hlock->read) {
-			if (curr->hardirq_context)
+			if (lockdep_hardirq_context(curr))
 				if (!mark_lock(curr, hlock,
 						LOCK_USED_IN_HARDIRQ_READ))
 					return 0;
@@ -3852,7 +3852,7 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 						LOCK_USED_IN_SOFTIRQ_READ))
 					return 0;
 		} else {
-			if (curr->hardirq_context)
+			if (lockdep_hardirq_context(curr))
 				if (!mark_lock(curr, hlock, LOCK_USED_IN_HARDIRQ))
 					return 0;
 			if (curr->softirq_context)
@@ -3890,7 +3890,7 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 
 static inline unsigned int task_irq_context(struct task_struct *task)
 {
-	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!task->hardirq_context +
+	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!lockdep_hardirq_context(task) +
 	       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
 }
 
@@ -3983,7 +3983,7 @@ static inline short task_wait_context(struct task_struct *curr)
 	 * Set appropriate wait type for the context; for IRQs we have to take
 	 * into account force_irqthread as that is implied by PREEMPT_RT.
 	 */
-	if (curr->hardirq_context) {
+	if (lockdep_hardirq_context(curr)) {
 		/*
 		 * Check if force_irqthreads will run us threaded.
 		 */
@@ -4826,11 +4826,11 @@ static void check_flags(unsigned long flags)
 		return;
 
 	if (irqs_disabled_flags(flags)) {
-		if (DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)) {
+		if (DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled(current))) {
 			printk("possible reason: unannotated irqs-off.\n");
 		}
 	} else {
-		if (DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)) {
+		if (DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled(current))) {
 			printk("possible reason: unannotated irqs-on.\n");
 		}
 	}
diff --git a/kernel/softirq.c b/kernel/softirq.c
index beb8e3a66c7c..f45ebff906f7 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -107,6 +107,12 @@ static bool ksoftirqd_running(unsigned long pending)
  * where hardirqs are disabled legitimately:
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
+
+DEFINE_PER_CPU(int, hardirqs_enabled);
+DEFINE_PER_CPU(int, hardirq_context);
+EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
+EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
+
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
