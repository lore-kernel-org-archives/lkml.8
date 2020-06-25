Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C900BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E912080C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405874AbgFYPoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:44:09 -0400
Received: from foss.arm.com ([217.140.110.172]:58306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405159AbgFYPoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:44:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06BBB1045;
        Thu, 25 Jun 2020 08:44:06 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256743F6CF;
        Thu, 25 Jun 2020 08:44:04 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] sched/uclamp: Protect uclamp fast path code with static key
Date:   Thu, 25 Jun 2020 16:43:52 +0100
Message-Id: <20200625154352.24767-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625154352.24767-1-qais.yousef@arm.com>
References: <20200625154352.24767-1-qais.yousef@arm.com>
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
enqueue/dequeue_task() fast path until it's needed.

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

In schedutil, we introduce a new uclamp_is_enabled() helper which takes
the static key into account to ensure RT boosting behavior is retained.

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

The perf diff between nouclamp and uclamp-static-key when uclamp is
disabled in the fast path:

     8.73%     -1.55%  [kernel.kallsyms]        [k] try_to_wake_up
     0.07%     +0.04%  [kernel.kallsyms]        [k] deactivate_task
     0.13%     -0.02%  [kernel.kallsyms]        [k] activate_task

The diff between nouclamp and uclamp-static-key when uclamp is enabled
in the fast path:

     8.73%     -0.72%  [kernel.kallsyms]        [k] try_to_wake_up
     0.13%     +0.39%  [kernel.kallsyms]        [k] activate_task
     0.07%     +0.38%  [kernel.kallsyms]        [k] deactivate_task

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
Cc: Chris Redpath <chris.redpath@arm.com>
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


 kernel/sched/core.c              | 59 +++++++++++++++++++++++++++++---
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/sched.h             |  7 ++++
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 235b2cae00a0..e2f1fffa013c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -794,6 +794,25 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
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
+ * enabled, since we have an actual users that make use of uclamp
+ * functionality.
+ *
+ * The knobs that would enable this static key are:
+ *
+ *   * A task modifying its uclamp value with sched_setattr().
+ *   * An admin modifying the sysctl_sched_uclamp_{min, max} via procfs.
+ *   * An admin modifying the cgroup cpu.uclamp.{min, max}
+ */
+static DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
+
 /* Integer rounded range for each bucket */
 #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
 
@@ -994,9 +1013,16 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	lockdep_assert_held(&rq->lock);
 
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
-	SCHED_WARN_ON(!bucket->tasks);
-	if (likely(bucket->tasks))
-		bucket->tasks--;
+
+	/*
+	 * This could happen if sched_uclamp_used was enabled while the
+	 * current task was running, hence we could end up with unbalanced call
+	 * to uclamp_rq_dec_id().
+	 */
+	if (unlikely(!bucket->tasks))
+		return;
+
+	bucket->tasks--;
 	uc_se->active = false;
 
 	/*
@@ -1032,6 +1058,13 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
+	/*
+	 * Avoid any overhead until uclamp is actually used by the userspace.
+	 * Including the branch if we use static_branch_likely()
+	 */
+	if (!static_branch_unlikely(&sched_uclamp_used))
+		return;
+
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
@@ -1047,6 +1080,13 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
+	/*
+	 * Avoid any overhead until uclamp is actually used by the userspace.
+	 * Including the branch if we use static_branch_likely()
+	 */
+	if (!static_branch_unlikely(&sched_uclamp_used))
+		return;
+
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
@@ -1155,8 +1195,10 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		update_root_tg = true;
 	}
 
-	if (update_root_tg)
+	if (update_root_tg) {
+		static_branch_enable(&sched_uclamp_used);
 		uclamp_update_root_tg();
+	}
 
 	/*
 	 * We update all RUNNABLE tasks only when task groups are in use.
@@ -1221,6 +1263,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
 		return;
 
+	static_branch_enable(&sched_uclamp_used);
+
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
 			      attr->sched_util_min, true);
@@ -1289,6 +1333,11 @@ static void __init init_uclamp(void)
 	}
 }
 
+bool uclamp_is_enabled(void)
+{
+	return static_branch_likely(&sched_uclamp_used);
+}
+
 #else /* CONFIG_UCLAMP_TASK */
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
@@ -7387,6 +7436,8 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	if (req.ret)
 		return req.ret;
 
+	static_branch_enable(&sched_uclamp_used);
+
 	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7fbaee24c824..3f4e296ccb67 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -210,7 +210,7 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
 	unsigned long dl_util, util, irq;
 	struct rq *rq = cpu_rq(cpu);
 
-	if (!IS_BUILTIN(CONFIG_UCLAMP_TASK) &&
+	if (!uclamp_is_enabled() &&
 	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
 		return max;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1d4e94c1e5fe..aff5430331e4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2371,6 +2371,8 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 
 	return clamp(util, min_util, max_util);
 }
+
+bool uclamp_is_enabled(void);
 #else /* CONFIG_UCLAMP_TASK */
 static inline
 unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
@@ -2378,6 +2380,11 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 {
 	return util;
 }
+
+static inline bool uclamp_is_enabled(void)
+{
+	return false;
+}
 #endif /* CONFIG_UCLAMP_TASK */
 
 #ifdef arch_scale_freq_capacity
-- 
2.17.1

