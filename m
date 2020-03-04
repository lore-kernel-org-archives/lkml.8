Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E97C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B2B20658
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Ndcwh9Kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388411AbgCDRAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:00:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39587 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388365AbgCDRAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:00:21 -0500
Received: by mail-qt1-f196.google.com with SMTP id e13so1887734qts.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ei+INJxVJ7JO6KporPxQXDCshgcX8SOazF2unhH80Ds=;
        b=Ndcwh9KtVR2l9U2EAn15s8DVIZNgojc0ksNWb9C3txzESPDnhP6b5KBvPwGIflpNig
         g4WSruDGjUjlVQmmX8/6WzH5m1PLHhAL+BSi2/uY9/UDmgqDCE0ubXzK9Eq+16uTx8hA
         6GRaVaaHJtEt3L1Dmdek9Y+h/8kDLEI3EKaD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ei+INJxVJ7JO6KporPxQXDCshgcX8SOazF2unhH80Ds=;
        b=p38gSwLptY6AT06K/i+ZMZGvGw064ZT0t+X0uGgfTQU3OiqLwyn1bfMJnFpP/a0Gn/
         fVfia3dPArLPakSxMM0WvduE5SThNW5ynjcIylaKE6ETE3cXrsFF9vsFs4jCOKLwWMV3
         1CzmlvNJgurslci5ZuPTqWLFbgTLMkX5Vg+y5FtkpMTHY21FIf7G1uEpu3YATVRJtTPG
         E8eZJ3PbkxOSQbSG8R1ecWxy+iCqIHSUOfSARoJUBN0bY1ztwMrCDhVK/BM8Uon2ilIN
         aymliRgaTMyGnlH3vfKIwyZXC5VEqrXKl5zGzoJCCwEuR+MyMnsbOedWdDK4wzTQYyYT
         SjoQ==
X-Gm-Message-State: ANhLgQ3w6UFdZiKCt1hKXOs+rG2IgKFeEIzq75Xf+Taq3xa1aKUauBkk
        swfKQEIN8kG4VArgnK1WYV9wRw==
X-Google-Smtp-Source: ADFU+vtKMu9fK99ZzoCL08dDrxLjqTTyCMhVuu9Jb/A9FbuGDR37xo3wpDpUSXggkj3SZJ1YguS7nw==
X-Received: by 2002:ac8:7508:: with SMTP id u8mr3314362qtq.163.1583341219859;
        Wed, 04 Mar 2020 09:00:19 -0800 (PST)
Received: from s2r5node9 ([162.243.188.99])
        by smtp.gmail.com with ESMTPSA id h7sm5724183qkm.125.2020.03.04.09.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:00:19 -0800 (PST)
From:   vpillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH 12/13] sched: cgroup tagging interface for core scheduling
Date:   Wed,  4 Mar 2020 17:00:02 +0000
Message-Id: <6c48d9428e5b23aab9be67538a94fe0436b16ecb.1583332765.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Marks all tasks in a cgroup as matching for core-scheduling.

A task will need to be moved into the core scheduler queue when the cgroup
it belongs to is tagged to run with core scheduling.  Similarly the task
will need to be moved out of the core scheduler queue when the cgroup
is untagged.

Also after we forked a task, its core scheduler queue's presence will
need to be updated according to its new cgroup's status.

Use stop machine mechanism to update all tasks in a cgroup to prevent a
new task from sneaking into the cgroup, and missed out from the update
while we iterates through all the tasks in the cgroup.  A more complicated
scheme could probably avoid the stop machine.  Such scheme will also
need to resovle inconsistency between a task's cgroup core scheduling
tag and residency in core scheduler queue.

We are opting for the simple stop machine mechanism for now that avoids
such complications.

Core scheduler has extra overhead.  Enable it only for core with
more than one SMT hardware threads.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
---
 kernel/sched/core.c  | 186 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |   4 +
 2 files changed, 184 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 18ee8e10a171..11e5a2a494ac 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -140,6 +140,37 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
 	return false;
 }
 
