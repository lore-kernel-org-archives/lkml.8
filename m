Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E792C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048D324681
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgCFOmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53800 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCFOmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEB0-0006Hv-Rk; Fri, 06 Mar 2020 15:42:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 726B01C21D7;
        Fri,  6 Mar 2020 15:42:05 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:05 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: cpupri_find: Implement fallback mechanism
 for !fit case
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200302132721.8353-2-qais.yousef@arm.com>
References: <20200302132721.8353-2-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158350572520.28353.11588620733544296269.tip-bot2@tip-bot2>
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

Commit-ID:     d9cb236b9429044dc694ea70a50163ddd283cea6
Gitweb:        https://git.kernel.org/tip/d9cb236b9429044dc694ea70a50163ddd283cea6
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 02 Mar 2020 13:27:16 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:26 +01:00

sched/rt: cpupri_find: Implement fallback mechanism for !fit case

When searching for the best lowest_mask with a fitness_fn passed, make
sure we record the lowest_level that returns a valid lowest_mask so that
we can use that as a fallback in case we fail to find a fitting CPU at
all levels.

The intention in the original patch was not to allow a down migration to
unfitting CPU. But this missed the case where we are already running on
unfitting one.

With this change now RT tasks can still move between unfitting CPUs when
they're already running on such CPU.

And as Steve suggested; to adhere to the strict priority rules of RT, if
a task is already running on a fitting CPU but due to priority it can't
run on it, allow it to downmigrate to unfitting CPU so it can run.

Reported-by: Pavan Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
Link: https://lkml.kernel.org/r/20200302132721.8353-2-qais.yousef@arm.com
Link: https://lore.kernel.org/lkml/20200203142712.a7yvlyo2y3le5cpn@e107158-lin/
---
 kernel/sched/cpupri.c | 157 ++++++++++++++++++++++++++---------------
 1 file changed, 101 insertions(+), 56 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 1a2719e..1bcfa19 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -41,6 +41,59 @@ static int convert_prio(int prio)
 	return cpupri;
 }
 
+static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
+				struct cpumask *lowest_mask, int idx)
+{
+	struct cpupri_vec *vec  = &cp->pri_to_cpu[idx];
+	int skip = 0;
+
+	if (!atomic_read(&(vec)->count))
+		skip = 1;
+	/*
+	 * When looking at the vector, we need to read the counter,
+	 * do a memory barrier, then read the mask.
+	 *
+	 * Note: This is still all racey, but we can deal with it.
+	 *  Ideally, we only want to look at masks that are set.
+	 *
+	 *  If a mask is not set, then the only thing wrong is that we
+	 *  did a little more work than necessary.
+	 *
+	 *  If we read a zero count but the mask is set, because of the
+	 *  memory barriers, that can only happen when the highest prio
+	 *  task for a run queue has left the run queue, in which case,
+	 *  it will be followed by a pull. If the task we are processing
+	 *  fails to find a proper place to go, that pull request will
+	 *  pull this task if the run queue is running at a lower
+	 *  priority.
+	 */
+	smp_rmb();
+
+	/* Need to do the rmb for every iteration */
+	if (skip)
+		return 0;
+
+	if (cpumask_any_and(p->cpus_ptr, vec->mask) >= nr_cpu_ids)
+		return 0;
+
+	if (lowest_mask) {
+		cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
+
+		/*
+		 * We have to ensure that we have at least one bit
+		 * still set in the array, since the map could have
+		 * been concurrently emptied between the first and
+		 * second reads of vec->mask.  If we hit this
+		 * condition, simply act as though we never hit this
+		 * priority level and continue on.
+		 */
+		if (cpumask_empty(lowest_mask))
+			return 0;
+	}
+
+	return 1;
+}
+
 /**
  * cpupri_find - find the best (lowest-pri) CPU in the system
  * @cp: The cpupri context
@@ -62,80 +115,72 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
 		struct cpumask *lowest_mask,
 		bool (*fitness_fn)(struct task_struct *p, int cpu))
 {
-	int idx = 0;
 	int task_pri = convert_prio(p->prio);
+	int best_unfit_idx = -1;
+	int idx = 0, cpu;
 
 	BUG_ON(task_pri >= CPUPRI_NR_PRIORITIES);
 
 	for (idx = 0; idx < task_pri; idx++) {
-		struct cpupri_vec *vec  = &cp->pri_to_cpu[idx];
-		int skip = 0;
 
-		if (!atomic_read(&(vec)->count))
-			skip = 1;
-		/*
-		 * When looking at the vector, we need to read the counter,
-		 * do a memory barrier, then read the mask.
-		 *
-		 * Note: This is still all racey, but we can deal with it.
-		 *  Ideally, we only want to look at masks that are set.
-		 *
-		 *  If a mask is not set, then the only thing wrong is that we
-		 *  did a little more work than necessary.
-		 *
-		 *  If we read a zero count but the mask is set, because of the
-		 *  memory barriers, that can only happen when the highest prio
-		 *  task for a run queue has left the run queue, in which case,
-		 *  it will be followed by a pull. If the task we are processing
-		 *  fails to find a proper place to go, that pull request will
-		 *  pull this task if the run queue is running at a lower
-		 *  priority.
-		 */
-		smp_rmb();
-
-		/* Need to do the rmb for every iteration */
-		if (skip)
-			continue;
-
-		if (cpumask_any_and(p->cpus_ptr, vec->mask) >= nr_cpu_ids)
+		if (!__cpupri_find(cp, p, lowest_mask, idx))
 			continue;
 
