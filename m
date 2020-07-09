Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F1CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA2720708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tETY/41W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1uc8lLRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgGIIp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgGIIp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:45:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07430C061A0B;
        Thu,  9 Jul 2020 01:45:56 -0700 (PDT)
Date:   Thu, 09 Jul 2020 08:45:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594284355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+4xw1FSYGQyoZLx5QjbtHpvgVDoCI4Cv4NTYFd7k8g=;
        b=tETY/41W2ET4kly+IcMGpZJasqrMcSpb81BFcLB4+nMFwA9orjRfd5uzFwQ/9dtbfuTx0D
        BbiSwiu8VlILvqYkhRL1ebHS4NkDPkKhD4VZBys0+s/SD4M5dAbMJTW2Z2Sw2vzI2dzz1u
        6WSY6DxbkAWU425z1rITE1ZBLo7udpeke/y705/FE5LDAKFLor3E7RYbuSUKkP/til6AEe
        BMazKUulkdNYa8aMW1mMhJXy8W0o5GNEMZWcVQqkaNIM9gpH+3jwg+kPcUHPDVrjWTYS9r
        ycWVNvKUMPAfhMrk7gKb4X+WDdCArKtEErgnwtaEWA3GUXaB+gbD+6qhlXGbjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594284355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+4xw1FSYGQyoZLx5QjbtHpvgVDoCI4Cv4NTYFd7k8g=;
        b=1uc8lLRsIcUoGYraaIwoyuUk19dsM/NBHkabzvzN5Ekd75ZnagWVQZ2fLObD0roVmHcdn6
        Gf9Tv4gXxNSoY9Bg==
From:   "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add a tracepoint to track rq->nr_running
Cc:     Phil Auld <pauld@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200629192303.GC120228@lorien.usersys.redhat.com>
References: <20200629192303.GC120228@lorien.usersys.redhat.com>
MIME-Version: 1.0
Message-ID: <159428435423.4006.2008200578767650522.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9d246053a69196c7c27068870e9b4b66ac536f68
Gitweb:        https://git.kernel.org/tip/9d246053a69196c7c27068870e9b4b66ac536f68
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Mon, 29 Jun 2020 15:23:03 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:39:02 +02:00

sched: Add a tracepoint to track rq->nr_running

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200629192303.GC120228@lorien.usersys.redhat.com
---
 include/linux/sched.h        |  1 +
 include/trace/events/sched.h |  4 ++++
 kernel/sched/core.c          | 13 +++++++++----
 kernel/sched/fair.c          |  8 ++++++--
 kernel/sched/pelt.c          |  2 --
 kernel/sched/sched.h         | 10 ++++++++++
 6 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6833729..12b10ce 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2044,6 +2044,7 @@ const struct sched_avg *sched_trace_rq_avg_dl(struct rq *rq);
 const struct sched_avg *sched_trace_rq_avg_irq(struct rq *rq);
 
 int sched_trace_rq_cpu(struct rq *rq);
+int sched_trace_rq_nr_running(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 04f9a4c..0d5ff09 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -642,6 +642,10 @@ DECLARE_TRACE(sched_util_est_se_tp,
 	TP_PROTO(struct sched_entity *se),
 	TP_ARGS(se));
 
+DECLARE_TRACE(sched_update_nr_running_tp,
+	TP_PROTO(struct rq *rq, int change),
+	TP_ARGS(rq, change));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4cf30e4..ff05195 100644
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
@@ -23,9 +27,6 @@
 #include "pelt.h"
 #include "smp.h"
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/sched.h>
-
 /*
  * Export tracepoints that act as a bare tracehook (ie: have no trace event
  * associated with them) to allow external modules to probe them.
@@ -38,6 +39,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
@@ -8195,4 +8197,7 @@ const u32 sched_prio_to_wmult[40] = {
  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
 };
 
-#undef CREATE_TRACE_POINTS
+void call_trace_sched_update_nr_running(struct rq *rq, int count)
+{
+        trace_sched_update_nr_running_tp(rq, count);
+}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6fab1d1..3213cb2 100644
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
@@ -11296,3 +11294,9 @@ const struct cpumask *sched_trace_rd_span(struct root_domain *rd)
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
index 11bea3b..2c613e1 100644
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
index b1432f6..65b72e0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -76,6 +76,8 @@
 #include "cpupri.h"
 #include "cpudeadline.h"
 
+#include <trace/events/sched.h>
+
 #ifdef CONFIG_SCHED_DEBUG
 # define SCHED_WARN_ON(x)	WARN_ONCE(x, #x)
 #else
@@ -97,6 +99,7 @@ extern atomic_long_t calc_load_tasks;
 extern void calc_global_load_tick(struct rq *this_rq);
 extern long calc_load_fold_active(struct rq *this_rq, long adjust);
 
+extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
 /*
  * Helpers for converting nanosecond timing to jiffy resolution
  */
@@ -1973,6 +1976,9 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 	unsigned prev_nr = rq->nr_running;
 
 	rq->nr_running = prev_nr + count;
+	if (trace_sched_update_nr_running_tp_enabled()) {
+		call_trace_sched_update_nr_running(rq, count);
+	}
 
 #ifdef CONFIG_SMP
 	if (prev_nr < 2 && rq->nr_running >= 2) {
@@ -1987,6 +1993,10 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
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
