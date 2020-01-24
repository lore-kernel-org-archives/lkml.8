Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AA3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E782720838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390240AbgAXOOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:14:50 -0500
Received: from foss.arm.com ([217.140.110.172]:51946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390216AbgAXOOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:14:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65A311FB;
        Fri, 24 Jan 2020 06:14:49 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6364E3F6C4;
        Fri, 24 Jan 2020 06:14:48 -0800 (PST)
Subject: Re: [PATCH v2 1/3] sched/fair: Add asymmetric CPU capacity wakeup
 scan
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
References: <20200124130213.24886-1-valentin.schneider@arm.com>
 <20200124130213.24886-2-valentin.schneider@arm.com>
Message-ID: <00aa64e8-5e75-181e-a4f4-72c2ac64081c@arm.com>
Date:   Fri, 24 Jan 2020 14:14:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200124130213.24886-2-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(copied over from the v1 thread)

On 24/01/2020 12:59, Quentin Perret wrote:
> Hey Valentin,
> 
> On Friday 24 Jan 2020 at 12:42:53 (+0000), Valentin Schneider wrote:
>> +/*
>> + * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
>> + * the task fits.
>> + */
>> +static int select_idle_capacity(struct task_struct *p, int target)
>> +{
>> +	struct sched_domain *sd;
>> +	struct cpumask *cpus;
>> +	int cpu;
>> +
>> +	if (!static_branch_unlikely(&sched_asym_cpucapacity))
>> +		return -1;
>> +
>> +	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
>> +	if (!sd)
>> +		return -1;
>> +
> 
> You might want 'sync_entity_load_avg(&p->se)' here no ?
> find_idlest_cpu() and wake_cap() need one, but since we're going to use
> them, you'll want to sync here too I think.
> 

Yeah, I think you're right, it's the exact same scenario here.

>> +	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>> +
>> +	for_each_cpu_wrap(cpu, cpus, target) {
>> +		if (!available_idle_cpu(cpu))
>> +			continue;
>> +		if (!task_fits_capacity(p, capacity_of(cpu)))
>> +			continue;
>> +
>> +		return cpu;
> 
> If we found an idle CPU, but not one big enough, should we still go
> ahead and choose it ? Misfit / idle balance will fix that later when a
> big CPU does become available.
> 

If we fail to find a big enough CPU, we'll just fallback to the rest of
select_idle_sibling() which will pick an idle CPU, just without caring
about capacity.

Now an alternative here would be to:
- return the first idle CPU on which the task fits (what the above does)
- else, return the biggest idle CPU we found (this could e.g. still steer
  the task towards a medium on a tri-capacity system)

I think what we were trying to go with here is to not entirely hijack
select_idle_sibling(). If we go with the above alternative, topologies
with sched_asym_cpucapacity enabled would only ever see
select_idle_capacity() and not the rest of select_idle_sibling(). Not sure
if it's a bad thing or not, but it's something to ponder over.
