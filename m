Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F19C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4292C2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588258712;
	bh=qlM9az2Mu6qcrDqC7rjQnCbfEc3OOne2AKmDVHC22QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c5oM1LMUagpi911lA9FFjFz9wbPL3QLMCE6oVFkaPyQLEPXonn/ZzD3a289YrEiUL
	 zKRhf3ISAlmCXPv5p9x7GJ3HVbghlLJCvPiLDjbdCNiMoWxsggk6U8uotNct3fYsug
	 X9zMIrZdJ5LWjpE2Umh7Cef8+HJBBCW053EpuSz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgD3O6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgD3O6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:58:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF7A62076D;
        Thu, 30 Apr 2020 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588258710;
        bh=qlM9az2Mu6qcrDqC7rjQnCbfEc3OOne2AKmDVHC22QM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufCxGIZFIcDmQiW1DSEmDR/KL8XoZubTDhSgr2RlZfEeFvCfjUgaVoVSBEWLylpCZ
         o1VuspeFLXTSHKQrsReeaBhxtbh1Zv0punWbMc/vMeb+2qTgbRNeC8E27QcmnDBtI/
         aZnWmQGYO6rQvKAZ4o96/6YsS80P71vZYvIrfrwU=
Date:   Thu, 30 Apr 2020 15:58:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Al Grant <Al.Grant@arm.com>, James Clark <James.Clark@arm.com>,
        maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] arm64: perf_event: Fix time_offset for arch timer
Message-ID: <20200430145823.GA25258@willie-the-truck>
References: <20200320093545.28227-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320093545.28227-1-leo.yan@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

[+Maz and tglx in case I'm barking up the wrong tree]

On Fri, Mar 20, 2020 at 05:35:45PM +0800, Leo Yan wrote:
> Between the system powering on and kernel's sched clock registration,
> the arch timer usually has been enabled at the early time and its
> counter is incremented during the period of the booting up.  Thus the
> arch timer's counter is not completely accounted into the sched clock,
> and has a delta between the arch timer's counter and sched clock.  This
> delta value should be stored into userpg->time_offset, which later can
> be retrieved by Perf tool in the user space for sample timestamp
> calculation.
> 
> Now userpg->time_offset is assigned to the negative sched clock with
> '-now', this value cannot reflect the delta between arch timer's counter
> and sched clock, so Perf cannot use it to calculate the sample time.
> 
> To fix this issue, this patch calculate the delta between the arch
> timer's and sched clock and assign the delta to userpg->time_offset.
> The detailed steps are firstly to convert counter to nanoseconds 'ns',
> then the offset is calculated as 'now' minus 'ns'.
> 
>         |<------------------- 'ns' ---------------------->|
>                                 |<-------- 'now' -------->|
>         |<---- time_offset ---->|
>         |-----------------------|-------------------------|
>         ^                       ^                         ^
>   Power on system     sched clock registration      Perf starts

FWIW, I'm /really/ struggling to understand the problem here.

If I've grokked it correctly (big 'if'), then you can't just factor in
what you call "time_offset" in the diagram above, because there isn't
a guarantee that the counter is zero-initialised at the start.

> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm64/kernel/perf_event.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index e40b65645c86..226d25d77072 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1143,6 +1143,7 @@ void arch_perf_update_userpage(struct perf_event *event,
>  {
>  	u32 freq;
>  	u32 shift;
> +	u64 count, ns, quot, rem;
>  
>  	/*
>  	 * Internal timekeeping for enabled/running/stopped times
> @@ -1164,5 +1165,21 @@ void arch_perf_update_userpage(struct perf_event *event,
>  		userpg->time_mult >>= 1;
>  	}
>  	userpg->time_shift = (u16)shift;
> -	userpg->time_offset = -now;
> +
> +	/*
> +	 * Since arch timer is enabled ealier than sched clock registration,
> +	 * compuate the delta (in nanosecond unit) between the arch timer
> +	 * counter and sched clock, assign the delta to time_offset and
> +	 * perf tool can use it for timestamp calculation.
> +	 *
> +	 * The formula for conversion arch timer cycle to ns is:
> +	 *   quot = (cyc >> time_shift);
> +	 *   rem  = cyc & ((1 << time_shift) - 1);
> +	 *   ns   = quot * time_mult + ((rem * time_mult) >> time_shift);
> +	 */
> +	count = arch_timer_read_counter();
> +	quot = count >> shift;
> +	rem = count & ((1 << shift) - 1);
> +	ns = quot * userpg->time_mult + ((rem * userpg->time_mult) >> shift);
> +	userpg->time_offset = now - ns;

Hmm, reading the counter and calculating the delta feels horribly
approximate to me. It would be much better if we could get hold of the
initial epoch cycles from the point at which sched_clock was initialised
using the counter. This represents the true cycle delta between the counter
and what sched_clock uses for 0 ns.

Unfortunately, I can't see a straightforward way to grab that information.
It looks like x86 pulls this directly from the TSC driver.

Will
