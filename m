Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDEAC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C57920702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgGUOXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:23:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:19460 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgGUOXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:23:40 -0400
IronPort-SDR: uICV1+vGYCvVmTMtvlhWlgNVzRD+IUvpY3SMx2DOgKxuu+pfZIciwJ50JOltQbh3DHIimr/s4C
 hn4HANzM//DA==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="150118242"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="150118242"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 07:23:39 -0700
IronPort-SDR: f7YMxM5WhyNto+eVG1ImQLCECDyDxwidMuXiZMqeGT9I5SEXKEcDb2eO9H2tSFwfJ1CVmFN09T
 jyxPZKyqI3hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="271729487"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2020 07:23:38 -0700
Received: from [10.254.76.99] (kliang2-mobl.ccr.corp.intel.com [10.254.76.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0314F580299;
        Tue, 21 Jul 2020 07:23:37 -0700 (PDT)
Subject: Re: [PATCH V6 09/14] perf/x86/intel: Support TopDown metrics on Ice
 Lake
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-10-kan.liang@linux.intel.com>
 <20200721124042.GX10769@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <e9f855ad-e4bd-8766-29b6-d251c859d58f@linux.intel.com>
Date:   Tue, 21 Jul 2020 10:23:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721124042.GX10769@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2020 8:40 AM, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 07:05:49AM -0700, kan.liang@linux.intel.com wrote:
> 
>> +static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
>> +{
>> +	u32 val;
>> +
>> +	/*
>> +	 * The metric is reported as an 8bit integer fraction
>> +	 * suming up to 0xff.
>> +	 * slots-in-metric = (Metric / 0xff) * slots
>> +	 */
>> +	val = (metric >> ((idx - INTEL_PMC_IDX_METRIC_BASE) * 8)) & 0xff;
>> +	return  mul_u64_u32_div(slots, val, 0xff);
>> +}
>> +
>> +static void __icl_update_topdown_event(struct perf_event *event,
>> +				       u64 slots, u64 metrics)
>> +{
>> +	int idx = event->hw.idx;
>> +	u64 delta;
>> +
>> +	if (is_metric_idx(idx))
>> +		delta = icl_get_metrics_event_value(metrics, slots, idx);
>> +	else
>> +		delta = slots;
>> +
>> +	local64_add(delta, &event->count);
>> +}
>> +
>> +/*
>> + * Update all active Topdown events.
>> + *
>> + * The PERF_METRICS and Fixed counter 3 are read separately. The values may be
>> + * modify by a NMI. PMU has to be disabled before calling this function.
>> + */
>> +static u64 icl_update_topdown_event(struct perf_event *event)
>> +{
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	struct perf_event *other;
>> +	u64 slots, metrics;
>> +	int idx;
>> +
>> +	/* read Fixed counter 3 */
>> +	rdpmcl((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
>> +	if (!slots)
>> +		return 0;
>> +
>> +	/* read PERF_METRICS */
>> +	rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
>> +
>> +	for_each_set_bit(idx, cpuc->active_mask, INTEL_PMC_IDX_TD_BE_BOUND + 1) {
>> +		if (!is_topdown_idx(idx))
>> +			continue;
>> +		other = cpuc->events[idx];
>> +		__icl_update_topdown_event(other, slots, metrics);
>> +	}
>> +
>> +	/*
>> +	 * Check and update this event, which may have been cleared
>> +	 * in active_mask e.g. x86_pmu_stop()
>> +	 */
>> +	if (event && !test_bit(event->hw.idx, cpuc->active_mask))
>> +		__icl_update_topdown_event(event, slots, metrics);
>> +
>> +	/*
>> +	 * Software is recommended to periodically clear both registers
>> +	 * in order to maintain accurate measurements, which is required for
>> +	 * certain scenarios that involve sampling metrics at high rates.
> 
> I'll maintain that that statement is clear as mud and therefore useless.
> 
>> +	 * Software should always write fixed counter 3 before write to
>> +	 * PERF_METRICS.
>> +	 */
>> +	wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
>> +	wrmsrl(MSR_PERF_METRICS, 0);
>> +
>> +	return slots;
>> +}
> 
> So in the normal case, this ends up calling into this function _5_
> times, once for each event. Now the first time, it will actually do
> something useful, but the other 4 times it's just wasting cycles.
> 
> Also, that for_each_set_bit() loop, trying to find the events to
> update...
> 
> Can't we, instead, make the SLOTS update advance 5 running counters in
> cpuc and feed the events off of that?
> 

Patch 13 forces the slots event to be part of a metric group. In patch 
7, for a metric group, we only update the values once with slots event.
I think the normal case mentioned above should not happen.

+	/* Only need to call update_topdown_event() once for group read. */
+	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
+	    !is_slots_event(event))
+		return;
+
+	perf_pmu_disable(event->pmu);
+	x86_pmu.update_topdown_event(event);
+	perf_pmu_enable(event->pmu);

Thanks,
Kan


