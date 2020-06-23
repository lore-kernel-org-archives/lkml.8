Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1980EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E3620738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h4SfwS0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbgFWIjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731898AbgFWIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:39:25 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7507CC061795;
        Tue, 23 Jun 2020 01:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Pm0qeLUgtNdFZvdu/jg2s3/JXfU4zGZxInPrc6eUgNY=; b=h4SfwS0cyhRsYNDNc5kDr3XUE1
        ttFxx+PRP430I61zGRaCwix1SzjNmgj7u5JZswlirmn+egh1bRuqhV+I1zkR9MAdU6WiepoAzxbVs
        CEvYSACqG9ZMi0Cc+i4XkxGFafh+ESI3fShtPX+aLyH38vOiI9T4xQS1iHtEKEDTm8J7HS8Ahe8+V
        L+tvR4fVVK2OUqvGT8PCg0Lmc8fSC4zwvXEJA/xHp0LVNUva254iZLQrYmd6zO71AvO64FbtKKHoT
        KkRCLiER/74ytMLaiyhBTT1TbImham+mlzkglUnt6vZRTm30w/9yIi6U4TT7Z/uGgITXBh6U9CxQU
        PM13oV2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jneS2-0000fp-Jx; Tue, 23 Jun 2020 08:38:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C67C0307995;
        Tue, 23 Jun 2020 10:38:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 00FE5237095FF; Tue, 23 Jun 2020 10:38:39 +0200 (CEST)
