Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3A6C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95531208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L5Y9wMv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgIGQCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbgIGQBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:01:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FD1C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2eIR6kOywvDQ+JkAQrzHBLrjWuZKaxrdLTttVTI6scY=; b=L5Y9wMv0dx1VLchx7fHIQee8gb
        YgONFyr1QD5UAt9PYYIAm1/ZKnOBoyD+RMrWoQMoX4nWhB7wmBcti8wMha00+ATo9uLotZZ9h3fv0
        MryhEHFgJE9ilGNz/ACjBJN0W9SZuEpv2IWBT9dOBY84E7RZAxsQHY5W3gZUDhV+EVKo3rG24cBEp
        46uRqu3lEOtbdbP7un86pWTEcWfqe267vJiBK8xnTMotHuyKwzBqY79Ejy21TazZE2LxtxEwZm1oi
        /fTUNGfV5j5Y0iRBTMg3mJXsEgFTD57/aJN32Bk6KhmpPbVrUvEuyBwNOTKKLNFUQf1o2jGVO+mf0
        7L4RSrSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFJa0-0006VZ-2J; Mon, 07 Sep 2020 16:01:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79AB4303DA0;
        Mon,  7 Sep 2020 18:01:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6729D20107B6F; Mon,  7 Sep 2020 18:01:15 +0200 (CEST)
Date:   Mon, 7 Sep 2020 18:01:15 +0200
From:   peterz@infradead.org
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, mark.rutland@arm.com, luto@amacapital.net
Subject: Re: [PATCH V2 3/3] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
Message-ID: <20200907160115.GS2674@hirez.programming.kicks-ass.net>
References: <20200821195754.20159-1-kan.liang@linux.intel.com>
 <20200821195754.20159-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821195754.20159-3-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 12:57:54PM -0700, kan.liang@linux.intel.com wrote:
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 0f3d01562ded..fa08d810dcd2 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1440,7 +1440,10 @@ static void x86_pmu_start(struct perf_event *event, int flags)
>  
>  	cpuc->events[idx] = event;
>  	__set_bit(idx, cpuc->active_mask);
> -	__set_bit(idx, cpuc->running);
> +	/* The cpuc->running is only used by the P4 PMU */
> +	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON) &&
> +	    (boot_cpu_data.x86 == 0xf))
> +		__set_bit(idx, cpuc->running);
>  	x86_pmu.enable(event);
>  	perf_event_update_userpage(event);
>  }

Yuck! Use a static_branch() or something. This is a gnarly nest of code
that runs 99.9% of the time to conclude a negative. IOW a complete waste
of cycles for everybody not running a P4 space heater.

> @@ -1544,6 +1547,9 @@ static void x86_pmu_del(struct perf_event *event, int flags)
>  	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
>  		goto do_del;
>  
> +	if (READ_ONCE(x86_pmu.attr_rdpmc) && x86_pmu.sched_task &&
> +	    test_bit(event->hw.idx, cpuc->active_mask))
> +		__set_bit(event->hw.idx, cpuc->dirty);

And that too seems like an overly complicated set of tests and branches.
This should be effectivly true for the 99% common case.

> @@ -2219,11 +2225,45 @@ static int x86_pmu_event_init(struct perf_event *event)
>  	return err;
>  }
>  
> +void x86_pmu_clear_dirty_counters(void)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	int i;
> +
> +	if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
> +		return;
> +
> +	 /* Don't need to clear the assigned counter. */
> +	for (i = 0; i < cpuc->n_events; i++)
> +		__clear_bit(cpuc->assign[i], cpuc->dirty);
> +
> +	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
> +		/* Metrics events don't have corresponding HW counters. */
> +		if (is_metric_idx(i))
> +			continue;
> +		else if (i >= INTEL_PMC_IDX_FIXED)
> +			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
> +		else
> +			wrmsrl(x86_pmu_event_addr(i), 0);
> +	}
> +
> +	bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
> +}

The bitmap_{empty,zero}() do indeed compile into single instructions,
neat!

>  static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
>  {
>  	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>  		return;
>  
> +	/*
> +	 * Enable sched_task() for the RDPMC task,
> +	 * and clear the existing dirty counters.
> +	 */
> +	if (x86_pmu.sched_task && event->hw.target && !is_sampling_event(event)) {
> +		perf_sched_cb_inc(event->ctx->pmu);
> +		x86_pmu_clear_dirty_counters();
> +	}

I'm failing to see the correctness of the !is_sampling_event() part
there.

>  	/*
>  	 * This function relies on not being called concurrently in two
>  	 * tasks in the same mm.  Otherwise one task could observe
> @@ -2246,6 +2286,9 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
>  	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>  		return;
>  
> +	if (x86_pmu.sched_task && event->hw.target && !is_sampling_event(event))
> +		perf_sched_cb_dec(event->ctx->pmu);
> +

Idem.

>  	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
>  		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
>  }
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index c72e4904e056..e67713bfa33a 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4166,11 +4166,39 @@ static void intel_pmu_cpu_dead(int cpu)
>  	intel_cpuc_finish(&per_cpu(cpu_hw_events, cpu));
>  }
>  
> +static void intel_pmu_rdpmc_sched_task(struct perf_event_context *ctx)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct perf_event *event;
> +
> +	if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
> +		return;
> +
> +	/*
> +	 * If the new task has the RDPMC enabled, clear the dirty counters to
> +	 * prevent the potential leak. If the new task doesn't have the RDPMC
> +	 * enabled, do nothing.
> +	 */
> +	list_for_each_entry(event, &ctx->event_list, event_entry) {
> +		if (event->hw.target &&
> +		    (event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED) &&
> +		    !is_sampling_event(event) &&
> +		    atomic_read(&event->mmap_count))
> +			break;
> +	}
> +	if (&event->event_entry == &ctx->event_list)
> +		return;

That's horrific, what's wrong with something like:

	if (!atomic_read(&current->mm->context.perf_rdpmc_allowed))
		return;

> +
> +	x86_pmu_clear_dirty_counters();
> +}

How is this Intel specific code? IIRC AMD has RDPMC too.
