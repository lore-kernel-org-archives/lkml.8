Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE1BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FB12072D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="QjdsmNbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgF3Vds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgF3Vdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:33:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F583C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x11so9008498plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=cRSqYsKRyUy/MEyNZR/Fow+Cd9bZ7quVG4LYI6LIvRw=;
        b=QjdsmNbjWCmLv5l6/3cvoAJxK2kkjcAuBo/Tgl0HIBIwRhdjn7498CZHszOMSUxCha
         SQm5xFii5TSULZqkS7iTfQQ8nL2og4zbmRdZSH3o2lYr2qH1gc0H5mz6tXmh/+oRbp0T
         paKZuAtu7UciKZ/ZjeBa7xCQQHDipfMvWbry8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=cRSqYsKRyUy/MEyNZR/Fow+Cd9bZ7quVG4LYI6LIvRw=;
        b=r1mnL4kjez+1vjIPYp2D7DgsIo3ruTdit09EmRIcl71Tshhf7jg3Um71APP/9vmmzH
         6Qps9iO+GfHFkI512qSjXfSI2OfCtdfEtcH/iGN0tYDJ6vGX2Knxb0JMI0fISdI4qVhN
         NhgYgfAGhiUrwbpD1SXhwgy498gd3DMAEEUmyVK2r/hdD8+6rNoSF9cUsjiX4dbGTWoI
         FAbrB+w8yGqHAc8jB+Q54rgkDDzkM67I6ZH9f9gvKW4QgAL3eKvCJfPsW1MNeWUPE/i6
         wi6GIf4FyL8V+7CAc9ufa8IpPY4zuALDo5qD0mwTCMggc2GNcxFYqg5hNpX+80MUBdHK
         Kj0Q==
X-Gm-Message-State: AOAM5337yDMCZk4jEsUutFG7JZhMyTRUn7/NmXsRjjZ3UZsUkS+3YFDr
        XytTEpiM1kKoKn6pFITpZZD8VA==
X-Google-Smtp-Source: ABdhPJw+lskBxqVVsHPRHrh1UOhgJrX+GwLjv13nbS2glYti2UdwchVQ0OlW2gVO+/w5b2N3z+NZNg==
X-Received: by 2002:a17:90b:1b0a:: with SMTP id nu10mr23758892pjb.182.1593552823249;
        Tue, 30 Jun 2020 14:33:43 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id m6sm274246pjb.34.2020.06.30.14.33.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:33:42 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        vineethrp@gmail.com, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH 12/16] sched: cgroup tagging interface for core scheduling
Date:   Tue, 30 Jun 2020 21:32:33 +0000
Message-Id: <daf223c19464da3053f6eaea055983f04106339d.1593530334.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
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
 kernel/sched/core.c  | 183 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |   4 +
 2 files changed, 180 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fb9edb09ead7..c84f209b8591 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -135,6 +135,37 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
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
@@ -166,10 +197,11 @@ static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
-	if (!p->core_cookie)
+	if (!sched_core_enqueued(p))
 		return;
 
 	rb_erase(&p->core_node, &rq->core_tree);
+	RB_CLEAR_NODE(&p->core_node);
 }
 
 /*
@@ -235,9 +267,23 @@ static int __sched_core_stopper(void *data)
 
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
-		rq->core_enabled = enabled;
-		if (cpu_online(cpu) && rq->core != rq)
-			sched_core_adjust_sibling_vruntime(cpu, enabled);
+
+		WARN_ON_ONCE(enabled == rq->core_enabled);
+
+		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2)) {
+			/*
+			 * All active and migrating tasks will have already
+			 * been removed from core queue when we clear the
+			 * cgroup tags. However, dying tasks could still be
+			 * left in core queue. Flush them here.
+			 */
+			if (!enabled)
+				sched_core_flush(cpu);
+
+			rq->core_enabled = enabled;
+			if (cpu_online(cpu) && rq->core != rq)
+				sched_core_adjust_sibling_vruntime(cpu, enabled);
+		}
 	}
 
 	return 0;
@@ -248,7 +294,11 @@ static int sched_core_count;
 
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
@@ -256,8 +306,6 @@ static void __sched_core_enable(void)
 
 static void __sched_core_disable(void)
 {
-	// XXX verify there are no cookie tasks (left)
-
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
 }
@@ -282,6 +330,7 @@ void sched_core_put(void)
 
 static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
 static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+static bool sched_core_enqueued(struct task_struct *task) { return false; }
 
 #endif /* CONFIG_SCHED_CORE */
 
@@ -3114,6 +3163,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SMP
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
+#endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&p->core_node);
 #endif
 	return 0;
 }
@@ -6674,6 +6726,9 @@ void init_idle(struct task_struct *idle, int cpu)
 #ifdef CONFIG_SMP
 	sprintf(idle->comm, "%s/%d", INIT_TASK_COMM, cpu);
 #endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&idle->core_node);
+#endif
 }
 
 #ifdef CONFIG_SMP
@@ -7646,6 +7701,15 @@ static void sched_change_group(struct task_struct *tsk, int type)
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
@@ -7738,6 +7802,18 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -8301,6 +8377,82 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
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
@@ -8337,6 +8489,14 @@ static struct cftype cpu_legacy_files[] = {
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
@@ -8510,6 +8670,14 @@ static struct cftype cpu_files[] = {
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
@@ -8538,6 +8706,7 @@ static struct cftype cpu_files[] = {
 struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_alloc	= cpu_cgroup_css_alloc,
 	.css_online	= cpu_cgroup_css_online,
+	.css_offline	= cpu_cgroup_css_offline,
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 875796d43fca..c4b4640fcdc8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -366,6 +366,10 @@ struct cfs_bandwidth {
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

