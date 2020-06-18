Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4635EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F49208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgFRTzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:55:48 -0400
Received: from foss.arm.com ([217.140.110.172]:58790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730193AbgFRTzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:55:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B5D2D6E;
        Thu, 18 Jun 2020 12:55:46 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10BE43F73C;
        Thu, 18 Jun 2020 12:55:43 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sched/uclamp: Protect uclamp fast path code with static key
Date:   Thu, 18 Jun 2020 20:55:25 +0100
Message-Id: <20200618195525.7889-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618195525.7889-1-qais.yousef@arm.com>
References: <20200618195525.7889-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a report that when uclamp is enabled, a netperf UDP test
regresses compared to a kernel compiled without uclamp.

https://lore.kernel.org/lkml/20200529100806.GA3070@suse.de/

While investigating the root cause, there were no sign that the uclamp
code is doing anything particularly expensive but could suffer from bad
cache behavior under certain circumstances that are yet to be
understood.

https://lore.kernel.org/lkml/20200616110824.dgkkbyapn3io6wik@e107158-lin/

To reduce the pressure on the fast path anyway, add a static key that is
by default will skip executing uclamp logic in the
enqueue/dequeue_task() fast path in the until it's needed.

As soon as the user start using util clamp by:

	1. Changing uclamp value of a task with sched_setattr()
	2. Modifying the default sysctl_sched_util_clamp_{min, max}
	3. Modifying the default cpu.uclamp.{min, max} value in cgroup

We flip the static key now that the user has opted to use util clamp.
Effectively re-introducing uclamp logic in the enqueue/dequeue_task()
fast path. It stays on from that point forward until the next reboot.

This should help minimize the effect of util clamp on workloads that
don't need it but still allow distros to ship their kernels with uclamp
compiled in by default.

SCHED_WARN_ON() in uclamp_rq_dec_id() was removed since now we can end
up with unbalanced call to uclamp_rq_dec_id() if we flip the key while
a task is running in the rq. Since we know it is harmless we just
quietly return if we attempt a uclamp_rq_dec_id() when
rq->uclamp[].bucket[].tasks is 0.

The following results demonstrates how this helps on 2 Sockets Xeon E5
2x10-Cores system.

                                   nouclamp                 uclamp      uclamp-static-key
Hmean     send-64         162.43 (   0.00%)      157.84 *  -2.82%*      163.39 *   0.59%*
Hmean     send-128        324.71 (   0.00%)      314.78 *  -3.06%*      326.18 *   0.45%*
Hmean     send-256        641.55 (   0.00%)      628.67 *  -2.01%*      648.12 *   1.02%*
Hmean     send-1024      2525.28 (   0.00%)     2448.26 *  -3.05%*     2543.73 *   0.73%*
Hmean     send-2048      4836.14 (   0.00%)     4712.08 *  -2.57%*     4867.69 *   0.65%*
Hmean     send-3312      7540.83 (   0.00%)     7425.45 *  -1.53%*     7621.06 *   1.06%*
Hmean     send-4096      9124.53 (   0.00%)     8948.82 *  -1.93%*     9276.25 *   1.66%*
Hmean     send-8192     15589.67 (   0.00%)    15486.35 *  -0.66%*    15819.98 *   1.48%*
Hmean     send-16384    26386.47 (   0.00%)    25752.25 *  -2.40%*    26773.74 *   1.47%*

Reported-by: Mel Gorman <mgorman@suse.de>
Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
CC: Patrick Bellasi <patrick.bellasi@matbug.net>
Cc: Chris Redpath <chrid.redpath@arm.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org
---

This takes a different approach to PSI which introduces a config option

```
      CONFIG_PSI_DEFAULT_DISABLED

        Require boot parameter to enable pressure stall information
        tracking (NEW)

      boot param psi
```

via commit e0c274472d5d "psi: make disabling/enabling easier for vendor kernels"

uclamp has a clearer points of entry when userspace would like to use it so we
can automatically flip the switch if the kernel is running on a userspace that
wants to user utilclamp without any extra userspace visible switches.

I wanted to make this dependent on schedutil being the governor too, but beside
the complexity, uclamp is used for capacity awareness. We could certainly
construct a more complex condition, but I'm not sure it's worth it. Open to
hear more opinions and points of views on this :)


 kernel/sched/core.c | 56 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e19d2b915406..0824e1bfb484 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -793,6 +793,25 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
