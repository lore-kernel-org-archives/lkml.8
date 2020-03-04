Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660B7C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2862467F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="NylZTz8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbgCDRAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:00:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45490 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388351AbgCDRAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:00:15 -0500
Received: by mail-qt1-f194.google.com with SMTP id a4so1863613qto.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8LcF0HG/4V3aF6I9lcq+0tptip8ch1z80Y/FT8Rg30E=;
        b=NylZTz8aOOXV09GuueQCAnwnbX8K8UqThwHxmuY/Hrwhrt19B4WDF9vf0UpzvT7EWn
         RZ+2nba6zWELjTZEIZesUwwf1xLynarzOTTbGYdOnpr+kE5+apHZkMqyleJ1VtQsBhQN
         opLJUDBSe4WJ4YG4Os4+LI0H1GIpm6JnN3TTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8LcF0HG/4V3aF6I9lcq+0tptip8ch1z80Y/FT8Rg30E=;
        b=ADBEliAJcK+NNEzRmB4VPEqhsyKVARC5313uDKn1kB8aUD83AIDyqxMEdWeCWDnE9R
         6/ghVqH2amBrhTIoSdh3ethfyHjpS33tzPdOOAvU04uiZhjMtBqaaOa20+wMEvoTipPo
         ly2vsthHjmUiQ3Jqx3fvw19Moq9Npcpop23ceyy6HhJo2QsbcTEmsouQBp3y2/gpyYkq
         NMP/wDh3SEInnqVDvNouLVenCMnhnnW4/7Dpq9Inh1konNvc+eGXo5XyPFay67+lwa0/
         Q8iN/JUVVm+03nXmLRO/BHSZyL7085XvSvoDCkYnxJ/4Wl+XvJtVzK8Qcm1sWP/y3XsC
         dF5g==
X-Gm-Message-State: ANhLgQ0zPFU/1H1eY6r0VtLWOlUlLeRoOmT22GfGM478AaSiYlQtdSIc
        7gaKyZ9IGsseugOpD+4rlK8w1Q==
X-Google-Smtp-Source: ADFU+vtTNHNqPgznvpvReQTMBUeZKhdnyux3AiQ7dyOavGQbOrEY5N0Y3Jrucxv8eG0R/HLt6OozTA==
X-Received: by 2002:ac8:1c0d:: with SMTP id a13mr3233172qtk.253.1583341213510;
        Wed, 04 Mar 2020 09:00:13 -0800 (PST)
Received: from s2r5node9 ([162.243.188.99])
        by smtp.gmail.com with ESMTPSA id l6sm14394573qti.10.2020.03.04.09.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:00:13 -0800 (PST)
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
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org
Subject: [RFC PATCH 06/13] sched: Update core scheduler queue when taking cpu online/offline
Date:   Wed,  4 Mar 2020 16:59:56 +0000
Message-Id: <11bd7179ece42536f81101414ef6564f6792cb51.1583332765.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

When we bring a CPU online and enable core scheduler, tasks that need
core scheduling need to be placed in the core's core scheduling queue.
Likewise when we taks a CPU offline or disable core scheudling on a
core, tasks in the core's core scheduling queue need to be removed.
Without such mechanisms, the core scheduler causes OOPs due to
inconsistent core scheduling state of a task.

Implement such enqueue and dequeue mechanisms according to a CPU's change
in core scheduling status.  The switch of core scheduling mode of a core,
and enqueue/dequeue of tasks on a core's queue due to the core scheduling
mode change has to be run in a separate context as it cannot be done in
the context taking cpu online/offline.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c     | 156 ++++++++++++++++++++++++++++++++++++----
 kernel/sched/deadline.c |  35 +++++++++
 kernel/sched/fair.c     |  38 ++++++++++
 kernel/sched/rt.c       |  43 +++++++++++
 kernel/sched/sched.h    |   7 ++
 5 files changed, 264 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 452ce5bb9321..445f0d519336 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -75,6 +75,11 @@ int sysctl_sched_rt_runtime = 950000;
 
 #ifdef CONFIG_SCHED_CORE
 
