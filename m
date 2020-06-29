Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDF4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4DC3206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXLdU11B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgF2TXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:23:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25655 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731944AbgF2TXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593458594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Skz3PY1AIipx/DpmG3bzvqjYvKfRIA4c8EWGn2foPXs=;
        b=MXLdU11BXbo42MPVhqi3DXiyHFUIOijY6EfL2h9/z6mPv6nxWOGF60zZqTYyHUugBJKM54
        43NSpBd4gu6o7ObaV1jnhLanmkwLMnGbTo2Tsqz7zLnPVvdYptFLFACDNSB7BpOO01jSB4
        THfwxlwqVwwouQ2ou9GEyEeHKvX8tR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-PVW77Cw-MxiR9V1Kc_nRUA-1; Mon, 29 Jun 2020 15:23:10 -0400
X-MC-Unique: PVW77Cw-MxiR9V1Kc_nRUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D83C804002;
        Mon, 29 Jun 2020 19:23:09 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-80.phx2.redhat.com [10.3.113.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D77B10016DA;
        Mon, 29 Jun 2020 19:23:05 +0000 (UTC)
Date:   Mon, 29 Jun 2020 15:23:03 -0400
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2] Sched: Add a tracepoint to track rq->nr_running
Message-ID: <20200629192303.GC120228@lorien.usersys.redhat.com>
References: <20200619141120.1476-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619141120.1476-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
are in kernel/sched/sched.h. In order to avoid CREATE_TRACE_POINTS in
the header a wrapper call is used and the trace/events/sched.h include
is moved before sched.h in kernel/sched/core.

Signed-off-by: Phil Auld <pauld@redhat.com>
CC: Qais Yousef <qais.yousef@arm.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: linux-kernel@vger.kernel.org
---

V2: Fix use of tracepoint in header from Steven. Pass rq* and use
helper to get nr_running field, from Qais. 


 include/linux/sched.h        |  1 +
 include/trace/events/sched.h |  4 ++++
 kernel/sched/core.c          | 13 +++++++++----
 kernel/sched/fair.c          |  8 ++++++--
 kernel/sched/pelt.c          |  2 --
 kernel/sched/sched.h         | 10 ++++++++++
 6 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5cb8324..5f114faf2247 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2015,6 +2015,7 @@ const struct sched_avg *sched_trace_rq_avg_dl(struct rq *rq);
 const struct sched_avg *sched_trace_rq_avg_irq(struct rq *rq);
 
 int sched_trace_rq_cpu(struct rq *rq);
+int sched_trace_rq_nr_running(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index ed168b0e2c53..8c72f9113694 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -634,6 +634,10 @@ DECLARE_TRACE(sched_overutilized_tp,
 	TP_PROTO(struct root_domain *rd, bool overutilized),
 	TP_ARGS(rd, overutilized));
 
+DECLARE_TRACE(sched_update_nr_running_tp,
+	TP_PROTO(struct rq *rq, int change),
+	TP_ARGS(rq, change));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..0d35d7c4c330 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6,6 +6,10 @@
  *
  *  Copyright (C) 1991-2002  Linus Torvalds
  */
+#define CREATE_TRACE_POINTS
+#include <trace/events/sched.h>
+#undef CREATE_TRACE_POINTS
+
 #include "sched.h"
 
 #include <linux/nospec.h>
@@ -21,9 +25,6 @@
 
 #include "pelt.h"
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/sched.h>
-
 /*
  * Export tracepoints that act as a bare tracehook (ie: have no trace event
  * associated with them) to allow external modules to probe them.
@@ -34,6 +35,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
@@ -7970,4 +7972,7 @@ const u32 sched_prio_to_wmult[40] = {
  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
 };
 
-#undef CREATE_TRACE_POINTS
+void call_trace_sched_update_nr_running(struct rq *rq, int count)
+{
+        trace_sched_update_nr_running_tp(rq, count);
+}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da3e5b54715b..2e2f3f68e318 100644
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
@@ -11293,3 +11291,9 @@ const struct cpumask *sched_trace_rd_span(struct root_domain *rd)
 #endif
 }
 EXPORT_SYMBOL_GPL(sched_trace_rd_span);
+
+int sched_trace_rq_nr_running(struct rq *rq)
+{
+        return rq ? rq->nr_running : -1;
+}
+EXPORT_SYMBOL_GPL(sched_trace_rq_nr_running);
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
index db3a57675ccf..e621eaa44474 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -75,6 +75,8 @@
 #include "cpupri.h"
 #include "cpudeadline.h"
 
+#include <trace/events/sched.h>
+
 #ifdef CONFIG_SCHED_DEBUG
 # define SCHED_WARN_ON(x)	WARN_ONCE(x, #x)
 #else
@@ -96,6 +98,7 @@ extern atomic_long_t calc_load_tasks;
 extern void calc_global_load_tick(struct rq *this_rq);
 extern long calc_load_fold_active(struct rq *this_rq, long adjust);
 
+extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
 /*
  * Helpers for converting nanosecond timing to jiffy resolution
  */
@@ -1959,6 +1962,9 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 	unsigned prev_nr = rq->nr_running;
 
 	rq->nr_running = prev_nr + count;
+	if (trace_sched_update_nr_running_tp_enabled()) {
+		call_trace_sched_update_nr_running(rq, count);
+	}
 
 #ifdef CONFIG_SMP
 	if (prev_nr < 2 && rq->nr_running >= 2) {
@@ -1973,6 +1979,10 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 static inline void sub_nr_running(struct rq *rq, unsigned count)
 {
 	rq->nr_running -= count;
+	if (trace_sched_update_nr_running_tp_enabled()) {
+		call_trace_sched_update_nr_running(rq, count);
+	}
+
 	/* Check if we still need preemption */
 	sched_update_tick_dependency(rq);
 }
-- 
2.18.0


-- 

