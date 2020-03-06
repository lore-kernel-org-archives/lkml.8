Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE37C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3770A2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCFOmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53727 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgCFOmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAt-0006Gs-IV; Fri, 06 Mar 2020 15:42:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 397C61C21D4;
        Fri,  6 Mar 2020 15:42:03 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:02 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Unify {pinned,flexible}_sched_in()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158350572291.28353.3266380896499443707.tip-bot2@tip-bot2>
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

Commit-ID:     ab6f824cfdf7363b5e529621cbc72ae6519c78d1
Gitweb:        https://git.kernel.org/tip/ab6f824cfdf7363b5e529621cbc72ae6519c78d1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 07 Aug 2019 11:17:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 11:56:55 +01:00

perf/core: Unify {pinned,flexible}_sched_in()

Less is more; unify the two very nearly identical function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 58 +++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 37 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3f1f77d..b713080 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1986,6 +1986,12 @@ static int perf_get_aux_event(struct perf_event *event,
 	return 1;
 }
 
+static inline struct list_head *get_event_list(struct perf_event *event)
+{
+	struct perf_event_context *ctx = event->ctx;
+	return event->attr.pinned ? &ctx->pinned_active : &ctx->flexible_active;
+}
+
 static void perf_group_detach(struct perf_event *event)
 {
 	struct perf_event *sibling, *tmp;
@@ -2028,12 +2034,8 @@ static void perf_group_detach(struct perf_event *event)
 		if (!RB_EMPTY_NODE(&event->group_node)) {
 			add_event_to_groups(sibling, event->ctx);
 
-			if (sibling->state == PERF_EVENT_STATE_ACTIVE) {
-				struct list_head *list = sibling->attr.pinned ?
-					&ctx->pinned_active : &ctx->flexible_active;
-
-				list_add_tail(&sibling->active_list, list);
-			}
+			if (sibling->state == PERF_EVENT_STATE_ACTIVE)
+				list_add_tail(&sibling->active_list, get_event_list(sibling));
 		}
 
 		WARN_ON_ONCE(sibling->ctx != event->ctx);
@@ -2350,6 +2352,8 @@ event_sched_in(struct perf_event *event,
 {
 	int ret = 0;
 
+	WARN_ON_ONCE(event->ctx != ctx);
+
 	lockdep_assert_held(&ctx->lock);
 
 	if (event->state <= PERF_EVENT_STATE_OFF)
@@ -3425,10 +3429,12 @@ struct sched_in_data {
 	int can_add_hw;
 };
 
-static int pinned_sched_in(struct perf_event *event, void *data)
+static int merge_sched_in(struct perf_event *event, void *data)
 {
 	struct sched_in_data *sid = data;
 
+	WARN_ON_ONCE(event->ctx != sid->ctx);
+
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
@@ -3437,37 +3443,15 @@ static int pinned_sched_in(struct perf_event *event, void *data)
 
 	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
 		if (!group_sched_in(event, sid->cpuctx, sid->ctx))
-			list_add_tail(&event->active_list, &sid->ctx->pinned_active);
+			list_add_tail(&event->active_list, get_event_list(event));
 	}
 
-	/*
-	 * If this pinned group hasn't been scheduled,
-	 * put it in error state.
-	 */
-	if (event->state == PERF_EVENT_STATE_INACTIVE)
-		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
-
-	return 0;
-}
-
-static int flexible_sched_in(struct perf_event *event, void *data)
-{
-	struct sched_in_data *sid = data;
-
-	if (event->state <= PERF_EVENT_STATE_OFF)
-		return 0;
-
-	if (!event_filter_match(event))
-		return 0;
+	if (event->state == PERF_EVENT_STATE_INACTIVE) {
+		if (event->attr.pinned)
+			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
 
-	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
-		int ret = group_sched_in(event, sid->cpuctx, sid->ctx);
-		if (ret) {
-			sid->can_add_hw = 0;
-			sid->ctx->rotate_necessary = 1;
-			return 0;
-		}
-		list_add_tail(&event->active_list, &sid->ctx->flexible_active);
+		sid->can_add_hw = 0;
+		sid->ctx->rotate_necessary = 1;
 	}
 
 	return 0;
@@ -3485,7 +3469,7 @@ ctx_pinned_sched_in(struct perf_event_context *ctx,
 
 	visit_groups_merge(&ctx->pinned_groups,
 			   smp_processor_id(),
-			   pinned_sched_in, &sid);
+			   merge_sched_in, &sid);
 }
 
 static void
@@ -3500,7 +3484,7 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
 
 	visit_groups_merge(&ctx->flexible_groups,
 			   smp_processor_id(),
-			   flexible_sched_in, &sid);
+			   merge_sched_in, &sid);
 }
 
 static void
