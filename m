Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F7DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BE4206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593368169;
	bh=t8EsLzPu4RUwrXsBTe6GgFOBjJOxoj/kplg8aW4wUGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q9CjNHh9z3YfSclfbE2IUisqTN3NnkiFtUYuiRcVF9cSNHKCENMpuqhhfcQBl3M+D
	 zpNWjBg4CjBprlYuGRdwwmOZZOA93TMHH5egN37VjDqMpiaHh3HvwxbiZvpBwUUWko
	 gR60VrJQaHJCAwm2AzgLTVT1NqGDI7zsJew8wf7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgF1SPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 14:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgF1SPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:15:48 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A65C03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:15:47 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d15so10998995edm.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lZTVzKkOJA7JD51LgqgKo90As/KeEA0AoV4hQE+0bq0=;
        b=r+hYZudFiiWixP0gqEo9Lt6tlZreJtHneSIhFd8M9Ub52kjl7/rQZhDkb2YnLUOSOZ
         anRlTcoQ+N90U4DLU8XLLC4+6UuQjt4YQ+kArNakQ6hiRv7hICQRGRiAoGrM4GjNV8hj
         5c+g5yrH20EUHg0QFgJGN/9fkBcLJlv94fIYjbeEv2r2Bn5u4lfRo89MhNofOH8CY+PF
         P+gRwv5S4vS5IDRxhsQdcWwbMEL3aqwkfxP6Old0aeDJrQMxB43gHHhfrqEmSdshokAC
         8h695nHQZ5DH0Bj0OhACL5DVWfc3SFP/CtsCCcjpXana1vyrLFePwlgSBDTSjpm3ShXs
         5mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lZTVzKkOJA7JD51LgqgKo90As/KeEA0AoV4hQE+0bq0=;
        b=Bj75z5+3Zs/FC4IGKLXgDssRvKXqJMiRxWfm1AEtho/bXc91RXc+WULSJrKO4Ffy1X
         wt2V+vps+cCME8jtjJT2CwWbTwlIdPpUQvShuJBvo8IrBViOAsEQGubd0ugLJwDx9R1P
         EEHnGOvsvwq7N5qbCgfahUYd2ey5MBhwF/DxO+KZf1u+pqIoH9CLC3Zs5z0SabhH7PUT
         awWF1gnXwni1N9tljb11/9PjPxyJlkx2dtUvTgFMHIlbeOnSatifkL00pfm64CayGMmQ
         83hK920gxEWNpR0jQMF3s8XqKDpucDb7v3sOlw34lbhRPuN6Cd374oE2P8bkfPY5+hrZ
         xM8Q==
X-Gm-Message-State: AOAM530NHazA/6NchE3BQV2ai2qi6E25lO94rLsD+0gooawkocUbeyxC
        USrJ+DtxJA6tIAXuRv7Aev9ELhKo
X-Google-Smtp-Source: ABdhPJxJj3Y2iStfk0i2OltBh8YjEckIZky2pnupeqaoA6Aw1fgHSGzuriLpFA2AscEQaVANfO4sCw==
X-Received: by 2002:a50:ee87:: with SMTP id f7mr14231861edr.355.1593368146471;
        Sun, 28 Jun 2020 11:15:46 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l12sm22028889edj.6.2020.06.28.11.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 11:15:45 -0700 (PDT)
Date:   Sun, 28 Jun 2020 20:15:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sched/urgent for 5.8-rc3
Message-ID: <20200628181544.GB19572@gmail.com>
References: <20200628152342.GE18884@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628152342.GE18884@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@suse.de> wrote:

> Hi Linus,
> 
> please pull the sched/urgent pile. I had to rebase it last-minute ontop
> of -rc2 because it was based on a random merge commit after -rc2 and I
> know you don't like pull requests based on random commits if there's not
> a real reason for that.

I based sched/urgent on a tested-working merge commit, not on a random 
interim commit - in this sense your rebase of 68f7b5cc835d was 
somewhat unnecessary.

I believe avoiding random merge commits is mostly relevant in the 
merge window phase, when reliability of interim merge stages is 
arguably low and same-day rebases were a disease a couple of years 
ago.

But after -rc1 using 'daily' upstream merge points is not nearly as 
questionable, especially if it's backed by testing like I did. 
Arguably post-rc1 merge points all increase reliability, and since 
that was the base I tested, it's what I used for the sched/urgent 
tree.

