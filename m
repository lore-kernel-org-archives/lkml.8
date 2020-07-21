Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62406C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B10E2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PXis+WYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgGUMkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgGUMku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:40:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C7C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z7pSLHnz/c5w340W1CTSwj9OTuCwsKs4s6JpI47cLxs=; b=PXis+WYyJayf9BzfZyZ8cUWy5S
        kpukd7dw4aCXpnA+/2hKjEzjr9CXvso8jP+Pg4iFL20bmknSyloXsTxTlxwA0LMZAw1EFSjsYsLHw
        1mXJHfCzugcWKUJy+RKmq1NeP/yOJPwOvpUdKuhSMa/bImvTyo7Ak67VxqmP7R2GSdoEGFCZSf50b
        uXsaa17BEWXm7YSnlbFehwsJ8NtEDo6/UA1pRwFr/1T5dbJ6BG0NyB/I3GKY+YpUga/Q1SIf4T0NG
        TT51EFM0lhw81K6CVlfRCjg4R1E++cjQOUKQnpFnEXrb7USqZU3SPlD9uHZjzFIrwl3hYQJuxf+0o
        j0MoqkMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxrZb-00030M-Ll; Tue, 21 Jul 2020 12:40:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92CF6305E21;
        Tue, 21 Jul 2020 14:40:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B4C7200DD94F; Tue, 21 Jul 2020 14:40:42 +0200 (CEST)
Date:   Tue, 21 Jul 2020 14:40:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V6 09/14] perf/x86/intel: Support TopDown metrics on Ice
 Lake
Message-ID: <20200721124042.GX10769@hirez.programming.kicks-ass.net>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-10-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717140554.22863-10-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 07:05:49AM -0700, kan.liang@linux.intel.com wrote:

> +static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
> +{
> +	u32 val;
> +
> +	/*
> +	 * The metric is reported as an 8bit integer fraction
> +	 * suming up to 0xff.
> +	 * slots-in-metric = (Metric / 0xff) * slots
> +	 */
> +	val = (metric >> ((idx - INTEL_PMC_IDX_METRIC_BASE) * 8)) & 0xff;
> +	return  mul_u64_u32_div(slots, val, 0xff);
> +}
> +
> +static void __icl_update_topdown_event(struct perf_event *event,
> +				       u64 slots, u64 metrics)
> +{
> +	int idx = event->hw.idx;
> +	u64 delta;
> +
> +	if (is_metric_idx(idx))
> +		delta = icl_get_metrics_event_value(metrics, slots, idx);
> +	else
> +		delta = slots;
> +
> +	local64_add(delta, &event->count);
> +}
> +
> +/*
> + * Update all active Topdown events.
> + *
> + * The PERF_METRICS and Fixed counter 3 are read separately. The values may be
> + * modify by a NMI. PMU has to be disabled before calling this function.
> + */
> +static u64 icl_update_topdown_event(struct perf_event *event)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct perf_event *other;
> +	u64 slots, metrics;
> +	int idx;
> +
> +	/* read Fixed counter 3 */
> +	rdpmcl((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
> +	if (!slots)
> +		return 0;
> +
> +	/* read PERF_METRICS */
> +	rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
> +
> +	for_each_set_bit(idx, cpuc->active_mask, INTEL_PMC_IDX_TD_BE_BOUND + 1) {
> +		if (!is_topdown_idx(idx))
> +			continue;
> +		other = cpuc->events[idx];
> +		__icl_update_topdown_event(other, slots, metrics);
> +	}
> +
> +	/*
> +	 * Check and update this event, which may have been cleared
> +	 * in active_mask e.g. x86_pmu_stop()
> +	 */
> +	if (event && !test_bit(event->hw.idx, cpuc->active_mask))
> +		__icl_update_topdown_event(event, slots, metrics);
> +
> +	/*
> +	 * Software is recommended to periodically clear both registers
> +	 * in order to maintain accurate measurements, which is required for
> +	 * certain scenarios that involve sampling metrics at high rates.

I'll maintain that that statement is clear as mud and therefore useless.

> +	 * Software should always write fixed counter 3 before write to
> +	 * PERF_METRICS.
> +	 */
> +	wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
> +	wrmsrl(MSR_PERF_METRICS, 0);
> +
> +	return slots;
> +}

So in the normal case, this ends up calling into this function _5_
times, once for each event. Now the first time, it will actually do
something useful, but the other 4 times it's just wasting cycles.

Also, that for_each_set_bit() loop, trying to find the events to
update...

Can't we, instead, make the SLOTS update advance 5 running counters in
cpuc and feed the events off of that?


