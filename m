Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D761CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10AF20825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="GCVufsQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgH1Twl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1Tw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:28 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0FFC061234
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:28 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p2so667421qkj.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=btfMl1Zmdwqg9zLIRNR4wlUEBz+PpjVtdy3Z/cuZ+M4=;
        b=GCVufsQs5XomveuvJOtXxbW+4/dC8fStdngmpICX1ZSzRZPhLtcqP4/LbMDl/W5Zex
         EpjHkHitT2xrbT3dLL2oL+neE2hntX5bCbRlZKmI2vl5/5DlnMok0XMFAlL8KFbgQQ7O
         Av9SUVGQ1H25udL23rKyALHKBcdZrX5XpZxTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=btfMl1Zmdwqg9zLIRNR4wlUEBz+PpjVtdy3Z/cuZ+M4=;
        b=ctl0ZHj6lnbaLRpep6iIzo1v9vngYxVzQphUGD+jmEN87GjsGK6ei2FcWjgmgH6ZLT
         Xo2Ytg7m0VO9vG3C6JM6hiDhAJy/OVM9hFIO1KL5eRBQBdwDFaSDrJZ9v3hTbctjcGAF
         Qd1QHPxdQY/FlRxhh1RfsCrawW3lIP4IMUhvnhKwmrZ2OxYsCQfF25mfh2UjMvzyInbZ
         NGmDWXzjFLrLykzIBOyfZnWFwZpucLKr7dCikJHbGVF2WyrvREa1L25yUBQMzJteLhla
         rpHDq55xMsCUb/ZSeOrlu/ohn2kfEMXZJLcEPMNha+PQfHW6+ZDQFk5GjtaC3XR6WFwb
         Kf9g==
X-Gm-Message-State: AOAM533/5HR3M/cK2l/Jvqjg1FAjjToWcHbyQuIhdbI160IOghgzuh0+
        SPBbpXVDWRANoicREy+p1Trsjg==
X-Google-Smtp-Source: ABdhPJzyAgXrkKkSsO8VwklVlrGJ1TU3MJI9Wc7Kb5NItmcl4sX2Q2I2S75ZMU2vuJharBTqyCUZvg==
X-Received: by 2002:a37:9746:: with SMTP id z67mr701458qkd.425.1598644347514;
        Fri, 28 Aug 2020 12:52:27 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:26 -0700 (PDT)
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
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Subject: [RFC PATCH v7 05/23] sched: Basic tracking of matching tasks
Date:   Fri, 28 Aug 2020 15:51:06 -0400
Message-Id: <ab2aebc528c010404f1617e7a6f861486e1c8a36.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Introduce task_struct::core_cookie as an opaque identifier for core
scheduling. When enabled; core scheduling will only allow matching
task to be on the core; where idle matches everything.

When task_struct::core_cookie is set (and core scheduling is enabled)
these tasks are indexed in a second RB-tree, first on cookie value
then on scheduling function, such that matching task selection always
finds the most elegible match.

NOTE: *shudder* at the overhead...

