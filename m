Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F514C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 01:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E84B208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 01:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaLcJN72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbgDABYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:24:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35941 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731509AbgDABYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 21:24:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id i13so11255751pfe.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 18:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Aw32lMi9SSDdJS5PfKnpiYWuSlV1WvfCQUy80vI+qqk=;
        b=HaLcJN72XZVuHbNNMetMUznMmDpsKnTpYIJ9YHL/1gep0jJFppLHcKhmxVhroiS7ey
         IRgCd+xMQpwRt+jKzOlB6ycHB/8oF6QtmttD0+KEEId8fo/h4vW8OPRbh8WF4VgU9DAb
         ymETk39riy8JVKNSpp7zUMf8lAYTshHf+lC3gF7Y7LKS8ALP+9uiLCPlX5/2WNTISwqM
         2WZXtCTkWbFgsKZeHXWp0AenuxHRI6ai3WmKZHnh4GtLCIdj4d5pJCm2e/oW63Pki1Sh
         HI7IXhcz7aVonrE8Dp72e2UtZ7bjBzlK7sBxf3a3VAJ47R+4hbwaGtJp17pl8ZMWdIN3
         NHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Aw32lMi9SSDdJS5PfKnpiYWuSlV1WvfCQUy80vI+qqk=;
        b=kweLmAdkIHl28hNN5kFne4RTUaJDj2kCfCgfXQu7cSZJvcoQtx0yV2ru4Yv8fjxP4f
         sgbLv12y8XEiIVU0dw0ejYpIg71KojHJi2UXLENZZYNPZh/aUiMKbnt6N4IzgwNqb61f
         MAQcUYUNFzLRwRraYqWyEbkYNYEDnGRPZbyTv1yBqz/DCTdbVljxv1FpEPCXTd0FGTs4
         AdZM+2Xtv28Rx8s2ytnY00j0FvCKBQ+9ig1cYqJCU45LU9z3utHmYa0fDGYJfLjJarZ2
         u6j5brqH51G868XVsyFVw11qD8CGMtkmFWszAWTn45wzcup180sSNEFnOabtIdCpVZ0q
         4UNw==
X-Gm-Message-State: ANhLgQ0uyu9JlkWgBLWXvZcfQ+aA+g5CB/gXWdgmwtue84nfy7DqQYlW
        KvYv7uZZSHpMHQx3QAhUXmo66A==
X-Google-Smtp-Source: ADFU+vuQYD73cKPi5MMZYK2oJY21kLohB/7K+vWuJRBeR3x3mkSkcST9YRUWoKenBnXiX4Mxu/XGTA==
X-Received: by 2002:a63:c451:: with SMTP id m17mr20319106pgg.223.1585704271012;
        Tue, 31 Mar 2020 18:24:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2400:8902::f03c:91ff:fe3f:32da])
        by smtp.gmail.com with ESMTPSA id q27sm297876pfn.173.2020.03.31.18.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Mar 2020 18:24:30 -0700 (PDT)
Date:   Wed, 1 Apr 2020 09:24:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
        Al Grant <Al.Grant@arm.com>, James Clark <James.Clark@arm.com>
Subject: Re: [PATCH] arm64: perf_event: Fix time_offset for arch timer
Message-ID: <20200401012417.GA9892@leoy-ThinkPad-X240s>
References: <20200320093545.28227-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320093545.28227-1-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm64/kernel/perf_event.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Gentle ping ...

Hi Mike R., Peter,

If possible, could you give a look for this patch?

Thank you,
Leo

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
>  }
> -- 
> 2.17.1
> 
