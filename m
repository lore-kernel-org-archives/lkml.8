Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63863C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6C52072D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wz6rFRXo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QzUYsdUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgHSIzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:55:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37136 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgHSIwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:52:10 -0400
Date:   Wed, 19 Aug 2020 08:52:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597827128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSB0N+9be3Ueq42H1CGqA3pI7bdNN9hhiVSr6xoOjiI=;
        b=Wz6rFRXoLc3SwnuLqS1fByUGIy+EoPw2lHJPYlGNudUgf2n54RpHvxlQPyqUZoV99+qnQ9
        FMBOtkKedfSqv1oDZ9Ov6hSLK9mNWyrC1xIuF9Snal48cHfxo9iTuO8u4R+ZodySO9LVSx
        3x1pFaYTp9oDNvrsF8Eg6efXqsDZkMyNPrSvmlkYPDXABRUNoCa81hepl4DHRAkto2Ub1T
        RJUSkKXDxFh3BGLXQYM2oeBz/JZBEq/acG10/D8Hc0PrGZw7JYJJHhmE2W0zrMfdkcCOvZ
        ic4R4vMb/wFA8MEW6pfGqDLYnqXZUNOw2fW0Js8R88tmL3cN5STmZnNkjki5xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597827128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSB0N+9be3Ueq42H1CGqA3pI7bdNN9hhiVSr6xoOjiI=;
        b=QzUYsdUHDO9ArO6OFldMA+iafllNBo1UlevEnhnoknv5zmwjtbEK98GSEIZ3sU7D2HZxto
        /uL+++Hp91shJGBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Add a new PERF_EV_CAP_SIBLING event capability
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723171117.9918-8-kan.liang@linux.intel.com>
References: <20200723171117.9918-8-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159782712765.3192.11418251021976454957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9f0c4fa111dc909ca545c45ea20ec84da555ce16
Gitweb:        https://git.kernel.org/tip/9f0c4fa111dc909ca545c45ea20ec84da555ce16
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 23 Jul 2020 10:11:10 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Aug 2020 16:34:36 +02:00

perf/core: Add a new PERF_EV_CAP_SIBLING event capability

Current perf assumes that events in a group are independent. Close an
event doesn't impact the value of the other events in the same group.
If the closed event is a member, after the event closure, other events
are still running like a group. If the closed event is a leader, other
events are running as singleton events.

Add PERF_EV_CAP_SIBLING to allow events to indicate they require being
part of a group, and when the leader dies they cannot exist
independently.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200723171117.9918-8-kan.liang@linux.intel.com
---
 include/linux/perf_event.h |  4 ++++-
 kernel/events/core.c       | 38 ++++++++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 04a49cc..6048650 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -576,9 +576,13 @@ typedef void (*perf_overflow_handler_t)(struct perf_event *,
  * PERF_EV_CAP_SOFTWARE: Is a software event.
  * PERF_EV_CAP_READ_ACTIVE_PKG: A CPU event (or cgroup event) that can be read
  * from any CPU in the package where it is active.
+ * PERF_EV_CAP_SIBLING: An event with this flag must be a group sibling and
+ * cannot be a group leader. If an event with this flag is detached from the
+ * group it is scheduled out and moved into an unrecoverable ERROR state.
  */
 #define PERF_EV_CAP_SOFTWARE		BIT(0)
 #define PERF_EV_CAP_READ_ACTIVE_PKG	BIT(1)
+#define PERF_EV_CAP_SIBLING		BIT(2)
 
 #define SWEVENT_HLIST_BITS		8
 #define SWEVENT_HLIST_SIZE		(1 << SWEVENT_HLIST_BITS)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5bfe8e3..57efe3b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2133,8 +2133,24 @@ static inline struct list_head *get_event_list(struct perf_event *event)
 	return event->attr.pinned ? &ctx->pinned_active : &ctx->flexible_active;
 }
 
+/*
+ * Events that have PERF_EV_CAP_SIBLING require being part of a group and
+ * cannot exist on their own, schedule them out and move them into the ERROR
+ * state. Also see _perf_event_enable(), it will not be able to recover
+ * this ERROR state.
+ */
+static inline void perf_remove_sibling_event(struct perf_event *event)
+{
+	struct perf_event_context *ctx = event->ctx;
+	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
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
 
@@ -2153,7 +2169,7 @@ static void perf_group_detach(struct perf_event *event)
 	/*
 	 * If this is a sibling, remove it from its group.
 	 */
-	if (event->group_leader != event) {
+	if (leader != event) {
 		list_del_init(&event->sibling_list);
 		event->group_leader->nr_siblings--;
 		goto out;
@@ -2166,6 +2182,9 @@ static void perf_group_detach(struct perf_event *event)
 	 */
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
 
+		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
+			perf_remove_sibling_event(sibling);
+
 		sibling->group_leader = sibling;
 		list_del_init(&sibling->sibling_list);
 
@@ -2183,10 +2202,10 @@ static void perf_group_detach(struct perf_event *event)
 	}
 
 out:
-	perf_event__header_size(event->group_leader);
-
-	for_each_sibling_event(tmp, event->group_leader)
+	for_each_sibling_event(tmp, leader)
 		perf_event__header_size(tmp);
+
+	perf_event__header_size(leader);
 }
 
 static bool is_orphaned_event(struct perf_event *event)
@@ -2979,6 +2998,7 @@ static void _perf_event_enable(struct perf_event *event)
 	raw_spin_lock_irq(&ctx->lock);
 	if (event->state >= PERF_EVENT_STATE_INACTIVE ||
 	    event->state <  PERF_EVENT_STATE_ERROR) {
+out:
 		raw_spin_unlock_irq(&ctx->lock);
 		return;
 	}
@@ -2990,8 +3010,16 @@ static void _perf_event_enable(struct perf_event *event)
 	 * has gone back into error state, as distinct from the task having
 	 * been scheduled away before the cross-call arrived.
 	 */
-	if (event->state == PERF_EVENT_STATE_ERROR)
+	if (event->state == PERF_EVENT_STATE_ERROR) {
+		/*
+		 * Detached SIBLING events cannot leave ERROR state.
+		 */
+		if (event->event_caps & PERF_EV_CAP_SIBLING &&
+		    event->group_leader == event)
+			goto out;
+
 		event->state = PERF_EVENT_STATE_OFF;
+	}
 	raw_spin_unlock_irq(&ctx->lock);
 
 	event_function_call(event, __perf_event_enable, NULL);
