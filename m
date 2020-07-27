Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD65C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2FB2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgG0K7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:59:49 -0400
Received: from foss.arm.com ([217.140.110.172]:41800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgG0K7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:59:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 279CF30E;
        Mon, 27 Jul 2020 03:59:48 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C9AB3F66E;
        Mon, 27 Jul 2020 03:59:46 -0700 (PDT)
From:   vincent.donnefort@arm.com
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH] sched/fair: provide u64 read for 32-bits arch helper
Date:   Mon, 27 Jul 2020 11:59:24 +0100
Message-Id: <1595847564-239957-1-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

Introducing two macro helpers u64_32read() and u64_32read_set_copy() to
factorize the u64 vminruntime and last_update_time read on a 32-bits
architecture. Those new helpers encapsulate smp_rmb() and smp_wmb()
synchronization and therefore, have a small penalty in set_task_rq_fair()
and init_cfs_rq().

The choice of using a macro over an inline function is driven by the
conditional u64 variable copy declarations.

  #ifndef CONFIG_64BIT
     u64 [vminruntime|last_update_time]_copy;
  #endif

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a05..00a825d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -563,10 +563,8 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 
 	/* ensure we never gain time by being placed backwards. */
 	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);
-#ifndef CONFIG_64BIT
-	smp_wmb();
-	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
-#endif
+
+	u64_32read_set_copy(cfs_rq->min_vruntime, cfs_rq->min_vruntime_copy);
 }
 
 /*
@@ -3284,6 +3282,11 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 }
 
 #ifdef CONFIG_SMP
+static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
+{
+	return u64_32read(cfs_rq->avg.last_update_time,
+			  cfs_rq->load_last_update_time_copy);
+}
 #ifdef CONFIG_FAIR_GROUP_SCHED
 /**
  * update_tg_load_avg - update the tg's load avg
@@ -3340,27 +3343,9 @@ void set_task_rq_fair(struct sched_entity *se,
 	if (!(se->avg.last_update_time && prev))
 		return;
 
-#ifndef CONFIG_64BIT
-	{
-		u64 p_last_update_time_copy;
-		u64 n_last_update_time_copy;
-
-		do {
-			p_last_update_time_copy = prev->load_last_update_time_copy;
-			n_last_update_time_copy = next->load_last_update_time_copy;
-
-			smp_rmb();
+	p_last_update_time = cfs_rq_last_update_time(prev);
+	n_last_update_time = cfs_rq_last_update_time(next);
 
-			p_last_update_time = prev->avg.last_update_time;
-			n_last_update_time = next->avg.last_update_time;
-
-		} while (p_last_update_time != p_last_update_time_copy ||
-			 n_last_update_time != n_last_update_time_copy);
-	}
-#else
-	p_last_update_time = prev->avg.last_update_time;
-	n_last_update_time = next->avg.last_update_time;
-#endif
 	__update_load_avg_blocked_se(p_last_update_time, se);
 	se->avg.last_update_time = n_last_update_time;
 }
@@ -3681,10 +3666,8 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 	decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
 
-#ifndef CONFIG_64BIT
-	smp_wmb();
-	cfs_rq->load_last_update_time_copy = sa->last_update_time;
-#endif
+	u64_32read_set_copy(sa->last_update_time,
+			    cfs_rq->load_last_update_time_copy);
 
 	return decayed;
 }
@@ -3810,27 +3793,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	}
 }
 
-#ifndef CONFIG_64BIT
-static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
-{
-	u64 last_update_time_copy;
-	u64 last_update_time;
-
-	do {
-		last_update_time_copy = cfs_rq->load_last_update_time_copy;
-		smp_rmb();
-		last_update_time = cfs_rq->avg.last_update_time;
-	} while (last_update_time != last_update_time_copy);
-
-	return last_update_time;
-}
-#else
-static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
-{
-	return cfs_rq->avg.last_update_time;
-}
-#endif
-
 /*
  * Synchronize entity load avg of dequeued entity without locking
  * the previous rq.
@@ -6744,21 +6706,9 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	if (p->state == TASK_WAKING) {
 		struct sched_entity *se = &p->se;
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-		u64 min_vruntime;
-
-#ifndef CONFIG_64BIT
-		u64 min_vruntime_copy;
-
-		do {
-			min_vruntime_copy = cfs_rq->min_vruntime_copy;
-			smp_rmb();
-			min_vruntime = cfs_rq->min_vruntime;
-		} while (min_vruntime != min_vruntime_copy);
-#else
-		min_vruntime = cfs_rq->min_vruntime;
-#endif
 
-		se->vruntime -= min_vruntime;
+		se->vruntime -= u64_32read(cfs_rq->min_vruntime,
+					   cfs_rq->min_vruntime_copy);
 	}
 
 	if (p->on_rq == TASK_ON_RQ_MIGRATING) {
@@ -10891,9 +10841,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
 	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
-#ifndef CONFIG_64BIT
-	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
-#endif
+	u64_32read_set_copy(cfs_rq->min_vruntime, cfs_rq->min_vruntime_copy);
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f33c77..c8c4646 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -605,6 +605,41 @@ struct cfs_rq {
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
 
+/*
+ * u64_32read() / u64_32read_set_copy()
+ *
+ * Use the copied u64 value to protect against data race. This is only
+ * applicable for 32-bits architectures.
+ */
+#if !defined(CONFIG_64BIT) && defined(CONFIG_SMP)
+# define u64_32read(val, copy)						\
+({									\
+	u64 _val;							\
+	u64 _val_copy;							\
+									\
+	do {								\
+		_val_copy = copy;					\
+		/*							\
+		 * paired with u64_32read_set_copy, ordering access	\
+		 * to val and copy.					\
+		 */							\
+		smp_rmb();						\
+		_val = val;						\
+	} while (_val != _val_copy);					\
+									\
+	_val;								\
+})
+# define u64_32read_set_copy(val, copy)					\
+do {									\
+	/* paired with u64_32read, ordering access to val and copy */	\
+	smp_wmb();							\
+	copy = val;							\
+} while (0)
+#else
+# define u64_32read(val, copy) (val)
+# define u64_32read_set_copy(val, copy) do { } while (0)
+#endif
+
 static inline int rt_bandwidth_enabled(void)
 {
 	return sysctl_sched_rt_runtime >= 0;
-- 
2.7.4

