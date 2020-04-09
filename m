Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135DAC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E096B20753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDIR3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:29:50 -0400
Received: from foss.arm.com ([217.140.110.172]:52786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgDIR3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:29:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E390B31B;
        Thu,  9 Apr 2020 10:29:49 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C1E13F73D;
        Thu,  9 Apr 2020 10:29:47 -0700 (PDT)
Subject: Re: [PATCH 2/4] sched/deadline: Improve admission control for
 asymmetric CPU capacities
To:     Valentin Schneider <valentin.schneider@arm.com>,
        luca abeni <luca.abeni@santannapisa.it>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-3-dietmar.eggemann@arm.com> <jhjeesyw96u.mognet@arm.com>
 <20200408153032.447e098d@nowhere> <jhjblo2vx60.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <31620965-e1e7-6854-ad46-8192ee4b41af@arm.com>
Date:   Thu, 9 Apr 2020 19:29:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <jhjblo2vx60.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.20 17:01, Valentin Schneider wrote:
> 
> On 08/04/20 14:30, luca abeni wrote:
>>>
>>> I don't think this is strictly equivalent to what we have now for the
>>> SMP case. 'cpus' used to come from dl_bw_cpus(), which is an ugly way
>>> of writing
>>>
>>>      cpumask_weight(rd->span AND cpu_active_mask);
>>>
>>> The rd->cpu_capacity_orig field you added gets set once per domain
>>> rebuild, so it also happens in sched_cpu_(de)activate() but is
>>> separate from touching cpu_active_mask. AFAICT this mean we can
>>> observe a CPU as !active but still see its capacity_orig accounted in
>>> a root_domain.
>>
>> Sorry, I suspect this is my fault, because the bug comes from my
>> original patch.
>> When I wrote the original code, I believed that when a CPU is
>> deactivated it is also removed from its root domain.
>>
>> I now see that I was wrong.
>>
> 
> Well it is indeed the case, but sadly it's not an atomic step - AFAICT with
> cpusets we do hold some cpuset lock when calling __dl_overflow() and when
> rebuilding the domains, but not when fiddling with the active mask.
> 
> I just realized it's even more obvious for dl_cpu_busy(): IIUC it is meant
> to prevent the removal of a CPU if it would lead to a DL overflow - it
> works now because the active mask is modified before it gets called, but
> here it breaks because it's called before the sched_domain rebuild.
> 
> Perhaps re-computing the root domain capacity sum at every dl_bw_cpus()
> call would be simpler. It's a bit more work, but then we already have a
> for_each_cpu_*() loop, and we only rely on the masks being correct.

Maybe we can do a hybrid. We have rd->span and rd->sum_cpu_capacity and
with the help of an extra per-cpu cpumask we could just

DEFINE_PER_CPU(cpumask_var_t, dl_bw_mask);

dl_bw_cpus(int i) {

    struct cpumask *cpus = this_cpu_cpumask_var_ptr(dl_bw_mask);
    ...
    cpumask_and(cpus, rd->span, cpu_active_mask);

    return cpumask_weight(cpus);
}

and

dl_bw_capacity(int i) {

    struct cpumask *cpus = this_cpu_cpumask_var_ptr(dl_bw_mask);
    ...
    cpumask_and(cpus, rd->span, cpu_active_mask);
    if (cpumask_equal(cpus, rd->span))
        return rd->sum_cpu_capacity;

    for_each_cpu(i, cpus)
        cap += capacity_orig_of(i);

    return cap;
}

So only in cases in which rd->span and cpu_active_mask differ we would
have to sum up again.
