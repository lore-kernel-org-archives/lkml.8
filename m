Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CC8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54AA420776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDnO/KJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbgFSOLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:11:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22902 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727003AbgFSOLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592575891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=XBjTjoHBK+LILFsrenecr/4P8LZAnHwHG171EcKYwwc=;
        b=bDnO/KJqsl3jlFD4GxjOIqZP8NH0JZqCXnnSfCUBMF+Psc3U9naXit+e0cVlPF/qjMTeSH
        SU42eWpJ/1eQAaIT8o/orIEICCWVjo4RztR4d3ZBw/mVUofypxpzORlgplNwnB14ni2NuX
        zHE/jP3u3FbcRbo5NM51IE/XooOiLJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-0hnv3kIMPxC-ZbROhFx4qg-1; Fri, 19 Jun 2020 10:11:28 -0400
X-MC-Unique: 0hnv3kIMPxC-ZbROhFx4qg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4014800053;
        Fri, 19 Jun 2020 14:11:26 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBC3019D7B;
        Fri, 19 Jun 2020 14:11:21 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH] Sched: Add a tracepoint to track rq->nr_running
Date:   Fri, 19 Jun 2020 10:11:20 -0400
Message-Id: <20200619141120.1476-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bare tracepoint trace_sched_update_nr_running_tp which tracks
->nr_running CPU's rq. This is used to accurately trace this data and
provide a visualization of scheduler imbalances in, for example, the
form of a heat map.  The tracepoint is accessed by loading an external
kernel module. An example module (forked from Qais' module and including
the pelt related tracepoints) can be found at:

  https://github.com/auldp/tracepoints-helpers.git

A script to turn the trace-cmd report output into a heatmap plot can be
found at:

  https://github.com/jirvoz/plot-nr-running

The tracepoints are added to add_nr_running() and sub_nr_running() which
are in kernel/sched/sched.h. Since sched.h includes trace/events/tlb.h
via mmu_context.h we had to limit when CREATE_TRACE_POINTS is defined.

Signed-off-by: Phil Auld <pauld@redhat.com>
CC: Qais Yousef <qais.yousef@arm.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: linux-kernel@vger.kernel.org
---
 include/trace/events/sched.h |  4 ++++
 kernel/sched/core.c          |  9 ++++-----
 kernel/sched/fair.c          |  2 --
 kernel/sched/pelt.c          |  2 --
 kernel/sched/sched.h         | 12 ++++++++++++
 5 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index ed168b0e2c53..a6d9fe5a68cf 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -634,6 +634,10 @@ DECLARE_TRACE(sched_overutilized_tp,
 	TP_PROTO(struct root_domain *rd, bool overutilized),
 	TP_ARGS(rd, overutilized));
 
+DECLARE_TRACE(sched_update_nr_running_tp,
+	TP_PROTO(int cpu, int change, unsigned int nr_running),
+	TP_ARGS(cpu, change, nr_running));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..6f28fdff1d48 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6,7 +6,10 @@
  *
  *  Copyright (C) 1991-2002  Linus Torvalds
  */
+
+#define SCHED_CREATE_TRACE_POINTS
 #include "sched.h"
+#undef SCHED_CREATE_TRACE_POINTS
 
 #include <linux/nospec.h>
 
@@ -21,9 +24,6 @@
 
 #include "pelt.h"
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/sched.h>
-
 /*
  * Export tracepoints that act as a bare tracehook (ie: have no trace event
  * associated with them) to allow external modules to probe them.
@@ -34,6 +34,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
@@ -7969,5 +7970,3 @@ const u32 sched_prio_to_wmult[40] = {
  /*  10 */  39045157,  49367440,  61356676,  76695844,  95443717,
  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
 };
-
-#undef CREATE_TRACE_POINTS
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da3e5b54715b..fe5d9b6db8f7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -22,8 +22,6 @@
  */
 #include "sched.h"
 
-#include <trace/events/sched.h>
-
 /*
  * Targeted preemption latency for CPU-bound tasks:
  *
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index b647d04d9c8b..bb69a0ae8d6c 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -28,8 +28,6 @@
 #include "sched.h"
 #include "pelt.h"
 
-#include <trace/events/sched.h>
-
 /*
  * Approximate:
  *   val * y^n,    where y^32 ~= 0.5 (~1 scheduling period)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..6ae96679c169 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -75,6 +75,15 @@
 #include "cpupri.h"
 #include "cpudeadline.h"
 
+#ifdef SCHED_CREATE_TRACE_POINTS
+#define CREATE_TRACE_POINTS
+#endif
+#include <trace/events/sched.h>
+
+#ifdef SCHED_CREATE_TRACE_POINTS
+#undef CREATE_TRACE_POINTS
+#endif
+
 #ifdef CONFIG_SCHED_DEBUG
 # define SCHED_WARN_ON(x)	WARN_ONCE(x, #x)
 #else
@@ -1959,6 +1968,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 	unsigned prev_nr = rq->nr_running;
 
 	rq->nr_running = prev_nr + count;
+	trace_sched_update_nr_running_tp(cpu_of(rq), count, rq->nr_running);
 
 #ifdef CONFIG_SMP
 	if (prev_nr < 2 && rq->nr_running >= 2) {
@@ -1973,6 +1983,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 static inline void sub_nr_running(struct rq *rq, unsigned count)
 {
 	rq->nr_running -= count;
+	trace_sched_update_nr_running_tp(cpu_of(rq), -count, rq->nr_running);
+
 	/* Check if we still need preemption */
 	sched_update_tick_dependency(rq);
 }
-- 
2.18.0