+struct core_sched_cpu_work {
+	struct work_struct work;
+	cpumask_t smt_mask;
+};
+
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
 
 /* kernel prio, less is more */
@@ -183,6 +188,18 @@ static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
 	rb_erase(&p->core_node, &rq->core_tree);
 }
 
+void sched_core_add(struct rq *rq, struct task_struct *p)
+{
+	if (p->core_cookie && task_on_rq_queued(p))
+		sched_core_enqueue(rq, p);
+}
+
+void sched_core_remove(struct rq *rq, struct task_struct *p)
+{
+	if (sched_core_enqueued(p))
+		sched_core_dequeue(rq, p);
+}
+
 /*
  * Find left-most (aka, highest priority) task matching @cookie.
  */
@@ -270,10 +287,132 @@ void sched_core_put(void)
 	mutex_unlock(&sched_core_mutex);
 }
 
+enum cpu_action {
+	CPU_ACTIVATE = 1,
+	CPU_DEACTIVATE = 2
+};
+
+static int __activate_cpu_core_sched(void *data);
+static int __deactivate_cpu_core_sched(void *data);
+static void core_sched_cpu_update(unsigned int cpu, enum cpu_action action);
+
+static int activate_cpu_core_sched(struct core_sched_cpu_work *work)
+{
+	if (static_branch_unlikely(&__sched_core_enabled))
+		stop_machine(__activate_cpu_core_sched, (void *) work, NULL);
+
+	return 0;
+}
+
+static int deactivate_cpu_core_sched(struct core_sched_cpu_work *work)
+{
+	if (static_branch_unlikely(&__sched_core_enabled))
+		stop_machine(__deactivate_cpu_core_sched, (void *) work, NULL);
+
+	return 0;
+}
+
+static void core_sched_cpu_activate_fn(struct work_struct *work)
+{
+	struct core_sched_cpu_work *cpu_work;
+
+	cpu_work = container_of(work, struct core_sched_cpu_work, work);
+	activate_cpu_core_sched(cpu_work);
+	kfree(cpu_work);
+}
+
+static void core_sched_cpu_deactivate_fn(struct work_struct *work)
+{
+	struct core_sched_cpu_work *cpu_work;
+
+	cpu_work = container_of(work, struct core_sched_cpu_work, work);
+	deactivate_cpu_core_sched(cpu_work);
+	kfree(cpu_work);
+}
+
+static void core_sched_cpu_update(unsigned int cpu, enum cpu_action action)
+{
+	struct core_sched_cpu_work *work;
+
+	work = kmalloc(sizeof(struct core_sched_cpu_work), GFP_ATOMIC);
+	if (!work)
+		return;
+
+	if (action == CPU_ACTIVATE)
+		INIT_WORK(&work->work, core_sched_cpu_activate_fn);
+	else
+		INIT_WORK(&work->work, core_sched_cpu_deactivate_fn);
+
+	cpumask_copy(&work->smt_mask, cpu_smt_mask(cpu));
+
+	queue_work(system_highpri_wq, &work->work);
+}
+
+static int __activate_cpu_core_sched(void *data)
+{
+	struct core_sched_cpu_work *work = (struct core_sched_cpu_work *) data;
+	struct rq *rq;
+	int i;
+
+	if (cpumask_weight(&work->smt_mask) < 2)
+		return 0;
+
+	for_each_cpu(i, &work->smt_mask) {
+		const struct sched_class *class;
+
+		rq = cpu_rq(i);
+
+		if (rq->core_enabled)
+			continue;
+
+		for_each_class(class) {
+			if (!class->core_sched_activate)
+				continue;
+
+			if (cpu_online(i))
+				class->core_sched_activate(rq);
+		}
+
+		rq->core_enabled = true;
+	}
+	return 0;
+}
+
+static int __deactivate_cpu_core_sched(void *data)
+{
+	struct core_sched_cpu_work *work = (struct core_sched_cpu_work *) data;
+	struct rq *rq;
+	int i;
+
+	if (cpumask_weight(&work->smt_mask) > 2)
+		return 0;
+
+	for_each_cpu(i, &work->smt_mask) {
+		const struct sched_class *class;
+
+		rq = cpu_rq(i);
+
+		if (!rq->core_enabled)
+			continue;
+
+		for_each_class(class) {
+			if (!class->core_sched_deactivate)
+				continue;
+
+			if (cpu_online(i))
+				class->core_sched_deactivate(cpu_rq(i));
+		}
+
+		rq->core_enabled = false;
+	}
+	return 0;
+}
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
 static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+static inline void core_sched_cpu_update(unsigned int cpu, int action) { }
 
 #endif /* CONFIG_SCHED_CORE */
 
