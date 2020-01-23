Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6626AC33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C8924125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JZiyde4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgAWIbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 03:31:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45624 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbgAWIbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 03:31:39 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N8UgmK029676
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 00:31:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=wpZw3E0I4bgJiYNL3nGciIFZCzEZKvAr9+vmUlsNpAE=;
 b=JZiyde4HgcYNTZg/PsLFHDw4iabSTIwIxH/Md75rp1mmMO/m5eBN1lP0N+gHUeY8HzQq
 ArK+pxLtABLRLjTYTL1y52aLFF3xBgVCz+QH7FCviir2JJo3W/TpWMA8R8iqE1gHHorF
 j3W8iaKVBJX6N005oYazTwqMOug+rB8tWys= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xp9a4ye5a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 00:31:37 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Jan 2020 00:31:36 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id F301A62E46B7; Thu, 23 Jan 2020 00:31:28 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v10] perf: Sharing PMU counters across compatible events
Date:   Thu, 23 Jan 2020 00:31:27 -0800
Message-ID: <20200123083127.446105-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=1
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001230073
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to enable PMU sharing. When multiple perf_events are
counting the same metric, they can share the hardware PMU counter. We
call these events as "compatible events".

The PMU sharing are limited to events within the same perf_event_context
(ctx). When a event is installed or enabled, search the ctx for compatible
events. This is implemented in perf_event_setup_dup(). One of these
compatible events are picked as the master (stored in event->dup_master).
Similarly, when the event is removed or disabled, perf_event_remove_dup()
is used to clean up sharing.

A new state PERF_EVENT_STATE_ENABLED is introduced for the master event.
This state is used when the slave event is ACTIVE, but the master event
is not.

On the critical paths (add, del read), sharing PMU counters doesn't
increase the complexity. Helper functions event_pmu_[add|del|read]() are
introduced to cover these cases. All these functions have O(1) time
complexity.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>

---
Changes in v10:
Simplify logic that calls perf_event_setup_dup() and
perf_event_remove_dup(). (Peter)
Other small fixes. (Peter)

Changes in v9:
Avoid ctx_resched() on remove/disable event (Peter).
Compare the whole perf_event_attr in perf_event_compatible().
Small fixes/improvements (Peter).

Changes in v8:
Fix issues with task event (Jiri).
Fix issues with event inherit.
Fix mmap'ed events, i.e. perf test 4 (kernel test bot).

Changes in v7:
Major rewrite to avoid allocating extra master event.
---
 arch/x86/events/core.c     |   7 +
 include/linux/perf_event.h |  22 ++-
 kernel/events/core.c       | 320 ++++++++++++++++++++++++++++++++++---
 3 files changed, 326 insertions(+), 23 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f118af9f0718..8211ab404821 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2297,6 +2297,11 @@ static int x86_pmu_aux_output_match(struct perf_event *event)
 	return 0;
 }
 
