Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A833BC10F26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC4F217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgCFOoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:44:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53729 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgCFOmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAt-0006Ga-5U; Fri, 06 Mar 2020 15:42:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CBE571C21D3;
        Fri,  6 Mar 2020 15:42:02 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:02 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Remove 'struct sched_in_data'
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158350572249.28353.5136899529392624818.tip-bot2@tip-bot2>
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

Commit-ID:     2c2366c7548ecee65adfd264517ddf50f9e2d029
Gitweb:        https://git.kernel.org/tip/2c2366c7548ecee65adfd264517ddf50f9e2d029
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 07 Aug 2019 11:45:01 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 11:56:58 +01:00

perf/core: Remove 'struct sched_in_data'

We can deduce the ctx and cpuctx from the event, no need to pass them
along. Remove the structure and pass in can_add_hw directly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b713080..b7eaaba 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3423,17 +3423,11 @@ static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
 	return 0;
 }
 
-struct sched_in_data {
-	struct perf_event_context *ctx;
-	struct perf_cpu_context *cpuctx;
-	int can_add_hw;
-};
-
 static int merge_sched_in(struct perf_event *event, void *data)
 {
-	struct sched_in_data *sid = data;
-
-	WARN_ON_ONCE(event->ctx != sid->ctx);
+	struct perf_event_context *ctx = event->ctx;
+	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	int *can_add_hw = data;
 
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
@@ -3441,8 +3435,8 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	if (!event_filter_match(event))
 		return 0;
 
-	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
-		if (!group_sched_in(event, sid->cpuctx, sid->ctx))
+	if (group_can_go_on(event, cpuctx, *can_add_hw)) {
+		if (!group_sched_in(event, cpuctx, ctx))
 			list_add_tail(&event->active_list, get_event_list(event));
 	}
 
@@ -3450,8 +3444,8 @@ static int merge_sched_in(struct perf_event *event, void *data)
 		if (event->attr.pinned)
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
 
-		sid->can_add_hw = 0;
-		sid->ctx->rotate_necessary = 1;
+		*can_add_hw = 0;
+		ctx->rotate_necessary = 1;
 	}
 
 	return 0;
@@ -3461,30 +3455,22 @@ static void
 ctx_pinned_sched_in(struct perf_event_context *ctx,
 		    struct perf_cpu_context *cpuctx)
 {
-	struct sched_in_data sid = {
-		.ctx = ctx,
-		.cpuctx = cpuctx,
-		.can_add_hw = 1,
-	};
+	int can_add_hw = 1;
 
 	visit_groups_merge(&ctx->pinned_groups,
 			   smp_processor_id(),
-			   merge_sched_in, &sid);
+			   merge_sched_in, &can_add_hw);
 }
 
 static void
 ctx_flexible_sched_in(struct perf_event_context *ctx,
 		      struct perf_cpu_context *cpuctx)
 {
-	struct sched_in_data sid = {
-		.ctx = ctx,
-		.cpuctx = cpuctx,
-		.can_add_hw = 1,
-	};
+	int can_add_hw = 1;
 
 	visit_groups_merge(&ctx->flexible_groups,
 			   smp_processor_id(),
-			   merge_sched_in, &sid);
+			   merge_sched_in, &can_add_hw);
 }
 
 static void
