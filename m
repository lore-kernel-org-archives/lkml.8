Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF3AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931BF206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGXTK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:10:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:39020 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgGXTK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:10:56 -0400
IronPort-SDR: Hoicfg16ucmrRuH/eK4u3kA6GSkr6JTSrUAOGuI+n/GMmG6+A1EfirikF8CKfffyPYm2jDl8Lh
 Snx4Ld6wbpPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="138830158"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="138830158"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 12:10:55 -0700
IronPort-SDR: K8Tzy4u5wyXvP63/Z9Y4GuMgCpjahYoUvjfGJOKq2D4YMd4ZxeAH1W+H2R7NJZVM4iG2MjW/uJ
 U2C1qgOswJ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="302757951"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 24 Jul 2020 12:10:55 -0700
Received: from [10.252.140.222] (kliang2-mobl.ccr.corp.intel.com [10.252.140.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6E6BC580638;
        Fri, 24 Jul 2020 12:10:54 -0700 (PDT)
Subject: Re: [PATCH V7 08/14] perf/x86/intel: Generic support for hardware
 TopDown metrics
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     peterz@infradead.org
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-9-kan.liang@linux.intel.com>
 <20200724131906.GW119549@hirez.programming.kicks-ass.net>
 <20200724152755.GK43129@hirez.programming.kicks-ass.net>
 <d7ae2272-52ea-c5a9-2937-9a51c544ade8@linux.intel.com>
Message-ID: <ddeae082-c38d-a961-4d90-1fbc1c9f2726@linux.intel.com>
Date:   Fri, 24 Jul 2020 15:10:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d7ae2272-52ea-c5a9-2937-9a51c544ade8@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2020 12:07 PM, Liang, Kan wrote:
> 
> 
> On 7/24/2020 11:27 AM, peterz@infradead.org wrote:
>> On Fri, Jul 24, 2020 at 03:19:06PM +0200, peterz@infradead.org wrote:
>>> On Thu, Jul 23, 2020 at 10:11:11AM -0700, kan.liang@linux.intel.com 
>>> wrote:
>>>> @@ -3375,6 +3428,72 @@ static int intel_pmu_hw_config(struct 
>>>> perf_event *event)
>>>>       if (event->attr.type != PERF_TYPE_RAW)
>>>>           return 0;
>>>> +    /*
>>>> +     * Config Topdown slots and metric events
>>>> +     *
>>>> +     * The slots event on Fixed Counter 3 can support sampling,
>>>> +     * which will be handled normally in x86_perf_event_update().
>>>> +     *
>>>> +     * The metric events don't support sampling.
>>>> +     *
>>>> +     * For counting, topdown slots and metric events will be
>>>> +     * handled specially for event update.
>>>> +     * A flag PERF_X86_EVENT_TOPDOWN is applied for the case.
>>>> +     */
>>>> +    if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
>>>> +        if (is_metric_event(event)) {
>>>> +            struct perf_event *leader = event->group_leader;
>>>> +            struct perf_event *sibling;
>>>> +
>>>> +            /* The metric events don't support sampling. */
>>>> +            if (is_sampling_event(event))
>>>> +                return -EINVAL;
>>>> +
>>>> +            /* The metric events cannot be a group leader. */
>>>> +            if (leader == event)
>>>> +                return -EINVAL;
>>>> +
>>>> +            /*
>>>> +             * The slots event cannot be the leader of a topdown
>>>> +             * sample-read group, e.g., {slots, topdown-retiring}:S
>>>> +             */
>>>> +            if (is_slots_event(leader) && is_sampling_event(leader))
>>>> +                return -EINVAL;
>>>
>>> This has nothing to do with sample-read; SLOTS cannot be sampling when
>>> coupled with the METRIC stuff because hardware is daft.
>>>
>>> And you can have SAMPLE_READ on non-leader events just fine.
>>>
>>>> +
>>>> +            /*
>>>> +             * The slots event must be before the metric events,
>>>> +             * because we only update the values of a topdown
>>>> +             * group once with the slots event.
>>>> +             */
>>>> +            if (!is_slots_event(leader)) {
>>>> +                for_each_sibling_event(sibling, leader) {
>>>> +                    if (is_slots_event(sibling))
>>>> +                        break;
>>>> +                    if (is_metric_event(sibling))
>>>> +                        return -EINVAL;
>>>> +                }
>>>> +            }
>>>
>>> Per the SIBLING patch this then wants to be:
>>>
>>>             if (!is_slots_event(leader))
>>>                 return -EINVAL;
>>>
>>>             event->event_caps |= PERF_EV_CAP_SIBLING.
>>>             /*
>>>              * Only once we have a METRICs sibling to we
>>>              * need TopDown magic.
>>>              */
>>>             leader->hw.flags |= PERF_X86_EVENT_TOPDOWN;

Since we only set the flag for the SLOTS event now, the V7 patch will 
treat the metric events as normal events, which trigger an error.

To fix the error, I think we may merge the changes as below with the 
[PATCH 08/14] perf/x86/intel: Generic support for hardware TopDown metrics.

I think we don't need the PERF_X86_EVENT_TOPDOWN flag anymore.
If it's a non-sampling slots event, apply the special function.
If it's a metric event, do nothing.

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0f3d01562ded..02dfee0b6615 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -73,10 +73,10 @@ u64 x86_perf_event_update(struct perf_event *event)
  	u64 prev_raw_count, new_raw_count;
  	u64 delta;

-	if (unlikely(!hwc->event_base))
+	if (unlikely(!hwc->event_base || is_metric_event(event)))
  		return 0;

-	if (unlikely(is_topdown_count(event)) && x86_pmu.update_topdown_event)
+	if (unlikely(is_slots_count(event)) && x86_pmu.update_topdown_event)
  		return x86_pmu.update_topdown_event(event);

  	/*
@@ -1280,11 +1280,10 @@ int x86_perf_event_set_period(struct perf_event 
*event)
  	s64 period = hwc->sample_period;
  	int ret = 0, idx = hwc->idx;

-	if (unlikely(!hwc->event_base))
+	if (unlikely(!hwc->event_base || is_metric_event(event)))
  		return 0;

-	if (unlikely(is_topdown_count(event)) &&
-	    x86_pmu.set_topdown_event_period)
+	if (unlikely(is_slots_count(event)) && x86_pmu.set_topdown_event_period)
  		return x86_pmu.set_topdown_event_period(event);

  	/*
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6cb079e0c9d9..010ac74afc09 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2405,27 +2405,18 @@ static u64 icl_update_topdown_event(struct 
perf_event *event)
  	return slots;
  }

-static void intel_pmu_read_topdown_event(struct perf_event *event)
+static void intel_pmu_read_event(struct perf_event *event)
  {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-
-	/* Only need to call update_topdown_event() once for group read. */
-	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
-	    !is_slots_event(event))
+	if (unlikely(is_metric_event(event)))
  		return;

-	perf_pmu_disable(event->pmu);
-	x86_pmu.update_topdown_event(event);
-	perf_pmu_enable(event->pmu);
-}
-
-static void intel_pmu_read_event(struct perf_event *event)
-{
  	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
  		intel_pmu_auto_reload_read(event);
-	else if (is_topdown_count(event) && x86_pmu.update_topdown_event)
-		intel_pmu_read_topdown_event(event);
-	else
+	else if (is_slots_count(event) && x86_pmu.update_topdown_event) {
+		perf_pmu_disable(event->pmu);
+		x86_pmu.update_topdown_event(event);
+		perf_pmu_enable(event->pmu);
+	} else
  		x86_perf_event_update(event);
  }

@@ -3606,12 +3597,14 @@ static int intel_pmu_hw_config(struct perf_event 
*event)
  	 *
  	 * The slots event on Fixed Counter 3 can support sampling,
  	 * which will be handled normally in x86_perf_event_update().
-	 *
  	 * The metric events don't support sampling.
  	 *
-	 * For counting, topdown slots and metric events will be
-	 * handled specially for event update.
-	 * A flag PERF_X86_EVENT_TOPDOWN is applied for the case.
+	 * For the counting of the slots and metric events, the rules
+	 * as below have to be applied:
+	 * - A standalone metric event or pure metric events group is
+	 *   not supported.
+	 * - The metric events group must include the slots event.
+	 * - The slots event must be the leader of the group.
  	 */
  	if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
  		if (event->attr.config1 || event->attr.config2)
@@ -3647,11 +3640,6 @@ static int intel_pmu_hw_config(struct perf_event 
*event)
  				return -EINVAL;

  			event->event_caps |= PERF_EV_CAP_SIBLING;
-			/*
-			 * Only once we have a METRICs sibling do we
-			 * need TopDown magic.
-			 */
-			leader->hw.flags |= PERF_X86_EVENT_TOPDOWN;
  		}
  	}

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 345442410a4d..153db209c105 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -79,12 +79,6 @@ static inline bool constraint_match(struct 
event_constraint *c, u64 ecode)
  #define PERF_X86_EVENT_PEBS_VIA_PT	0x0800 /* use PT buffer for PEBS */
  #define PERF_X86_EVENT_PAIR		0x1000 /* Large Increment per Cycle */
  #define PERF_X86_EVENT_LBR_SELECT	0x2000 /* Save/Restore MSR_LBR_SELECT */
