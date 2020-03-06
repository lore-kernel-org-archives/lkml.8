Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E002C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7262F20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgCFOoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:44:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53728 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgCFOmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAs-0006Fg-4b; Fri, 06 Mar 2020 15:42:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B28CF1C21D3;
        Fri,  6 Mar 2020 15:42:01 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:01 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Use min_heap in visit_groups_merge()
Cc:     Ian Rogers <irogers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200214075133.181299-4-irogers@google.com>
References: <20200214075133.181299-4-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158350572146.28353.4698357304879018456.tip-bot2@tip-bot2>
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

Commit-ID:     6eef8a7116deae0706ba6d897c0d7dd887cd2be2
Gitweb:        https://git.kernel.org/tip/6eef8a7116deae0706ba6d897c0d7dd887cd2be2
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 13 Feb 2020 23:51:30 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 11:56:59 +01:00

perf/core: Use min_heap in visit_groups_merge()

visit_groups_merge will pick the next event based on when it was
inserted in to the context (perf_event group_index). Events may be per CPU
or for any CPU, but in the future we'd also like to have per cgroup events
to avoid searching all events for the events to schedule for a cgroup.
Introduce a min heap for the events that maintains a property that the
earliest inserted event is always at the 0th element. Initialize the heap
with per-CPU and any-CPU events for the context.

Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200214075133.181299-4-irogers@google.com
---
 kernel/events/core.c | 67 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dceeeb1..ddfb06c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -49,6 +49,7 @@
 #include <linux/sched/mm.h>
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
+#include <linux/min_heap.h>
 
 #include "internal.h"
 
@@ -3392,32 +3393,66 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 	ctx_sched_out(&cpuctx->ctx, cpuctx, event_type);
 }
 
-static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
-			      int (*func)(struct perf_event *, void *), void *data)
+static bool perf_less_group_idx(const void *l, const void *r)
 {
-	struct perf_event **evt, *evt1, *evt2;
+	const struct perf_event *le = l, *re = r;
+
+	return le->group_index < re->group_index;
+}
+
+static void swap_ptr(void *l, void *r)
+{
+	void **lp = l, **rp = r;
+
+	swap(*lp, *rp);
+}
+
+static const struct min_heap_callbacks perf_min_heap = {
+	.elem_size = sizeof(struct perf_event *),
+	.less = perf_less_group_idx,
+	.swp = swap_ptr,
+};
+
+static void __heap_add(struct min_heap *heap, struct perf_event *event)
+{
+	struct perf_event **itrs = heap->data;
+
+	if (event) {
+		itrs[heap->nr] = event;
+		heap->nr++;
+	}
+}
+
+static noinline int visit_groups_merge(struct perf_event_groups *groups,
+				int cpu,
+				int (*func)(struct perf_event *, void *),
+				void *data)
+{
+	/* Space for per CPU and/or any CPU event iterators. */
+	struct perf_event *itrs[2];
+	struct min_heap event_heap = {
+		.data = itrs,
+		.nr = 0,
+		.size = ARRAY_SIZE(itrs),
+	};
+	struct perf_event **evt = event_heap.data;
 	int ret;
 
-	evt1 = perf_event_groups_first(groups, -1);
-	evt2 = perf_event_groups_first(groups, cpu);
+	__heap_add(&event_heap, perf_event_groups_first(groups, -1));
+	__heap_add(&event_heap, perf_event_groups_first(groups, cpu));
 
-	while (evt1 || evt2) {
-		if (evt1 && evt2) {
-			if (evt1->group_index < evt2->group_index)
-				evt = &evt1;
-			else
-				evt = &evt2;
-		} else if (evt1) {
-			evt = &evt1;
-		} else {
-			evt = &evt2;
-		}
+	min_heapify_all(&event_heap, &perf_min_heap);
 
+	while (event_heap.nr) {
 		ret = func(*evt, data);
 		if (ret)
 			return ret;
 
 		*evt = perf_event_groups_next(*evt);
+		if (*evt)
+			min_heapify(&event_heap, 0, &perf_min_heap);
+		else
+			min_heap_pop(&event_heap, &perf_min_heap);
 	}
 
 	return 0;