NOTE: *sigh*, a 3rd copy of the scheduling function; the alternative
is per class tracking of cookies and that just duplicates a lot of
stuff for no raisin (the 2nd copy lives in the rt-mutex PI code).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
---
 include/linux/sched.h |   8 ++-
 kernel/sched/core.c   | 146 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c   |  46 -------------
 kernel/sched/sched.h  |  55 ++++++++++++++++
 4 files changed, 208 insertions(+), 47 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 93ecd930efd3..5fe9878502cb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -682,10 +682,16 @@ struct task_struct {
 	const struct sched_class	*sched_class;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
+	struct sched_dl_entity		dl;
+
+#ifdef CONFIG_SCHED_CORE
+	struct rb_node			core_node;
+	unsigned long			core_cookie;
+#endif
+
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
 #endif
-	struct sched_dl_entity		dl;
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e2642c5dbd61..eea18956a9ef 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -77,6 +77,141 @@ __read_mostly int scheduler_running;
 
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
 
+/* kernel prio, less is more */
+static inline int __task_prio(struct task_struct *p)
+{
+	if (p->sched_class == &stop_sched_class) /* trumps deadline */
+		return -2;
+
+	if (rt_prio(p->prio)) /* includes deadline */
+		return p->prio; /* [-1, 99] */
+
+	if (p->sched_class == &idle_sched_class)
+		return MAX_RT_PRIO + NICE_WIDTH; /* 140 */
+
+	return MAX_RT_PRIO + MAX_NICE; /* 120, squash fair */
+}
+
+/*
+ * l(a,b)
+ * le(a,b) := !l(b,a)
+ * g(a,b)  := l(b,a)
+ * ge(a,b) := !l(a,b)
+ */
+
+/* real prio, less is less */
+static inline bool prio_less(struct task_struct *a, struct task_struct *b)
+{
+
+	int pa = __task_prio(a), pb = __task_prio(b);
+
+	if (-pa < -pb)
+		return true;
+
+	if (-pb < -pa)
+		return false;
+
+	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
+		return !dl_time_before(a->dl.deadline, b->dl.deadline);
+
+	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
+		u64 vruntime = b->se.vruntime;
+
+		/*
+		 * Normalize the vruntime if tasks are in different cpus.
+		 */
+		if (task_cpu(a) != task_cpu(b)) {
+			vruntime -= task_cfs_rq(b)->min_vruntime;
+			vruntime += task_cfs_rq(a)->min_vruntime;
+		}
+
+		return !((s64)(a->se.vruntime - vruntime) <= 0);
+	}
+
+	return false;
+}
+
+static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)
+{
+	if (a->core_cookie < b->core_cookie)
+		return true;
+
+	if (a->core_cookie > b->core_cookie)
+		return false;
+
+	/* flip prio, so high prio is leftmost */
+	if (prio_less(b, a))
+		return true;
+
+	return false;
+}
+
+static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
+{
+	struct rb_node *parent, **node;
+	struct task_struct *node_task;
+
+	rq->core->core_task_seq++;
+
+	if (!p->core_cookie)
+		return;
+
+	node = &rq->core_tree.rb_node;
+	parent = *node;
+
+	while (*node) {
+		node_task = container_of(*node, struct task_struct, core_node);
+		parent = *node;
+
+		if (__sched_core_less(p, node_task))
+			node = &parent->rb_left;
+		else
+			node = &parent->rb_right;
+	}
+
+	rb_link_node(&p->core_node, parent, node);
+	rb_insert_color(&p->core_node, &rq->core_tree);
+}
+
+static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
+{
+	rq->core->core_task_seq++;
+
+	if (!p->core_cookie)
+		return;
+
+	rb_erase(&p->core_node, &rq->core_tree);
+}
+
+/*
+ * Find left-most (aka, highest priority) task matching @cookie.
+ */
+static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
+{
+	struct rb_node *node = rq->core_tree.rb_node;
+	struct task_struct *node_task, *match;
+
+	/*
+	 * The idle task always matches any cookie!
+	 */
+	match = idle_sched_class.pick_task(rq);
+
+	while (node) {
+		node_task = container_of(node, struct task_struct, core_node);
+
+		if (cookie < node_task->core_cookie) {
+			node = node->rb_left;
+		} else if (cookie > node_task->core_cookie) {
+			node = node->rb_right;
+		} else {
+			match = node_task;
+			node = node->rb_left;
+		}
+	}
+
+	return match;
+}
+
 /*
  * The static-key + stop-machine variable are needed such that:
  *
@@ -135,6 +270,11 @@ void sched_core_put(void)
 	mutex_unlock(&sched_core_mutex);
 }
 
+#else /* !CONFIG_SCHED_CORE */
+
+static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
+static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+
 #endif /* CONFIG_SCHED_CORE */
 
 /*
@@ -1628,6 +1768,9 @@ static inline void init_uclamp(void) { }
 
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (sched_core_enabled(rq))
+		sched_core_enqueue(rq, p);
+
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
@@ -1642,6 +1785,9 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 
 static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (sched_core_enabled(rq))
+		sched_core_dequeue(rq, p);
+
 	if (!(flags & DEQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index af8c40191a19..285002a2f641 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -258,33 +258,11 @@ const struct sched_class fair_sched_class;
  */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	SCHED_WARN_ON(!entity_is_task(se));
-	return container_of(se, struct task_struct, se);
-}
 
 /* Walk up scheduling entities hierarchy */
 #define for_each_sched_entity(se) \
 		for (; se; se = se->parent)
 
-static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
-{
-	return p->se.cfs_rq;
-}
-
-/* runqueue on which this entity is (to be) queued */
-static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
-{
-	return se->cfs_rq;
-}
-
-/* runqueue "owned" by this group */
-static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
-{
-	return grp->my_q;
-}
-
 static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
 {
 	if (!path)
@@ -445,33 +423,9 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #else	/* !CONFIG_FAIR_GROUP_SCHED */
 
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	return container_of(se, struct task_struct, se);
-}
-
 #define for_each_sched_entity(se) \
 		for (; se; se = NULL)
 
-static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
-{
-	return &task_rq(p)->cfs;
-}
-
-static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
-{
-	struct task_struct *p = task_of(se);
-	struct rq *rq = task_rq(p);
-
-	return &rq->cfs;
-}
-
-/* runqueue "owned" by this group */
-static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
-{
-	return NULL;
-}
-
 static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
 {
 	if (path)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6ab8adff169b..92e0b8679eef 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1053,6 +1053,10 @@ struct rq {
 	/* per rq */
 	struct rq		*core;
 	unsigned int		core_enabled;
+	struct rb_root		core_tree;
+
+	/* shared state */
+	unsigned int		core_task_seq;
 #endif
 };
 
@@ -1132,6 +1136,57 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+static inline struct task_struct *task_of(struct sched_entity *se)
+{
+	SCHED_WARN_ON(!entity_is_task(se));
+	return container_of(se, struct task_struct, se);
+}
+
+static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
+{
+	return p->se.cfs_rq;
+}
+
+/* runqueue on which this entity is (to be) queued */
+static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
+{
+	return se->cfs_rq;
+}
+
+/* runqueue "owned" by this group */
+static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
+{
+	return grp->my_q;
+}
+
+#else
+
+static inline struct task_struct *task_of(struct sched_entity *se)
+{
+	return container_of(se, struct task_struct, se);
+}
+
+static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
+{
+	return &task_rq(p)->cfs;
+}
+
+static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
+{
+	struct task_struct *p = task_of(se);
+	struct rq *rq = task_rq(p);
+
+	return &rq->cfs;
+}
+
+/* runqueue "owned" by this group */
+static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
+{
+	return NULL;
+}
+#endif
+
 extern void update_rq_clock(struct rq *rq);
 
 static inline u64 __rq_clock_broken(struct rq *rq)
-- 
2.17.1

