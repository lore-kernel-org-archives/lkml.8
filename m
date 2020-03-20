Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE4BC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B65120776
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCTM6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35617 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgCTM6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHDu-0003hh-E6; Fri, 20 Mar 2020 13:58:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0A0A71C22BE;
        Fri, 20 Mar 2020 13:58:02 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:01 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix endless multiplex timer
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200305123851.GX2596@hirez.programming.kicks-ass.net>
References: <20200305123851.GX2596@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <158470908175.28353.4859180707604949658.tip-bot2@tip-bot2>
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

Commit-ID:     90c91dfb86d0ff545bd329d3ddd72c147e2ae198
Gitweb:        https://git.kernel.org/tip/90c91dfb86d0ff545bd329d3ddd72c147e2ae198
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 05 Mar 2020 13:38:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:22 +01:00

perf/core: Fix endless multiplex timer

Kan and Andi reported that we fail to kill rotation when the flexible
events go empty, but the context does not. XXX moar

Fixes: fd7d55172d1e ("perf/cgroups: Don't rotate events for cgroups unnecessarily")
Reported-by: Andi Kleen <ak@linux.intel.com>
Reported-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200305123851.GX2596@hirez.programming.kicks-ass.net
---
 kernel/events/core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ccf8d4f..b5a68d2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2291,6 +2291,7 @@ __perf_remove_from_context(struct perf_event *event,
 
 	if (!ctx->nr_events && ctx->is_active) {
 		ctx->is_active = 0;
+		ctx->rotate_necessary = 0;
 		if (ctx->task) {
 			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
 			cpuctx->task_ctx = NULL;
@@ -3188,12 +3189,6 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 	if (!ctx->nr_active || !(is_active & EVENT_ALL))
 		return;
 
-	/*
-	 * If we had been multiplexing, no rotations are necessary, now no events
-	 * are active.
-	 */
-	ctx->rotate_necessary = 0;
-
 	perf_pmu_disable(ctx->pmu);
 	if (is_active & EVENT_PINNED) {
 		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
@@ -3203,6 +3198,13 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 	if (is_active & EVENT_FLEXIBLE) {
 		list_for_each_entry_safe(event, tmp, &ctx->flexible_active, active_list)
 			group_sched_out(event, cpuctx, ctx);
+
+		/*
+		 * Since we cleared EVENT_FLEXIBLE, also clear
+		 * rotate_necessary, is will be reset by
+		 * ctx_flexible_sched_in() when needed.
+		 */
+		ctx->rotate_necessary = 0;
 	}
 	perf_pmu_enable(ctx->pmu);
 }
@@ -3985,6 +3987,12 @@ ctx_event_to_rotate(struct perf_event_context *ctx)
 				      typeof(*event), group_node);
 	}
 
+	/*
+	 * Unconditionally clear rotate_necessary; if ctx_flexible_sched_in()
+	 * finds there are unschedulable events, it will set it again.
+	 */
+	ctx->rotate_necessary = 0;
+
 	return event;
 }
 
