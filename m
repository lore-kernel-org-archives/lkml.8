Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4101EC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2F3206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWVm3yEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgELOL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgELOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:11:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD981C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:11:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v63so6417589pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oNVTKHh3BRkv6kZOADjLrXd170DS/xHoo09T4Nrhheo=;
        b=MWVm3yEZ9mSSxyQajWzj0yf8qSW+nGL9S0s54ewsyJafx/WvQOyxCLQrBhyMSZvQBI
         9+5RU5hwl89M8YOWDSjt6f4/MVsC+3kDOJDBDSARox31Kuxn7jHLGyglVlxsea788sgT
         V4vV/qQUdgXTMbsUQSODcwoGY1kuJHDkqWORfkxfPc4M4FzqtyUq4sIAR8OwJlhf5/uC
         xSY/yQqzxK882W9rEvO4OqiH00Gf0eB5n6mez1V5YaXklkw/Z/WYAd9gRZ+27eHIN+fY
         dVUnnUPWj9ivdPH1C988u0jzs2ft6j2po5LglaDe6xSyIs3Cvx/FTFRKO/efDUDp/D4g
         ySLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oNVTKHh3BRkv6kZOADjLrXd170DS/xHoo09T4Nrhheo=;
        b=At8LU53LFO5YDoUbrREnFF+U5VKO6JCMj/mPQQjYCSueml8OfUb/SJOJOLxuPniMzm
         u49wG3BiHs1JP8CzegkmEtCr4c4CyMFVmHzo/PzZx5gSvt2gFEx+CoePaIlLZKx5GSPK
         QCi3gruhkj1SfUmxr4PCxw925STRh+jWJahVTDl3jCNUbSydgZJkzvtHmQgzvIZG07WY
         136n3hiDV4dkon/8kICb0c9Y591sLkiZdDEDmVJSy3Kn8OqgyIilXhCmwparyHxWXZ5G
         DYs8HaHjxm/mYIEafUl04Kl9J0D++jEH5xtmqlP5cPyQOzUaanf/y/gexzNU7YuXcDjP
         U+lQ==
X-Gm-Message-State: AGi0PuYXFR2B77VLMpxi375i9HY5LeXCeBiEv1dmILBMm2lZi0+l1NK6
        XMEPjUcnLrHZ260VyN4t5Oun0w==
X-Google-Smtp-Source: APiQypLB7DTmaAG8KF0rhekx3BS1ffHO8/I3uQtsFt8SfpFqBrT4+h+i1IuZBPTlHiysq1JCJ20Wtw==
X-Received: by 2002:a63:ef02:: with SMTP id u2mr19767305pgh.21.1589292688279;
        Tue, 12 May 2020 07:11:28 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id s199sm12383422pfs.124.2020.05.12.07.11.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 07:11:27 -0700 (PDT)
Date:   Tue, 12 May 2020 22:11:26 +0800
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
Subject: Re: [PATCH 5/5] arm64: perf: Add cap_user_time_short
Message-ID: <20200512141126.GD20352@leoy-ThinkPad-X240s>
References: <20200512124058.833263033@infradead.org>
 <20200512124451.061059334@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512124451.061059334@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 02:41:03PM +0200, Peter Zijlstra wrote:
> This completes the ARM64 cap_user_time support.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/kernel/perf_event.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1173,6 +1173,7 @@ void arch_perf_update_userpage(struct pe
>  
>  	userpg->cap_user_time = 0;
>  	userpg->cap_user_time_zero = 0;
> +	userpg->cap_user_time_short = 0;
>  
>  	do {
>  		rd = sched_clock_read_begin(&seq);
> @@ -1183,13 +1184,13 @@ void arch_perf_update_userpage(struct pe
>  		userpg->time_mult = rd->mult;
>  		userpg->time_shift = rd->shift;
>  		userpg->time_zero = rd->epoch_ns;
> +		userpg->time_cycle = rd->epoch_cyc;

s/time_cycle/time_cycles, maybe consider to change the naming to
'time_cycle'.

This patch set looks good to me after I tested it on Arm64 board.

Thanks,
Leo

> +		userpg->time_mask = rd->sched_clock_mask;
>  
>  		/*
> -		 * This isn't strictly correct, the ARM64 counter can be
> -		 * 'short' and then we get funnies when it wraps. The correct
> -		 * thing would be to extend the perf ABI with a cycle and mask
> -		 * value, but because wrapping on ARM64 is very rare in
> -		 * practise this 'works'.
> +		 * Subtract the cycle base, such that software that
> +		 * doesn't know about cap_user_time_short still 'works'
> +		 * assuming no wraps.
>  		 */
>  		userpg->time_zero -= (rd->epoch_cyc * rd->mult) >> rd->shift;
>  
> @@ -1214,4 +1215,5 @@ void arch_perf_update_userpage(struct pe
>  	 */
>  	userpg->cap_user_time = 1;
>  	userpg->cap_user_time_zero = 1;
> +	userpg->cap_user_time_short = 1;
>  }
> 
> 
