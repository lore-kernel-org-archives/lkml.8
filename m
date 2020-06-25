Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DC1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40AB20679
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ubk1Hqqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404022AbgFYKYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403899AbgFYKXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:23:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF3C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 03:23:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so3074094pge.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 03:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aD0Mm08bVawc8uNEZ8jOYlVBKSND1d88I7GODmq3fsk=;
        b=ubk1HqqiONXNwRyZOSAqaegZ688nbffSZAhNPWm5ubGgemju0MhV7Zj+Qw0nPU2Kr4
         ymfAXK71pWR5Q0VooRWKs2fi5wA3sCheKoM7d9I64mgi3UdQEAYRmKhwMGarOGxnJsUv
         5SSUGfPO3q7yVF5xhRnPNvPocbDqKEM2Lp4AZYSSIAJJlgmG4d3nDchw2oncY3HZ9LOR
         4tyxLyAnWh0oWIhRtt9kB2dodpKcxX+zgs5A3B/FYyB8BTPBpQEgdfBW3nMoOsZwoCKr
         /7FSSntstxKukbfkBRLkjswV/ZwYBQ7A8y0mZpDbzrf4Xp9k20mT4GJhbPjc78m3I15a
         LtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aD0Mm08bVawc8uNEZ8jOYlVBKSND1d88I7GODmq3fsk=;
        b=g+wIn9tWAvQQeAqev6Yce2+wdZ4hu2RSJBntGzTfhm+gFrWf6hmNTV83X1ItJYfbdb
         Zu8xk2Z8X5Pb4XalI2ljQrBcEmv2plJiQI1ijLuPxMQlArC/4PKqf6I6vLpK/LnNb1bd
         Ems3GKBraQCPa8Q1bkIvQf7gVQFB38B8gOV4xQH3ztrVgEHUNYFzHyITTW1eRZx4/Szq
         1dnVjzMsRcWeTaAU+DxTELM/2Qyxnz6bfDSmymtPsLzUiQ35Pcm5Fc3chnIOZXdMvjKH
         fME+Ue5r0/GqLi+dkEa3Mawy61NNrVxjni8sK041zLh9s3xIkL7KLbq3NDnFQ6xUIQ0R
         A85Q==
X-Gm-Message-State: AOAM531nzwDoE5KlSK0c64qdF76/0FMJTPZe6kwfh5QtAJkBCBfIgnFV
        QEKrzXcxhNdgAGDzQfBsrUmCdw==
X-Google-Smtp-Source: ABdhPJz+vvs7ucfRpTcH9x/tx9udaUViA11z9lggnKo40W0iLSSK71beKRar6taPK95ziaUYxrA7rg==
X-Received: by 2002:a63:7f17:: with SMTP id a23mr19440822pgd.3.1593080587955;
        Thu, 25 Jun 2020 03:23:07 -0700 (PDT)
Received: from localhost ([122.172.111.76])
        by smtp.gmail.com with ESMTPSA id 4sm19566182pgk.68.2020.06.25.03.23.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 03:23:07 -0700 (PDT)
Date:   Thu, 25 Jun 2020 15:53:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, dsmythies@telus.net,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: force frequency update when limits
 change
Message-ID: <20200625102305.gu3xo4ovcqyd35vd@vireshk-i7>
References: <20200625064614.101183-1-wvw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625064614.101183-1-wvw@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-06-20, 23:46, Wei Wang wrote:
> To avoid reducing the frequency of a CPU prematurely, we skip reducing
> the frequency if the CPU had been busy recently.
> 
> This should not be done when the limits of the policy are changed, for
> example due to thermal throttling. We should always get the frequency
> within the new limits as soon as possible.
> 
> There was a fix in
> commit 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when
> limits change") upstream which introduced another flag. However, the
> fix didn't address the case when next_freq is the same as previously
> voted, which is then checked in sugov_update_next_freq. As a result, the
> frequency would be stuck at low until the high demanding workload quits.
> 
> test trace:
>   kworker/u19:0-1872  ( 1872) [002] ....   347.878871: cpu_frequency_limits: min=600000 max=2348000 cpu_id=6
>          dhry64-11525 (11525) [007] d.h2   347.880012: sugov_should_update_freq: thermal limit on policy6
>          dhry64-11525 (11525) [007] d.h2   347.880012: sugov_deferred_update: policy6 skipped update
>          dhry64-11525 (11525) [007] d.h2   347.884040: sugov_deferred_update: policy6 skipped update

I am not sure these are helpful in the logs as the code which
generated them isn't there in the kernel.

> ...
> 
> This patch fixes this by skipping the check and forcing an update in
> this case. The second flag was kept as the limits_change flag could be
> updated in thermal kworker from another CPU.

I am sorry but I am not fully sure of what the problem is. Can you
describe that by giving an example with some random frequency, and
tell the expected and actual behavior ?

> Fixes: ecd288429126 ("cpufreq: schedutil: Don't set next_freq to UINT_MAX")
> Signed-off-by: Wei Wang <wvw@google.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 7fbaee24c824..dc2cd768022e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -102,11 +102,12 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>  				   unsigned int next_freq)
>  {
> -	if (sg_policy->next_freq == next_freq)
> +	if (!sg_policy->need_freq_update && sg_policy->next_freq == next_freq)

AFAIU, if the next freq is same as currently programmed one, there is
no need to force update it.

>  		return false;
>  
>  	sg_policy->next_freq = next_freq;
>  	sg_policy->last_freq_update_time = time;
> +	sg_policy->need_freq_update = false;
>  
>  	return true;
>  }
> @@ -178,7 +179,6 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>  		return sg_policy->next_freq;
>  
> -	sg_policy->need_freq_update = false;
>  	sg_policy->cached_raw_freq = freq;
>  	return cpufreq_driver_resolve_freq(policy, freq);
>  }
> -- 
> 2.27.0.212.ge8ba1cc988-goog

-- 
viresh