Message-ID: <20200623083721.571835311@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 23 Jun 2020 10:36:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: [PATCH v4 8/8] lockdep: Remove lockdep_hardirq{s_enabled,_context}() argument
References: <20200623083645.277342609@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the macros use per-cpu data, we no longer need the argument.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/common.c        |    2 +-
 include/linux/irqflags.h       |    8 ++++----
 include/linux/lockdep.h        |    2 +-
 kernel/locking/lockdep.c       |   30 +++++++++++++++---------------
 kernel/softirq.c               |    2 +-
 tools/include/linux/irqflags.h |    4 ++--
 6 files changed, 24 insertions(+), 24 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -689,7 +689,7 @@ noinstr void idtentry_exit_user(struct p
 
 noinstr bool idtentry_enter_nmi(struct pt_regs *regs)
 {
-	bool irq_state = lockdep_hardirqs_enabled(current);
+	bool irq_state = lockdep_hardirqs_enabled();
 
 	__nmi_enter();
 	lockdep_hardirqs_off(CALLER_ADDR0);
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -40,9 +40,9 @@ DECLARE_PER_CPU(int, hardirq_context);
   extern void trace_hardirqs_off_finish(void);
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
-# define lockdep_hardirq_context(p)	(this_cpu_read(hardirq_context))
+# define lockdep_hardirq_context()	(this_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
-# define lockdep_hardirqs_enabled(p)	(this_cpu_read(hardirqs_enabled))
+# define lockdep_hardirqs_enabled()	(this_cpu_read(hardirqs_enabled))
 # define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
 # define lockdep_hardirq_enter()			\
 do {							\
@@ -109,9 +109,9 @@ do {						\
 # define trace_hardirqs_off_finish()		do { } while (0)
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
-# define lockdep_hardirq_context(p)	0
+# define lockdep_hardirq_context()	0
 # define lockdep_softirq_context(p)	0
-# define lockdep_hardirqs_enabled(p)	0
+# define lockdep_hardirqs_enabled()	0
 # define lockdep_softirqs_enabled(p)	0
 # define lockdep_hardirq_enter()	do { } while (0)
 # define lockdep_hardirq_threaded()	do { } while (0)
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -736,7 +736,7 @@ do {									\
 
 # define lockdep_assert_RT_in_threaded_ctx() do {			\
 		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
-			  lockdep_hardirq_context(current) &&		\
+			  lockdep_hardirq_context() &&			\
 			  !(current->hardirq_threaded || current->irq_config),	\
 			  "Not in threaded context on PREEMPT_RT as expected\n");	\
 } while (0)
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2062,9 +2062,9 @@ print_bad_irq_dependency(struct task_str
 	pr_warn("-----------------------------------------------------\n");
 	pr_warn("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] is trying to acquire:\n",
 		curr->comm, task_pid_nr(curr),
-		lockdep_hardirq_context(curr), hardirq_count() >> HARDIRQ_SHIFT,
+		lockdep_hardirq_context(), hardirq_count() >> HARDIRQ_SHIFT,
 		curr->softirq_context, softirq_count() >> SOFTIRQ_SHIFT,
-		lockdep_hardirqs_enabled(curr),
+		lockdep_hardirqs_enabled(),
 		curr->softirqs_enabled);
 	print_lock(next);
 
@@ -3331,9 +3331,9 @@ print_usage_bug(struct task_struct *curr
 
 	pr_warn("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] takes:\n",
 		curr->comm, task_pid_nr(curr),
-		lockdep_hardirq_context(curr), hardirq_count() >> HARDIRQ_SHIFT,
+		lockdep_hardirq_context(), hardirq_count() >> HARDIRQ_SHIFT,
 		lockdep_softirq_context(curr), softirq_count() >> SOFTIRQ_SHIFT,
-		lockdep_hardirqs_enabled(curr),
+		lockdep_hardirqs_enabled(),
 		lockdep_softirqs_enabled(curr));
 	print_lock(this);
 
@@ -3658,7 +3658,7 @@ void lockdep_hardirqs_on_prepare(unsigne
 	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
-	if (unlikely(lockdep_hardirqs_enabled(current))) {
+	if (unlikely(lockdep_hardirqs_enabled())) {
 		/*
 		 * Neither irq nor preemption are disabled here
 		 * so this is racy by nature but losing one hit
@@ -3686,7 +3686,7 @@ void lockdep_hardirqs_on_prepare(unsigne
 	 * Can't allow enabling interrupts while in an interrupt handler,
 	 * that's general bad form and such. Recursion, limited stack etc..
 	 */
-	if (DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context(current)))
+	if (DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context()))
 		return;
 
 	current->hardirq_chain_key = current->curr_chain_key;
@@ -3724,7 +3724,7 @@ void noinstr lockdep_hardirqs_on(unsigne
 	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
-	if (lockdep_hardirqs_enabled(curr)) {
+	if (lockdep_hardirqs_enabled()) {
 		/*
 		 * Neither irq nor preemption are disabled here
 		 * so this is racy by nature but losing one hit
@@ -3783,7 +3783,7 @@ void noinstr lockdep_hardirqs_off(unsign
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return;
 
-	if (lockdep_hardirqs_enabled(curr)) {
+	if (lockdep_hardirqs_enabled()) {
 		/*
 		 * We have done an ON -> OFF transition:
 		 */
@@ -3832,7 +3832,7 @@ void lockdep_softirqs_on(unsigned long i
 	 * usage bit for all held locks, if hardirqs are
 	 * enabled too:
 	 */
-	if (lockdep_hardirqs_enabled(curr))
+	if (lockdep_hardirqs_enabled())
 		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
 	lockdep_recursion_finish();
 }
@@ -3881,7 +3881,7 @@ mark_usage(struct task_struct *curr, str
 	 */
 	if (!hlock->trylock) {
 		if (hlock->read) {
-			if (lockdep_hardirq_context(curr))
+			if (lockdep_hardirq_context())
 				if (!mark_lock(curr, hlock,
 						LOCK_USED_IN_HARDIRQ_READ))
 					return 0;
@@ -3890,7 +3890,7 @@ mark_usage(struct task_struct *curr, str
 						LOCK_USED_IN_SOFTIRQ_READ))
 					return 0;
 		} else {
-			if (lockdep_hardirq_context(curr))
+			if (lockdep_hardirq_context())
 				if (!mark_lock(curr, hlock, LOCK_USED_IN_HARDIRQ))
 					return 0;
 			if (curr->softirq_context)
@@ -3928,7 +3928,7 @@ mark_usage(struct task_struct *curr, str
 
 static inline unsigned int task_irq_context(struct task_struct *task)
 {
-	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!lockdep_hardirq_context(task) +
+	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!lockdep_hardirq_context() +
 	       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
 }
 
@@ -4021,7 +4021,7 @@ static inline short task_wait_context(st
 	 * Set appropriate wait type for the context; for IRQs we have to take
 	 * into account force_irqthread as that is implied by PREEMPT_RT.
 	 */
-	if (lockdep_hardirq_context(curr)) {
+	if (lockdep_hardirq_context()) {
 		/*
 		 * Check if force_irqthreads will run us threaded.
 		 */
@@ -4864,11 +4864,11 @@ static void check_flags(unsigned long fl
 		return;
 
 	if (irqs_disabled_flags(flags)) {
-		if (DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled(current))) {
+		if (DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())) {
 			printk("possible reason: unannotated irqs-off.\n");
 		}
 	} else {
-		if (DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled(current))) {
+		if (DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())) {
 			printk("possible reason: unannotated irqs-on.\n");
 		}
 	}
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -230,7 +230,7 @@ static inline bool lockdep_softirq_start
 {
 	bool in_hardirq = false;
 
-	if (lockdep_hardirq_context(current)) {
+	if (lockdep_hardirq_context()) {
 		in_hardirq = true;
 		lockdep_hardirq_exit();
 	}
--- a/tools/include/linux/irqflags.h
+++ b/tools/include/linux/irqflags.h
@@ -2,9 +2,9 @@
 #ifndef _LIBLOCKDEP_LINUX_TRACE_IRQFLAGS_H_
 #define _LIBLOCKDEP_LINUX_TRACE_IRQFLAGS_H_
 
-# define lockdep_hardirq_context(p)	0
+# define lockdep_hardirq_context()	0
 # define lockdep_softirq_context(p)	0
-# define lockdep_hardirqs_enabled(p)	0
+# define lockdep_hardirqs_enabled()	0
 # define lockdep_softirqs_enabled(p)	0
 # define lockdep_hardirq_enter()	do { } while (0)
 # define lockdep_hardirq_exit()		do { } while (0)


