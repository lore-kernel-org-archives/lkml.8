Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AADC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F2420720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bw9pWzuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgEKJZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgEKJZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:25:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E67AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7OpLvp7YfGNXUn/7bmt46LHF/81ym1CQ5UJOWVJ8sXM=; b=bw9pWzucX7lwVrw5hdscf/FaH3
        tVKEZ8XHj2OCsaTCWh7e+7Y3yBDs0dRTGLQBI4gAQydkCRQAeYpWx2HvFPDQDPiAnB7L9u1IU0S/K
        AbjjFg9MyrX9VUqCvAN83HdPgtjd0yFI60AM3gJqqlgfxgHx+kmuANHXbzk9bhiZoqmO53b3J5C7B
        DIVfWBVfYOMAnhPcylvrPbpHD2BjEWan7A6XAkFcdPYTTzd8YAzGKTC3LFkwRcIa7rHM+ZBUgEf0o
        sd73WiufpDAztuzRahM4g98l1bBzE4Ne9qq7anWf6340IvqOTshcMdKH/W7Iw4TBprd+16tnUWUUq
        iU/zByWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY4gb-0006eF-BY; Mon, 11 May 2020 09:25:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59922301A80;
        Mon, 11 May 2020 11:25:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 450F2203C0863; Mon, 11 May 2020 11:25:19 +0200 (CEST)
Date:   Mon, 11 May 2020 11:25:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64: perf_event: Fix time offset prior to epoch
Message-ID: <20200511092519.GA3001@hirez.programming.kicks-ass.net>
References: <20200505135544.6003-1-leo.yan@linaro.org>
 <20200511092200.GF2957@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511092200.GF2957@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 11:22:00AM +0200, Peter Zijlstra wrote:

> (_completely_ untested)
> 
> ---
>  arch/arm64/kernel/perf_event.c | 27 ++++++++++++++++++---------
>  include/linux/sched_clock.h    | 28 ++++++++++++++++++++++++++++
>  kernel/time/sched_clock.c      | 41 +++++++++++++----------------------------
>  3 files changed, 59 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 4d7879484cec..81a49a916660 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1165,28 +1165,37 @@ device_initcall(armv8_pmu_driver_init)
>  void arch_perf_update_userpage(struct perf_event *event,
>  			       struct perf_event_mmap_page *userpg, u64 now)
>  {
> -	u32 freq;
> -	u32 shift;
> +	struct clock_read_data *rd;
> +	unsigned int seq;
>  
>  	/*
>  	 * Internal timekeeping for enabled/running/stopped times
>  	 * is always computed with the sched_clock.
>  	 */
> -	freq = arch_timer_get_rate();
>  	userpg->cap_user_time = 1;
> +	userpg->cap_user_time_zero = 1;
> +
> +	do {
> +		rd = sched_clock_read_begin(&seq);
> +
> +		userpg->time_mult = rd->mult;
> +		userpg->time_shift = rd->shift;
> +		userpg->time_offset = rd->epoch_ns;

			^^^^^^^ wants to be time_zero

> +
> +		userpg->time_zero -= (rd->epoch_cyc * rd->shift) >> rd->shift;
> +
> +	} while (sched_clock_read_retry(seq));
> +
> +	userpg->time_offset = userpf->time_zero - now;
>  
> -	clocks_calc_mult_shift(&userpg->time_mult, &shift, freq,
> -			NSEC_PER_SEC, 0);

And that ^^^ was complete crap.

>  	/*
>  	 * time_shift is not expected to be greater than 31 due to
>  	 * the original published conversion algorithm shifting a
>  	 * 32-bit value (now specifies a 64-bit value) - refer
>  	 * perf_event_mmap_page documentation in perf_event.h.
>  	 */
> -	if (shift == 32) {
> -		shift = 31;
> +	if (userpg->time_shift == 32) {
> +		userpg->time_shift = 31;
>  		userpg->time_mult >>= 1;
>  	}
> -	userpg->time_shift = (u16)shift;
> -	userpg->time_offset = -now;
>  }
