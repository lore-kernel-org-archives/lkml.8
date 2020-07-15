Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1433C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9844820663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCQYqHda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGODJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgGODJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:09:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C5C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:09:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t6so1323512plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R8Gi68qr1aDvO0QyibD3Pq2zcXF2jU6VWUvfFWeUSio=;
        b=mCQYqHdaeQKSdh/0G0+UcnKbrk3gam4BRinxdpoSmGWJoo7YCrXU1HXoo+l5rldKPl
         35He1pWMZF9+F9lDMZ/nN7jyxZJKlRGDfK/7qZh0qgnwbam4p/hkHtbfSI7oUXsU2MYb
         Cl+PWrpd57mmjpgbe9ZokVqqcc23el1nAOtpj4e4lZMjeIEieffTfWhCh5sYaAZxbY0f
         cj8Y2A3l/aKfqUHGS48stXID25o58xi/YqXfV+8OlDK+hbdWvRENKfBx96v9J21XA8MR
         XbeQrkCgsBNXAIX4Fy0Wa8z3FfdSfjqYRN7X6lpEEm36Z9uwGzkz8f8D2M1DjKiUWxtg
         tJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R8Gi68qr1aDvO0QyibD3Pq2zcXF2jU6VWUvfFWeUSio=;
        b=a3VuJKzCJgDekAm3kS3TjbE0XNDThOx4CNJHCoCrKQav/xZImj9B5nmgrI5M2a3D0L
         jGlfGhHre15CbCwQPUr779HvcJ88XC7VEQu67yB/a3C21g0ET7z32tyCTlMVrfXGtlHy
         B+MHbtIRQEdLXj3dto4uYrwvwpqvWwmhcdOCKjJiQdxLyKip9DnDhIe2r/g5bSsLsYtp
         6PcHmvs5UU02ZfVsEe1+nRg4+jaL8SXsQcW1CbealRe2WwCVQPLqFHrJgYeQGGGIGABm
         iV39gnyYhN5HdjNOJw4EBi0UYHw5nZ3/8Vnh9RhbsL78O1WsGzONNNQy9nqnghhsPjw/
         +RnA==
X-Gm-Message-State: AOAM533jmiAbsAxwuitkpyL4IYmuo4+ARwo12IaGksBGiq7N47oPqo7w
        bGVf3HA++BCBAaAFL3cvdY+RoA==
X-Google-Smtp-Source: ABdhPJxLkRpCAh56OHvV9+ruY7Vzg+a1Z9+GxC17tANOkAOMf1eHdhsH69mrQ3UVDo33lzSRWmiORw==
X-Received: by 2002:a17:902:82cb:: with SMTP id u11mr6359503plz.207.1594782588903;
        Tue, 14 Jul 2020 20:09:48 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id ml8sm369552pjb.47.2020.07.14.20.09.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:09:48 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:39:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/13] cpufreq: powernv-cpufreq: Fix a bunch of kerneldoc
 related issues
Message-ID: <20200715030946.xxetozdxe5slvoid@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-8-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714145049.2496163-8-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-20, 15:50, Lee Jones wrote:
> Repair problems with formatting and missing attributes/parameters, and
> demote header comments which do not meet the required standards
> applicable to kerneldoc.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/cpufreq/powernv-cpufreq.c:84: warning: Function parameter or member 'last_lpstate_idx' not described in 'global_pstate_info'
>  drivers/cpufreq/powernv-cpufreq.c:84: warning: Function parameter or member 'last_gpstate_idx' not described in 'global_pstate_info'
>  drivers/cpufreq/powernv-cpufreq.c:84: warning: Function parameter or member 'policy' not described in 'global_pstate_info'
>  drivers/cpufreq/powernv-cpufreq.c:182: warning: Function parameter or member 'i' not described in 'idx_to_pstate'
>  drivers/cpufreq/powernv-cpufreq.c:201: warning: Function parameter or member 'pstate' not described in 'pstate_to_idx'
>  drivers/cpufreq/powernv-cpufreq.c:670: warning: Function parameter or member 't' not described in 'gpstate_timer_handler'
>  drivers/cpufreq/powernv-cpufreq.c:670: warning: Excess function parameter 'data' description in 'gpstate_timer_handler'
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 068cc53abe320..2e5a8b8a4abaa 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -64,13 +64,14 @@
>   *				highest_lpstate_idx
>   * @last_sampled_time:		Time from boot in ms when global pstates were
>   *				last set
> - * @last_lpstate_idx,		Last set value of local pstate and global
> - * last_gpstate_idx		pstate in terms of cpufreq table index
> + * @last_lpstate_idx:		Last set value of local pstate and global
> + * @last_gpstate_idx:		pstate in terms of cpufreq table index
>   * @timer:			Is used for ramping down if cpu goes idle for
>   *				a long time with global pstate held high
>   * @gpstate_lock:		A spinlock to maintain synchronization between
>   *				routines called by the timer handler and
>   *				governer's target_index calls
> + * @policy:			Associated CPUFreq policy
>   */
>  struct global_pstate_info {
>  	int highest_lpstate_idx;
> @@ -170,7 +171,7 @@ static inline u8 extract_pstate(u64 pmsr_val, unsigned int shift)
>  
>  /* Use following functions for conversions between pstate_id and index */
>  
> -/**
> +/*
>   * idx_to_pstate : Returns the pstate id corresponding to the
>   *		   frequency in the cpufreq frequency table
>   *		   powernv_freqs indexed by @i.
> @@ -188,7 +189,7 @@ static inline u8 idx_to_pstate(unsigned int i)
>  	return powernv_freqs[i].driver_data;
>  }
>  
> -/**
> +/*
>   * pstate_to_idx : Returns the index in the cpufreq frequencytable
>   *		   powernv_freqs for the frequency whose corresponding
>   *		   pstate id is @pstate.
> @@ -660,7 +661,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
>  /**
>   * gpstate_timer_handler
>   *
> - * @data: pointer to cpufreq_policy on which timer was queued
> + * @t: Timer context used to fetch global pstate info struct
>   *
>   * This handler brings down the global pstate closer to the local pstate
>   * according quadratic equation. Queues a new timer if it is still not equal

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
