Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64054C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F2520754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCTM6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35606 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgCTM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHDy-0003jX-2j; Fri, 20 Mar 2020 13:58:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A477D1C22C0;
        Fri, 20 Mar 2020 13:58:05 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:05 -0000
From:   "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Optimize switching tasks inside shared cgroups
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200316191333.115523-3-hannes@cmpxchg.org>
References: <20200316191333.115523-3-hannes@cmpxchg.org>
MIME-Version: 1.0
Message-ID: <158470908538.28353.4035583045093717977.tip-bot2@tip-bot2>
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

Commit-ID:     36b238d5717279163859fb6ba0f4360abcafab83
Gitweb:        https://git.kernel.org/tip/36b238d5717279163859fb6ba0f4360abcafab83
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Mon, 16 Mar 2020 15:13:32 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:19 +01:00

psi: Optimize switching tasks inside shared cgroups

When switching tasks running on a CPU, the psi state of a cgroup
containing both of these tasks does not change. Right now, we don't
exploit that, and can perform many unnecessary state changes in nested
hierarchies, especially when most activity comes from one leaf cgroup.

This patch implements an optimization where we only update cgroups
whose state actually changes during a task switch. These are all
cgroups that contain one task but not the other, up to the first
shared ancestor. When both tasks are in the same group, we don't need
to update anything at all.

We can identify the first shared ancestor by walking the groups of the
incoming task until we see TSK_ONCPU set on the local CPU; that's the
first group that also contains the outgoing task.

The new psi_task_switch() is similar to psi_task_change(). To allow
code reuse, move the task flag maintenance code into a new function
and the poll/avg worker wakeups into the shared psi_group_change().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200316191333.115523-3-hannes@cmpxchg.org
---
 include/linux/psi.h  |  2 +-
 kernel/sched/psi.c   | 87 +++++++++++++++++++++++++++++++++----------
 kernel/sched/stats.h |  9 +----
 3 files changed, 70 insertions(+), 28 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 7b3de73..7361023 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -17,6 +17,8 @@ extern struct psi_group psi_system;
 void psi_init(void);
 
 void psi_task_change(struct task_struct *task, int clear, int set);
+void psi_task_switch(struct task_struct *prev, struct task_struct *next,
+		     bool sleep);
 
 void psi_memstall_tick(struct task_struct *task, int cpu);
 void psi_memstall_enter(unsigned long *flags);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 5012829..955a124 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -669,13 +669,14 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 		groupc->times[PSI_NONIDLE] += delta;
 }
 
-static u32 psi_group_change(struct psi_group *group, int cpu,
-			    unsigned int clear, unsigned int set)
+static void psi_group_change(struct psi_group *group, int cpu,
+			     unsigned int clear, unsigned int set,
+			     bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
+	u32 state_mask = 0;
 	unsigned int t, m;
 	enum psi_states s;
-	u32 state_mask = 0;
 
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
@@ -717,7 +718,11 @@ static u32 psi_group_change(struct psi_group *group, int cpu,
 
 	write_seqcount_end(&groupc->seq);
 
-	return state_mask;
+	if (state_mask & group->poll_states)
+		psi_schedule_poll_work(group, 1);
+
+	if (wake_clock && !delayed_work_pending(&group->avgs_work))
+		schedule_delayed_work(&group->avgs_work, PSI_FREQ);
 }
 
 static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
@@ -744,27 +749,32 @@ static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
 	return &psi_system;
 }
 
-void psi_task_change(struct task_struct *task, int clear, int set)
+static void psi_flags_change(struct task_struct *task, int clear, int set)
 {
-	int cpu = task_cpu(task);
-	struct psi_group *group;
-	bool wake_clock = true;
-	void *iter = NULL;
-
-	if (!task->pid)
-		return;
-
 	if (((task->psi_flags & set) ||
 	     (task->psi_flags & clear) != clear) &&
 	    !psi_bug) {
 		printk_deferred(KERN_ERR "psi: inconsistent task state! task=%d:%s cpu=%d psi_flags=%x clear=%x set=%x\n",
-				task->pid, task->comm, cpu,
+				task->pid, task->comm, task_cpu(task),
 				task->psi_flags, clear, set);
 		psi_bug = 1;
 	}
 
 	task->psi_flags &= ~clear;
 	task->psi_flags |= set;
+}
+
+void psi_task_change(struct task_struct *task, int clear, int set)
+{
+	int cpu = task_cpu(task);
+	struct psi_group *group;
+	bool wake_clock = true;
+	void *iter = NULL;
+
+	if (!task->pid)
+		return;
+
+	psi_flags_change(task, clear, set);
 
 	/*
 	 * Periodic aggregation shuts off if there is a period of no
@@ -777,14 +787,51 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 		     wq_worker_last_func(task) == psi_avgs_work))
 		wake_clock = false;
 
-	while ((group = iterate_groups(task, &iter))) {
-		u32 state_mask = psi_group_change(group, cpu, clear, set);
+	while ((group = iterate_groups(task, &iter)))
+		psi_group_change(group, cpu, clear, set, wake_clock);
+}
+
+void psi_task_switch(struct task_struct *prev, struct task_struct *next,
+		     bool sleep)
+{
+	struct psi_group *group, *common = NULL;
+	int cpu = task_cpu(prev);
+	void *iter;
+
+	if (next->pid) {
+		psi_flags_change(next, 0, TSK_ONCPU);
+		/*
+		 * When moving state between tasks, the group that
+		 * contains them both does not change: we can stop
+		 * updating the tree once we reach the first common
+		 * ancestor. Iterate @next's ancestors until we
+		 * encounter @prev's state.
+		 */
+		iter = NULL;
+		while ((group = iterate_groups(next, &iter))) {
+			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
+				common = group;
+				break;
+			}
+
+			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
+		}
+	}
+
+	/*
+	 * If this is a voluntary sleep, dequeue will have taken care
+	 * of the outgoing TSK_ONCPU alongside TSK_RUNNING already. We
+	 * only need to deal with it during preemption.
+	 */
+	if (sleep)
+		return;
 
-		if (state_mask & group->poll_states)
-			psi_schedule_poll_work(group, 1);
+	if (prev->pid) {
+		psi_flags_change(prev, TSK_ONCPU, 0);
 
-		if (wake_clock && !delayed_work_pending(&group->avgs_work))
-			schedule_delayed_work(&group->avgs_work, PSI_FREQ);
+		iter = NULL;
+		while ((group = iterate_groups(prev, &iter)) && group != common)
+			psi_group_change(group, cpu, TSK_ONCPU, 0, true);
 	}
 }
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 6ff0ac1..1339f5b 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -141,14 +141,7 @@ static inline void psi_sched_switch(struct task_struct *prev,
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	/*
-	 * Clear the TSK_ONCPU state if the task was preempted. If
-	 * it's a voluntary sleep, dequeue will have taken care of it.
-	 */
-	if (!sleep)
-		psi_task_change(prev, TSK_ONCPU, 0);
-
-	psi_task_change(next, 0, TSK_ONCPU);
+	psi_task_switch(prev, next, sleep);
 }
 
 static inline void psi_task_tick(struct rq *rq)
