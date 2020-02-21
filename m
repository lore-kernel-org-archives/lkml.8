Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2874C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A40206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgBUPJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:09:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:41730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbgBUPJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:09:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16E40B232;
        Fri, 21 Feb 2020 15:09:10 +0000 (UTC)
Date:   Fri, 21 Feb 2020 15:09:05 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com, hdanton@sina.com
Subject: Re: [PATCH v4 0/5] remove runnable_load_avg and improve
 group_classify
Message-ID: <20200221150904.GU3420@suse.de>
References: <20200221132715.20648-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200221132715.20648-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 02:27:10PM +0100, Vincent Guittot wrote:
> This new version stays quite close to the previous one and should 
> replace without problems the previous one that part of Mel's patchset:
> https://lkml.org/lkml/2020/2/14/156
> 

Thanks Vincent, just in time for tests to run over the weekend!

I can confirm the patches slotted in easily into a yet-to-be-relased v6
of my series that still has my fix inserted after patch 2. After looking
at your series, I see only patches 3-5 need to be retested as well as
my own patches on top. This should take less time as I can reuse some of
the old results. I'll post v6 if the tests complete successfully.

The overall diff is as follows in case you want to double check it is
what you expect.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3060ba94e813..3f51586365f3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -740,10 +740,8 @@ void init_entity_runnable_average(struct sched_entity *se)
 	 * Group entities are initialized with zero load to reflect the fact that
 	 * nothing has been attached to the task group yet.
 	 */
-	if (entity_is_task(se)) {
-		sa->runnable_avg = SCHED_CAPACITY_SCALE;
+	if (entity_is_task(se))
 		sa->load_avg = scale_load_down(se->load.weight);
-	}
 
 	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
 }
@@ -796,6 +794,8 @@ void post_init_entity_util_avg(struct task_struct *p)
 		}
 	}
 
+	sa->runnable_avg = cpu_scale;
+
 	if (p->sched_class != &fair_sched_class) {
 		/*
 		 * For !fair tasks do:
@@ -3083,9 +3083,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 #endif
 
 	enqueue_load_avg(cfs_rq, se);
-	if (se->on_rq) {
+	if (se->on_rq)
 		account_entity_enqueue(cfs_rq, se);
-	}
+
 }
 
 void reweight_task(struct task_struct *p, int prio)
@@ -5613,6 +5613,24 @@ static unsigned long cpu_runnable(struct rq *rq)
 	return cfs_rq_runnable_avg(&rq->cfs);
 }
 
+static unsigned long cpu_runnable_without(struct rq *rq, struct task_struct *p)
+{
+	struct cfs_rq *cfs_rq;
+	unsigned int runnable;
+
+	/* Task has no contribution or is new */
+	if (cpu_of(rq) != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+		return cpu_runnable(rq);
+
+	cfs_rq = &rq->cfs;
+	runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
+
+	/* Discount task's runnable from CPU's runnable */
+	lsub_positive(&runnable, p->se.avg.runnable_avg);
+
+	return runnable;
+}
+
 static unsigned long capacity_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity;
@@ -8521,6 +8539,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
 		sgs->group_load += cpu_load_without(rq, p);
 		sgs->group_util += cpu_util_without(i, p);
+		sgs->group_runnable += cpu_runnable_without(rq, p);
 		local = task_running_on_cpu(i, p);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running - local;
 
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 2cc88d9e3b38..c40d57a2a248 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -267,8 +267,6 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  *   load_sum := runnable
  *   load_avg = se_weight(se) * load_sum
  *
- * XXX collapse load_sum and runnable_load_sum
- *
  * cfq_rq:
  *
  *   runnable_sum = \Sum se->avg.runnable_sum
@@ -325,7 +323,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
  *   util_sum = cpu_scale * load_sum
  *   runnable_sum = util_sum
  *
- *   load_avg and runnable_load_avg are not supported and meaningless.
+ *   load_avg and runnable_avg are not supported and meaningless.
  *
  */
 
@@ -351,7 +349,7 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
  *   util_sum = cpu_scale * load_sum
  *   runnable_sum = util_sum
  *
- *   load_avg and runnable_load_avg are not supported and meaningless.
+ *   load_avg and runnable_avg are not supported and meaningless.
  *
  */
 
@@ -378,7 +376,7 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
  *   util_sum = cpu_scale * load_sum
  *   runnable_sum = util_sum
  *
- *   load_avg and runnable_load_avg are not supported and meaningless.
+ *   load_avg and runnable_avg are not supported and meaningless.
  *
  */
 
