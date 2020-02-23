Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDE9C35666
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 18:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C146020836
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 18:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgBWSkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 13:40:15 -0500
Received: from foss.arm.com ([217.140.110.172]:50504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWSkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 13:40:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63CAD101E;
        Sun, 23 Feb 2020 10:40:13 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E71D33F703;
        Sun, 23 Feb 2020 10:40:11 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 3/6] sched/rt: Optimize cpupri_find on non-heterogenous systems
Date:   Sun, 23 Feb 2020 18:39:58 +0000
Message-Id: <20200223184001.14248-4-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200223184001.14248-1-qais.yousef@arm.com>
References: <20200223184001.14248-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By introducing a new cpupri_find_fitness() function that takes the
fitness_fn as an argument and only called when asym_system static key is
enabled.

cpupri_find() is now a wrapper function that calls cpupri_find_fitness()
passing NULL as a fitness_fn, hence disabling the logic that handles
fitness by default.

Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
LINK: https://lore.kernel.org/lkml/c0772fca-0a4b-c88d-fdf2-5715fcf8447b@arm.com/
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/cpupri.c | 10 ++++++++--
 kernel/sched/cpupri.h |  6 ++++--
 kernel/sched/rt.c     | 23 +++++++++++++++++++----
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 1bcfa1995550..dd3f16d1a04a 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -94,8 +94,14 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 	return 1;
 }
 
+int cpupri_find(struct cpupri *cp, struct task_struct *p,
+		struct cpumask *lowest_mask)
+{
+	return cpupri_find_fitness(cp, p, lowest_mask, NULL);
+}
+
 /**
- * cpupri_find - find the best (lowest-pri) CPU in the system
+ * cpupri_find_fitness - find the best (lowest-pri) CPU in the system
  * @cp: The cpupri context
  * @p: The task
  * @lowest_mask: A mask to fill in with selected CPUs (or NULL)
@@ -111,7 +117,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
  *
  * Return: (int)bool - CPUs were found
  */
-int cpupri_find(struct cpupri *cp, struct task_struct *p,
+int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 		struct cpumask *lowest_mask,
 		bool (*fitness_fn)(struct task_struct *p, int cpu))
 {
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index 32dd520db11f..efbb492bb94c 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -19,8 +19,10 @@ struct cpupri {
 
 #ifdef CONFIG_SMP
 int  cpupri_find(struct cpupri *cp, struct task_struct *p,
-		 struct cpumask *lowest_mask,
-		 bool (*fitness_fn)(struct task_struct *p, int cpu));
+		 struct cpumask *lowest_mask);
+int  cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
+			 struct cpumask *lowest_mask,
+			 bool (*fitness_fn)(struct task_struct *p, int cpu));
 void cpupri_set(struct cpupri *cp, int cpu, int pri);
 int  cpupri_init(struct cpupri *cp);
 void cpupri_cleanup(struct cpupri *cp);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2c3fae637cef..e48d7c215aee 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1504,7 +1504,7 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 	 * let's hope p can move out.
 	 */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpupri_find(&rq->rd->cpupri, rq->curr, NULL, NULL))
+	    !cpupri_find(&rq->rd->cpupri, rq->curr, NULL))
 		return;
 
 	/*
@@ -1512,7 +1512,7 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 	 * see if it is pushed or pulled somewhere else.
 	 */
 	if (p->nr_cpus_allowed != 1 &&
-	    cpupri_find(&rq->rd->cpupri, p, NULL, NULL))
+	    cpupri_find(&rq->rd->cpupri, p, NULL))
 		return;
 
 	/*
@@ -1691,6 +1691,7 @@ static int find_lowest_rq(struct task_struct *task)
 	struct cpumask *lowest_mask = this_cpu_cpumask_var_ptr(local_cpu_mask);
 	int this_cpu = smp_processor_id();
 	int cpu      = task_cpu(task);
+	int ret;
 
 	/* Make sure the mask is initialized first */
 	if (unlikely(!lowest_mask))
@@ -1699,8 +1700,22 @@ static int find_lowest_rq(struct task_struct *task)
 	if (task->nr_cpus_allowed == 1)
 		return -1; /* No other targets possible */
 
-	if (!cpupri_find(&task_rq(task)->rd->cpupri, task, lowest_mask,
-			 rt_task_fits_capacity))
+	/*
+	 * If we're on asym system ensure we consider the different capacities
+	 * of the CPUs when searching for the lowest_mask.
+	 */
+	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+
+		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
+					  task, lowest_mask,
+					  rt_task_fits_capacity);
+	} else {
+
+		ret = cpupri_find(&task_rq(task)->rd->cpupri,
+				  task, lowest_mask);
+	}
+
+	if (!ret)
 		return -1; /* No targets found */
 
 	/*
-- 
2.17.1

