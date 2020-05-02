Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC40C47256
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7EA21835
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GjxI/GGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgEBAVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 20:21:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15034 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726352AbgEBAVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:21:49 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0420AGno022029
        for <linux-kernel@vger.kernel.org>; Fri, 1 May 2020 17:21:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=XyF6yllWZVLqd7sMLDhcJwIoEEAvSBQiu3h/zBhd4YY=;
 b=GjxI/GGtTnyYt5aM5i2OV9VMkNoEW4z2MRsLHp02s0ERU7slh4e4bTxX8oNMsgUI/uJU
 /Dhx6p4s4xjuccVPEw/ihEkWfRNwu3kPZNU41i06HT5wqgZK75e+ZFItfed2EDYB6r5K
 y5wmTv9B/H8mKkbDwuGBQ9NCboLLWnXP+gY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30r7dyxq0y-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 17:21:47 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 1 May 2020 17:21:39 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 97A1862E4E3D; Fri,  1 May 2020 17:21:32 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel test robot <rong.a.chen@intel.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v13] perf: Sharing PMU counters across compatible events
Date:   Fri, 1 May 2020 17:21:30 -0700
Message-ID: <20200502002131.3031835-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_18:2020-05-01,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=1
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005020000
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to enable PMU sharing. When multiple perf_events are
counting the same metric, they can share the hardware PMU counter. We
call these events as "compatible events".

The PMU sharing are limited to events within the same perf_event_context
(ctx). When a event is installed or enabled, search the ctx for compatibl=
e
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
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>

---
Changes in v13:
Fix memory ordering in perf_event_exit_dup_master and perf_event_count.
Remove test code in perf_event_can_share().

Changes in v12:
Add perf_event->dup_active_list to fix rdpmc. (kernel test robot)
Fix event reset. (kernel test robot)
Do not consider sharing when the perf event is disabled.

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
(cherry picked from commit 8b98afc0ec100b017a5e80c184809939d4f01f8d)

fix perf_event_count()
---
 arch/x86/events/core.c     |   7 +
 include/linux/perf_event.h |  22 +-
 kernel/events/core.c       | 422 ++++++++++++++++++++++++++++++++++---
 3 files changed, 416 insertions(+), 35 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9e63ee50b19a..a245cac31a19 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2345,6 +2345,11 @@ static int x86_pmu_aux_output_match(struct perf_ev=
ent *event)
 	return 0;
 }
=20
+static void x86_copy_hw_config(struct perf_event *old, struct perf_event=
 *new)
