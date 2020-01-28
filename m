Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC057C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0D12467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ua+vjhu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgA1GXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 01:23:01 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:37623 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgA1GXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 01:23:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580192580; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=rrWOOkDR3OWSLbm13jKGj6HmMXK8D2MqiwP/1r6uC4k=; b=ua+vjhu8rCyPtzjMw7m/R1cYOwK7J/X7r9PDUr/M4IdQyNVJROLi9E35H7xO9XxpDhQ4BxaN
 5SA2EIV9BpW2ueqpg2wVhD6pWmoH26DRrCBHkXxqZRJU1P5TC3T+j10Bu9R+A3X9IeUFtw9f
 cVYzbLNTkwguMcdQb6aRsrHiifk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2fd33d.7f605ec6c378-smtp-out-n01;
 Tue, 28 Jan 2020 06:22:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 30428C447A3; Tue, 28 Jan 2020 06:22:53 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D995C43383;
        Tue, 28 Jan 2020 06:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D995C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 28 Jan 2020 11:52:45 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH v3 1/3] sched/fair: Add asymmetric CPU capacity wakeup
 scan
Message-ID: <20200128062245.GA27398@codeaurora.org>
References: <20200126200934.18712-1-valentin.schneider@arm.com>
 <20200126200934.18712-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126200934.18712-2-valentin.schneider@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Sun, Jan 26, 2020 at 08:09:32PM +0000, Valentin Schneider wrote:
>  
> +static inline int check_cpu_capacity(struct rq *rq, struct sched_domain *sd);
> +
> +/*
> + * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
> + * the task fits. If no CPU is big enough, but there are idle ones, try to
> + * maximize capacity.
> + */
> +static int select_idle_capacity(struct task_struct *p, int target)
> +{
> +	unsigned long best_cap = 0;
> +	struct sched_domain *sd;
> +	struct cpumask *cpus;
> +	int best_cpu = -1;
> +	struct rq *rq;
> +	int cpu;
> +
> +	if (!static_branch_unlikely(&sched_asym_cpucapacity))
> +		return -1;
> +
> +	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
> +	if (!sd)
> +		return -1;
> +
> +	sync_entity_load_avg(&p->se);
> +
> +	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +
> +	for_each_cpu_wrap(cpu, cpus, target) {
> +		rq = cpu_rq(cpu);
> +
> +		if (!available_idle_cpu(cpu))
> +			continue;
> +		if (task_fits_capacity(p, rq->cpu_capacity))
> +			return cpu;

I have couple of questions.

(1) Any particular reason for not checking sched_idle_cpu() as a backup
for the case where all eligible CPUs are busy? select_idle_cpu() does
that.

(2) Assuming all CPUs are busy, we return -1 from here and end up
calling select_idle_cpu(). The traversal in select_idle_cpu() may be
waste in cases where sd_llc == sd_asym_cpucapacity . For example SDM845.
Should we worry about this?

> +
> +		/*
> +		 * It would be silly to keep looping when we've found a CPU
> +		 * of highest available capacity. Just check that it's not been
> +		 * too pressured lately.
> +		 */
> +		if (rq->cpu_capacity_orig == READ_ONCE(rq->rd->max_cpu_capacity) &&
> +		    !check_cpu_capacity(rq, sd))
> +			return cpu;
> +
> +		if (rq->cpu_capacity > best_cap) {
> +			best_cap = rq->cpu_capacity;
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
> @@ -5902,6 +5956,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	struct sched_domain *sd;
>  	int i, recent_used_cpu;
>  
> +	/* For asymmetric capacities, try to be smart about the placement */
> +	i = select_idle_capacity(p, target);
> +	if ((unsigned)i < nr_cpumask_bits)
> +		return i;
> +
>  	if (available_idle_cpu(target) || sched_idle_cpu(target))
>  		return target;
>  
> -- 
> 2.24.0
> 

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
