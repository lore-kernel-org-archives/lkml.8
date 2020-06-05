Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B95C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E369206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cg4PIktu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgFEJhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgFEJhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:37:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174EDC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BgAFCtadeCSjQRZFGbfYeltR3Qq+KbUhZM6A9E2cTTE=; b=Cg4PIktuLqiYrCXmIxHVdi6EXk
        uSbGcD0kxpjDBDAvGDF5eyNyGPqlqg+F8fnt9bCT0PtdXm5qgHmyoqLxgXIdZVx+E1oUFzCIM0bFt
        6+k89fGt47x7R9rT9kKnslfNaibS+b3qG7Le09GgW1rZq6D5vqS0J92m1ZZVO1FQfXooqjv2te949
        NYQBiz5/8W5c8erV0G+iMnNrCW3EUqmExAoSG0Rir9Wkb+fLWyMoBSg87mFNYvvyIxVK/I1pemujM
        BG9W9noCHuicIyge+PSUd/djseUw+gifMP+4nDwJCi5DY2IWhAUOIZtHZFEILSs30EFVvy5vCpcf5
        EhWzsOQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jh8mh-0004SU-SF; Fri, 05 Jun 2020 09:37:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D8EB306064;
        Fri,  5 Jun 2020 11:37:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C77921A73960; Fri,  5 Jun 2020 11:37:04 +0200 (CEST)
Date:   Fri, 5 Jun 2020 11:37:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net, sfr@canb.auug.org.au,
        linux@roeck-us.net
Subject: Re: [RFC][PATCH 5/7] irq_work, smp: Allow irq_work on
 call_single_queue
Message-ID: <20200605093704.GB2948@hirez.programming.kicks-ass.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.011635912@infradead.org>
 <20200528234031.GB551@lenoir>
 <20200529133641.GM706495@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529133641.GM706495@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 03:36:41PM +0200, Peter Zijlstra wrote:
> Maybe I can anonymous-union my way around it, dunno. I'll think about
> it. I'm certainly not proud of this. But at least the BUILD_BUG_ON()s
> should catch the more blatant breakage here.

How's this then? Differently ugly, but at least it compiles with that
horrible struct randomization junk enabled.

---
 include/linux/irq_work.h  |   28 ++++++-------------
 include/linux/sched.h     |    4 +-
 include/linux/smp.h       |   25 ++++++-----------
 include/linux/smp_types.h |   66 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c       |    6 ++--
 kernel/smp.c              |   18 ------------
 6 files changed, 89 insertions(+), 58 deletions(-)

--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_IRQ_WORK_H
 #define _LINUX_IRQ_WORK_H
 
-#include <linux/llist.h>
+#include <linux/smp_types.h>
 
 /*
  * An entry can be in one of four states:
@@ -13,26 +13,16 @@
  * busy      NULL, 2 -> {free, claimed} : callback in progress, can be claimed
  */
 
-/* flags share CSD_FLAG_ space */
-
-#define IRQ_WORK_PENDING	BIT(0)
-#define IRQ_WORK_BUSY		BIT(1)
-
-/* Doesn't want IPI, wait for tick: */
-#define IRQ_WORK_LAZY		BIT(2)
-/* Run hard IRQ context, even on RT */
-#define IRQ_WORK_HARD_IRQ	BIT(3)
-
-#define IRQ_WORK_CLAIMED	(IRQ_WORK_PENDING | IRQ_WORK_BUSY)
-
-/*
- * structure shares layout with single_call_data_t.
- */
 struct irq_work {
-	struct llist_node llnode;
-	atomic_t flags;
+	union {
+		struct __call_single_node node;
+		struct {
+			struct llist_node llnode;
+			atomic_t flags;
+		};
+	};
 	void (*func)(struct irq_work *);
-};
+} __no_randomize_layout;
 
 static inline
 void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -32,6 +32,7 @@
 #include <linux/posix-timers.h>
 #include <linux/rseq.h>
 #include <linux/kcsan.h>
+#include <linux/smp_types.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -654,9 +655,8 @@ struct task_struct {
 	unsigned int			ptrace;
 
 #ifdef CONFIG_SMP
-	struct llist_node		wake_entry;
-	unsigned int			wake_entry_type;
 	int				on_cpu;
+	struct __call_single_node	wake_entry;
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* Current CPU: */
 	unsigned int			cpu;
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -12,32 +12,25 @@
 #include <linux/list.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
-#include <linux/llist.h>
+#include <linux/smp_types.h>
 
 typedef void (*smp_call_func_t)(void *info);
 typedef bool (*smp_cond_func_t)(int cpu, void *info);
 
