Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00071C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE069206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="daSDd8Yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgELODD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgELODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:03:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CCCC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:03:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b190so652969pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KPYkLoC2C4Sk/B5wg5r+gTORkTgExyx51OnDHmLxSUM=;
        b=daSDd8Ykcoy3ZAgXDfNp4Qq7j5H15ZyalpHRs1vZcye7jWW948+4CnUfx5QZKxEMRS
         Ph2k67EtLEwvVEAhajcDTkiOmNkNlbtfCowAiI4ciquyj+VakuEd6nss0GnWvuyy1HaU
         My6VjjZg4Wm2A5yo36QDUijDCMnGv2ei+ptMcKRnmyWan+YOYREjwR8wttEz8mys8lLO
         t0zQvvWT8xCwxpmdG/xlSRsHnbl/awwZ6JSwhexTxDD9UEMfJ3bL2ct5/bR8AvxUsZWT
         YrwXMcRVUCCuAF/sjsE/0T1VmPGC7A0bTKISpMi4m1VHRUWL3vslSIurwXm+mI6TlAss
         POBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KPYkLoC2C4Sk/B5wg5r+gTORkTgExyx51OnDHmLxSUM=;
        b=JyTvBIdbhvVH1r5XjCLt3Ap8wri4htUQUNTbX8a0mc2veE5889oouh/NQCmSlxFgh7
         bCauC568iSN5bybrfhJxwmU9FkfrJvJPtE9ON985mnTOduHhmcy9gvrzxsF+JI3jNA/c
         0f2IY12/qG4P5cSmay6DJnvl03cCjpHqIbPActSYNroJPsg2ebRqOLsDp7leuB0fO4Ht
         fiF3liINHEQ5qZHck8CTnp6nzOG/faYj5mYlSB19o+KRQOAl8YuxFlLYz1wTaEI6w0gL
         v1OzEonNSSE5iEPoJao2hwN/UZOyxoZhmsFaA3h6+ddN/bAfXA+kfDyg0IRpDmL+/HPT
         aUTg==
X-Gm-Message-State: AGi0PuZjianNL5k3cmoX7xXu0Pw+zJNtLCSqZacBM86ka+yU71gHcxR+
        +rhHscCMuKCXPTk45BLmbTXaKw==
X-Google-Smtp-Source: APiQypKllb4iXt3nc66JTP97CFDAti23azw7/y3W2VOej8f/d+P0OaTmD8JGFLP50XpX306Bk/r5DA==
X-Received: by 2002:a63:d909:: with SMTP id r9mr18992558pgg.245.1589292180928;
        Tue, 12 May 2020 07:03:00 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id t12sm10581769pgm.37.2020.05.12.07.02.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 07:03:00 -0700 (PDT)
Date:   Tue, 12 May 2020 22:03:01 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        sboyd@codeaurora.org, john.stultz@linaro.org
Subject: Re: [PATCH 2/5] arm64: perf: Implement correct cap_user_time
Message-ID: <20200512140301.GC20352@leoy-ThinkPad-X240s>
References: <20200512124058.833263033@infradead.org>
 <20200512124450.824507755@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512124450.824507755@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, May 12, 2020 at 02:41:00PM +0200, Peter Zijlstra wrote:
> As reported by Leo; the existing implementation is broken when the
> clock and counter don't intersect at 0.
> 
> Use the sched_clock's struct clock_read_data information to correctly
> implement cap_user_time and cap_user_time_zero.
> 
> Note that the ARM64 counter is architecturally only guaranteed to be
> 56bit wide (implementations are allowed to be wider) and the existing
> perf ABI cannot deal with wrap-around.
> 
> This implementation should also be faster than the old; seeing how we
> don't need to recompute mult and shift all the time.
> 
> Reported-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/kernel/perf_event.c |   36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  #include <linux/perf/arm_pmu.h>
>  #include <linux/platform_device.h>
> +#include <linux/sched_clock.h>
>  #include <linux/smp.h>
>  
>  /* ARMv8 Cortex-A53 specific event types. */
> @@ -1165,28 +1166,45 @@ device_initcall(armv8_pmu_driver_init)
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
> +		userpg->time_zero = rd->epoch_ns;
> +
> +		/*
> +		 * This isn't strictly correct, the ARM64 counter can be
> +		 * 'short' and then we get funnies when it wraps. The correct
> +		 * thing would be to extend the perf ABI with a cycle and mask
> +		 * value, but because wrapping on ARM64 is very rare in
> +		 * practise this 'works'.
> +		 */
> +		userpg->time_zero -= (rd->epoch_cyc * rd->mult) >> rd->shift;
> +
> +	} while (sched_clock_read_retry(seq));
> +
> +	userpg->time_offset = userpg->time_zero - now;
>  
> -	clocks_calc_mult_shift(&userpg->time_mult, &shift, freq,
> -			NSEC_PER_SEC, 0);
>  	/*
>  	 * time_shift is not expected to be greater than 31 due to
>  	 * the original published conversion algorithm shifting a
>  	 * 32-bit value (now specifies a 64-bit value) - refer
>  	 * perf_event_mmap_page documentation in perf_event.h.
>  	 */
> -	if (shift == 32) {
> -		shift = 31;
> +	if (userpg->shift == 32) {

Thanks a lot for the patch set, some typos:

s/shift/time_shift

> +		userpg->shift = 31;

s/shift/time_shift

Thanks,
Leo

>  		userpg->time_mult >>= 1;
>  	}
> -	userpg->time_shift = (u16)shift;
> -	userpg->time_offset = -now;
> +
>  }
> 
> 
