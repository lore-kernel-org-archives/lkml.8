Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA9CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F4C2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nyCwpdgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgGXLqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGXLqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:46:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FA5C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SfcyZ0erS4wUNQM84JiAO4TzEKWL1zkXJ64OQYvZW2M=; b=nyCwpdgFHDnctg8zE1S8wjTWR5
        0M7W+VVaiMGeZjZL63sSi2mr79XILk1qttFgR8eLzytGhQZd8sVs7IU2YMGgn9K0IEysvhThrcuh6
        8i2wFxjJ8qdEIZdwdBFV4sBvT+Z99AkyXGpwE7QSvpXJ2/+8f6l6xcwRqwv3E/1N8tuxH6SuhKvjD
        CFValG3C1E22XWEDOhXZeUPOHsi33DZwAuouwX5wqkRoFy4oZFBg1q4NfIp6ApDGBWuD5j2bkUET+
        yJmSnwhdxumzkAavooQBFpxaOiSygcE2tVYCc4paFh5GBY66n7+7cWSrGCA6FE4jcpHfWLc/vLNh8
        +YuVobYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyw9n-0005AS-RX; Fri, 24 Jul 2020 11:46:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D1643003E5;
        Fri, 24 Jul 2020 13:46:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0488D2870376E; Fri, 24 Jul 2020 13:46:28 +0200 (CEST)
Date:   Fri, 24 Jul 2020 13:46:28 +0200
From:   peterz@infradead.org
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH V7 07/14] perf/core: Add a new PERF_EV_CAP_COEXIST event
 capability
Message-ID: <20200724114628.GJ43129@hirez.programming.kicks-ass.net>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-8-kan.liang@linux.intel.com>
 <20200724105543.GV119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724105543.GV119549@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 12:55:43PM +0200, peterz@infradead.org wrote:
> > +	event_sched_out(event, cpuctx, ctx);
> > +	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> > +}
> 
> Ah, so the problem here is that ERROR is actually recoverable using
> IOC_ENABLE. We don't want that either. Let me try and figure out of EXIT
> would work.

EXIT is difficult too.. Also, that COEXIST thing hurt my brian, can't we
do a simpler SIBLING thing that simply requires the event to be a group
sibling?

The consequence is that SLOTS must be the leader, is that really a
problem? You keep providing the {cycles, slots, metric-things} example,
but afaict {slots, metric-thing, cycles} should work just fine too.
PERF_SAMPLE_READ with PERF_FORMAT_GROUP doesn't need to the the leader.

The thing is, with COEXIST, if you have:

	{cycles, slots, metric1, metric2}

and you say that COEXIST events need to co-exist with at least one other
COEXIST event you end up with a problem when: close(fd_slots) happens,
because in the above case, there's two more COEXIST events, so the
requirement holds, even through this is very much not what we want.

You 'fixed' this by saying closing any COEXIST event will tear the group
up, but that's 'weird' and unexpected if you were to do:
close(fd_metric2).


So something like this.

---
Subject: perf/core: Add a new PERF_EV_CAP_SIBLING event capability

Current perf assumes that events in a group are independent. Close an
event doesn't impact the value of the other events in the same group.
If the closed event is a member, after the event closure, other events
are still running like a group. If the closed event is a leader, other
events are running as singleton events.

Add PERF_EV_CAP_SIBLING to allow events to indicate they require being
part of a group, and when the leader dies they cannot exist
independently.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/perf_event.h |    4 ++++
 kernel/events/core.c       |   38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 5 deletions(-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -576,9 +576,13 @@ typedef void (*perf_overflow_handler_t)(
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
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2133,8 +2133,24 @@ static inline struct list_head *get_even
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
 
@@ -2153,7 +2169,7 @@ static void perf_group_detach(struct per
 	/*
 	 * If this is a sibling, remove it from its group.
 	 */
-	if (event->group_leader != event) {
+	if (leader != event) {
 		list_del_init(&event->sibling_list);
 		event->group_leader->nr_siblings--;
 		goto out;
@@ -2166,6 +2182,9 @@ static void perf_group_detach(struct per
 	 */
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
 
+		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
+			perf_remove_sibling_event(sibling);
+
 		sibling->group_leader = sibling;
 		list_del_init(&sibling->sibling_list);
 
@@ -2183,10 +2202,10 @@ static void perf_group_detach(struct per
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
@@ -2979,6 +2998,7 @@ static void _perf_event_enable(struct pe
 	raw_spin_lock_irq(&ctx->lock);
 	if (event->state >= PERF_EVENT_STATE_INACTIVE ||
 	    event->state <  PERF_EVENT_STATE_ERROR) {
+out:
 		raw_spin_unlock_irq(&ctx->lock);
 		return;
 	}
@@ -2990,8 +3010,16 @@ static void _perf_event_enable(struct pe
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

