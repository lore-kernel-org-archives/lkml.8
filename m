Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7DAC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6965420754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgCTM60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35649 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbgCTM6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHE3-0003kI-JS; Fri, 20 Mar 2020 13:58:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 06EC61C22C2;
        Fri, 20 Mar 2020 13:58:06 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:05 -0000
From:   "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Fix cpu.pressure for cpu.max and competing cgroups
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200316191333.115523-2-hannes@cmpxchg.org>
References: <20200316191333.115523-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Message-ID: <158470908574.28353.5889910600117208817.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b05e75d611380881e73edc58a20fd8c6bb71720b
Gitweb:        https://git.kernel.org/tip/b05e75d611380881e73edc58a20fd8c6bb71720b
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Mon, 16 Mar 2020 15:13:31 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:18 +01:00

psi: Fix cpu.pressure for cpu.max and competing cgroups

For simplicity, cpu pressure is defined as having more than one
runnable task on a given CPU. This works on the system-level, but it
has limitations in a cgrouped reality: When cpu.max is in use, it
doesn't capture the time in which a task is not executing on the CPU
due to throttling. Likewise, it doesn't capture the time in which a
competing cgroup is occupying the CPU - meaning it only reflects
cgroup-internal competitive pressure, not outside pressure.

Enable tracking of currently executing tasks, and then change the
definition of cpu pressure in a cgroup from

	NR_RUNNING > 1

to

	NR_RUNNING > ON_CPU

which will capture the effects of cpu.max as well as competition from
outside the cgroup.

After this patch, a cgroup running `stress -c 1` with a cpu.max
setting of 5000 10000 shows ~50% continuous CPU pressure.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200316191333.115523-2-hannes@cmpxchg.org
---
 include/linux/psi_types.h | 10 +++++++++-
 kernel/sched/core.c       |  2 ++
 kernel/sched/psi.c        | 12 +++++++-----
 kernel/sched/stats.h      | 28 ++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 07aaf9b..4b72584 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -14,13 +14,21 @@ enum psi_task_count {
 	NR_IOWAIT,
 	NR_MEMSTALL,
 	NR_RUNNING,
-	NR_PSI_TASK_COUNTS = 3,
+	/*
+	 * This can't have values other than 0 or 1 and could be
+	 * implemented as a bit flag. But for now we still have room
+	 * in the first cacheline of psi_group_cpu, and this way we
+	 * don't have to special case any state tracking for it.
+	 */
+	NR_ONCPU,
+	NR_PSI_TASK_COUNTS = 4,
 };
 
 /* Task state bitmasks */
 #define TSK_IOWAIT	(1 << NR_IOWAIT)
 #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
 #define TSK_RUNNING	(1 << NR_RUNNING)
+#define TSK_ONCPU	(1 << NR_ONCPU)
 
 /* Resources that workloads could be stalled on */
 enum psi_res {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 014d4f7..c1f923d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4091,6 +4091,8 @@ static void __sched notrace __schedule(bool preempt)
 		 */
 		++*switch_count;
 
+		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
+
 		trace_sched_switch(preempt, prev, next);
 
 		/* Also unlocks the rq: */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 0285207..5012829 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -225,7 +225,7 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 	case PSI_MEM_FULL:
 		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
 	case PSI_CPU_SOME:
-		return tasks[NR_RUNNING] > 1;
+		return tasks[NR_RUNNING] > tasks[NR_ONCPU];
 	case PSI_NONIDLE:
 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
 			tasks[NR_RUNNING];
@@ -695,10 +695,10 @@ static u32 psi_group_change(struct psi_group *group, int cpu,
 		if (!(m & (1 << t)))
 			continue;
 		if (groupc->tasks[t] == 0 && !psi_bug) {
-			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u] clear=%x set=%x\n",
+			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
 					cpu, t, groupc->tasks[0],
 					groupc->tasks[1], groupc->tasks[2],
-					clear, set);
+					groupc->tasks[3], clear, set);
 			psi_bug = 1;
 		}
 		groupc->tasks[t]--;
@@ -916,9 +916,11 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 
 	rq = task_rq_lock(task, &rf);
 
-	if (task_on_rq_queued(task))
+	if (task_on_rq_queued(task)) {
 		task_flags = TSK_RUNNING;
-	else if (task->in_iowait)
+		if (task_current(rq, task))
+			task_flags |= TSK_ONCPU;
+	} else if (task->in_iowait)
 		task_flags = TSK_IOWAIT;
 
 	if (task->flags & PF_MEMSTALL)
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index ba683fe..6ff0ac1 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -93,6 +93,14 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 		if (p->flags & PF_MEMSTALL)
 			clear |= TSK_MEMSTALL;
 	} else {
+		/*
+		 * When a task sleeps, schedule() dequeues it before
+		 * switching to the next one. Merge the clearing of
+		 * TSK_RUNNING and TSK_ONCPU to save an unnecessary
+		 * psi_task_change() call in psi_sched_switch().
+		 */
+		clear |= TSK_ONCPU;
+
 		if (p->in_iowait)
 			set |= TSK_IOWAIT;
 	}
@@ -126,6 +134,23 @@ static inline void psi_ttwu_dequeue(struct task_struct *p)
 	}
 }
 
+static inline void psi_sched_switch(struct task_struct *prev,
+				    struct task_struct *next,
+				    bool sleep)
+{
+	if (static_branch_likely(&psi_disabled))
+		return;
+
+	/*
+	 * Clear the TSK_ONCPU state if the task was preempted. If
+	 * it's a voluntary sleep, dequeue will have taken care of it.
+	 */
+	if (!sleep)
+		psi_task_change(prev, TSK_ONCPU, 0);
+
+	psi_task_change(next, 0, TSK_ONCPU);
+}
+
 static inline void psi_task_tick(struct rq *rq)
 {
 	if (static_branch_likely(&psi_disabled))
@@ -138,6 +163,9 @@ static inline void psi_task_tick(struct rq *rq)
 static inline void psi_enqueue(struct task_struct *p, bool wakeup) {}
 static inline void psi_dequeue(struct task_struct *p, bool sleep) {}
 static inline void psi_ttwu_dequeue(struct task_struct *p) {}
+static inline void psi_sched_switch(struct task_struct *prev,
+				    struct task_struct *next,
+				    bool sleep) {}
 static inline void psi_task_tick(struct rq *rq) {}
 #endif /* CONFIG_PSI */
 