+{
+	new->hw.idx =3D old->hw.idx;
+}
+
 static struct pmu pmu =3D {
 	.pmu_enable		=3D x86_pmu_enable,
 	.pmu_disable		=3D x86_pmu_disable,
@@ -2373,6 +2378,8 @@ static struct pmu pmu =3D {
 	.check_period		=3D x86_pmu_check_period,
=20
 	.aux_output_match	=3D x86_pmu_aux_output_match,
+
+	.copy_hw_config		=3D x86_copy_hw_config,
 };
=20
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 87e21681759c..1306fbd920fd 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -503,6 +503,13 @@ struct pmu {
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
 	 */
 	int (*check_period)		(struct perf_event *event, u64 value); /* optional=
 */
+
+	/*
+	 * Copy hw configuration from one event to another. This is used
+	 * to make switching master faster in PMC sharing.
+	 */
+	void (*copy_hw_config)		(struct perf_event *old,
+					 struct perf_event *new); /* optional */
 };
=20
 enum perf_addr_filter_action_t {
@@ -552,6 +559,10 @@ struct perf_addr_filter_range {
=20
 /**
  * enum perf_event_state - the states of an event:
+ *
+ * PERF_EVENT_STATE_ENABLED:	Special state for PMC sharing: the hw PMC
+ *				is enabled, but this event is not counting.
+ *				See perf_event_init_dup_master().
  */
 enum perf_event_state {
 	PERF_EVENT_STATE_DEAD		=3D -4,
@@ -559,7 +570,8 @@ enum perf_event_state {
 	PERF_EVENT_STATE_ERROR		=3D -2,
 	PERF_EVENT_STATE_OFF		=3D -1,
 	PERF_EVENT_STATE_INACTIVE	=3D  0,
-	PERF_EVENT_STATE_ACTIVE		=3D  1,
+	PERF_EVENT_STATE_ENABLED	=3D  1,
+	PERF_EVENT_STATE_ACTIVE		=3D  2,
 };
=20
 struct file;
@@ -645,6 +657,7 @@ struct perf_event {
 	int				group_caps;
=20
 	struct perf_event		*group_leader;
+	struct perf_event		*dup_master;  /* for PMU sharing */
 	struct pmu			*pmu;
 	void				*pmu_private;
=20
@@ -762,6 +775,13 @@ struct perf_event {
 	void *security;
 #endif
 	struct list_head		sb_list;
+
+	int				dup_active;
+	/* See event_pmu_read_dup() */
+	local64_t			dup_count;
+	/* See perf_event_init_dup_master() */
+	local64_t			master_count;
+	struct list_head		dup_active_list;
 #endif /* CONFIG_PERF_EVENTS */
 };
=20
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 206dd29c3c6c..40c8b15407b7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1002,7 +1002,6 @@ perf_cgroup_event_enable(struct perf_event *event, =
struct perf_event_context *ct
 	 */
 	cpuctx =3D container_of(ctx, struct perf_cpu_context, ctx);
=20
-	pr_info("%s cpu %d\n", __func__, smp_processor_id());
 	/*
 	 * Since setting cpuctx->cgrp is conditional on the current @cgrp
 	 * matching the event's cgroup, we must do this for every new event,
@@ -1012,8 +1011,6 @@ perf_cgroup_event_enable(struct perf_event *event, =
struct perf_event_context *ct
 	if (ctx->is_active && !cpuctx->cgrp) {
 		struct perf_cgroup *cgrp =3D perf_cgroup_from_task(current, ctx);
=20
-		pr_info("%s cpu %d cgrp %px\n", __func__, smp_processor_id(),
-			cgrp);
 		if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
 			cpuctx->cgrp =3D cgrp;
 	}
@@ -1785,6 +1782,244 @@ perf_event_groups_next(struct perf_event *event)
 		event =3D rb_entry_safe(rb_next(&event->group_node),	\
 				typeof(*event), group_node))
=20
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
+	return memcmp(&event_a->attr, &event_b->attr, event_a->attr.size) =3D=3D=
 0;
+}
+
+static void perf_event_init_dup_master(struct perf_event *event)
+{
+	bool is_active =3D event->state =3D=3D PERF_EVENT_STATE_ACTIVE;
+	s64 count;
+
+	WARN_ON_ONCE(event->dup_active !=3D 0);
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
+	count =3D local64_read(&event->count);
+	local64_set(&event->master_count, count);
+
+	if (is_active) {
+		local64_set(&event->dup_count, count);
+		event->dup_active =3D 1;
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
+	barrier();
+
+	WRITE_ONCE(event->dup_master, NULL);
+	event->dup_active =3D 0;
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
+	if (master =3D=3D EVENT_TOMBSTONE)
+		return;
+
+again:
+	prev_count =3D local64_read(&event->dup_count);
+	if (master->state > PERF_EVENT_STATE_INACTIVE)
+		master->pmu->read(master);
+	new_count =3D local64_read(&master->count);
+	if (local64_cmpxchg(&event->dup_count, prev_count, new_count) !=3D prev=
_count)
+		goto again;
+
+	if (event =3D=3D master)
+		local64_add(new_count - prev_count, &event->master_count);
+	else
+		local64_add(new_count - prev_count, &event->count);
+}
+
+/* After adding a event to the ctx, try find compatible event(s). */
+static void
+perf_event_setup_dup(struct perf_event *event, struct perf_event_context=
 *ctx)
+{
+	struct perf_event *tmp;
+
+	if (event->state < PERF_EVENT_STATE_OFF ||
+	    !perf_event_can_share(event))
+		return;
+
+	/* look for dup with other events */
+	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
+		if (tmp =3D=3D event ||
+		    !perf_event_can_share(tmp) ||
+		    !perf_event_compatible(event, tmp))
+			continue;
+		if (tmp->state < PERF_EVENT_STATE_INACTIVE)
+			continue;
+
+		/* first dup, pick tmp as the master */
+		if (!tmp->dup_master) {
+			if (tmp->state =3D=3D PERF_EVENT_STATE_ACTIVE)
+				tmp->pmu->read(tmp);
+			perf_event_init_dup_master(tmp);
+		}
+
+		event->dup_master =3D tmp->dup_master;
+
+		break;
+	}
+}
+
+/* Remove dup_master for the event */
+static void
+perf_event_remove_dup(struct perf_event *event, struct perf_event_contex=
t *ctx)
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
+	if (event->dup_master !=3D event) {
+		event->dup_master =3D NULL;
+		return;
+	}
+
+	active_count =3D event->dup_active;
+	if (active_count) {
+		perf_pmu_disable(event->pmu);
+		event->pmu->del(event, 0);
+	}
+
+	/* this event is the master */
+	dup_count =3D 0;
+	new_master =3D NULL;
+	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
+		u64 count;
+
+		if (tmp->dup_master !=3D event || tmp =3D=3D event)
+			continue;
+		if (!new_master) {
+			new_master =3D tmp;
+			list_del_init(&new_master->dup_active_list);
+		}
+
+		if (tmp->state =3D=3D PERF_EVENT_STATE_ACTIVE) {
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
+		count =3D local64_read(&new_master->count);
+		local64_set(&tmp->dup_count, count);
+
+		if (tmp =3D=3D new_master)
+			local64_set(&tmp->master_count, count);
+		else if (tmp->state =3D=3D PERF_EVENT_STATE_ACTIVE)
+			list_move_tail(&tmp->dup_active_list,
+				       &new_master->dup_active_list);
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
+		ret =3D new_master->pmu->add(new_master, PERF_EF_START);
+		/*
+		 * Since we just removed the old master (@event), it should be
+		 * impossible to fail to schedule the new master, an identical
+		 * event.
+		 */
+		WARN_ON_ONCE(ret);
+		if (new_master->state =3D=3D PERF_EVENT_STATE_INACTIVE) {
+			/*
+			 * We don't need to update time, so don't call
+			 * perf_event_set_state().
+			 */
+			new_master->state =3D PERF_EVENT_STATE_ENABLED;
+		}
+		perf_pmu_enable(new_master->pmu);
+	}
+
+	if (dup_count =3D=3D 1) {
+		/*
+		 * We set up as a master, but there aren't any more duplicates.
+		 * Simply clear ->dup_master, as ->master_count =3D=3D ->count per
+		 * the above.
+		 */
+		WRITE_ONCE(new_master->dup_master, NULL);
+	} else {
+		new_master->dup_active =3D active_count;
+	}
+}
+
 /*
  * Add an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
@@ -1993,6 +2228,7 @@ list_del_event(struct perf_event *event, struct per=
f_event_context *ctx)
 	if (!(event->attach_state & PERF_ATTACH_CONTEXT))
 		return;
=20
+	perf_event_remove_dup(event, ctx);
 	event->attach_state &=3D ~PERF_ATTACH_CONTEXT;
=20
 	ctx->nr_events--;
@@ -2218,6 +2454,68 @@ event_filter_match(struct perf_event *event)
 	       perf_cgroup_match(event) && pmu_filter_match(event);
 }
=20
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
+	master =3D event->dup_master;
+
+	if (!master->dup_active) {
+		ret =3D event->pmu->add(master, PERF_EF_START);
+		if (ret)
+			return ret;
+
+		if (master !=3D event)
+			perf_event_set_state(master, PERF_EVENT_STATE_ENABLED);
+	}
+
+	master->dup_active++;
+	if (master !=3D event)
+		list_add_tail(&event->dup_active_list,
+			      &master->dup_active_list);
+	master->pmu->read(master);
+	value =3D local64_read(&master->count);
+	local64_set(&event->dup_count, value);
+	perf_event_update_userpage(event);
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
+	master =3D event->dup_master;
+	if (!--master->dup_active) {
+		event->pmu->del(master, 0);
+		perf_event_set_state(master, PERF_EVENT_STATE_INACTIVE);
+	}
+	event_pmu_read_dup(event, master);
+	if (master !=3D event)
+		list_del_init(&event->dup_active_list);
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
@@ -2228,7 +2526,7 @@ event_sched_out(struct perf_event *event,
 	WARN_ON_ONCE(event->ctx !=3D ctx);
 	lockdep_assert_held(&ctx->lock);
=20
-	if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
+	if (event->state < PERF_EVENT_STATE_ENABLED)
 		return;
=20
 	/*
@@ -2240,13 +2538,16 @@ event_sched_out(struct perf_event *event,
=20
 	perf_pmu_disable(event->pmu);
=20
-	event->pmu->del(event, 0);
+	event_pmu_del(event, ctx);
 	event->oncpu =3D -1;
=20
 	if (READ_ONCE(event->pending_disable) >=3D 0) {
 		WRITE_ONCE(event->pending_disable, -1);
 		perf_cgroup_event_disable(event, ctx);
 		state =3D PERF_EVENT_STATE_OFF;
+	} else if (event->dup_active) {
+		WARN_ON_ONCE(event->dup_master !=3D event);
+		state =3D PERF_EVENT_STATE_ENABLED;
 	}
 	perf_event_set_state(event, state);
=20
@@ -2384,6 +2685,7 @@ static void __perf_event_disable(struct perf_event =
*event,
=20
 	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
 	perf_cgroup_event_disable(event, ctx);
+	perf_event_remove_dup(event, ctx);
 }
=20
 /*
@@ -2518,7 +2820,7 @@ event_sched_in(struct perf_event *event,
=20
 	perf_log_itrace_start(event);
=20
-	if (event->pmu->add(event, PERF_EF_START)) {
+	if (event_pmu_add(event, ctx)) {
 		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 		event->oncpu =3D -1;
 		ret =3D -EAGAIN;
@@ -2630,6 +2932,7 @@ static void add_event_to_ctx(struct perf_event *eve=
nt,
 {
 	list_add_event(event, ctx);
 	perf_group_attach(event);
+	perf_event_setup_dup(event, ctx);
 }
=20
 static void ctx_sched_out(struct perf_event_context *ctx,
@@ -2683,7 +2986,8 @@ static void perf_event_sched_in(struct perf_cpu_con=
text *cpuctx,
  */
 static void ctx_resched(struct perf_cpu_context *cpuctx,
 			struct perf_event_context *task_ctx,
-			enum event_type_t event_type)
+			enum event_type_t event_type,
+			struct perf_event *new_event)
 {
 	enum event_type_t ctx_event_type;
 	bool cpu_event =3D !!(event_type & EVENT_CPU);
@@ -2713,6 +3017,9 @@ static void ctx_resched(struct perf_cpu_context *cp=
uctx,
 	else if (ctx_event_type & EVENT_PINNED)
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
=20
+	if (new_event)
+		perf_event_setup_dup(new_event, new_event->ctx);
+
 	perf_event_sched_in(cpuctx, task_ctx, current);
 	perf_pmu_enable(cpuctx->ctx.pmu);
 }
@@ -2723,7 +3030,7 @@ void perf_pmu_resched(struct pmu *pmu)
 	struct perf_event_context *task_ctx =3D cpuctx->task_ctx;
=20
 	perf_ctx_lock(cpuctx, task_ctx);
-	ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
+	ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU, NULL);
 	perf_ctx_unlock(cpuctx, task_ctx);
 }
=20
@@ -2781,7 +3088,7 @@ static int  __perf_install_in_context(void *info)
 	if (reprogram) {
 		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
 		add_event_to_ctx(event, ctx);
-		ctx_resched(cpuctx, task_ctx, get_event_type(event));
+		ctx_resched(cpuctx, task_ctx, get_event_type(event), event);
 	} else {
 		add_event_to_ctx(event, ctx);
 	}
@@ -2929,8 +3236,10 @@ static void __perf_event_enable(struct perf_event =
*event,
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 	perf_cgroup_event_enable(event, ctx);
=20
-	if (!ctx->is_active)
+	if (!ctx->is_active) {
+		perf_event_setup_dup(event, ctx);
 		return;
+	}
=20
 	if (!event_filter_match(event)) {
 		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
@@ -2941,7 +3250,7 @@ static void __perf_event_enable(struct perf_event *=
event,
 	 * If the event is in a group and isn't the group leader,
 	 * then don't put it on unless the group is on.
 	 */
-	if (leader !=3D event && leader->state !=3D PERF_EVENT_STATE_ACTIVE) {
+	if (leader !=3D event && leader->state <=3D PERF_EVENT_STATE_INACTIVE) =
{
 		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
 		return;
 	}
@@ -2950,7 +3259,7 @@ static void __perf_event_enable(struct perf_event *=
event,
 	if (ctx->task)
 		WARN_ON_ONCE(task_ctx !=3D ctx);
=20
-	ctx_resched(cpuctx, task_ctx, get_event_type(event));
+	ctx_resched(cpuctx, task_ctx, get_event_type(event), event);
 }
=20
 /*
@@ -3289,8 +3598,8 @@ static void __perf_event_sync_stat(struct perf_even=
t *event,
 	 * we know the event must be on the current CPU, therefore we
 	 * don't need to use it.
 	 */
-	if (event->state =3D=3D PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+	if (event->state > PERF_EVENT_STATE_INACTIVE)
+		event_pmu_read(event);
=20
 	perf_event_update_time(event);
=20
@@ -4136,7 +4445,7 @@ static void perf_event_enable_on_exec(int ctxn)
 	 */
 	if (enabled) {
 		clone_ctx =3D unclone_ctx(ctx);
-		ctx_resched(cpuctx, ctx, event_type);
+		ctx_resched(cpuctx, ctx, event_type, NULL);
 	} else {
 		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
 	}
@@ -4207,22 +4516,22 @@ static void __perf_event_read(void *info)
 		goto unlock;
=20
 	if (!data->group) {
-		pmu->read(event);
+		event_pmu_read(event);
 		data->ret =3D 0;
 		goto unlock;
 	}
=20
 	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
=20
-	pmu->read(event);
+	event_pmu_read(event);
=20
 	for_each_sibling_event(sub, event) {
-		if (sub->state =3D=3D PERF_EVENT_STATE_ACTIVE) {
+		if (sub->state > PERF_EVENT_STATE_INACTIVE) {
 			/*
 			 * Use sibling's PMU rather than @event's since
 			 * sibling could be on different (eg: software) PMU.
 			 */
-			sub->pmu->read(sub);
+			event_pmu_read(sub);
 		}
 	}
=20
@@ -4234,7 +4543,20 @@ static void __perf_event_read(void *info)
=20
 static inline u64 perf_event_count(struct perf_event *event)
 {
-	return local64_read(&event->count) + atomic64_read(&event->child_count)=
;
+	struct perf_event *master;
+	u64 count;
+
+again:
+	master =3D READ_ONCE(event->dup_master);
+	if (master =3D=3D EVENT_TOMBSTONE)
+		goto again;
+
+	if (likely(master !=3D event))
+		count =3D local64_read(&event->count);
+	else
+		count =3D local64_read(&event->master_count);
+
+	return count + atomic64_read(&event->child_count);
 }
=20
 /*
@@ -4292,8 +4614,11 @@ int perf_event_read_local(struct perf_event *event=
, u64 *value,
 	 * oncpu =3D=3D -1).
 	 */
 	if (event->oncpu =3D=3D smp_processor_id())
-		event->pmu->read(event);
+		event_pmu_read(event);
=20
+	if (event->dup_master =3D=3D event)
+		*value =3D local64_read(&event->master_count);
+	else
 		*value =3D local64_read(&event->count);
 	if (enabled || running) {
 		u64 now =3D event->shadow_ctx_time + perf_clock();
@@ -4321,7 +4646,7 @@ static int perf_event_read(struct perf_event *event=
, bool group)
 	 * value in the event structure:
 	 */
 again:
-	if (state =3D=3D PERF_EVENT_STATE_ACTIVE) {
+	if (state > PERF_EVENT_STATE_INACTIVE) {
 		struct perf_read_data data;
=20
 		/*
@@ -5262,6 +5587,9 @@ static __poll_t perf_poll(struct file *file, poll_t=
able *wait)
 static void _perf_event_reset(struct perf_event *event)
 {
 	(void)perf_event_read(event, false);
+	if (event->dup_master =3D=3D event)
+		local64_set(&event->master_count, 0);
+	else
 		local64_set(&event->count, 0);
 	perf_event_update_userpage(event);
 }
@@ -5276,8 +5604,12 @@ u64 perf_event_pause(struct perf_event *event, boo=
l reset)
 	WARN_ON_ONCE(event->attr.inherit);
 	_perf_event_disable(event);
 	count =3D local64_read(&event->count);
-	if (reset)
+	if (reset) {
+		if (event->dup_master =3D=3D event)
+			local64_set(&event->master_count, 0);
+		else
 			local64_set(&event->count, 0);
+	}
 	perf_event_ctx_unlock(event, ctx);
=20
 	return count;
@@ -5593,13 +5925,15 @@ int perf_event_task_disable(void)
=20
 static int perf_event_index(struct perf_event *event)
 {
-	if (event->hw.state & PERF_HES_STOPPED)
+	struct perf_event *e =3D event->dup_master ? : event;
+
+	if (e->hw.state & PERF_HES_STOPPED)
 		return 0;
=20
-	if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
+	if (event->state < PERF_EVENT_STATE_ACTIVE)
 		return 0;
=20
-	return event->pmu->event_idx(event);
+	return e->pmu->event_idx(e);
 }
=20
 static void calc_timer_values(struct perf_event *event,
@@ -5678,8 +6012,11 @@ void perf_event_update_userpage(struct perf_event =
*event)
 	barrier();
 	userpg->index =3D perf_event_index(event);
 	userpg->offset =3D perf_event_count(event);
-	if (userpg->index)
-		userpg->offset -=3D local64_read(&event->hw.prev_count);
+	if (userpg->index) {
+		struct perf_event *e =3D event->dup_master ? : event;
+
+		userpg->offset -=3D local64_read(&e->hw.prev_count);
+	}
=20
 	userpg->time_enabled =3D enabled +
 			atomic64_read(&event->child_total_time_enabled);
@@ -5694,6 +6031,14 @@ void perf_event_update_userpage(struct perf_event =
*event)
 	preempt_enable();
 unlock:
 	rcu_read_unlock();
+
+	if (event->dup_master =3D=3D event) {
+		struct perf_event *tmp;
+
+		list_for_each_entry(tmp, &event->dup_active_list,
+				    dup_active_list)
+			perf_event_update_userpage(tmp);
+	}
 }
 EXPORT_SYMBOL_GPL(perf_event_update_userpage);
=20
@@ -6681,8 +7026,8 @@ static void perf_output_read_group(struct perf_outp=
ut_handle *handle,
 		values[n++] =3D running;
=20
 	if ((leader !=3D event) &&
-	    (leader->state =3D=3D PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+	    (leader->state > PERF_EVENT_STATE_INACTIVE))
+		event_pmu_read(leader);
=20
 	values[n++] =3D perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
@@ -6694,8 +7039,8 @@ static void perf_output_read_group(struct perf_outp=
ut_handle *handle,
 		n =3D 0;
=20
 		if ((sub !=3D event) &&
-		    (sub->state =3D=3D PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+		    (sub->state > PERF_EVENT_STATE_INACTIVE))
+			event_pmu_read(sub);
=20
 		values[n++] =3D perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
@@ -10115,10 +10460,10 @@ static enum hrtimer_restart perf_swevent_hrtime=
r(struct hrtimer *hrtimer)
=20
 	event =3D container_of(hrtimer, struct perf_event, hw.hrtimer);
=20
-	if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
+	if (event->state <=3D PERF_EVENT_STATE_INACTIVE)
 		return HRTIMER_NORESTART;
=20
-	event->pmu->read(event);
+	event_pmu_read(event);
=20
 	perf_sample_data_init(&data, 0, event->hw.last_period);
 	regs =3D get_irq_regs();
@@ -11015,6 +11360,7 @@ perf_event_alloc(struct perf_event_attr *attr, in=
t cpu,
 	INIT_LIST_HEAD(&event->event_entry);
 	INIT_LIST_HEAD(&event->sibling_list);
 	INIT_LIST_HEAD(&event->active_list);
+	INIT_LIST_HEAD(&event->dup_active_list);
 	init_event_group(event);
 	INIT_LIST_HEAD(&event->rb_entry);
 	INIT_LIST_HEAD(&event->active_entry);
@@ -11820,9 +12166,17 @@ SYSCALL_DEFINE5(perf_event_open,
 		perf_remove_from_context(group_leader, 0);
 		put_ctx(gctx);
=20
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
=20
 		/*
--=20
2.24.1

