Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDA4C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F096F20825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="AmkZ78gz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgH1TxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgH1Twn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED09FC061233
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:42 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p4so700219qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=j0jsmMYqUoWKbjqQeM7AtTDW7DRliTaOnieP+vA+zpM=;
        b=AmkZ78gztu6Q3D/ASAwtWoYyGzZ4948tWa6TzBwpnQ95DgSrnb/clWu03TGpl/CaP3
         IQmx0aCnWp2rocB2hbC6xX8OYmco2QLb5m4TcEvsG9A5jbv+1BkScE+1vbI0+pAtQ771
         G/wkDQvMqbniNkdwExQiRLkRt+dTXBx1avD50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=j0jsmMYqUoWKbjqQeM7AtTDW7DRliTaOnieP+vA+zpM=;
        b=BHv/BtWLJF0Q67hYN6rfE1Zdxvkuxf/j+42s3qf5FkeMrlX88wa2FUX1EdVNr0zeh7
         X+8kf6s5ChzzsZT/jwbZAfvwZs7LJgosPSqtWq/Fw3ZD+a65+OccD1/4eS80Twp+Z0ZT
         XAJhC84i+nKmPMLg9qtQGd6taJljbZiiBNSDPeCPnlU9QoBOdL4oZclCd4PFu2Hb92Rv
         Goo/ewl1OQNVi97USfWk+cr9l2PWSGlV1WQLFKXHphMNR8VShl4faS+IHkk+Kca1IHoD
         W50yolHoFkfPa+NdX89YuJmAPM40i+4gbqkjRh0wdLABMtXBbMPb77JBHahOSipTJOqV
         vYYQ==
X-Gm-Message-State: AOAM533r/lQy05W/0u/zTz0i9zr58UUCzg5mCmYpZezHaWF5RyExPiny
        FaFuS5yV+1sG1MQ8VFUcM8ngeA==
X-Google-Smtp-Source: ABdhPJypznXPU8nYFrjiwdIgB2AwaRCuLjHV90boJuXjIaEV0NlzjzsiIlwWumqEoh24hnANmq1/Vg==
X-Received: by 2002:a37:5905:: with SMTP id n5mr709953qkb.409.1598644362077;
        Fri, 28 Aug 2020 12:52:42 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:41 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Aaron Lu <ziqian.lzq@antfin.com>
Subject: [RFC PATCH v7 11/23] sched/fair: core wide cfs task priority comparison
Date:   Fri, 28 Aug 2020 15:51:12 -0400
Message-Id: <d02923d38df20f1d8c51cf4df6dce66ac0a385ce.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Lu <aaron.lwe@gmail.com>

This patch provides a vruntime based way to compare two cfs task's
priority, be it on the same cpu or different threads of the same core.

When the two tasks are on the same CPU, we just need to find a common
cfs_rq both sched_entities are on and then do the comparison.

When the two tasks are on differen threads of the same core, each thread
will choose the next task to run the usual way and then the root level
sched entities which the two tasks belong to will be used to decide
which task runs next core wide.

An illustration for the cross CPU case:

   cpu0         cpu1
 /   |  \     /   |  \
se1 se2 se3  se4 se5 se6
    /  \            /   \
  se21 se22       se61  se62
  (A)                    /
                       se621
                        (B)

Assume CPU0 and CPU1 are smt siblings and cpu0 has decided task A to
run next and cpu1 has decided task B to run next. To compare priority
of task A and B, we compare priority of se2 and se6. Whose vruntime is
smaller, who wins.

To make this work, the root level sched entities' vruntime of the two
threads must be directly comparable. So one of the hyperthread's root
cfs_rq's min_vruntime is chosen as the core wide one and all root level
sched entities' vruntime is normalized against it.

All sub cfs_rqs and sched entities are not interesting in cross cpu
priority comparison as they will only participate in the usual cpu local
schedule decision so no need to normalize their vruntimes.

Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
---
 kernel/sched/core.c  |  23 +++----
 kernel/sched/fair.c  | 142 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   3 +
 3 files changed, 150 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1f480b6025cd..707a56ef0fa3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -114,19 +114,8 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
-		u64 vruntime = b->se.vruntime;
-
-		/*
-		 * Normalize the vruntime if tasks are in different cpus.
-		 */
-		if (task_cpu(a) != task_cpu(b)) {
-			vruntime -= task_cfs_rq(b)->min_vruntime;
-			vruntime += task_cfs_rq(a)->min_vruntime;
-		}
-
-		return !((s64)(a->se.vruntime - vruntime) <= 0);
-	}
+	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
+		return cfs_prio_less(a, b);
 
 	return false;
 }
@@ -229,8 +218,12 @@ static int __sched_core_stopper(void *data)
 	bool enabled = !!(unsigned long)data;
 	int cpu;
 
-	for_each_possible_cpu(cpu)
-		cpu_rq(cpu)->core_enabled = enabled;
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+		rq->core_enabled = enabled;
+		if (cpu_online(cpu) && rq->core != rq)
+			sched_core_adjust_sibling_vruntime(cpu, enabled);
+	}
 
 	return 0;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 298d2c521c1e..e54a35612efa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -460,11 +460,142 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_SCHED_CORE
