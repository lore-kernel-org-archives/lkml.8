Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF1C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74F224681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgA1Laa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:30:30 -0500
Received: from foss.arm.com ([217.140.110.172]:55464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgA1La3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:30:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB9CB101E;
        Tue, 28 Jan 2020 03:30:28 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 721D13F52E;
        Tue, 28 Jan 2020 03:30:27 -0800 (PST)
Subject: Re: [PATCH v3 1/3] sched/fair: Add asymmetric CPU capacity wakeup
 scan
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
References: <20200126200934.18712-1-valentin.schneider@arm.com>
 <20200126200934.18712-2-valentin.schneider@arm.com>
 <20200128062245.GA27398@codeaurora.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1ed322d6-0325-ecac-cc68-326a14b8c1dd@arm.com>
Date:   Tue, 28 Jan 2020 11:30:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200128062245.GA27398@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On 28/01/2020 06:22, Pavan Kondeti wrote:
> Hi Valentin,
> 
> On Sun, Jan 26, 2020 at 08:09:32PM +0000, Valentin Schneider wrote:
>>  
>> +static inline int check_cpu_capacity(struct rq *rq, struct sched_domain *sd);
>> +
>> +/*
>> + * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
>> + * the task fits. If no CPU is big enough, but there are idle ones, try to
>> + * maximize capacity.
>> + */
>> +static int select_idle_capacity(struct task_struct *p, int target)
>> +{
>> +	unsigned long best_cap = 0;
>> +	struct sched_domain *sd;
>> +	struct cpumask *cpus;
>> +	int best_cpu = -1;
>> +	struct rq *rq;
>> +	int cpu;
>> +
>> +	if (!static_branch_unlikely(&sched_asym_cpucapacity))
>> +		return -1;
>> +
>> +	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
>> +	if (!sd)
>> +		return -1;
>> +
>> +	sync_entity_load_avg(&p->se);
>> +
>> +	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>> +
>> +	for_each_cpu_wrap(cpu, cpus, target) {
>> +		rq = cpu_rq(cpu);
>> +
>> +		if (!available_idle_cpu(cpu))
>> +			continue;
>> +		if (task_fits_capacity(p, rq->cpu_capacity))
>> +			return cpu;
> 
> I have couple of questions.
> 
> (1) Any particular reason for not checking sched_idle_cpu() as a backup
> for the case where all eligible CPUs are busy? select_idle_cpu() does
> that.
> 

No particular reason other than we didn't consider it, I think. I don't see
any harm in folding it in, I'll do that for v4. I am curious however; are
you folks making use of SCHED_IDLE? AFAIA Android isn't making use of it
yet, though Viresh paved the way for that to happen.

> (2) Assuming all CPUs are busy, we return -1 from here and end up
> calling select_idle_cpu(). The traversal in select_idle_cpu() may be
> waste in cases where sd_llc == sd_asym_cpucapacity . For example SDM845.
> Should we worry about this?
> 

Before v3, since we didn't have the fallback CPU selection within
select_idle_capacity(), we would need the fall-through to select_idle_cpu()
(we could've skipped an idle CPU just because its capacity wasn't high
enough).

That's not the case anymore, so indeed we may be able to bail out of
select_idle_sibling() right after select_idle_capacity() (or after the
prev / recent_used_cpu checks). Our only requirement here is that sd_llc
remains a subset of sd_asym_cpucapacity.

So far for Arm topologies we can have:
- sd_llc < sd_asym_cpucapacity (e.g. legacy big.LITTLE like Juno)
- sd_llc == sd_asym_cpucapacity (e.g. DynamIQ like SDM845)

I'm slightly worried about sd_llc > sd_asym_cpucapacity ever being an
actual thing - I don't believe it makes much sense, but that's not stopping
anyone.

AFAIA we (Arm) *currently* don't allow that with big.LITTLE or DynamIQ, nor
do I think it can happen with the default scheduler topology where MC is
the last possible level we can have as sd_llc.

So it *might* be a safe assumption - and I can still add a SCHED_WARN_ON().