-		if (lowest_mask) {
-			int cpu;
+		if (!lowest_mask || !fitness_fn)
+			return 1;
 
-			cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
+		/* Ensure the capacity of the CPUs fit the task */
+		for_each_cpu(cpu, lowest_mask) {
+			if (!fitness_fn(p, cpu))
+				cpumask_clear_cpu(cpu, lowest_mask);
+		}
 
+		/*
+		 * If no CPU at the current priority can fit the task
+		 * continue looking
+		 */
+		if (cpumask_empty(lowest_mask)) {
 			/*
-			 * We have to ensure that we have at least one bit
-			 * still set in the array, since the map could have
-			 * been concurrently emptied between the first and
-			 * second reads of vec->mask.  If we hit this
-			 * condition, simply act as though we never hit this
-			 * priority level and continue on.
+			 * Store our fallback priority in case we
+			 * didn't find a fitting CPU
 			 */
-			if (cpumask_empty(lowest_mask))
-				continue;
+			if (best_unfit_idx == -1)
+				best_unfit_idx = idx;
 
-			if (!fitness_fn)
-				return 1;
-
-			/* Ensure the capacity of the CPUs fit the task */
-			for_each_cpu(cpu, lowest_mask) {
-				if (!fitness_fn(p, cpu))
-					cpumask_clear_cpu(cpu, lowest_mask);
-			}
-
-			/*
-			 * If no CPU at the current priority can fit the task
-			 * continue looking
-			 */
-			if (cpumask_empty(lowest_mask))
-				continue;
+			continue;
 		}
 
 		return 1;
 	}
 
+	/*
+	 * If we failed to find a fitting lowest_mask, make sure we fall back
+	 * to the last known unfitting lowest_mask.
+	 *
+	 * Note that the map of the recorded idx might have changed since then,
+	 * so we must ensure to do the full dance to make sure that level still
+	 * holds a valid lowest_mask.
+	 *
+	 * As per above, the map could have been concurrently emptied while we
+	 * were busy searching for a fitting lowest_mask at the other priority
+	 * levels.
+	 *
+	 * This rule favours honouring priority over fitting the task in the
+	 * correct CPU (Capacity Awareness being the only user now).
+	 * The idea is that if a higher priority task can run, then it should
+	 * run even if this ends up being on unfitting CPU.
+	 *
+	 * The cost of this trade-off is not entirely clear and will probably
+	 * be good for some workloads and bad for others.
+	 *
+	 * The main idea here is that if some CPUs were overcommitted, we try
+	 * to spread which is what the scheduler traditionally did. Sys admins
+	 * must do proper RT planning to avoid overloading the system if they
+	 * really care.
+	 */
+	if (best_unfit_idx != -1)
+		return __cpupri_find(cp, p, lowest_mask, best_unfit_idx);
+
 	return 0;
 }
 