+static inline struct cfs_rq *root_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return &rq_of(cfs_rq)->cfs;
+}
+
+static inline bool is_root_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq == root_cfs_rq(cfs_rq);
+}
+
+static inline struct cfs_rq *core_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return &rq_of(cfs_rq)->core->cfs;
+}
+
+static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
+{
+	if (!sched_core_enabled(rq_of(cfs_rq)) || !is_root_cfs_rq(cfs_rq))
+		return cfs_rq->min_vruntime;
+
+	return core_cfs_rq(cfs_rq)->min_vruntime;
+}
+
+#ifndef CONFIG_64BIT
+static inline u64 cfs_rq_min_vruntime_copy(struct cfs_rq *cfs_rq)
+{
+	if (!sched_core_enabled(rq_of(cfs_rq)) || !is_root_cfs_rq(cfs_rq))
+		return cfs_rq->min_vruntime_copy;
+
+	return core_cfs_rq(cfs_rq)->min_vruntime_copy;
+}
+#endif /* CONFIG_64BIT */
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
+{
+	struct sched_entity *sea = &a->se;
+	struct sched_entity *seb = &b->se;
+	bool samecpu = task_cpu(a) == task_cpu(b);
+	s64 delta;
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	if (samecpu) {
+		/* vruntime is per cfs_rq */
+		while (!is_same_group(sea, seb)) {
+			int sea_depth = sea->depth;
+			int seb_depth = seb->depth;
+
+			if (sea_depth >= seb_depth)
+				sea = parent_entity(sea);
+			if (sea_depth <= seb_depth)
+				seb = parent_entity(seb);
+		}
+
+		delta = (s64)(sea->vruntime - seb->vruntime);
+		goto out;
+	}
+
+	/* crosscpu: compare root level se's vruntime to decide priority */
+	while (sea->parent)
+		sea = sea->parent;
+	while (seb->parent)
+		seb = seb->parent;
+#else
+	/*
+	 * Use the min_vruntime of root cfs_rq if the tasks are
+	 * enqueued in different cpus.
+	 * */
+	if (!samecpu) {
+		delta = (s64)(task_rq(a)->cfs.min_vruntime -
+			      task_rq(b)->cfs.min_vruntime);
+		goto out;
+	}
+#endif /* CONFIG_FAIR_GROUP_SCHED */
+
+	delta = (s64)(sea->vruntime - seb->vruntime);
+
+out:
+	return delta > 0;
+}
+
+/*
+ * This function takes care of adjusting the min_vruntime of siblings of
+ * a core during coresched enable/disable.
+ * This is called in stop machine context so no need to take the rq lock.
+ *
+ * Coresched enable case
+ *  Once Core scheduling is enabled, the root level sched entities
+ *  of both siblings will use cfs_rq->min_vruntime as the common cfs_rq
+ *  min_vruntime, so it's necessary to normalize vruntime of existing root
+ *  level sched entities in sibling_cfs_rq.
+ *
+ *  Update of sibling_cfs_rq's min_vruntime isn't necessary as we will be
+ *  only using cfs_rq->min_vruntime during the entire run of core scheduling.
+ *
+ * Coresched disable case
+ *  During the entire run of core scheduling, sibling_cfs_rq's min_vruntime
+ *  is left unused and could lag far behind its still queued sched entities.
+ *  Sync it to the up2date core wide one to avoid problems.
+ */
+void sched_core_adjust_sibling_vruntime(int cpu, bool coresched_enabled)
+{
+	struct cfs_rq *cfs = &cpu_rq(cpu)->cfs;
+	struct cfs_rq *core_cfs = &cpu_rq(cpu)->core->cfs;
+	if (coresched_enabled) {
+		struct sched_entity *se, *next;
+		s64 delta = core_cfs->min_vruntime - cfs->min_vruntime;
+		rbtree_postorder_for_each_entry_safe(se, next,
+				&cfs->tasks_timeline.rb_root,
+				run_node) {
+			se->vruntime += delta;
+		}
+	} else {
+		cfs->min_vruntime = core_cfs->min_vruntime;
+#ifndef CONFIG_64BIT
+		smp_wmb();
+		cfs->min_vruntime_copy = core_cfs->min_vruntime;
+#endif
+	}
+}
+
+#else
 static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
 {
 	return cfs_rq->min_vruntime;
 }
 
+#ifndef CONFIG_64BIT
+static inline u64 cfs_rq_min_vruntime_copy(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->min_vruntime_copy;
+}
+#endif /* CONFIG_64BIT */
+
+#endif /* CONFIG_SCHED_CORE */
+
 static __always_inline
 void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
 
@@ -520,8 +651,13 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 			vruntime = min_vruntime(vruntime, se->vruntime);
 	}
 
+#ifdef CONFIG_SCHED_CORE
+	if (sched_core_enabled(rq_of(cfs_rq)) && is_root_cfs_rq(cfs_rq))
+		cfs_rq = core_cfs_rq(cfs_rq);
+#endif
+
 	/* ensure we never gain time by being placed backwards. */
-	cfs_rq->min_vruntime = max_vruntime(cfs_rq_min_vruntime(cfs_rq), vruntime);
+	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);
 #ifndef CONFIG_64BIT
 	smp_wmb();
 	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
@@ -6717,9 +6853,9 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		u64 min_vruntime_copy;
 
 		do {
-			min_vruntime_copy = cfs_rq->min_vruntime_copy;
+			min_vruntime_copy = cfs_rq_min_vruntime_copy(cfs_rq);
 			smp_rmb();
-			min_vruntime = cfs_rq->min_vruntime;
+			min_vruntime = cfs_rq_min_vruntime(cfs_rq);
 		} while (min_vruntime != min_vruntime_copy);
 #else
 		min_vruntime = cfs_rq_min_vruntime(cfs_rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index def442f2c690..7e9346de3f59 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1106,6 +1106,9 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
+void sched_core_adjust_sibling_vruntime(int cpu, bool coresched_enabled);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
-- 
2.17.1