+static bool sched_core_empty(struct rq *rq)
+{
+	return RB_EMPTY_ROOT(&rq->core_tree);
+}
+
+static bool sched_core_enqueued(struct task_struct *task)
+{
+	return !RB_EMPTY_NODE(&task->core_node);
+}
+
+static struct task_struct *sched_core_first(struct rq *rq)
+{
+	struct task_struct *task;
+
+	task = container_of(rb_first(&rq->core_tree), struct task_struct, core_node);
+	return task;
+}
+
+static void sched_core_flush(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct task_struct *task;
+
+	while (!sched_core_empty(rq)) {
+		task = sched_core_first(rq);
+		rb_erase(&task->core_node, &rq->core_tree);
+		RB_CLEAR_NODE(&task->core_node);
+	}
+	rq->core->core_task_seq++;
+}
+
 static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
 	struct rb_node *parent, **node;
@@ -171,10 +202,11 @@ static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
-	if (!p->core_cookie)
+	if (!sched_core_enqueued(p))
 		return;
 
 	rb_erase(&p->core_node, &rq->core_tree);
+	RB_CLEAR_NODE(&p->core_node);
 }
 
 void sched_core_add(struct rq *rq, struct task_struct *p)
@@ -250,8 +282,22 @@ static int __sched_core_stopper(void *data)
 	bool enabled = !!(unsigned long)data;
 	int cpu;
 
-	for_each_online_cpu(cpu)
-		cpu_rq(cpu)->core_enabled = enabled;
+	if (!enabled) {
+		for_each_online_cpu(cpu) {
+		/*
+		 * All active and migrating tasks will have already been removed
+		 * from core queue when we clear the cgroup tags.
+		 * However, dying tasks could still be left in core queue.
+		 * Flush them here.
+		 */
+			sched_core_flush(cpu);
+		}
+	}
+
+	for_each_online_cpu(cpu) {
+		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2))
+			cpu_rq(cpu)->core_enabled = enabled;
+	}
 
 	return 0;
 }
@@ -261,7 +307,11 @@ static int sched_core_count;
 
 static void __sched_core_enable(void)
 {
-	// XXX verify there are no cookie tasks (yet)
+	int cpu;
+
+	/* verify there are no cookie tasks (yet) */
+	for_each_online_cpu(cpu)
+		BUG_ON(!sched_core_empty(cpu_rq(cpu)));
 
 	static_branch_enable(&__sched_core_enabled);
 	stop_machine(__sched_core_stopper, (void *)true, NULL);
@@ -269,8 +319,6 @@ static void __sched_core_enable(void)
 
 static void __sched_core_disable(void)
 {
-	// XXX verify there are no cookie tasks (left)
-
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
 }
@@ -416,6 +464,7 @@ static int __deactivate_cpu_core_sched(void *data)
 
 static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
 static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+static bool sched_core_enqueued(struct task_struct *task) { return false; }
 static inline void core_sched_cpu_update(unsigned int cpu, int action) { }
 
 #endif /* CONFIG_SCHED_CORE */
@@ -3268,6 +3317,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SMP
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
+#endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&p->core_node);
 #endif
 	return 0;
 }
@@ -6819,6 +6871,9 @@ void init_idle(struct task_struct *idle, int cpu)
 #ifdef CONFIG_SMP
 	sprintf(idle->comm, "%s/%d", INIT_TASK_COMM, cpu);
 #endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&idle->core_node);
+#endif
 }
 
 #ifdef CONFIG_SMP
@@ -7796,6 +7851,15 @@ static void sched_change_group(struct task_struct *tsk, int type)
 	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
 			  struct task_group, css);
 	tg = autogroup_task_group(tsk, tg);
+
+#ifdef CONFIG_SCHED_CORE
+	if ((unsigned long)tsk->sched_task_group == tsk->core_cookie)
+		tsk->core_cookie = 0UL;
+
+	if (tg->tagged /* && !tsk->core_cookie ? */)
+		tsk->core_cookie = (unsigned long)tg;
+#endif
+
 	tsk->sched_task_group = tg;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -7881,6 +7945,18 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