+static void x86_copy_hw_config(struct perf_event *old, struct perf_event *new)
+{
+	new->hw.idx = old->hw.idx;
+}
+
 static struct pmu pmu = {
 	.pmu_enable		= x86_pmu_enable,
 	.pmu_disable		= x86_pmu_disable,
@@ -2325,6 +2330,8 @@ static struct pmu pmu = {
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
+
+	.copy_hw_config		= x86_copy_hw_config,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6d4c22aee384..266bf36f020c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -491,6 +491,13 @@ struct pmu {
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
 	 */
 	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
+
+	/*
+	 * Copy hw configuration from one event to another. This is used
+	 * to make switching master faster in PMC sharing.
+	 */
+	void (*copy_hw_config)		(struct perf_event *old,
+					 struct perf_event *new); /* optional */
 };
 
 enum perf_addr_filter_action_t {
@@ -540,6 +547,9 @@ struct perf_addr_filter_range {
 
 /**
  * enum perf_event_state - the states of an event:
+ *
+ * PERF_EVENT_STATE_ENABLED:	Special state for PMC sharing: the hw PMC
+ *				is enabled, but this event is not counting.
  */
 enum perf_event_state {
 	PERF_EVENT_STATE_DEAD		= -4,
@@ -547,7 +557,8 @@ enum perf_event_state {
 	PERF_EVENT_STATE_ERROR		= -2,
 	PERF_EVENT_STATE_OFF		= -1,
 	PERF_EVENT_STATE_INACTIVE	=  0,
-	PERF_EVENT_STATE_ACTIVE		=  1,
+	PERF_EVENT_STATE_ENABLED	=  1,
+	PERF_EVENT_STATE_ACTIVE		=  2,
 };
 
 struct file;
@@ -633,6 +644,7 @@ struct perf_event {
 	int				group_caps;
 
 	struct perf_event		*group_leader;
+	struct perf_event		*dup_master;  /* for PMU sharing */
 	struct pmu			*pmu;
 	void				*pmu_private;
 
@@ -750,6 +762,14 @@ struct perf_event {
 	void *security;
 #endif
 	struct list_head		sb_list;
+
+	/* check event_sync_dup_count() for the use of dup_base_* */
+	u64				dup_base_count;
+	u64				dup_base_child_count;
+	/* when this event is master,  read from master*count */
+	local64_t			master_count;
+	atomic64_t			master_child_count;
+	int				dup_active_count;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 11829570e12c..f03ed09609f3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1657,6 +1657,202 @@ perf_event_groups_next(struct perf_event *event)
 		event = rb_entry_safe(rb_next(&event->group_node),	\
 				typeof(*event), group_node))
 
+static inline bool perf_event_can_share(struct perf_event *event)
+{
+	/* only share hardware counting events */
+	return !is_software_event(event) && !is_sampling_event(event);
+}
+
+/*
+ * Returns whether the two events can share a PMU counter.
+ *
+ * Note: This function does NOT check perf_event_can_share() for
+ * the two events, they should be checked before this function
+ */
+static inline bool perf_event_compatible(struct perf_event *event_a,
+					 struct perf_event *event_b)
+{
+	return memcmp(&event_a->attr, &event_b->attr, event_a->attr.size) == 0;
+}
+
+/* prepare the dup_master, this event is its own dup_master */
+static void perf_event_init_dup_master(struct perf_event *event)
+{
+	bool is_active = event->state == PERF_EVENT_STATE_ACTIVE;
+	s64 count, child_count;
+
+	WARN_ON_ONCE(event->dup_active_count != 0);
+	event->dup_master = event;
+	/*
+	 * dup_master->count is used by the hw PMC, and shared with other
+	 * events, so we have to read from dup_master->master_count. Copy
+	 * event->count to event->master_count.
+	 *
+	 * Same logic for child_count and master_child_count.
+	 */
+	count = local64_read(&event->count);
+	child_count = atomic64_read(&event->child_count);
+	local64_set(&event->master_count, count);
+	atomic64_set(&event->master_child_count, child_count);
+
+	if (is_active) {
+		event->dup_base_count = count;
+		event->dup_base_child_count = child_count;
+
+		event->dup_active_count = 1;
+	}
+}
+
+/* tear down dup_master, no more sharing for this event */
+static void perf_event_exit_dup_master(struct perf_event *event)
+{
+	event->dup_active_count = 0;
+
+	event->dup_master = NULL;
+	/* restore event->count and event->child_count */
+	local64_set(&event->count, local64_read(&event->master_count));
+	atomic64_set(&event->child_count,
+		     atomic64_read(&event->master_child_count));
+}
+
+/*
+ * sync data count from dup_master to event, called on event_pmu_read()
+ * and event_pmu_del()
+ */
+static void event_sync_dup_count(struct perf_event *event,
+				 struct perf_event *master)
+{
+	u64 new_count;
+	u64 new_child_count;
+
+	event->pmu->read(master);
+	new_count = local64_read(&master->count);
+	new_child_count = atomic64_read(&master->child_count);
+
+	if (event == master) {
+		local64_add(new_count - event->dup_base_count,
+			    &event->master_count);
+		atomic64_add(new_child_count - event->dup_base_child_count,
+			     &event->master_child_count);
+	} else {
+		local64_add(new_count - event->dup_base_count, &event->count);
+		atomic64_add(new_child_count - event->dup_base_child_count,
+			     &event->child_count);
+	}
+
+	/* save dup_base_* for next sync */
+	event->dup_base_count = new_count;
+	event->dup_base_child_count = new_child_count;
+}
+
+/* After adding a event to the ctx, try find compatible event(s). */
+static void perf_event_setup_dup(struct perf_event *event,
+				 struct perf_event_context *ctx)
+
+{
+	struct perf_event *tmp;
+
+	if (!perf_event_can_share(event))
+		return;
+
+	/* look for dup with other events */
+	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
+		if (tmp == event ||
+		    !perf_event_can_share(tmp) ||
+		    !perf_event_compatible(event, tmp))
+			continue;
+
+		/* first dup, pick tmp as the master */
+		if (!tmp->dup_master) {
+			if (tmp->state == PERF_EVENT_STATE_ACTIVE)
+				tmp->pmu->read(tmp);
+			perf_event_init_dup_master(tmp);
+		}
+
+		event->dup_master = tmp->dup_master;
+		break;
+	}
+}
+
+static int event_pmu_add(struct perf_event *event,
+			 struct perf_event_context *ctx);
+
+/* Remove dup_master for the event */
+static void perf_event_remove_dup(struct perf_event *event,
+				  struct perf_event_context *ctx)
+
+{
+	struct perf_event *tmp, *new_master;
+
+	int dup_count, active_count;
+
+	/* no sharing */
+	if (!event->dup_master)
+		return;
+
+	WARN_ON_ONCE(event->state < PERF_EVENT_STATE_OFF ||
+		     event->state > PERF_EVENT_STATE_ENABLED);
+
+	/* this event is not the master */
+	if (event->dup_master != event) {
+		event->dup_master = NULL;
+		return;
+	}
+
+	/* this event is the master */
+	dup_count = 0;
+	new_master = NULL;
+	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
+		if (tmp->dup_master != event || tmp == event)
+			continue;
+		if (!new_master)
+			new_master = tmp;
+
+		/* only init new_master when we need to (dup_count > 1) */
+		if (dup_count == 1)
+			perf_event_init_dup_master(new_master);
+
+		if (tmp->state == PERF_EVENT_STATE_ACTIVE) {
+			/* sync read from old master */
+			event_sync_dup_count(tmp, event);
+
+			/* prepare to read from new master */
+			tmp->dup_base_count = local64_read(&new_master->count);
+			tmp->dup_base_child_count =
+				atomic64_read(&new_master->child_count);
+		}
+		tmp->dup_master = new_master;
+		dup_count++;
+	}
+
+	active_count = event->dup_active_count;
+	perf_event_exit_dup_master(event);
+
+	if (!dup_count)
+		return;
+
+	if (dup_count == 1)  /* no more sharing */
+		new_master->dup_master = NULL;
+	else
+		new_master->dup_active_count = active_count;
+
+	if (active_count) {
+		/* copy hardware configure to switch faster */
+		if (event->pmu->copy_hw_config)
+			event->pmu->copy_hw_config(event, new_master);
+
+		perf_pmu_disable(new_master->pmu);
+		WARN_ON_ONCE(new_master->pmu->add(new_master, PERF_EF_START));
+		perf_pmu_enable(new_master->pmu);
+		if (new_master->state == PERF_EVENT_STATE_INACTIVE)
+			/*
+			 * We don't need to update time, so don't call
+			 * perf_event_set_state().
+			 */
+			new_master->state = PERF_EVENT_STATE_ENABLED;
+	}
+}
+
 /*
  * Add an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
@@ -1861,6 +2057,7 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	if (!(event->attach_state & PERF_ATTACH_CONTEXT))
 		return;
 
+	perf_event_remove_dup(event, ctx);
 	event->attach_state &= ~PERF_ATTACH_CONTEXT;
 
 	list_update_cgroup_event(event, ctx, false);
@@ -2084,6 +2281,61 @@ event_filter_match(struct perf_event *event)
 	       perf_cgroup_match(event) && pmu_filter_match(event);
 }
 
+/* PMU sharing aware version of event->pmu->add() */
+static int event_pmu_add(struct perf_event *event,
+			 struct perf_event_context *ctx)
+{
+	struct perf_event *master;
+	int ret;
+
+	/* no sharing, just do event->pmu->add() */
+	if (!event->dup_master)
+		return event->pmu->add(event, PERF_EF_START);
+
+	master = event->dup_master;
+
+	if (!master->dup_active_count) {
+		ret = event->pmu->add(master, PERF_EF_START);
+		if (ret)
+			return ret;
+
+		if (master != event)
+			perf_event_set_state(master, PERF_EVENT_STATE_ENABLED);
+	}
+
+	master->dup_active_count++;
+	master->pmu->read(master);
+	event->dup_base_count = local64_read(&master->count);
+	event->dup_base_child_count = atomic64_read(&master->child_count);
+	return 0;
+}
+
+/* PMU sharing aware version of event->pmu->del() */
+static void event_pmu_del(struct perf_event *event,
+			  struct perf_event_context *ctx)
+{
+	struct perf_event *master;
+
+	if (!event->dup_master)
+		return event->pmu->del(event, 0);
+
+	master = event->dup_master;
+	event_sync_dup_count(event, master);
+	if (--master->dup_active_count == 0) {
+		event->pmu->del(master, 0);
+		perf_event_set_state(master, PERF_EVENT_STATE_INACTIVE);
+	}
+}
+
+/* PMU sharing aware version of event->pmu->read() */
+static void event_pmu_read(struct perf_event *event)
+{
+	if (!event->dup_master)
+		return event->pmu->read(event);
+
+	event_sync_dup_count(event, event->dup_master);
+}
+
 static void
 event_sched_out(struct perf_event *event,
 		  struct perf_cpu_context *cpuctx,
@@ -2094,7 +2346,7 @@ event_sched_out(struct perf_event *event,
 	WARN_ON_ONCE(event->ctx != ctx);
 	lockdep_assert_held(&ctx->lock);
 
-	if (event->state != PERF_EVENT_STATE_ACTIVE)
+	if (event->state < PERF_EVENT_STATE_ENABLED)
 		return;
 
 	/*
@@ -2106,13 +2358,15 @@ event_sched_out(struct perf_event *event,
 
 	perf_pmu_disable(event->pmu);
 
-	event->pmu->del(event, 0);
+	event_pmu_del(event, ctx);
 	event->oncpu = -1;
 
 	if (READ_ONCE(event->pending_disable) >= 0) {
 		WRITE_ONCE(event->pending_disable, -1);
 		state = PERF_EVENT_STATE_OFF;
-	}
+	} else if (event->dup_master == event &&
+		   event->dup_active_count)
+		state = PERF_EVENT_STATE_ENABLED;
 	perf_event_set_state(event, state);
 
 	if (!is_software_event(event))
@@ -2379,7 +2633,7 @@ event_sched_in(struct perf_event *event,
 
 	perf_log_itrace_start(event);
 
-	if (event->pmu->add(event, PERF_EF_START)) {
+	if (event_pmu_add(event, ctx)) {
 		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 		event->oncpu = -1;
 		ret = -EAGAIN;
@@ -2491,6 +2745,7 @@ static void add_event_to_ctx(struct perf_event *event,
 {
 	list_add_event(event, ctx);
 	perf_group_attach(event);
+	perf_event_setup_dup(event, ctx);
 }
 
 static void ctx_sched_out(struct perf_event_context *ctx,
@@ -2793,8 +3048,10 @@ static void __perf_event_enable(struct perf_event *event,
 
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 
-	if (!ctx->is_active)
+	if (!ctx->is_active) {
+		perf_event_setup_dup(event, ctx);
 		return;
+	}
 
 	if (!event_filter_match(event)) {
 		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
@@ -2805,7 +3062,7 @@ static void __perf_event_enable(struct perf_event *event,
 	 * If the event is in a group and isn't the group leader,
 	 * then don't put it on unless the group is on.
 	 */
-	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
+	if (leader != event && leader->state <= PERF_EVENT_STATE_INACTIVE) {
 		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
 		return;
 	}
@@ -3152,8 +3409,8 @@ static void __perf_event_sync_stat(struct perf_event *event,
 	 * we know the event must be on the current CPU, therefore we
 	 * don't need to use it.
 	 */
-	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+	if (event->state > PERF_EVENT_STATE_INACTIVE)
+		event_pmu_read(event);
 
 	perf_event_update_time(event);
 
@@ -4028,22 +4285,22 @@ static void __perf_event_read(void *info)
 		goto unlock;
 
 	if (!data->group) {
-		pmu->read(event);
+		event_pmu_read(event);
 		data->ret = 0;
 		goto unlock;
 	}
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
 
-	pmu->read(event);
+	event_pmu_read(event);
 
 	for_each_sibling_event(sub, event) {
-		if (sub->state == PERF_EVENT_STATE_ACTIVE) {
+		if (sub->state > PERF_EVENT_STATE_INACTIVE) {
 			/*
 			 * Use sibling's PMU rather than @event's since
 			 * sibling could be on different (eg: software) PMU.
 			 */
-			sub->pmu->read(sub);
+			event_pmu_read(sub);
 		}
 	}
 
@@ -4055,6 +4312,11 @@ static void __perf_event_read(void *info)
 
 static inline u64 perf_event_count(struct perf_event *event)
 {
+	if (event->dup_master == event) {
+		return local64_read(&event->master_count) +
+			atomic64_read(&event->master_child_count);
+	}
+
 	return local64_read(&event->count) + atomic64_read(&event->child_count);
 }
 
@@ -4113,9 +4375,12 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 	 * oncpu == -1).
 	 */
 	if (event->oncpu == smp_processor_id())
-		event->pmu->read(event);
+		event_pmu_read(event);
 
-	*value = local64_read(&event->count);
+	if (event->dup_master == event)
+		*value = local64_read(&event->master_count);
+	else
+		*value = local64_read(&event->count);
 	if (enabled || running) {
 		u64 now = event->shadow_ctx_time + perf_clock();
 		u64 __enabled, __running;
@@ -4142,7 +4407,7 @@ static int perf_event_read(struct perf_event *event, bool group)
 	 * value in the event structure:
 	 */
 again:
-	if (state == PERF_EVENT_STATE_ACTIVE) {
+	if (state > PERF_EVENT_STATE_INACTIVE) {
 		struct perf_read_data data;
 
 		/*
@@ -6492,8 +6757,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = running;
 
 	if ((leader != event) &&
-	    (leader->state == PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+	    (leader->state > PERF_EVENT_STATE_INACTIVE))
+		event_pmu_read(leader);
 
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
@@ -6505,8 +6770,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		n = 0;
 
 		if ((sub != event) &&
-		    (sub->state == PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+		    (sub->state > PERF_EVENT_STATE_INACTIVE))
+			event_pmu_read(sub);
 
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
@@ -9804,10 +10069,10 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 
 	event = container_of(hrtimer, struct perf_event, hw.hrtimer);
 
-	if (event->state != PERF_EVENT_STATE_ACTIVE)
+	if (event->state <= PERF_EVENT_STATE_INACTIVE)
 		return HRTIMER_NORESTART;
 
-	event->pmu->read(event);
+	event_pmu_read(event);
 
 	perf_sample_data_init(&data, 0, event->hw.last_period);
 	regs = get_irq_regs();
@@ -11498,9 +11763,17 @@ SYSCALL_DEFINE5(perf_event_open,
 		perf_remove_from_context(group_leader, 0);
 		put_ctx(gctx);
 
+		/*
+		 * move_group only happens to sw events, from sw ctx to hw
+		 * ctx. The sw events should not have valid dup_master. So
+		 * it is not necessary to handle dup_events.
+		 */
+		WARN_ON_ONCE(group_leader->dup_master);
+
 		for_each_sibling_event(sibling, group_leader) {
 			perf_remove_from_context(sibling, 0);
 			put_ctx(gctx);
+			WARN_ON_ONCE(sibling->dup_master);
 		}
 
 		/*
@@ -11767,7 +12040,10 @@ static void sync_child_event(struct perf_event *child_event,
 	/*
 	 * Add back the child's count to the parent's count:
 	 */
-	atomic64_add(child_val, &parent_event->child_count);
+	if (parent_event->dup_master == parent_event)
+		atomic64_add(child_val, &parent_event->master_child_count);
+	else
+		atomic64_add(child_val, &parent_event->child_count);
 	atomic64_add(child_event->total_time_enabled,
 		     &parent_event->child_total_time_enabled);
 	atomic64_add(child_event->total_time_running,
-- 
2.17.1