So in case Linus prefers the 'old' branch from a couple of days ago 
instead of the freshly rebased one from today, you can find it at:

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-06-28

   # HEAD: 68f7b5cc835de7d5b6c7696533c126018171e793 sched/cfs: change initial value of runnable_avg

"The most anticipated fix in this pull request is probably the horrible build
 fix for the RANDSTRUCT fail that didn't make -rc2. Also included is the cleanup
 that removes those BUILD_BUG_ON()s and replaces it with ugly unions.

 Also included is the try_to_wake_up() race fix that was first triggered by
 Paul's RCU-torture runs, but was independently hit by Dave Chinner's fstest
 runs as well."

 Thanks,

	Ingo

------------------>
Juri Lelli (2):
      sched/deadline: Initialize ->dl_boosted
      sched/core: Fix PI boosting between RT and DEADLINE tasks

Peter Zijlstra (4):
      sched/core: Fix CONFIG_GCC_PLUGIN_RANDSTRUCT build fail
      sched/core: Fix ttwu() race
      sched/core: s/WF_ON_RQ/WQ_ON_CPU/
      smp, irq_work: Continue smp_call_function*() and irq_work*() integration

Scott Wood (1):
      sched/core: Check cpus_mask, not cpus_ptr in __set_cpus_allowed_ptr(), to fix mask corruption

Vincent Guittot (1):
      sched/cfs: change initial value of runnable_avg


 include/linux/irq_work.h  | 26 ++++++-------------
 include/linux/sched.h     |  3 +--
 include/linux/smp.h       | 23 ++++++-----------
 include/linux/smp_types.h | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c       | 44 ++++++++++++++++++++++++-------
 kernel/sched/deadline.c   |  1 +
 kernel/sched/fair.c       |  2 +-
 kernel/sched/sched.h      |  2 +-
 kernel/smp.c              | 18 -------------
 9 files changed, 120 insertions(+), 65 deletions(-)
 create mode 100644 include/linux/smp_types.h

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 2735da5f839e..30823780c192 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_IRQ_WORK_H
 #define _LINUX_IRQ_WORK_H
 
-#include <linux/llist.h>
+#include <linux/smp_types.h>
 
 /*
  * An entry can be in one of four states:
@@ -13,24 +13,14 @@
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
 };
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b62e6aaf28f0..692e327d7455 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -654,9 +654,8 @@ struct task_struct {
 	unsigned int			ptrace;
 
 #ifdef CONFIG_SMP
-	struct llist_node		wake_entry;
-	unsigned int			wake_entry_type;
 	int				on_cpu;
+	struct __call_single_node	wake_entry;
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* Current CPU: */
 	unsigned int			cpu;
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 7ee202ad21a6..80d557ef8a11 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -12,29 +12,22 @@
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
 };
diff --git a/include/linux/smp_types.h b/include/linux/smp_types.h
new file mode 100644
index 000000000000..364b3ae3e41d
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
+};
+
+#endif /* __LINUX_SMP_TYPES_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8f360326861e..ca5db40392d4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1637,7 +1637,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	if (cpumask_equal(p->cpus_ptr, new_mask))
+	if (cpumask_equal(&p->cpus_mask, new_mask))
 		goto out;
 
 	/*
@@ -2293,8 +2293,15 @@ void sched_ttwu_pending(void *arg)
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
-	llist_for_each_entry_safe(p, t, llist, wake_entry)
+	llist_for_each_entry_safe(p, t, llist, wake_entry.llist) {
+		if (WARN_ON_ONCE(p->on_cpu))
+			smp_cond_load_acquire(&p->on_cpu, !VAL);
+
+		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
+			set_task_cpu(p, cpu_of(rq));
+
 		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
+	}
 
 	rq_unlock_irqrestore(rq, &rf);
 }
@@ -2322,7 +2329,7 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
-	__smp_call_single_queue(cpu, &p->wake_entry);
+	__smp_call_single_queue(cpu, &p->wake_entry.llist);
 }
 
 void wake_up_if_idle(int cpu)
@@ -2369,7 +2376,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 	 * the soon-to-be-idle CPU as the current CPU is likely busy.
 	 * nr_running is checked to avoid unnecessary task stacking.
 	 */
