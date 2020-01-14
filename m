Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C689C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACE4207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgANBME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:12:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:39417 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbgANBMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:12:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 17:12:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,431,1571727600"; 
   d="scan'208";a="397328828"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.162]) ([10.54.74.162])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2020 17:12:02 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
 l50q2K/r651xphs7CGEdKi1nU0YJVbQxJQ==
Message-ID: <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
Date:   Mon, 13 Jan 2020 17:12:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/19 11:10 AM, Tim Chen wrote:
> On 10/30/19 11:33 AM, Vineeth Remanan Pillai wrote:
>> Fourth iteration of the Core-Scheduling feature.
>>
>> This version was aiming mostly at addressing the vruntime comparison
>> issues with v3. The main issue seen in v3 was the starvation of
>> interactive tasks when competing with cpu intensive tasks. This issue
>> is mitigated to a large extent.
>>
>> We have tested and verified that incompatible processes are not
>> selected during schedule. In terms of performance, the impact
>> depends on the workload:
>> - on CPU intensive applications that use all the logical CPUs with
>>   SMT enabled, enabling core scheduling performs better than nosmt.
>> - on mixed workloads with considerable io compared to cpu usage,
>>   nosmt seems to perform better than core scheduling.
>>
>> v4 is rebased on top of 5.3.5(dc073f193b70):
>> https://github.com/digitalocean/linux-coresched/tree/coresched/v4-v5.3.5
>>
> 
> The v4 core scheduler will crash when you toggle the core scheduling
> tag of the cgroup while there are active tasks in the cgroup running.
> 
> The reason is because we don't properly move tasks in and out of the
> core scheduler queue according to the new core scheduling tag status.
> A task's core scheduler status will then get misaligned with its core
> cookie status.
> 
> The patch below fixes that.
> 
> Thanks.
> 
> Tim
> 

I also encountered kernel panic with the v4 code when taking cpu offline or online
when core scheduler is running.  I've refreshed the previous patch, along
with 3 other patches to fix problems related to CPU online/offline.

As a side effect of the fix, each core can now operate in core-scheduling
mode or non core-scheduling mode, depending on how many online SMT threads it has.

Vineet, are you guys planning to refresh v4 and update it to v5?  Aubrey posted
a port to the latest kernel earlier.

Tim

--->8---
From 3c00f178538e2a33d075b5705adaf31784b19add Mon Sep 17 00:00:00 2001
Message-Id: <3c00f178538e2a33d075b5705adaf31784b19add.1578960120.git.tim.c.chen@linux.intel.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Thu, 7 Nov 2019 15:45:24 -0500
Subject: [PATCH 1/4] sched: Update tasks in core queue when its cgroup tag is
 changed

A task will need to be moved into the core scheduler queue when the cgroup
it belongs to is tagged to run with core scheduling.  Similarly the task
will need to be moved out of the core scheduler queue when the cgroup
is untagged.

Also after we forked a task, its core scheduler queue's presence will
need to be updated according to its new cgroup's status.

Implement these missing core scheduler queue update mechanisms.
Otherwise, the core scheduler will OOPs the kernel when we toggle the
cgroup's core scheduling tag due to inconsistent core scheduler queue
status.

Use stop machine mechanism to update all tasks in a cgroup to prevent a
new task from sneaking into the cgroup, and missed out from the update
while we iterates through all the tasks in the cgroup.  A more complicated
scheme could probably avoid the stop machine.  Such scheme will also
need to resovle inconsistency between a task's cgroup core scheduling
tag and residency in core scheduler queue.

We are opting for the simple stop machine mechanism for now that avoids
such complications.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c | 120 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 107 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778b5940c30..44399f5434f8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -138,6 +138,37 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
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
@@ -169,10 +200,11 @@ static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
-	if (!p->core_cookie)
+	if (!sched_core_enqueued(p))
 		return;
 
 	rb_erase(&p->core_node, &rq->core_tree);
+	RB_CLEAR_NODE(&p->core_node);
 }
 
 /*
@@ -236,6 +268,18 @@ static int __sched_core_stopper(void *data)
 	bool enabled = !!(unsigned long)data;
 	int cpu;
 
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
 	for_each_online_cpu(cpu)
 		cpu_rq(cpu)->core_enabled = enabled;
 
@@ -247,7 +291,11 @@ static int sched_core_count;
 
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
@@ -257,8 +305,6 @@ static void __sched_core_enable(void)
 
 static void __sched_core_disable(void)
 {
-	// XXX verify there are no cookie tasks (left)
-
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
 
@@ -285,6 +331,7 @@ void sched_core_put(void)
 
 static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
 static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+static bool sched_core_enqueued(struct task_struct *task) { return false; }
 
 #endif /* CONFIG_SCHED_CORE */
 