+static void cpu_cgroup_css_offline(struct cgroup_subsys_state *css)
+{
+#ifdef CONFIG_SCHED_CORE
+	struct task_group *tg = css_tg(css);
+
+	if (tg->tagged) {
+		sched_core_put();
+		tg->tagged = 0;
+	}
+#endif
+}
+
 static void cpu_cgroup_css_released(struct cgroup_subsys_state *css)
 {
 	struct task_group *tg = css_tg(css);
@@ -7910,7 +7986,12 @@ static void cpu_cgroup_fork(struct task_struct *task)
 	rq = task_rq_lock(task, &rf);
 
 	update_rq_clock(rq);
+	if (sched_core_enqueued(task))
+		sched_core_dequeue(rq, task);
 	sched_change_group(task, TASK_SET_GROUP);
+	if (sched_core_enabled(rq) && task_on_rq_queued(task) &&
+	    task->core_cookie)
+		sched_core_enqueue(rq, task);
 
 	task_rq_unlock(rq, task, &rf);
 }
@@ -8436,6 +8517,82 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_RT_GROUP_SCHED */
 
+#ifdef CONFIG_SCHED_CORE
+static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct task_group *tg = css_tg(css);
+
+	return !!tg->tagged;
+}
+
+struct write_core_tag {
+	struct cgroup_subsys_state *css;
+	int val;
+};
+
+static int __sched_write_tag(void *data)
+{
+	struct write_core_tag *tag = (struct write_core_tag *) data;
+	struct cgroup_subsys_state *css = tag->css;
+	int val = tag->val;
+	struct task_group *tg = css_tg(tag->css);
+	struct css_task_iter it;
+	struct task_struct *p;
+
+	tg->tagged = !!val;
+
+	css_task_iter_start(css, 0, &it);
+	/*
+	 * Note: css_task_iter_next will skip dying tasks.
+	 * There could still be dying tasks left in the core queue
+	 * when we set cgroup tag to 0 when the loop is done below.
+	 */
+	while ((p = css_task_iter_next(&it))) {
+		p->core_cookie = !!val ? (unsigned long)tg : 0UL;
+
+		if (sched_core_enqueued(p)) {
+			sched_core_dequeue(task_rq(p), p);
+			if (!p->core_cookie)
+				continue;
+		}
+
+		if (sched_core_enabled(task_rq(p)) &&
+		    p->core_cookie && task_on_rq_queued(p))
+			sched_core_enqueue(task_rq(p), p);
+
+	}
+	css_task_iter_end(&it);
+
+	return 0;
+}
+
+static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+{
+	struct task_group *tg = css_tg(css);
+	struct write_core_tag wtag;
+
+	if (val > 1)
+		return -ERANGE;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -EINVAL;
+
+	if (tg->tagged == !!val)
+		return 0;
+
+	if (!!val)
+		sched_core_get();
+
+	wtag.css = css;
+	wtag.val = val;
+	stop_machine(__sched_write_tag, (void *) &wtag, NULL);
+	if (!val)
+		sched_core_put();
+
+	return 0;
+}
+#endif
+
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
@@ -8472,6 +8629,14 @@ static struct cftype cpu_legacy_files[] = {
 		.write_u64 = cpu_rt_period_write_uint,
 	},
 #endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "tag",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_read_u64,
+		.write_u64 = cpu_core_tag_write_u64,
+	},
+#endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
 		.name = "uclamp.min",
@@ -8645,6 +8810,14 @@ static struct cftype cpu_files[] = {
 		.write_s64 = cpu_weight_nice_write_s64,
 	},
 #endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "tag",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_read_u64,
+		.write_u64 = cpu_core_tag_write_u64,
+	},
+#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.name = "max",
@@ -8673,6 +8846,7 @@ static struct cftype cpu_files[] = {
 struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_alloc	= cpu_cgroup_css_alloc,
 	.css_online	= cpu_cgroup_css_online,
+	.css_offline	= cpu_cgroup_css_offline,
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e4019a482f0e..2079654b5c87 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -355,6 +355,10 @@ struct cfs_bandwidth {
 struct task_group {
 	struct cgroup_subsys_state css;
 
+#ifdef CONFIG_SCHED_CORE
+	int			tagged;
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* schedulable entities of this group on each CPU */
 	struct sched_entity	**se;
-- 
2.17.1