-#define PERF_X86_EVENT_TOPDOWN		0x4000 /* Count Topdown slots/metrics 
events */
-
-static inline bool is_topdown_count(struct perf_event *event)
-{
-	return event->hw.flags & PERF_X86_EVENT_TOPDOWN;
-}

  static inline bool is_metric_event(struct perf_event *event)
  {
@@ -105,6 +99,14 @@ static inline bool is_topdown_event(struct 
perf_event *event)
  	return is_metric_event(event) || is_slots_event(event);
  }

+static inline bool is_slots_count(struct perf_event *event)
+{
+	if (is_slots_event(event) && !is_sampling_event(event))
+		return true;
+
+	return false;
+}
+
  struct amd_nb {
  	int nb_id;  /* NorthBridge id */
  	int refcnt; /* reference count */


Thanks,
Kan

>>>> +        }
>>>> +
>>>> +        if (!is_sampling_event(event)) {
>>>> +            if (event->attr.config1 != 0)
>>>> +                return -EINVAL;
>>>
>>> How does this depend on sampling?
>>>
>>>> +            /*
>>>> +             * The TopDown metrics events and slots event don't
>>>> +             * support any filters.
>>>> +             */
>>>> +            if (event->attr.config & X86_ALL_EVENT_FLAGS)
>>>> +                return -EINVAL;
>>>
>>> That seems independent of sampling too. Even a sampling SLOTS shouldn't
>>> be having any of those afaict.
>>>
>>>> +
>>>> +            event->hw.flags |= PERF_X86_EVENT_TOPDOWN;
>>>
>>> This is confusing too, a !sampling SLOTS event without METRIC siblings
>>> shouldn't have this set, right? So arguably, this should be like above.
>>>
>>>> +
>>>> +            event->event_caps |= PERF_EV_CAP_COEXIST;
>>>> +
>>>> +            if (is_metric_event(event))
>>>> +                event->hw.flags &= ~PERF_X86_EVENT_RDPMC_ALLOWED;
>>>
>>> This too seems like something that should be in the is_metric_event()
>>> branch above.
>>>
>>>> +        }
>>>> +    }
>>>> +
>>>>       if (!(event->attr.config & ARCH_PERFMON_EVENTSEL_ANY))
>>>>           return 0;
>>
>> FWIW, I pushed out a branch with all these changes in:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git 
>> perf/metric
>>
>> Just to get it some build love, if you want it differently, I'm happy to
>> throw it all out again.
> 
> Thanks Peter.
> 
> I will pull the branch and do more tests.
> 
> Thanks,
> Kan