+/*
+ * This static key is used to reduce the uclamp overhead in the fast path. It
+ * only disables the call to uclamp_rq_{inc, dec}() in enqueue/dequeue_task().
+ *
+ * This allows users to continue to enable uclamp in their kernel config with
+ * minimum uclamp overhead in the fast path.
+ *
+ * As soon as userspace modifies any of the uclamp knobs, the static key is
+ * disabled, since we have an actual users that make use of uclamp
+ * functionality.
+ *
+ * The knobs that would disable this static key are:
+ *
+ *   * A task modifying its uclamp value with sched_setattr().
+ *   * An admin modifying the sysctl_sched_uclamp_{min, max} via procfs.
+ *   * An admin modifying the cgroup cpu.uclamp.{min, max}
+ */
+DEFINE_STATIC_KEY_TRUE(sched_uclamp_unused);
+
 /* Integer rounded range for each bucket */
 #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
 
@@ -993,9 +1012,16 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	lockdep_assert_held(&rq->lock);
 
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
-	SCHED_WARN_ON(!bucket->tasks);
-	if (likely(bucket->tasks))
-		bucket->tasks--;
+
+	/*
+	 * This could happen if sched_uclamp_unused was disabled while the
+	 * current task was running, hence we could end up with unbalanced call
+	 * to uclamp_rq_dec_id().
+	 */
+	if (unlikely(!bucket->tasks))
+		return;
+
+	bucket->tasks--;
 	uc_se->active = false;
 
 	/*
@@ -1031,6 +1057,9 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
+	if (static_branch_likely(&sched_uclamp_unused))
+		return;
+
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
@@ -1046,6 +1075,9 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
+	if (static_branch_likely(&sched_uclamp_unused))
+		return;
+
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
@@ -1155,9 +1187,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		update_root_tg = true;
 	}
 
-	if (update_root_tg)
+	if (update_root_tg) {
 		uclamp_update_root_tg();
 
+		if (static_branch_unlikely(&sched_uclamp_unused))
+			static_branch_disable(&sched_uclamp_unused);
+	}
+
 	/*
 	 * We update all RUNNABLE tasks only when task groups are in use.
 	 * Otherwise, keep it simple and do just a lazy update at each next
@@ -1221,6 +1257,9 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
 		return;
 
+	if (static_branch_unlikely(&sched_uclamp_unused))
+		static_branch_disable(&sched_uclamp_unused);
+
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
 			      attr->sched_util_min, true);
@@ -1260,6 +1299,8 @@ static void __init init_uclamp_rq(struct rq *rq)
 
 		uc_rq[clamp_id].value = uclamp_none(clamp_id);
 	}
+
+	rq->uclamp_flags = 0;
 }
 
 static void __init init_uclamp(void)
@@ -1270,10 +1311,8 @@ static void __init init_uclamp(void)
 
 	mutex_init(&uclamp_mutex);
 
-	for_each_possible_cpu(cpu) {
+	for_each_possible_cpu(cpu)
 		init_uclamp_rq(cpu_rq(cpu));
-		cpu_rq(cpu)->uclamp_flags = 0;
-	}
 
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&init_task.uclamp_req[clamp_id],
@@ -7315,6 +7354,9 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	if (req.ret)
 		return req.ret;
 
+	if (static_branch_unlikely(&sched_uclamp_unused))
+		static_branch_disable(&sched_uclamp_unused);
+
 	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
 
-- 
2.17.1

