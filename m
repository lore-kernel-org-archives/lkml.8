Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC3BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D64206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IY53g0Jy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nULTFBhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGIIqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:46:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34832 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgGIIqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:46:00 -0400
Date:   Thu, 09 Jul 2020 08:45:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594284357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n800VljcrfaTpGsn4dBJegwqZaa/7kZbw3tfRVvjYBo=;
        b=IY53g0JywtEAk40qOeDPbpdVd0KbKNcD9iklBxcOS92KgMUwOMvghWoeBH9DlfL9d4e7A8
        cONrW7uDN8tUUnsHSOXhgEIcUMa7eCueK5tfB1/OTk3E5lv/9sGlnpRnnEumxSWee6kh7R
        2H0bNFG3NLmgcy83/oWt4ZEI7dqIpYcQviuKbltoFAK+XOgsQHX5+dt4o0KKdJxNE+DC/I
        jWEViJJEQhlPTdiq/aBMxHe0wQW1SbeyzSktJ143yrtk5isHLp3fNXMyTl74AMQApnE2P4
        QpAaoUWTvWdyYx7qeHUg0UVj9P1vPCUKlqttb4ZZf8Sd65csxftPg5hNqscYDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594284357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n800VljcrfaTpGsn4dBJegwqZaa/7kZbw3tfRVvjYBo=;
        b=nULTFBhwZyi3+/GdiLV86CriKCHtSPtn0VFJHUU2wPXa0ThXOLopvtwcwQb42ZPg9eDkYo
        suBKbarpsyHn6sDw==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Protect uclamp fast path code with static key
Cc:     Mel Gorman <mgorman@suse.de>, Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lukasz Luba <lukasz.luba@arm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200630112123.12076-3-qais.yousef@arm.com>
References: <20200630112123.12076-3-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <159428435654.4006.4995358747907000800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     46609ce227039fd192e0ecc7d940bed587fd2c78
Gitweb:        https://git.kernel.org/tip/46609ce227039fd192e0ecc7d940bed587fd2c78
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Tue, 30 Jun 2020 12:21:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:39:01 +02:00

sched/uclamp: Protect uclamp fast path code with static key

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

Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
Reported-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lkml.kernel.org/r/20200630112123.12076-3-qais.yousef@arm.com
---
 kernel/sched/core.c              | 74 ++++++++++++++++++++++++++++++-
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/sched.h             | 47 +++++++++++++++++++-
 3 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9605db7..4cf30e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -796,6 +796,26 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
+/*
+ * This static key is used to reduce the uclamp overhead in the fast path. It
+ * primarily disables the call to uclamp_rq_{inc, dec}() in
+ * enqueue/dequeue_task().
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
+DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
+
 /* Integer rounded range for each bucket */
 #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
 
@@ -992,10 +1012,38 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 
 	lockdep_assert_held(&rq->lock);
 
+	/*
+	 * If sched_uclamp_used was enabled after task @p was enqueued,
+	 * we could end up with unbalanced call to uclamp_rq_dec_id().
+	 *
+	 * In this case the uc_se->active flag should be false since no uclamp
+	 * accounting was performed at enqueue time and we can just return
+	 * here.
+	 *
+	 * Need to be careful of the following enqeueue/dequeue ordering
+	 * problem too
+	 *
+	 *	enqueue(taskA)
+	 *	// sched_uclamp_used gets enabled
+	 *	enqueue(taskB)
+	 *	dequeue(taskA)
+	 *	// Must not decrement bukcet->tasks here
+	 *	dequeue(taskB)
+	 *
+	 * where we could end up with stale data in uc_se and
+	 * bucket[uc_se->bucket_id].
+	 *
+	 * The following check here eliminates the possibility of such race.
+	 */
+	if (unlikely(!uc_se->active))
+		return;
+
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
+
 	SCHED_WARN_ON(!bucket->tasks);
 	if (likely(bucket->tasks))
 		bucket->tasks--;
