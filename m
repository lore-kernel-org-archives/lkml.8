Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6F9C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8870920722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCSKaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:30:21 -0400
Received: from foss.arm.com ([217.140.110.172]:33052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgCSKaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:30:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE52A31B;
        Thu, 19 Mar 2020 03:30:20 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B91653F305;
        Thu, 19 Mar 2020 03:30:19 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 8/9] sched/fair: Split select_task_rq_fair want_affine
 logic
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
References: <20200311181601.18314-1-valentin.schneider@arm.com>
 <20200311181601.18314-9-valentin.schneider@arm.com>
Message-ID: <c0a1f683-f5c5-cd95-a586-28cc1da9fc3d@arm.com>
Date:   Thu, 19 Mar 2020 11:30:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311181601.18314-9-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.20 19:16, Valentin Schneider wrote:

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f98dac0c7f82..a6fca6817e92 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6620,26 +6620,33 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  	}
>  
>  	rcu_read_lock();
> +
> +	sd = highest_flag_domain(cpu, sd_flag);
> +
> +	/*
> +	 * If !want_affine, we just look for the highest domain where
> +	 * sd_flag is set.
> +	 */
> +	if (!want_affine)
> +		goto scan;
> +
> +	/*
> +	 * Otherwise we look for the lowest domain with SD_WAKE_AFFINE and that
> +	 * spans both 'cpu' and 'prev_cpu'.
> +	 */
>  	for_each_domain(cpu, tmp) {
> -		/*
> -		 * If both 'cpu' and 'prev_cpu' are part of this domain,
> -		 * cpu is a valid SD_WAKE_AFFINE target.
> -		 */
> -		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
> +		if ((tmp->flags & SD_WAKE_AFFINE) &&
>  		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
>  			if (cpu != prev_cpu)
>  				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
>  
> -			sd = NULL; /* Prefer wake_affine over balance flags */
> +			/* Prefer wake_affine over SD lookup */

I assume that 'balance flags' stands for (wakeup) load balance, i.e.
find_idlest_xxx() path. So why change it?


[...]