@@ -6612,13 +6751,8 @@ int sched_cpu_activate(unsigned int cpu)
 	 */
 	if (cpumask_weight(cpu_smt_mask(cpu)) == 2) {
 		static_branch_inc_cpuslocked(&sched_smt_present);
-#ifdef CONFIG_SCHED_CORE
-		if (static_branch_unlikely(&__sched_core_enabled)) {
-			rq->core_enabled = true;
-		}
-#endif
 	}
-
+	core_sched_cpu_update(cpu, CPU_ACTIVATE);
 #endif
 	set_cpu_active(cpu, true);
 
@@ -6665,15 +6799,10 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 * When going down, decrement the number of cores with SMT present.
 	 */
 	if (cpumask_weight(cpu_smt_mask(cpu)) == 2) {
-#ifdef CONFIG_SCHED_CORE
-		struct rq *rq = cpu_rq(cpu);
-		if (static_branch_unlikely(&__sched_core_enabled)) {
-			rq->core_enabled = false;
-		}
-#endif
 		static_branch_dec_cpuslocked(&sched_smt_present);
 
 	}
+	core_sched_cpu_update(cpu, CPU_DEACTIVATE);
 #endif
 
 	if (!sched_smp_initialized)
@@ -6748,9 +6877,6 @@ int sched_cpu_dying(unsigned int cpu)
 	update_max_interval();
 	nohz_balance_exit_idle(rq);
 	hrtick_clear(rq);
-#ifdef CONFIG_SCHED_CORE
-	rq->core = NULL;
-#endif
 	return 0;
 }
 #endif
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ee7fd8611ee4..e916bba0159c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1773,6 +1773,37 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 	return rb_entry(left, struct sched_dl_entity, rb_node);
 }
 
