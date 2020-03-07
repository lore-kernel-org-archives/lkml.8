Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B4BC3F2D6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E134D206E2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VUqR+uN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCGAKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:10:05 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52770 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726231AbgCGAKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:10:05 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02709sxM004186
        for <linux-kernel@vger.kernel.org>; Fri, 6 Mar 2020 16:10:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=3BRQDMhKeNIOBRwgjv6a5dM15afjpRAyMwmGYgJxDt8=;
 b=VUqR+uN3ba5RzYMzyXzUvhEP6qawuYQmFhOquOxFzuNmC5tPHbKdJJW4hqMOHpmXE2iw
 ppnobndUHBhBS8R8QjB4juSUkfusyFndE8Dt1irP+wFWodXWssoDghjr3ZF4KSs4+tM8
 J65MhAIo26MsOb+IR2KL369gIBD+jX+2O30= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2yk4mjqssj-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 16:10:02 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 6 Mar 2020 16:09:49 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id D04E462E287F; Fri,  6 Mar 2020 16:09:43 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <arnaldo.melo@gmail.com>, <jolsa@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v11] perf: Sharing PMU counters across compatible events
Date:   Fri, 6 Mar 2020 16:09:39 -0800
Message-ID: <20200307000939.3533447-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_09:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060142
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

If the master event is a cgroup event or a event in a group, it is
possible that some slave events are ACTIVE, but the master event is not.
To handle this scenario, we introduced PERF_EVENT_STATE_ENABLED. Also,
since PMU drivers write into event->count, master event needs another
variable (master_count) for the reading of this event.

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

