Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8575CC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680532072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCER4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:56:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:26188 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgCER4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:56:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 09:56:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="387572966"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 05 Mar 2020 09:56:52 -0800
Received: from [10.251.16.243] (kliang2-mobl.ccr.corp.intel.com [10.251.16.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4E8A75802A3;
        Thu,  5 Mar 2020 09:56:51 -0800 (PST)
Subject: Re: [PATCH] perf/core: Fix endless multiplex timer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, ak@linux.intel.com
References: <20200303202819.3942-1-kan.liang@linux.intel.com>
 <20200303210812.GA4745@worktop.programming.kicks-ass.net>
 <b71515e4-484e-d80a-37db-2e51abe69928@linux.intel.com>
 <20200304093344.GJ2596@hirez.programming.kicks-ass.net>
 <6a271c19-9575-24ca-8ebc-9ff5a65bbe3d@linux.intel.com>
 <20200305123851.GX2596@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <5c5b7fd1-4b85-8cce-b263-4a421b00f6df@linux.intel.com>
Date:   Thu, 5 Mar 2020 12:56:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305123851.GX2596@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/2020 7:38 AM, Peter Zijlstra wrote:
> On Wed, Mar 04, 2020 at 09:20:42AM -0500, Liang, Kan wrote:
>>
>> NMI watchdog is pinned event.
>> ctx_event_to_rotate() will only pick an event from the flexible_groups.
>> So the cpu_ctx_sched_out() in perf_rotate_context() will never be called.
> 
> Surely that's fixable; same principle.
> 

Yes, after applying this patch, the issue has gone.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 3f1f77de7247..595fb3decd43 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2182,6 +2182,7 @@ __perf_remove_from_context(struct perf_event *event,
>   
>   	if (!ctx->nr_events && ctx->is_active) {
>   		ctx->is_active = 0;
> +		ctx->rotate_necessary = 0;
>   		if (ctx->task) {
>   			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
>   			cpuctx->task_ctx = NULL;
> @@ -3077,12 +3078,6 @@ static void ctx_sched_out(struct perf_event_context *ctx,
>   	if (!ctx->nr_active || !(is_active & EVENT_ALL))
>   		return;
>   
> -	/*
> -	 * If we had been multiplexing, no rotations are necessary, now no events
> -	 * are active.
> -	 */
> -	ctx->rotate_necessary = 0;
> -
>   	perf_pmu_disable(ctx->pmu);
>   	if (is_active & EVENT_PINNED) {
>   		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
> @@ -3092,6 +3087,13 @@ static void ctx_sched_out(struct perf_event_context *ctx,
>   	if (is_active & EVENT_FLEXIBLE) {
>   		list_for_each_entry_safe(event, tmp, &ctx->flexible_active, active_list)
>   			group_sched_out(event, cpuctx, ctx);
> +
> +		/*
> +		 * Since we cleared EVENT_FLEXIBLE, also clear
> +		 * rotate_necessary, is will be reset by
> +		 * ctx_flexible_sched_in() when needed.
> +		 */
> +		ctx->rotate_necessary = 0;
>   	}
>   	perf_pmu_enable(ctx->pmu);
>   }
> @@ -3841,6 +3843,12 @@ ctx_event_to_rotate(struct perf_event_context *ctx)
>   				      typeof(*event), group_node);
>   	}
>   
> +	/*
> +	 * Unconditionally clear rotate_necessary; if ctx_flexible_sched_in()
> +	 * finds there are unschedulable events, it will set it again.
> +	 */
> +	ctx->rotate_necessary = 0;
> +
>   	return event;
>   }
>   
> 
