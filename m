Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1DBC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0010E2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405871AbgBNQkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:40:02 -0500
Received: from foss.arm.com ([217.140.110.172]:39250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405845AbgBNQj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:39:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52D51101E;
        Fri, 14 Feb 2020 08:39:59 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB13E3F68E;
        Fri, 14 Feb 2020 08:39:57 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 1/3] sched/rt: cpupri_find: implement fallback mechanism for !fit case
Date:   Fri, 14 Feb 2020 16:39:47 +0000
Message-Id: <20200214163949.27850-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214163949.27850-1-qais.yousef@arm.com>
References: <20200214163949.27850-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/sched/cpupri.c | 157 +++++++++++++++++++++++++++---------------
 1 file changed, 101 insertions(+), 56 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 1a2719e1350a..1bcfa1995550 100644
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
 
-- 
2.17.1