+
 	uc_se->active = false;
 
 	/*
@@ -1023,6 +1071,15 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
+	/*
+	 * Avoid any overhead until uclamp is actually used by the userspace.
+	 *
+	 * The condition is constructed such that a NOP is generated when
+	 * sched_uclamp_used is disabled.
+	 */
+	if (!static_branch_unlikely(&sched_uclamp_used))
+		return;
+
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
@@ -1038,6 +1095,15 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
+	/*
+	 * Avoid any overhead until uclamp is actually used by the userspace.
+	 *
+	 * The condition is constructed such that a NOP is generated when
+	 * sched_uclamp_used is disabled.
+	 */
+	if (!static_branch_unlikely(&sched_uclamp_used))
+		return;
+
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
@@ -1146,8 +1212,10 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		update_root_tg = true;
 	}
 
-	if (update_root_tg)
+	if (update_root_tg) {
+		static_branch_enable(&sched_uclamp_used);
 		uclamp_update_root_tg();
+	}
 
 	/*
 	 * We update all RUNNABLE tasks only when task groups are in use.
@@ -1212,6 +1280,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
 		return;
 
+	static_branch_enable(&sched_uclamp_used);
+
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
 			      attr->sched_util_min, true);
@@ -7436,6 +7506,8 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	if (req.ret)
 		return req.ret;
 
+	static_branch_enable(&sched_uclamp_used);
+
 	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7fbaee2..dc6835b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -210,7 +210,7 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
 	unsigned long dl_util, util, irq;
 	struct rq *rq = cpu_rq(cpu);
 
-	if (!IS_BUILTIN(CONFIG_UCLAMP_TASK) &&
+	if (!uclamp_is_used() &&
 	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
 		return max;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9bef2dd..b1432f6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -878,6 +878,8 @@ struct uclamp_rq {
 	unsigned int value;
 	struct uclamp_bucket bucket[UCLAMP_BUCKETS];
 };
+
+DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
 #endif /* CONFIG_UCLAMP_TASK */
 
 /*
@@ -2365,12 +2367,35 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #ifdef CONFIG_UCLAMP_TASK
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
+/**
+ * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
+ * @rq:		The rq to clamp against. Must not be NULL.
+ * @util:	The util value to clamp.
+ * @p:		The task to clamp against. Can be NULL if you want to clamp
+ *		against @rq only.
+ *
+ * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
+ *
+ * If sched_uclamp_used static key is disabled, then just return the util
+ * without any clamping since uclamp aggregation at the rq level in the fast
+ * path is disabled, rendering this operation a NOP.
+ *
+ * Use uclamp_eff_value() if you don't care about uclamp values at rq level. It
+ * will return the correct effective uclamp value of the task even if the
+ * static key is disabled.
+ */
 static __always_inline
 unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 				  struct task_struct *p)
 {
-	unsigned long min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
-	unsigned long max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
+	unsigned long min_util;
+	unsigned long max_util;
+
+	if (!static_branch_likely(&sched_uclamp_used))
+		return util;
+
+	min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
+	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
 
 	if (p) {
 		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
@@ -2387,6 +2412,19 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 
 	return clamp(util, min_util, max_util);
 }
+
+/*
+ * When uclamp is compiled in, the aggregation at rq level is 'turned off'
+ * by default in the fast path and only gets turned on once userspace performs
+ * an operation that requires it.
+ *
+ * Returns true if userspace opted-in to use uclamp and aggregation at rq level
+ * hence is active.
+ */
+static inline bool uclamp_is_used(void)
+{
+	return static_branch_likely(&sched_uclamp_used);
+}
 #else /* CONFIG_UCLAMP_TASK */
 static inline
 unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
@@ -2394,6 +2432,11 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 {
 	return util;
 }
+
+static inline bool uclamp_is_used(void)
+{
+	return false;
+}
 #endif /* CONFIG_UCLAMP_TASK */
 
 #ifdef arch_scale_freq_capacity
