Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED56C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADAF2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCFOmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53744 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgCFOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAr-0006F8-2q; Fri, 06 Mar 2020 15:42:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A14DE1C21D3;
        Fri,  6 Mar 2020 15:42:00 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:00 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/cgroup: Order events in RB tree by cgroup id
Cc:     Ian Rogers <irogers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20190724223746.153620-3-irogers@google.com>
References: <20190724223746.153620-3-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158350572034.28353.9707652627280717916.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     95ed6c707f26a727a29972b60469630ae10d579c
Gitweb:        https://git.kernel.org/tip/95ed6c707f26a727a29972b60469630ae10d579c
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 13 Feb 2020 23:51:33 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 11:57:01 +01:00

perf/cgroup: Order events in RB tree by cgroup id

If one is monitoring 6 events on 20 cgroups the per-CPU RB tree will
hold 120 events. The scheduling in of the events currently iterates
over all events looking to see which events match the task's cgroup or
its cgroup hierarchy. If a task is in 1 cgroup with 6 events, then 114
events are considered unnecessarily.

This change orders events in the RB tree by cgroup id if it is present.
This means scheduling in may go directly to events associated with the
task's cgroup if one is present. The per-CPU iterator storage in
visit_groups_merge is sized sufficent for an iterator per cgroup depth,
where different iterators are needed for the task's cgroup and parent
cgroups. By considering the set of iterators when visiting, the lowest
group_index event may be selected and the insertion order group_index
property is maintained. This also allows event rotation to function
correctly, as although events are grouped into a cgroup, rotation always
selects the lowest group_index event to rotate (delete/insert into the
tree) and the min heap of iterators make it so that the group_index order
is maintained.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20190724223746.153620-3-irogers@google.com
---
 kernel/events/core.c | 94 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8065949..ccf8d4f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1577,6 +1577,30 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
 	if (left->cpu > right->cpu)
 		return false;
 
+#ifdef CONFIG_CGROUP_PERF
+	if (left->cgrp != right->cgrp) {
+		if (!left->cgrp || !left->cgrp->css.cgroup) {
+			/*
+			 * Left has no cgroup but right does, no cgroups come
+			 * first.
+			 */
+			return true;
+		}
+		if (!right->cgrp || right->cgrp->css.cgroup) {
+			/*
+			 * Right has no cgroup but left does, no cgroups come
+			 * first.
+			 */
+			return false;
+		}
+		/* Two dissimilar cgroups, order by id. */
+		if (left->cgrp->css.cgroup->kn->id < right->cgrp->css.cgroup->kn->id)
+			return true;
+
+		return false;
+	}
+#endif
+
 	if (left->group_index < right->group_index)
 		return true;
 	if (left->group_index > right->group_index)
@@ -1656,25 +1680,48 @@ del_event_from_groups(struct perf_event *event, struct perf_event_context *ctx)
 }
 
 /*
- * Get the leftmost event in the @cpu subtree.
+ * Get the leftmost event in the cpu/cgroup subtree.
  */
 static struct perf_event *
-perf_event_groups_first(struct perf_event_groups *groups, int cpu)
+perf_event_groups_first(struct perf_event_groups *groups, int cpu,
+			struct cgroup *cgrp)
 {
 	struct perf_event *node_event = NULL, *match = NULL;
 	struct rb_node *node = groups->tree.rb_node;
+#ifdef CONFIG_CGROUP_PERF
+	u64 node_cgrp_id, cgrp_id = 0;
+
+	if (cgrp)
+		cgrp_id = cgrp->kn->id;
+#endif
 
 	while (node) {
 		node_event = container_of(node, struct perf_event, group_node);
 
 		if (cpu < node_event->cpu) {
 			node = node->rb_left;
-		} else if (cpu > node_event->cpu) {
+			continue;
+		}
+		if (cpu > node_event->cpu) {
 			node = node->rb_right;
-		} else {
-			match = node_event;
+			continue;
+		}
+#ifdef CONFIG_CGROUP_PERF
+		node_cgrp_id = 0;
+		if (node_event->cgrp && node_event->cgrp->css.cgroup)
+			node_cgrp_id = node_event->cgrp->css.cgroup->kn->id;
+
+		if (cgrp_id < node_cgrp_id) {
 			node = node->rb_left;
+			continue;
+		}
+		if (cgrp_id > node_cgrp_id) {
+			node = node->rb_right;
+			continue;
 		}
+#endif
+		match = node_event;
+		node = node->rb_left;
 	}
 
 	return match;
@@ -1687,12 +1734,26 @@ static struct perf_event *
 perf_event_groups_next(struct perf_event *event)
 {
 	struct perf_event *next;
+#ifdef CONFIG_CGROUP_PERF
+	u64 curr_cgrp_id = 0;
+	u64 next_cgrp_id = 0;
+#endif
 
 	next = rb_entry_safe(rb_next(&event->group_node), typeof(*event), group_node);
-	if (next && next->cpu == event->cpu)
-		return next;
+	if (next == NULL || next->cpu != event->cpu)
+		return NULL;
 
-	return NULL;
+#ifdef CONFIG_CGROUP_PERF
+	if (event->cgrp && event->cgrp->css.cgroup)
+		curr_cgrp_id = event->cgrp->css.cgroup->kn->id;
+
+	if (next->cgrp && next->cgrp->css.cgroup)
+		next_cgrp_id = next->cgrp->css.cgroup->kn->id;
+
+	if (curr_cgrp_id != next_cgrp_id)
+		return NULL;
+#endif
+	return next;
 }
 
 /*
@@ -3473,6 +3534,9 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 				int (*func)(struct perf_event *, void *),
 				void *data)
 {
+#ifdef CONFIG_CGROUP_PERF
+	struct cgroup_subsys_state *css = NULL;
+#endif
 	/* Space for per CPU and/or any CPU event iterators. */
 	struct perf_event *itrs[2];
 	struct min_heap event_heap;
@@ -3487,6 +3551,11 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 		};
 
 		lockdep_assert_held(&cpuctx->ctx.lock);
+
+#ifdef CONFIG_CGROUP_PERF
+		if (cpuctx->cgrp)
+			css = &cpuctx->cgrp->css;
+#endif
 	} else {
 		event_heap = (struct min_heap){
 			.data = itrs,
@@ -3494,11 +3563,16 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 			.size = ARRAY_SIZE(itrs),
 		};
 		/* Events not within a CPU context may be on any CPU. */
-		__heap_add(&event_heap, perf_event_groups_first(groups, -1));
+		__heap_add(&event_heap, perf_event_groups_first(groups, -1, NULL));
 	}
 	evt = event_heap.data;
 
-	__heap_add(&event_heap, perf_event_groups_first(groups, cpu));
+	__heap_add(&event_heap, perf_event_groups_first(groups, cpu, NULL));
+
+#ifdef CONFIG_CGROUP_PERF
+	for (; css; css = css->parent)
+		__heap_add(&event_heap, perf_event_groups_first(groups, cpu, css->cgroup));
+#endif
 
 	min_heapify_all(&event_heap, &perf_min_heap);
 