-	if ((wake_flags & WF_ON_RQ) && cpu_rq(cpu)->nr_running <= 1)
+	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
 		return true;
 
 	return false;
@@ -2378,6 +2385,9 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
 	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
+		if (WARN_ON_ONCE(cpu == smp_processor_id()))
+			return false;
+
 		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
 		__ttwu_queue_wakelist(p, cpu, wake_flags);
 		return true;
@@ -2528,7 +2538,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 			goto out;
 
 		success = 1;
-		cpu = task_cpu(p);
 		trace_sched_waking(p);
 		p->state = TASK_RUNNING;
 		trace_sched_wakeup(p);
@@ -2550,7 +2559,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 	/* We're going to change ->state: */
 	success = 1;
-	cpu = task_cpu(p);
 
 	/*
 	 * Ensure we load p->on_rq _after_ p->state, otherwise it would
@@ -2614,8 +2622,21 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * which potentially sends an IPI instead of spinning on p->on_cpu to
 	 * let the waker make forward progress. This is safe because IRQs are
 	 * disabled and the IPI will deliver after on_cpu is cleared.
+	 *
+	 * Ensure we load task_cpu(p) after p->on_cpu:
+	 *
+	 * set_task_cpu(p, cpu);
+	 *   STORE p->cpu = @cpu
+	 * __schedule() (switch to task 'p')
+	 *   LOCK rq->lock
+	 *   smp_mb__after_spin_lock()		smp_cond_load_acquire(&p->on_cpu)
+	 *   STORE p->on_cpu = 1		LOAD p->cpu
+	 *
+	 * to ensure we observe the correct CPU on which the task is currently
+	 * scheduling.
 	 */
-	if (READ_ONCE(p->on_cpu) && ttwu_queue_wakelist(p, cpu, wake_flags | WF_ON_RQ))
+	if (smp_load_acquire(&p->on_cpu) &&
+	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
 		goto unlock;
 
 	/*
@@ -2635,6 +2656,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		psi_ttwu_dequeue(p);
 		set_task_cpu(p, cpu);
 	}
+#else
+	cpu = task_cpu(p);
 #endif /* CONFIG_SMP */
 
 	ttwu_queue(p, cpu, wake_flags);
@@ -2642,7 +2665,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 out:
 	if (success)
-		ttwu_stat(p, cpu, wake_flags);
+		ttwu_stat(p, task_cpu(p), wake_flags);
 	preempt_enable();
 
 	return success;
@@ -2763,7 +2786,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #endif
 	init_numa_balancing(clone_flags, p);
 #ifdef CONFIG_SMP
-	p->wake_entry_type = CSD_TYPE_TTWU;
+	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 #endif
 }
 
@@ -4533,7 +4556,8 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	 */
 	if (dl_prio(prio)) {
 		if (!dl_prio(p->normal_prio) ||
-		    (pi_task && dl_entity_preempt(&pi_task->dl, &p->dl))) {
+		    (pi_task && dl_prio(pi_task->prio) &&
+		     dl_entity_preempt(&pi_task->dl, &p->dl))) {
 			p->dl.dl_boosted = 1;
 			queue_flag |= ENQUEUE_REPLENISH;
 		} else
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 504d2f51b0d6..f63f337c7147 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2692,6 +2692,7 @@ void __dl_clear_params(struct task_struct *p)
 	dl_se->dl_bw			= 0;
 	dl_se->dl_density		= 0;
 
+	dl_se->dl_boosted		= 0;
 	dl_se->dl_throttled		= 0;
 	dl_se->dl_yielded		= 0;
 	dl_se->dl_non_contending	= 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cbcb2f71599b..658aa7a2ae6f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -806,7 +806,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 		}
 	}
 
-	sa->runnable_avg = cpu_scale;
+	sa->runnable_avg = sa->util_avg;
 
 	if (p->sched_class != &fair_sched_class) {
 		/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1d4e94c1e5fe..877fb08eb1b0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1682,7 +1682,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 #define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
 #define WF_FORK			0x02		/* Child wakeup after fork */
 #define WF_MIGRATED		0x04		/* Internal use, task got migrated */
-#define WF_ON_RQ		0x08		/* Wakee is on_rq */
+#define WF_ON_CPU		0x08		/* Wakee is on_cpu */
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
diff --git a/kernel/smp.c b/kernel/smp.c
index 472c2b274c65..aa17eedff5be 100644
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
 
