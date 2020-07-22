Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D62EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58261206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbgGVT0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:26:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:57714 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgGVT0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:26:47 -0400
IronPort-SDR: XxQ2WnUIbMfHX0eNd//YoYRjWlgUAqdSdB2WakIbMVZ9SFsrWZfyW0XmQy8N5WQyMSlq4R9Va+
 bebyBALzKgtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="137909789"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="137909789"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 12:26:47 -0700
IronPort-SDR: nOsE7Ndks8lSoQBqh5yBvMiPKKBNLvRMHW0l9mkBz1g+CUd17noPE20kLlMNgjsKOnwCymm0AP
 sBxYwMpXKu0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="318758537"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 22 Jul 2020 12:26:47 -0700
Received: from [10.251.9.199] (kliang2-mobl.ccr.corp.intel.com [10.251.9.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6C5FA5802E4;
        Wed, 22 Jul 2020 12:26:46 -0700 (PDT)
Subject: Re: [PATCH V6 11/14] perf/x86/intel: Disable sample-read the slots
 and metrics events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-12-kan.liang@linux.intel.com>
 <20200721131011.GY10769@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <1bfa475e-2f7c-31e0-5114-34ac9808e4d6@linux.intel.com>
Date:   Wed, 22 Jul 2020 15:26:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721131011.GY10769@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2020 9:10 AM, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 07:05:51AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Users fail to sample-read the slots and metrics events, e.g.,
>> perf record -e '{slots, topdown-retiring}:S'.
>>
>> When reading the metrics event, the fixed counter 3 (slots) has to be
>> reset, which impacts the sampling of the slots event.
>>
>> Add a specific validate_group() support to reject the case and error out
>> for Ice Lake.
>>
>> An alternative fix may unconditionally disable slots sampling, but it's
>> not a decent fix. Users may want to only sample the slot events
>> without the topdown metrics events.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> I'm confused by this; it doesn't make sense.
> 
> Should not patch 7 have something like the below instead?
> 
> Also, I think there is a bug when we create a group like this and then
> kill the leader, in that case the core code will 'promote' the sibling
> metric events to their own individual events, see perf_group_detach().
> 
> We need additional code to move those events into unrecoverable ERROR
> state. A new group_caps flag could indicate this promotion isn't
> allowed.

Yes, I can produce the bug with a custom program. The below patch can 
fix it. I will add it into the upcoming V7 patch set.

 From c90d4c19b24392e6bd9ff3c6d23d0d300bfa774f Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Wed, 22 Jul 2020 12:06:32 -0700
Subject: [PATCH] perf/core: Add a new PERF_EV_CAP_COEXIST event capability

Current perf assumes that group events are independent. Close an event
doesn't impact the value of the other events in the same group. If the
closed event is a member, after the event closure, other events are
running like a group. If the closed event is a leader, after the
closure, other events are running as singleton events.

However, the assumption is not correct anymore, e.g., the TopDown slots
and metrics events. The slots and metrics events must coexist in the
same group. If the slots event is closed, the value for the metrics
events is invalid.

Add a new PERF_EV_CAP_COEXIST event capability to indicate the
relationship among group events.

If any event with the flag is detached from the group, split the group
into singleton events, and move the events, which also have the flag,
to the unrecoverable ERROR state.

The leader of a PERF_EV_CAP_COEXIST group has to be updated at last.
Move perf_event__header_size(leader); to the end of perf_group_detach().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
  arch/x86/events/intel/core.c |  2 ++
  include/linux/perf_event.h   |  5 ++++
  kernel/events/core.c         | 52 +++++++++++++++++++++++++++++++++---
  3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 35694f6337c9..b0ab638e48ee 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3659,6 +3659,8 @@ static int intel_pmu_hw_config(struct perf_event 
*event)
  				return -EINVAL;

  			event->hw.flags |= PERF_X86_EVENT_TOPDOWN;
+
+			event->event_caps |= PERF_EV_CAP_COEXIST;
  		}
  	}

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a26f3c9589b7..aa60a1381aa1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -585,9 +585,14 @@ typedef void (*perf_overflow_handler_t)(struct 
perf_event *,
   * PERF_EV_CAP_SOFTWARE: Is a software event.
   * PERF_EV_CAP_READ_ACTIVE_PKG: A CPU event (or cgroup event) that can 
be read
   * from any CPU in the package where it is active.
+ * PERF_EV_CAP_COEXIST: An event with this flag must coexist with other 
sibling
+ * events, which have the same flag. If any event with the flag is detached
+ * from the group, split the group into singleton events, and move the 
events
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
@@ -2133,10 +2133,28 @@ static inline struct list_head 
*get_event_list(struct perf_event *event)
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

@@ -2150,15 +2168,25 @@ static void perf_group_detach(struct perf_event 
*event)

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
@@ -2172,6 +2200,10 @@ static void perf_group_detach(struct perf_event 
*event)
  		/* Inherit group flags from the previous leader */
  		sibling->group_caps = event->group_caps;

+		/* Remove sibling PERF_EV_CAP_COEXIST event */
+		if (cap_coexist)
+			perf_remove_coexist_events(sibling);
+
  		if (!RB_EMPTY_NODE(&event->group_node)) {
  			add_event_to_groups(sibling, event->ctx);

@@ -2181,12 +2213,24 @@ static void perf_group_detach(struct perf_event 
*event)

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


> 
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3441,8 +3441,22 @@ static int intel_pmu_hw_config(struct pe
>   	 * A flag PERF_X86_EVENT_TOPDOWN is applied for the case.
>   	 */
>   	if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
> -		if (is_metric_event(event) && is_sampling_event(event))
> -			return -EINVAL;
> +
> +		if (is_metric_event(event)) {
> +			struct perf_event *leader = event->group_leader;
> +
> +			if (is_sampling_event(event))
> +				return -EINVAL;
> +
> +			if (leader == event)
> +				return -EINVAL;
> +
> +			if (!is_slots_event(leader))
> +				return -EINVAL;
> +
> +			if (is_sampling_event(leader))
> +				return -EINVAL;
> +		}

The leader doesn't need to be a slots event, e.g., {cycles, slots, 
topdown_fe_bound} is also a valid group.
But the slots event must be before all metric events.

So I will also use the below codes to replace the above one in V7.


+		if (is_metric_event(event)) {
+			struct perf_event *leader = event->group_leader;
+			struct perf_event *sibling;
+
+			/* The metric events don't support sampling. */
+			if (is_sampling_event(event))
+				return -EINVAL;
+
+			/* The metric events cannot be a group leader. */
+			if (leader == event)
+				return -EINVAL;
+
+			/*
+			 * The slots event cannot be the leader of a topdown
+			 * sample-read group, e.g., {slots, topdown-retiring}:S
+			 */
+			if (is_slots_event(leader) && is_sampling_event(leader))
+				return -EINVAL;
+
+			/*
+			 * The slots event must be before the metric events,
+			 * because we only update the values of a topdown
+			 * group once with the slots event.
+			 */
+			if (!is_slots_event(leader)) {
+				for_each_sibling_event(sibling, leader) {
+					if (is_slots_event(sibling))
+						break;
+					if (is_metric_event(sibling))
+						return -EINVAL;
+				}
+			}
+		}



Thanks,
Kan

