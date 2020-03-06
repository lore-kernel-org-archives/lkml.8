Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B180C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5F620848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgCFOoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:44:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53731 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCFOmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAr-0006FA-EI; Fri, 06 Mar 2020 15:42:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0A88A1C21D4;
        Fri,  6 Mar 2020 15:42:01 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:00 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/cgroup: Grow per perf_cpu_context heap storage
Cc:     Ian Rogers <irogers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200214075133.181299-6-irogers@google.com>
References: <20200214075133.181299-6-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158350572076.28353.12179412076735895355.tip-bot2@tip-bot2>
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

Commit-ID:     c2283c9368d41063f2077cb58def02217360526d
Gitweb:        https://git.kernel.org/tip/c2283c9368d41063f2077cb58def02217360526d
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 13 Feb 2020 23:51:32 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 11:57:00 +01:00

perf/cgroup: Grow per perf_cpu_context heap storage

Allow the per-CPU min heap storage to have sufficient space for per-cgroup
iterators.

Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200214075133.181299-6-irogers@google.com
---
 kernel/events/core.c | 47 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7529e76..8065949 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -892,6 +892,47 @@ static inline void perf_cgroup_sched_in(struct task_struct *prev,
 	rcu_read_unlock();
 }
 
+static int perf_cgroup_ensure_storage(struct perf_event *event,
+				struct cgroup_subsys_state *css)
+{
+	struct perf_cpu_context *cpuctx;
+	struct perf_event **storage;
+	int cpu, heap_size, ret = 0;
+
+	/*
+	 * Allow storage to have sufficent space for an iterator for each
+	 * possibly nested cgroup plus an iterator for events with no cgroup.
+	 */
+	for (heap_size = 1; css; css = css->parent)
+		heap_size++;
+
+	for_each_possible_cpu(cpu) {
+		cpuctx = per_cpu_ptr(event->pmu->pmu_cpu_context, cpu);
+		if (heap_size <= cpuctx->heap_size)
+			continue;
+
+		storage = kmalloc_node(heap_size * sizeof(struct perf_event *),
+				       GFP_KERNEL, cpu_to_node(cpu));
+		if (!storage) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		raw_spin_lock_irq(&cpuctx->ctx.lock);
+		if (cpuctx->heap_size < heap_size) {
+			swap(cpuctx->heap, storage);
+			if (storage == cpuctx->heap_default)
+				storage = NULL;
+			cpuctx->heap_size = heap_size;
+		}
+		raw_spin_unlock_irq(&cpuctx->ctx.lock);
+
+		kfree(storage);
+	}
+
+	return ret;
+}
+
 static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 				      struct perf_event_attr *attr,
 				      struct perf_event *group_leader)
@@ -911,6 +952,10 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 		goto out;
 	}
 
+	ret = perf_cgroup_ensure_storage(event, css);
+	if (ret)
+		goto out;
+
 	cgrp = container_of(css, struct perf_cgroup, css);
 	event->cgrp = cgrp;
 
@@ -3440,6 +3485,8 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 			.nr = 0,
 			.size = cpuctx->heap_size,
 		};
+
+		lockdep_assert_held(&cpuctx->ctx.lock);
 	} else {
 		event_heap = (struct min_heap){
 			.data = itrs,