-enum {
-	CSD_FLAG_LOCK		= 0x01,
-
-	/* IRQ_WORK_flags */
-
-	CSD_TYPE_ASYNC		= 0x00,
-	CSD_TYPE_SYNC		= 0x10,
-	CSD_TYPE_IRQ_WORK	= 0x20,
-	CSD_TYPE_TTWU		= 0x30,
-	CSD_FLAG_TYPE_MASK	= 0xF0,
-};
-
 /*
  * structure shares (partial) layout with struct irq_work
  */
 struct __call_single_data {
-	struct llist_node llist;
-	unsigned int flags;
+	union {
+		struct __call_single_node node;
+		struct {
+			struct llist_node llist;
+			unsigned int flags;
+		};
+	};
 	smp_call_func_t func;
 	void *info;
-};
+} __no_randomize_layout;
 
 /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
 typedef struct __call_single_data call_single_data_t
--- /dev/null
+++ b/include/linux/smp_types.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SMP_TYPES_H
+#define __LINUX_SMP_TYPES_H
+
+#include <linux/llist.h>
+
+enum {
+	CSD_FLAG_LOCK		= 0x01,
+
+	IRQ_WORK_PENDING	= 0x01,
+	IRQ_WORK_BUSY		= 0x02,
+	IRQ_WORK_LAZY		= 0x04, /* No IPI, wait for tick */
+	IRQ_WORK_HARD_IRQ	= 0x08, /* IRQ context on PREEMPT_RT */
+
+	IRQ_WORK_CLAIMED	= (IRQ_WORK_PENDING | IRQ_WORK_BUSY),
+
+	CSD_TYPE_ASYNC		= 0x00,
+	CSD_TYPE_SYNC		= 0x10,
+	CSD_TYPE_IRQ_WORK	= 0x20,
+	CSD_TYPE_TTWU		= 0x30,
+
+	CSD_FLAG_TYPE_MASK	= 0xF0,
+};
+
+/*
+ * struct __call_single_node is the primary type on
+ * smp.c:call_single_queue.
+ *
+ * flush_smp_call_function_queue() only reads the type from
+ * __call_single_node::u_flags as a regular load, the above
+ * (anonymous) enum defines all the bits of this word.
+ *
+ * Other bits are not modified until the type is known.
+ *
+ * CSD_TYPE_SYNC/ASYNC:
+ *	struct {
+ *		struct llist_node node;
+ *		unsigned int flags;
+ *		smp_call_func_t func;
+ *		void *info;
+ *	};
+ *
+ * CSD_TYPE_IRQ_WORK:
+ *	struct {
+ *		struct llist_node node;
+ *		atomic_t flags;
+ *		void (*func)(struct irq_work *);
+ *	};
+ *
+ * CSD_TYPE_TTWU:
+ *	struct {
+ *		struct llist_node node;
+ *		unsigned int flags;
+ *	};
+ *
+ */
+
+struct __call_single_node {
+	struct llist_node	llist;
+	union {
+		unsigned int	u_flags;
+		atomic_t	a_flags;
+	};
+} __no_randomize_layout;
+
+#endif /* __LINUX_SMP_TYPES_H */
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2293,7 +2293,7 @@ void sched_ttwu_pending(void *arg)
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
-	llist_for_each_entry_safe(p, t, llist, wake_entry)
+	llist_for_each_entry_safe(p, t, llist, wake_entry.llist)
 		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
 
 	rq_unlock_irqrestore(rq, &rf);
@@ -2322,7 +2322,7 @@ static void __ttwu_queue_wakelist(struct
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
-	__smp_call_single_queue(cpu, &p->wake_entry);
+	__smp_call_single_queue(cpu, &p->wake_entry.llist);
 }
 
 void wake_up_if_idle(int cpu)
@@ -2763,7 +2763,7 @@ static void __sched_fork(unsigned long c
 #endif
 	init_numa_balancing(clone_flags, p);
 #ifdef CONFIG_SMP
-	p->wake_entry_type = CSD_TYPE_TTWU;
+	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 #endif
 }
 
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -669,24 +669,6 @@ void __init smp_init(void)
 {
 	int num_nodes, num_cpus;
 
-	/*
-	 * Ensure struct irq_work layout matches so that
-	 * flush_smp_call_function_queue() can do horrible things.
-	 */
-	BUILD_BUG_ON(offsetof(struct irq_work, llnode) !=
-		     offsetof(struct __call_single_data, llist));
-	BUILD_BUG_ON(offsetof(struct irq_work, func) !=
-		     offsetof(struct __call_single_data, func));
-	BUILD_BUG_ON(offsetof(struct irq_work, flags) !=
-		     offsetof(struct __call_single_data, flags));
-
-	/*
-	 * Assert the CSD_TYPE_TTWU layout is similar enough
-	 * for task_struct to be on the @call_single_queue.
-	 */
-	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
-		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
-
 	idle_threads_init();
 	cpuhp_threads_init();
 