Changes in v11:
Fold in major fixes by Peter.
In perf_event_remove_dup(), del() old master before add() new master.

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
 include/linux/perf_event.h |  21 ++-
 kernel/events/core.c       | 355 ++++++++++++++++++++++++++++++++++---
 3 files changed, 361 insertions(+), 22 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3bb738f5a472..32f836dbfae3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2341,6 +2341,11 @@ static int x86_pmu_aux_output_match(struct perf_event *event)
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
@@ -2369,6 +2374,8 @@ static struct pmu pmu = {
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
+
+	.copy_hw_config		= x86_copy_hw_config,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 547773f5894e..abb9bcb00ce1 100644
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
@@ -540,6 +547,10 @@ struct perf_addr_filter_range {
 
 /**
  * enum perf_event_state - the states of an event:
+ *
+ * PERF_EVENT_STATE_ENABLED:	Special state for PMC sharing: the hw PMC
+ *				is enabled, but this event is not counting.
+ *				See perf_event_init_dup_master().
  */
 enum perf_event_state {
 	PERF_EVENT_STATE_DEAD		= -4,
@@ -547,7 +558,8 @@ enum perf_event_state {
 	PERF_EVENT_STATE_ERROR		= -2,
 	PERF_EVENT_STATE_OFF		= -1,
 	PERF_EVENT_STATE_INACTIVE	=  0,
-	PERF_EVENT_STATE_ACTIVE		=  1,
+	PERF_EVENT_STATE_ENABLED	=  1,
+	PERF_EVENT_STATE_ACTIVE		=  2,
 };
 
 struct file;
@@ -633,6 +645,7 @@ struct perf_event {
 	int				group_caps;
 
 	struct perf_event		*group_leader;
+	struct perf_event		*dup_master;  /* for PMU sharing */
 	struct pmu			*pmu;
 	void				*pmu_private;
 
@@ -750,6 +763,12 @@ struct perf_event {
 	void *security;
 #endif
 	struct list_head		sb_list;
+
+	int				dup_active;
+	/* See event_pmu_read_dup() */
+	local64_t			dup_count;
+	/* See perf_event_init_dup_master() */
+	local64_t			master_count;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 969a71db5487..fc7d0c972e5b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1658,6 +1658,238 @@ perf_event_groups_next(struct perf_event *event)
 		event = rb_entry_safe(rb_next(&event->group_node),	\
 				typeof(*event), group_node))
 
+static inline bool perf_event_can_share(struct perf_event *event)
+{
+	/* only share hardware counting events */
+	return !is_sampling_event(event);
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
+static void perf_event_init_dup_master(struct perf_event *event)
+{
+	bool is_active = event->state == PERF_EVENT_STATE_ACTIVE;
+	s64 count;
+
+	WARN_ON_ONCE(event->dup_active != 0);
+	event->dup_master = event;
+	/*
+	 * The event sharing scheme allows for duplicate events to be ACTIVE
+	 * while the master is not. In order to facilitate this, the master
+	 * will be put in the ENABLED state whenever it has active duplicates
+	 * but is itself *not* ACTIVE.
+	 *
+	 * When ENABLED the master event is scheduled, but its counter must
+	 * appear stalled. Since the PMU driver updates event->count, the
+	 * master must keep a shadow counter for itself, this is
+	 * event->master_count.
+	 */
+	count = local64_read(&event->count);
+	local64_set(&event->master_count, count);
+
+	if (is_active) {
+		local64_set(&event->dup_count, count);
+		event->dup_active = 1;
+	}
+
+	barrier();
+
+	WRITE_ONCE(event->dup_master, event);
+}
+
+/* tear down dup_master, no more sharing for this event */
+static void perf_event_exit_dup_master(struct perf_event *event)
+{
+	WARN_ON_ONCE(event->state < PERF_EVENT_STATE_OFF ||
+		     event->state > PERF_EVENT_STATE_INACTIVE);
+
+	/* restore event->count and event->child_count */
+	local64_set(&event->count, local64_read(&event->master_count));
+
+	event->dup_active = 0;
+	WRITE_ONCE(event->dup_master, NULL);
+
+	barrier();
+}
+
+#define EVENT_TOMBSTONE ((void *)-1L)
+
+/*
+ * sync data count from dup_master to event, called on event_pmu_read()
+ * and event_pmu_del()
+ */
+static void
+event_pmu_read_dup(struct perf_event *event, struct perf_event *master)
+{
+	u64 prev_count, new_count;
+
+	if (master == EVENT_TOMBSTONE)
+		return;
+
+again:
+	prev_count = local64_read(&event->dup_count);
+	if (master->state > PERF_EVENT_STATE_INACTIVE)
+		master->pmu->read(master);
+	new_count = local64_read(&master->count);
+	if (local64_cmpxchg(&event->dup_count, prev_count, new_count) != prev_count)
+		goto again;
+
+	if (event == master)
+		local64_add(new_count - prev_count, &event->master_count);
+	else
+		local64_add(new_count - prev_count, &event->count);
+}
+
+/* After adding a event to the ctx, try find compatible event(s). */
+static void
+perf_event_setup_dup(struct perf_event *event, struct perf_event_context *ctx)
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
+
+		break;
+	}
+}
+
+/* Remove dup_master for the event */
+static void
+perf_event_remove_dup(struct perf_event *event, struct perf_event_context *ctx)
+
+{
+	struct perf_event *tmp, *new_master;
+	int dup_count, active_count;
+	int ret;
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
+	active_count = event->dup_active;
+	if (active_count) {
+		perf_pmu_disable(event->pmu);
+		event->pmu->del(event, 0);
+	}
+
+	/* this event is the master */
+	dup_count = 0;
+	new_master = NULL;
+	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
+		u64 count;
+
+		if (tmp->dup_master != event || tmp == event)
+			continue;
+		if (!new_master)
+			new_master = tmp;
+
+		if (tmp->state == PERF_EVENT_STATE_ACTIVE) {
+			/* sync read from old master */
+			event_pmu_read_dup(tmp, event);
+		}
+		/*
+		 * Flip an active event to a new master; this is tricky
+		 * because for an active event event_pmu_read() can be
+		 * called at any time from NMI context.
+		 *
+		 * This means we need to have ->dup_master and ->dup_count
+		 * consistent at all times. Of course we cannot do two
+		 * writes at once :/
+		 *
+		 * Instead, flip ->dup_master to EVENT_TOMBSTONE, this will
+		 * make event_pmu_read_dup() NOP. Then we can set
+		 * ->dup_count and finally set ->dup_master to the
+		 * new_master to let event_pmu_read_dup() rip.
+		 */
+		WRITE_ONCE(tmp->dup_master, EVENT_TOMBSTONE);
+		barrier();
+
+		count = local64_read(&new_master->count);
+		local64_set(&tmp->dup_count, count);
+
+		if (tmp == new_master)
+			local64_set(&tmp->master_count, count);
+
+		barrier();
+		WRITE_ONCE(tmp->dup_master, new_master);
+		dup_count++;
+	}
+
+	perf_event_exit_dup_master(event);
+
+	if (!dup_count)
+		return;
+
+	if (active_count) {
+		/* copy hardware configure to switch faster */
+		if (event->pmu->copy_hw_config)
+			event->pmu->copy_hw_config(event, new_master);
+
+		ret = new_master->pmu->add(new_master, PERF_EF_START);
+		/*
+		 * Since we just removed the old master (@event), it should be
+		 * impossible to fail to schedule the new master, an identical
+		 * event.
+		 */
+		WARN_ON_ONCE(ret);
+		if (new_master->state == PERF_EVENT_STATE_INACTIVE) {
+			/*
+			 * We don't need to update time, so don't call
+			 * perf_event_set_state().
+			 */
+			new_master->state = PERF_EVENT_STATE_ENABLED;
+		}
+		perf_pmu_enable(new_master->pmu);
+	}
+
+	if (dup_count == 1) {
+		/*
+		 * We set up as a master, but there aren't any more duplicates.
+		 * Simply clear ->dup_master, as ->master_count == ->count per
+		 * the above.
+		 */
+		WRITE_ONCE(new_master->dup_master, NULL);
+	} else {
+		new_master->dup_active = active_count;
+	}
+}
+
 /*
  * Add an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
@@ -1862,6 +2094,7 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	if (!(event->attach_state & PERF_ATTACH_CONTEXT))
 		return;
 
+	perf_event_remove_dup(event, ctx);
 	event->attach_state &= ~PERF_ATTACH_CONTEXT;
 
 	list_update_cgroup_event(event, ctx, false);
@@ -2085,6 +2318,62 @@ event_filter_match(struct perf_event *event)
 	       perf_cgroup_match(event) && pmu_filter_match(event);
 }
 
+/* PMU sharing aware version of event->pmu->add() */
+static int event_pmu_add(struct perf_event *event,
+			 struct perf_event_context *ctx)
+{
+	struct perf_event *master;
+	s64 value;
+	int ret;
+
+	/* no sharing, just do event->pmu->add() */
+	if (!event->dup_master)
+		return event->pmu->add(event, PERF_EF_START);
+
+	master = event->dup_master;
+
+	if (!master->dup_active) {
+		ret = event->pmu->add(master, PERF_EF_START);
+		if (ret)
+			return ret;
+
+		if (master != event)
+			perf_event_set_state(master, PERF_EVENT_STATE_ENABLED);
+	}
+
+	master->dup_active++;
+	master->pmu->read(master);
+	value = local64_read(&master->count);
+	local64_set(&event->dup_count, value);
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
+	if (!--master->dup_active) {
+		event->pmu->del(master, 0);
+		perf_event_set_state(master, PERF_EVENT_STATE_INACTIVE);
+	}
+	event_pmu_read_dup(event, master);
+}
+
+/* PMU sharing aware version of event->pmu->read() */
+static void event_pmu_read(struct perf_event *event)
+{
+	if (!event->dup_master)
+		return event->pmu->read(event);
+
+	event_pmu_read_dup(event, event->dup_master);
+}
+
 static void
 event_sched_out(struct perf_event *event,
 		  struct perf_cpu_context *cpuctx,
@@ -2095,7 +2384,7 @@ event_sched_out(struct perf_event *event,
 	WARN_ON_ONCE(event->ctx != ctx);
 	lockdep_assert_held(&ctx->lock);
 
-	if (event->state != PERF_EVENT_STATE_ACTIVE)
+	if (event->state < PERF_EVENT_STATE_ENABLED)
 		return;
 
 	/*
@@ -2107,12 +2396,15 @@ event_sched_out(struct perf_event *event,
 
 	perf_pmu_disable(event->pmu);
 
-	event->pmu->del(event, 0);
+	event_pmu_del(event, ctx);
 	event->oncpu = -1;
 
 	if (READ_ONCE(event->pending_disable) >= 0) {
 		WRITE_ONCE(event->pending_disable, -1);
 		state = PERF_EVENT_STATE_OFF;
+	} else if (event->dup_active) {
+		WARN_ON_ONCE(event->dup_master != event);
+		state = PERF_EVENT_STATE_ENABLED;
 	}
 	perf_event_set_state(event, state);
 
@@ -2380,7 +2672,7 @@ event_sched_in(struct perf_event *event,
 
 	perf_log_itrace_start(event);
 
-	if (event->pmu->add(event, PERF_EF_START)) {
+	if (event_pmu_add(event, ctx)) {
 		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 		event->oncpu = -1;
 		ret = -EAGAIN;
@@ -2492,6 +2784,7 @@ static void add_event_to_ctx(struct perf_event *event,
 {
 	list_add_event(event, ctx);
 	perf_group_attach(event);
+	perf_event_setup_dup(event, ctx);
 }
 
 static void ctx_sched_out(struct perf_event_context *ctx,
@@ -2791,8 +3084,10 @@ static void __perf_event_enable(struct perf_event *event,
 
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 
-	if (!ctx->is_active)
+	if (!ctx->is_active) {
+		perf_event_setup_dup(event, ctx);
 		return;
+	}
 
 	if (!event_filter_match(event)) {
 		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
@@ -2803,7 +3098,7 @@ static void __perf_event_enable(struct perf_event *event,
 	 * If the event is in a group and isn't the group leader,
 	 * then don't put it on unless the group is on.
 	 */
-	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
+	if (leader != event && leader->state <= PERF_EVENT_STATE_INACTIVE) {
 		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
 		return;
 	}
@@ -3150,8 +3445,8 @@ static void __perf_event_sync_stat(struct perf_event *event,
 	 * we know the event must be on the current CPU, therefore we
 	 * don't need to use it.
 	 */
-	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+	if (event->state > PERF_EVENT_STATE_INACTIVE)
+		event_pmu_read(event);
 
 	perf_event_update_time(event);
 
@@ -4026,22 +4321,22 @@ static void __perf_event_read(void *info)
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
 
@@ -4053,7 +4348,14 @@ static void __perf_event_read(void *info)
 
 static inline u64 perf_event_count(struct perf_event *event)
 {
-	return local64_read(&event->count) + atomic64_read(&event->child_count);
+	u64 count;
+
+	if (likely(event->dup_master != event))
+		count = local64_read(&event->count);
+	else
+		count = local64_read(&event->master_count);
+
+	return count + atomic64_read(&event->child_count);
 }
 
 /*
@@ -4111,9 +4413,12 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
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
@@ -4140,7 +4445,7 @@ static int perf_event_read(struct perf_event *event, bool group)
 	 * value in the event structure:
 	 */
 again:
-	if (state == PERF_EVENT_STATE_ACTIVE) {
+	if (state > PERF_EVENT_STATE_INACTIVE) {
 		struct perf_read_data data;
 
 		/*
@@ -6498,8 +6803,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = running;
 
 	if ((leader != event) &&
-	    (leader->state == PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+	    (leader->state > PERF_EVENT_STATE_INACTIVE))
+		event_pmu_read(leader);
 
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
@@ -6511,8 +6816,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		n = 0;
 
 		if ((sub != event) &&
-		    (sub->state == PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+		    (sub->state > PERF_EVENT_STATE_INACTIVE))
+			event_pmu_read(sub);
 
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
@@ -9810,10 +10115,10 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 
 	event = container_of(hrtimer, struct perf_event, hw.hrtimer);
 
-	if (event->state != PERF_EVENT_STATE_ACTIVE)
+	if (event->state <= PERF_EVENT_STATE_INACTIVE)
 		return HRTIMER_NORESTART;
 
-	event->pmu->read(event);
+	event_pmu_read(event);
 
 	perf_sample_data_init(&data, 0, event->hw.last_period);
 	regs = get_irq_regs();
@@ -11504,9 +11809,17 @@ SYSCALL_DEFINE5(perf_event_open,
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
-- 
2.17.1

