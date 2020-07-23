Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76A4C433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28BE22CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgGWRLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:11:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:6607 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbgGWRLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:11:47 -0400
IronPort-SDR: 4HqL7sWNOC5Ym8GIJM536w+HvStCdA2Gd67E6Og0l9FSdWOkeocXYr4cgX5wX6Wv+9M6VYcL+t
 MRgj4UBU9sEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="235456771"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="235456771"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 10:11:47 -0700
IronPort-SDR: /lbRTIihCVwvwTzQqLpTbQ770aFpGVCl2/2oEa/M9UW1EWvE7PlRg8Ytg3fOZ68rSGcdCg69PV
 xT7eGucqYKUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="488904283"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2020 10:11:46 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 07/14] perf/core: Add a new PERF_EV_CAP_COEXIST event capability
Date:   Thu, 23 Jul 2020 10:11:10 -0700
Message-Id: <20200723171117.9918-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723171117.9918-1-kan.liang@linux.intel.com>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Current perf assumes that events in a group are independent. Close an
event doesn't impact the value of the other events in the same group.
If the closed event is a member, after the event closure, other events
are still running like a group. If the closed event is a leader, other
events are running as singleton events.

However, the assumption is not correct anymore, e.g., the TopDown slots
and metrics events. The slots and metrics events must coexist in the
same group. If the slots event is closed, the value for the metrics
events is invalid.

Add a new PERF_EV_CAP_COEXIST event capability to indicate the
relationship among group events.

If any event with the flag is detached from the group, split the group
into singleton events, and move all events, which have the flag, to the
unrecoverable ERROR state.

The leader of a PERF_EV_CAP_COEXIST group has to be updated at last.
Move perf_event__header_size(leader); to the end of perf_group_detach().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h |  5 ++++
 kernel/events/core.c       | 52 +++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3b22db08b6fb..93631e5389bf 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -576,9 +576,14 @@ typedef void (*perf_overflow_handler_t)(struct perf_event *,
  * PERF_EV_CAP_SOFTWARE: Is a software event.
  * PERF_EV_CAP_READ_ACTIVE_PKG: A CPU event (or cgroup event) that can be read
  * from any CPU in the package where it is active.
+ * PERF_EV_CAP_COEXIST: An event with this flag must coexist with other sibling
+ * events, which have the same flag. If any event with the flag is detached
+ * from the group, split the group into singleton events, and move the events
+ * with the flag to the unrecoverable ERROR state.
  */
 #define PERF_EV_CAP_SOFTWARE		BIT(0)
 #define PERF_EV_CAP_READ_ACTIVE_PKG	BIT(1)
+#define PERF_EV_CAP_COEXIST		BIT(2)
 
 #define SWEVENT_HLIST_BITS		8
 #define SWEVENT_HLIST_SIZE		(1 << SWEVENT_HLIST_BITS)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7c436d705fbd..e35d549a356d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2133,10 +2133,28 @@ static inline struct list_head *get_event_list(struct perf_event *event)
 	return event->attr.pinned ? &ctx->pinned_active : &ctx->flexible_active;
 }
 
+/*
+ * If the event has PERF_EV_CAP_COEXIST capability,
+ * schedule it out and move it into the ERROR state.
+ */
+static inline void perf_remove_coexist_events(struct perf_event *event)
+{
+	struct perf_event_context *ctx = event->ctx;
+	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+
+	if (!(event->event_caps & PERF_EV_CAP_COEXIST))
+		return;
+
+	event_sched_out(event, cpuctx, ctx);
+	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+}
+
 static void perf_group_detach(struct perf_event *event)
 {
+	struct perf_event *leader = event->group_leader;
 	struct perf_event *sibling, *tmp;
 	struct perf_event_context *ctx = event->ctx;
+	bool cap_coexist = !!(event->event_caps & PERF_EV_CAP_COEXIST);
 
 	lockdep_assert_held(&ctx->lock);
 
@@ -2150,15 +2168,25 @@ static void perf_group_detach(struct perf_event *event)
 
 	perf_put_aux_event(event);
 
+	/*
+	 * If a PERF_EV_CAP_COEXIST event is detached,
+	 * split the group into singleton events.
+	 */
+	if (cap_coexist) {
+		event = leader;
+		goto split_group;
+	}
+
 	/*
 	 * If this is a sibling, remove it from its group.
 	 */
-	if (event->group_leader != event) {
+	if (leader != event) {
 		list_del_init(&event->sibling_list);
 		event->group_leader->nr_siblings--;
 		goto out;
 	}
 
+split_group:
 	/*
 	 * If this was a group event with sibling events then
 	 * upgrade the siblings to singleton events by adding them
@@ -2172,6 +2200,10 @@ static void perf_group_detach(struct perf_event *event)
 		/* Inherit group flags from the previous leader */
 		sibling->group_caps = event->group_caps;
 
+		/* Remove sibling PERF_EV_CAP_COEXIST event */
+		if (cap_coexist)
+			perf_remove_coexist_events(sibling);
+
 		if (!RB_EMPTY_NODE(&event->group_node)) {
 			add_event_to_groups(sibling, event->ctx);
 
@@ -2181,12 +2213,24 @@ static void perf_group_detach(struct perf_event *event)
 
 		WARN_ON_ONCE(sibling->ctx != event->ctx);
 	}
-
 out:
-	perf_event__header_size(event->group_leader);
 
-	for_each_sibling_event(tmp, event->group_leader)
+	for_each_sibling_event(tmp, leader)
 		perf_event__header_size(tmp);
+
+	/*
+	 * Change the leader of a PERF_EV_CAP_COEXIST group into
+	 * a singleton event. If the leader is a PERF_EV_CAP_COEXIST
+	 * event as well, remove it.
+	 */
+
+	if (cap_coexist) {
+		list_del_init(&leader->sibling_list);
+		leader->group_leader->nr_siblings = 0;
+		perf_remove_coexist_events(leader);
+	}
+
+	perf_event__header_size(leader);
 }
 
 static bool is_orphaned_event(struct perf_event *event)
-- 
2.17.1

