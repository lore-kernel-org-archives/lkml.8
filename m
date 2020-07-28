Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29947C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060DB2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YmDZO4sM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgG1Mcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbgG1Mcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:32:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62C2C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=oarW/qlqlu192ogdl6wKLE44JOUw7xqWCwtlAs5SBQw=; b=YmDZO4sMslPowMyBWcwo9ZbHG8
        hGxTxqFQ0QXI1Ven4+JFVGrTeK9UJpOh1FFeBnnCctwwtQy3yXMu1drE8hlQZFShQtGziP//7krw4
        7InzFPNMuC10E7ukub8Ggbm5O8qytQKmOdVbzGMlYhohlA+ZlRara9tEWXW1cGPd2uM23nBA6Omqa
        Q+VJbg/1vo6JLjgisDV+EQBA5/f8tkuUxEjTdAr2nAVsLpPQyLr7mZbwX0dwvJ7EOGpFfY9CEL8vu
        bUS6sUnQsJsg7mHHdVWQFGrsI0OKU/Fn4N+YDnsCvlVDWZKMD1AnB35TG0Gog4dLiKLPTG5PViR6A
        IZCQDi7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0Omg-0002ak-6h; Tue, 28 Jul 2020 12:32:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E6F4305C16;
        Tue, 28 Jul 2020 14:32:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1394B2BB55741; Tue, 28 Jul 2020 14:32:40 +0200 (CEST)
Date:   Tue, 28 Jul 2020 14:32:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH V7 08/14] perf/x86/intel: Generic support for hardware
 TopDown metrics
Message-ID: <20200728123240.GJ10769@hirez.programming.kicks-ass.net>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-9-kan.liang@linux.intel.com>
 <20200724131906.GW119549@hirez.programming.kicks-ass.net>
 <20200724152755.GK43129@hirez.programming.kicks-ass.net>
 <d7ae2272-52ea-c5a9-2937-9a51c544ade8@linux.intel.com>
 <ddeae082-c38d-a961-4d90-1fbc1c9f2726@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddeae082-c38d-a961-4d90-1fbc1c9f2726@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 03:10:52PM -0400, Liang, Kan wrote:

> > > > Per the SIBLING patch this then wants to be:
> > > > 
> > > >             if (!is_slots_event(leader))
> > > >                 return -EINVAL;
> > > > 
> > > >             event->event_caps |= PERF_EV_CAP_SIBLING.
> > > >             /*
> > > >              * Only once we have a METRICs sibling to we
> > > >              * need TopDown magic.
> > > >              */
> > > >             leader->hw.flags |= PERF_X86_EVENT_TOPDOWN;
> 
> Since we only set the flag for the SLOTS event now, the V7 patch will treat
> the metric events as normal events, which trigger an error.

Damn, that was a silly oversight on my part.

> I think we don't need the PERF_X86_EVENT_TOPDOWN flag anymore.
> If it's a non-sampling slots event, apply the special function.
> If it's a metric event, do nothing.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 0f3d01562ded..02dfee0b6615 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -73,10 +73,10 @@ u64 x86_perf_event_update(struct perf_event *event)
>  	u64 prev_raw_count, new_raw_count;
>  	u64 delta;
> 
> -	if (unlikely(!hwc->event_base))
> +	if (unlikely(!hwc->event_base || is_metric_event(event)))
>  		return 0;
> 
> -	if (unlikely(is_topdown_count(event)) && x86_pmu.update_topdown_event)
> +	if (unlikely(is_slots_count(event)) && x86_pmu.update_topdown_event)
>  		return x86_pmu.update_topdown_event(event);
> 
>  	/*
> @@ -1280,11 +1280,10 @@ int x86_perf_event_set_period(struct perf_event
> *event)
>  	s64 period = hwc->sample_period;
>  	int ret = 0, idx = hwc->idx;
> 
> -	if (unlikely(!hwc->event_base))
> +	if (unlikely(!hwc->event_base || is_metric_event(event)))
>  		return 0;
> 
> -	if (unlikely(is_topdown_count(event)) &&
> -	    x86_pmu.set_topdown_event_period)
> +	if (unlikely(is_slots_count(event)) && x86_pmu.set_topdown_event_period)
>  		return x86_pmu.set_topdown_event_period(event);
> 
>  	/*

This; I don't like that much, it adds even more conditions to fairly hot
code.

I was even considering adding a static_branch for
x86_pmu.intel_cap.perf_metrics.

Anyway, let me fix this.
