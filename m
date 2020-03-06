Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30C7C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59172146E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCFOmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53748 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgCFOmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAv-0006Hm-5C; Fri, 06 Mar 2020 15:42:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C4F931C21D5;
        Fri,  6 Mar 2020 15:42:04 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:04 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Optimize cpupri_find() on
 non-heterogenous systems
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200302132721.8353-4-qais.yousef@arm.com>
References: <20200302132721.8353-4-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158350572453.28353.9922528021955517987.tip-bot2@tip-bot2>
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

Commit-ID:     a1bd02e1f28b1939cac8c64072a0e578c3cbc345
Gitweb:        https://git.kernel.org/tip/a1bd02e1f28b1939cac8c64072a0e578c3cbc345
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 02 Mar 2020 13:27:18 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:27 +01:00

sched/rt: Optimize cpupri_find() on non-heterogenous systems

By introducing a new cpupri_find_fitness() function that takes the
fitness_fn as an argument and only called when asym_system static key is
enabled.

cpupri_find() is now a wrapper function that calls cpupri_find_fitness()
passing NULL as a fitness_fn, hence disabling the logic that handles
fitness by default.

LINK: https://lore.kernel.org/lkml/c0772fca-0a4b-c88d-fdf2-5715fcf8447b@arm.com/
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
Link: https://lkml.kernel.org/r/20200302132721.8353-4-qais.yousef@arm.com
---
 kernel/sched/cpupri.c | 10 ++++++++--
 kernel/sched/cpupri.h |  6 ++++--
 kernel/sched/rt.c     | 23 +++++++++++++++++++----
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 1bcfa19..dd3f16d 100644
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
index 32dd520..efbb492 100644
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
index f0071fa..29a8695 100644
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