@@ -3016,6 +3063,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SMP
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
+#endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&p->core_node);
 #endif
 	return 0;
 }
@@ -6560,6 +6610,9 @@ void init_idle(struct task_struct *idle, int cpu)
 #ifdef CONFIG_SMP
 	sprintf(idle->comm, "%s/%d", INIT_TASK_COMM, cpu);
 #endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&idle->core_node);
+#endif
 }
 
 #ifdef CONFIG_SMP
@@ -7671,7 +7724,12 @@ static void cpu_cgroup_fork(struct task_struct *task)
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
@@ -8033,12 +8091,52 @@ static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype
 	return !!tg->tagged;
 }
 
-static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+struct write_core_tag {
+	struct cgroup_subsys_state *css;
+	int val;
+};
+
+static int __sched_write_tag(void *data)
 {
-	struct task_group *tg = css_tg(css);
+	struct write_core_tag *tag = (struct write_core_tag *) data;
+	struct cgroup_subsys_state *css = tag->css;
+	int val = tag->val;
+	struct task_group *tg = css_tg(tag->css);
 	struct css_task_iter it;
 	struct task_struct *p;
 
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
 	if (val > 1)
 		return -ERANGE;
 
@@ -8048,16 +8146,12 @@ static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype
 	if (tg->tagged == !!val)
 		return 0;
 
-	tg->tagged = !!val;
-
 	if (!!val)
 		sched_core_get();
 
-	css_task_iter_start(css, 0, &it);
-	while ((p = css_task_iter_next(&it)))
-		p->core_cookie = !!val ? (unsigned long)tg : 0UL;
-	css_task_iter_end(&it);
-
+	wtag.css = css;
+	wtag.val = val;
+	stop_machine(__sched_write_tag, (void *) &wtag, NULL);
 	if (!val)
 		sched_core_put();
 
-- 
2.20.1


From ee10a2f324702b5d940545322686fb6f1ec61431 Mon Sep 17 00:00:00 2001
Message-Id: <ee10a2f324702b5d940545322686fb6f1ec61431.1578960120.git.tim.c.chen@linux.intel.com>
In-Reply-To: <3c00f178538e2a33d075b5705adaf31784b19add.1578960120.git.tim.c.chen@linux.intel.com>
References: <3c00f178538e2a33d075b5705adaf31784b19add.1578960120.git.tim.c.chen@linux.intel.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Mon, 22 Jul 2019 16:13:45 -0700
Subject: [PATCH 2/4] sched: Return idle task in pick_next_task for offlined
 CPU

There could be races in core scheduler where a CPU is trying to pick
a task for its sibling in core scheduler, when that CPU has just been
offlined.  We should not schedule any tasks on the CPU in this case.
Return an idle task in pick_next_task for this situation.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44399f5434f8..1a132beba3f8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4154,6 +4154,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	int i, j, cpu, occ = 0;
 	bool need_sync = false;
 
+	cpu = cpu_of(rq);
+	if (cpu_is_offline(cpu))
+		return idle_sched_class.pick_next_task(rq, prev, rf);
+
 	if (!sched_core_enabled(rq))
 		return __pick_next_task(rq, prev, rf);
 
@@ -4186,7 +4190,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	if (!rq->nr_running)
 		newidle_balance(rq, rf);
 
-	cpu = cpu_of(rq);
 	smt_mask = cpu_smt_mask(cpu);
 
 	/*
@@ -4228,8 +4231,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			struct rq *rq_i = cpu_rq(i);
 			struct task_struct *p;
 
-			if (cpu_is_offline(i))
+			if (cpu_is_offline(i)) {
+				rq_i->core_pick = rq_i->idle;
 				continue;
+			}
 
 			if (rq_i->core_pick)
 				continue;
-- 
2.20.1


From 226c811b3dc74452dc04244d57919d67a2555cc1 Mon Sep 17 00:00:00 2001
Message-Id: <226c811b3dc74452dc04244d57919d67a2555cc1.1578960120.git.tim.c.chen@linux.intel.com>
In-Reply-To: <3c00f178538e2a33d075b5705adaf31784b19add.1578960120.git.tim.c.chen@linux.intel.com>
References: <3c00f178538e2a33d075b5705adaf31784b19add.1578960120.git.tim.c.chen@linux.intel.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Tue, 7 Jan 2020 13:22:28 -0800
Subject: [PATCH 3/4] sched/core: Enable core scheduler only for core with SMT
 threads

Core scheduler has extra overhead.  Enable it only for core with
more than one SMT hardware threads.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a132beba3f8..9d875d6ed3f3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -280,8 +280,10 @@ static int __sched_core_stopper(void *data)
 		}
 	}
 
-	for_each_online_cpu(cpu)
-		cpu_rq(cpu)->core_enabled = enabled;
+	for_each_online_cpu(cpu) {
+		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2))
+			cpu_rq(cpu)->core_enabled = enabled;
+	}
 
 	return 0;
 }
-- 
2.20.1


From 38c85b523a88b7dd0f659a874c7a1793751ca5ab Mon Sep 17 00:00:00 2001
Message-Id: <38c85b523a88b7dd0f659a874c7a1793751ca5ab.1578960120.git.tim.c.chen@linux.intel.com>
In-Reply-To: <3c00f178538e2a33d075b5705adaf31784b19add.1578960120.git.tim.c.chen@linux.intel.com>
References: <3c00f178538e2a33d075b5705adaf31784b19add.1578960120.git.tim.c.chen@linux.intel.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Tue, 7 Jan 2020 13:26:54 -0800
Subject: [PATCH 4/4] sched/core: Update core scheduler queue when taking cpu
 online/offline

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
index 9d875d6ed3f3..8db8960c6e69 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -74,6 +74,11 @@ int sysctl_sched_rt_runtime = 950000;
 
 #ifdef CONFIG_SCHED_CORE
 
+struct core_sched_cpu_work {
+	struct work_struct work;
+	cpumask_t smt_mask;
+};
+
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
 
 /* kernel prio, less is more */
@@ -207,6 +212,18 @@ static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
 	RB_CLEAR_NODE(&p->core_node);
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
@@ -329,11 +346,133 @@ void sched_core_put(void)
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
 static bool sched_core_enqueued(struct task_struct *task) { return false; }
+static inline void core_sched_cpu_update(unsigned int cpu, int action) { }
 
 #endif /* CONFIG_SCHED_CORE */
 
@@ -6941,13 +7080,8 @@ int sched_cpu_activate(unsigned int cpu)
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
 
@@ -6996,15 +7130,10 @@ int sched_cpu_deactivate(unsigned int cpu)
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
@@ -7081,9 +7210,6 @@ int sched_cpu_dying(unsigned int cpu)
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
index 514b6328262f..6bb69d42965b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1755,6 +1755,37 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
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
@@ -2430,6 +2461,10 @@ const struct sched_class dl_sched_class = {
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
index 4728f5ed45aa..6cfcced2b0bd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10058,6 +10058,40 @@ static void rq_offline_fair(struct rq *rq)
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
 
 #ifdef CONFIG_SCHED_CORE
@@ -10612,6 +10646,10 @@ const struct sched_class fair_sched_class = {
 
 	.task_dead		= task_dead_fair,
 	.set_cpus_allowed	= set_cpus_allowed_common,
+#ifdef CONFIG_SCHED_CORE
+	.core_sched_activate	= core_sched_activate_fair,
+	.core_sched_deactivate	= core_sched_deactivate_fair,
+#endif
 #endif
 
 	.task_tick		= task_tick_fair,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4714630a90b9..c6694e45b255 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1548,6 +1548,45 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
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
@@ -2382,6 +2421,10 @@ const struct sched_class rt_sched_class = {
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
index 4844e703298a..c2068f2e2dd2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1055,6 +1055,9 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 
 extern void queue_core_balance(struct rq *rq);
 
+void sched_core_add(struct rq *rq, struct task_struct *p);
+void sched_core_remove(struct rq *rq, struct task_struct *p);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1838,6 +1841,10 @@ struct sched_class {
 
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
+#ifdef CONFIG_SCHED_CORE
+	void (*core_sched_activate)(struct rq *rq);
+	void (*core_sched_deactivate)(struct rq *rq);
+#endif
 #endif
 
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
-- 
2.20.1

