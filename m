Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A9FC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F097D2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgA2KjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:39:01 -0500
Received: from foss.arm.com ([217.140.110.172]:39128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgA2KjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:39:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E03F51FB;
        Wed, 29 Jan 2020 02:39:00 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8573E3F52E;
        Wed, 29 Jan 2020 02:38:59 -0800 (PST)
Subject: Re: [PATCH v3 1/3] sched/fair: Add asymmetric CPU capacity wakeup
 scan
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, qperret@google.com,
        adharmap@codeaurora.org
References: <20200126200934.18712-1-valentin.schneider@arm.com>
 <20200126200934.18712-2-valentin.schneider@arm.com>
 <20200128062245.GA27398@codeaurora.org>
 <1ed322d6-0325-ecac-cc68-326a14b8c1dd@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1aa14491-517e-92d2-08b0-568338d75812@arm.com>
Date:   Wed, 29 Jan 2020 11:38:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1ed322d6-0325-ecac-cc68-326a14b8c1dd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2020 12:30, Valentin Schneider wrote:
> Hi Pavan,
> 
> On 28/01/2020 06:22, Pavan Kondeti wrote:
>> Hi Valentin,
>>
>> On Sun, Jan 26, 2020 at 08:09:32PM +0000, Valentin Schneider wrote:

[...]

>>> +
>>> +	if (!static_branch_unlikely(&sched_asym_cpucapacity))
>>> +		return -1;

We do need this one to bail out quickly on non CPU asym systems. (1)

>>> +	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
>>> +	if (!sd)
>>> +		return -1;

And I assume we can't return target here because of exclusive cpusets
which can form symmetric CPU capacities islands on a CPU asymmetric
system? (2)

>>> +	sync_entity_load_avg(&p->se);
>>> +
>>> +	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>>> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>>> +
>>> +	for_each_cpu_wrap(cpu, cpus, target) {
>>> +		rq = cpu_rq(cpu);
>>> +
>>> +		if (!available_idle_cpu(cpu))
>>> +			continue;
>>> +		if (task_fits_capacity(p, rq->cpu_capacity))
>>> +			return cpu;
>>
>> I have couple of questions.

[...]

>> (2) Assuming all CPUs are busy, we return -1 from here and end up
>> calling select_idle_cpu(). The traversal in select_idle_cpu() may be
>> waste in cases where sd_llc == sd_asym_cpucapacity . For example SDM845.
>> Should we worry about this?
>>
> 
> Before v3, since we didn't have the fallback CPU selection within
> select_idle_capacity(), we would need the fall-through to select_idle_cpu()
> (we could've skipped an idle CPU just because its capacity wasn't high
> enough).
> 
> That's not the case anymore, so indeed we may be able to bail out of
> select_idle_sibling() right after select_idle_capacity() (or after the
> prev / recent_used_cpu checks). Our only requirement here is that sd_llc
> remains a subset of sd_asym_cpucapacity.

How do you distinguish '-1' in (1), (2) and 'best_cpu = -1' (3)?

In (1) and (2) you want to check if target is idle (or sched_idle) but
in (3) you probably only want to check 'recent_used_cpu'?
