Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C1DC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 05:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C672A20720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 05:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vbjF9SHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgBGFJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 00:09:05 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:36606 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbgBGFJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 00:09:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581052143; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=az7UVPDnqJfTy5NU0q+er7fVoQgHc3LZZHKtm3lVT4w=; b=vbjF9SHo14cyhzoKYfj4mCkWwSL//MdN5nw/27hFxddhAceEUXVKcb9tCZtHe29YiHhL7RPi
 N/s77/746zP7f0gBBU/Il39ZfkXkN5cw6pau7A3msCYShyr6dwJs4sf+naegGeH8NY6jqY1F
 O7wYoN5uHixQwgfzZVXJ6e3FCOs=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3cf0ee.7f7897d5e5a8-smtp-out-n03;
 Fri, 07 Feb 2020 05:09:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3BB5BC4479C; Fri,  7 Feb 2020 05:09:02 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A87FC43383;
        Fri,  7 Feb 2020 05:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A87FC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Fri, 7 Feb 2020 10:38:54 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH v4 1/4] sched/fair: Add asymmetric CPU capacity wakeup
 scan
Message-ID: <20200207050854.GF27398@codeaurora.org>
References: <20200206191957.12325-1-valentin.schneider@arm.com>
 <20200206191957.12325-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206191957.12325-2-valentin.schneider@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 07:19:54PM +0000, Valentin Schneider wrote:
> From: Morten Rasmussen <morten.rasmussen@arm.com>
> 

<snip>

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fe4e0d7753756..9a5a6e9d2375e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5894,6 +5894,40 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	return cpu;
>  }
>  
> +/*
> + * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
> + * the task fits. If no CPU is big enough, but there are idle ones, try to
> + * maximize capacity.
> + */
> +static int
> +select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> +{
> +	unsigned long best_cap = 0;
> +	int cpu, best_cpu = -1;
> +	struct cpumask *cpus;
> +
> +	sync_entity_load_avg(&p->se);
> +
> +	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +
> +	for_each_cpu_wrap(cpu, cpus, target) {
> +		unsigned long cpu_cap = capacity_of(cpu);
> +
> +		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> +			continue;
> +		if (task_fits_capacity(p, cpu_cap))
> +			return cpu;
> +
> +		if (cpu_cap > best_cap) {
> +			best_cap = cpu_cap;
> +			best_cpu = cpu;
> +		}
> +	}
> +
> +	return best_cpu;
> +}
> +
>  /*
>   * Try and locate an idle core/thread in the LLC cache domain.
>   */
> @@ -5902,6 +5936,28 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	struct sched_domain *sd;
>  	int i, recent_used_cpu;
>  
> +	/*
> +	 * For asymmetric CPU capacity systems, our domain of interest is
> +	 * sd_asym_cpucapacity rather than sd_llc.
> +	 */
> +	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> +		sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
> +		/*
> +		 * On an asymmetric CPU capacity system where an exclusive
> +		 * cpuset defines a symmetric island (i.e. one unique
> +		 * capacity_orig value through the cpuset), the key will be set
> +		 * but the CPUs within that cpuset will not have a domain with
> +		 * SD_ASYM_CPUCAPACITY. These should follow the usual symmetric
> +		 * capacity path.
> +		 */
> +		if (!sd)
> +			goto symmetric;
> +
> +		i = select_idle_capacity(p, sd, target);
> +		return ((unsigned)i < nr_cpumask_bits) ? i : target;
> +	}
> +
> +symmetric:
>  	if (available_idle_cpu(target) || sched_idle_cpu(target))
>  		return target;
>  
> -- 
> 2.24.0
> 

Looks good to me.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