+static void for_each_dl_task(struct rq *rq,
+                             void (*fn)(struct rq *rq, struct task_struct *p))
+{
+	struct dl_rq *dl_rq = &rq->dl;
+	struct sched_dl_entity *dl_ent;
+	struct task_struct *task;
+	struct rb_node *rb_node;
+
+	rb_node = rb_first_cached(&dl_rq->root);
+	while (rb_node) {
+		dl_ent = rb_entry(rb_node, struct sched_dl_entity, rb_node);
+		task = dl_task_of(dl_ent);
+		fn(rq, task);
+		rb_node = rb_next(rb_node);
+	}
+}
+
+#ifdef CONFIG_SCHED_CORE
+
+static void core_sched_activate_dl(struct rq *rq)
+{
+	for_each_dl_task(rq, sched_core_add);
+}
+
+static void core_sched_deactivate_dl(struct rq *rq)
+{
+	for_each_dl_task(rq, sched_core_remove);
+}
+
+#endif
+
 static struct task_struct *pick_task_dl(struct rq *rq)
 {
 	struct sched_dl_entity *dl_se;
@@ -2460,6 +2491,10 @@ const struct sched_class dl_sched_class = {
 	.rq_online              = rq_online_dl,
 	.rq_offline             = rq_offline_dl,
 	.task_woken		= task_woken_dl,
+#ifdef CONFIG_SCHED_CORE
+	.core_sched_activate    = core_sched_activate_dl,
+	.core_sched_deactivate  = core_sched_deactivate_dl,
+#endif
 #endif
 
 	.task_tick		= task_tick_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d6c932e8d554..a9eeef896c78 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10249,6 +10249,40 @@ static void rq_offline_fair(struct rq *rq)
 	unthrottle_offline_cfs_rqs(rq);
 }
 
+static void for_each_fair_task(struct rq *rq,
+			       void (*fn)(struct rq *rq, struct task_struct *p))
+{
+	struct cfs_rq *cfs_rq, *pos;
+	struct sched_entity *se;
+	struct task_struct *task;
+
+	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
+		for (se = __pick_first_entity(cfs_rq);
+		     se != NULL;
+		     se = __pick_next_entity(se)) {
+
+			if (!entity_is_task(se))
+				continue;
+
+			task = task_of(se);
+			fn(rq, task);
+		}
+	}
+}
+
+#ifdef CONFIG_SCHED_CORE
+
+static void core_sched_activate_fair(struct rq *rq)
+{
+	for_each_fair_task(rq, sched_core_add);
+}
+
+static void core_sched_deactivate_fair(struct rq *rq)
+{
+	for_each_fair_task(rq, sched_core_remove);
+}
+
+#endif
 #endif /* CONFIG_SMP */
 
 /*
@@ -10769,6 +10803,10 @@ const struct sched_class fair_sched_class = {
 
 	.task_dead		= task_dead_fair,
 	.set_cpus_allowed	= set_cpus_allowed_common,
+#ifdef CONFIG_SCHED_CORE
+	.core_sched_activate	= core_sched_activate_fair,
+	.core_sched_deactivate	= core_sched_deactivate_fair,
+#endif
 #endif
 
 	.task_tick		= task_tick_fair,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index d044baedc617..ccb585223fad 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1567,6 +1567,45 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	return rt_task_of(rt_se);
 }
 
+static void for_each_rt_task(struct rq *rq,
+			     void (*fn)(struct rq *rq, struct task_struct *p))
+{
+	rt_rq_iter_t iter;
+	struct rt_prio_array *array;
+	struct list_head *queue;
+	int i;
+	struct rt_rq *rt_rq = &rq->rt;
+	struct sched_rt_entity *rt_se = NULL;
+	struct task_struct *task;
+
+	for_each_rt_rq(rt_rq, iter, rq) {
+		array = &rt_rq->active;
+		for (i = 0; i < MAX_RT_PRIO; i++) {
+			queue = array->queue + i;
+			list_for_each_entry(rt_se, queue, run_list) {
+				if (rt_entity_is_task(rt_se)) {
+					task = rt_task_of(rt_se);
+					fn(rq, task);
+				}
+			}
+		}
+	}
+}
+
+#ifdef CONFIG_SCHED_CORE
+
+static void core_sched_activate_rt(struct rq *rq)
+{
+	for_each_rt_task(rq, sched_core_add);
+}
+
+static void core_sched_deactivate_rt(struct rq *rq)
+{
+	for_each_rt_task(rq, sched_core_remove);
+}
+
+#endif
+
 static struct task_struct *pick_task_rt(struct rq *rq)
 {
 	struct task_struct *p;
@@ -2384,6 +2423,10 @@ const struct sched_class rt_sched_class = {
 	.rq_offline             = rq_offline_rt,
 	.task_woken		= task_woken_rt,
 	.switched_from		= switched_from_rt,
+#ifdef CONFIG_SCHED_CORE
+	.core_sched_activate    = core_sched_activate_rt,
+	.core_sched_deactivate  = core_sched_deactivate_rt,
+#endif
 #endif
 
 	.task_tick		= task_tick_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a38ae770dfd6..03d502357599 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1052,6 +1052,9 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+void sched_core_add(struct rq *rq, struct task_struct *p);
+void sched_core_remove(struct rq *rq, struct task_struct *p);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1823,6 +1826,10 @@ struct sched_class {
 
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
+#ifdef CONFIG_SCHED_CORE
+	void (*core_sched_activate)(struct rq *rq);
+	void (*core_sched_deactivate)(struct rq *rq);
+#endif
 #endif
 
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
-- 
2.17.1

