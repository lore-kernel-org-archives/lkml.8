Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D525EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B132E2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgA2PlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:41:12 -0500
Received: from foss.arm.com ([217.140.110.172]:42814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgA2PlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 10:41:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D28931B;
        Wed, 29 Jan 2020 07:41:12 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41D623F52E;
        Wed, 29 Jan 2020 07:41:10 -0800 (PST)
Subject: Re: [Patch v8 4/7] sched/fair: Enable periodic update of average
 thermal pressure
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Quentin Perret <qperret@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
 <20200116151502.GQ2827@hirez.programming.kicks-ass.net>
 <CAKfTPtA-M_APhGzwADhuwABzW_M5YKjm_ONGzQjFNRoJ+qYBmg@mail.gmail.com>
 <20200117145544.GE14879@hirez.programming.kicks-ass.net>
 <CAKfTPtAzgNAV5c_sTycSocmi8Y4oGGT5rDNSYmgL3tCjZ1RAQw@mail.gmail.com>
 <e0ede843-4cb8-83d8-708b-87d96b6eb1c3@arm.com>
 <CAKfTPtA-pr9y2MuwY8vTAy=m4beqdhNCek0fgdZP7u0JT8ojvA@mail.gmail.com>
 <aabc0d05-6092-7e50-9758-acab30d3c434@arm.com>
 <CAKfTPtCG2xT2+Hwo__N2+0nSRkdOQqtJ_38AxpC4AbCe60y=Xw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f5d64110-85bf-92a5-9d63-faa5d64d2155@arm.com>
Date:   Wed, 29 Jan 2020 16:41:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCG2xT2+Hwo__N2+0nSRkdOQqtJ_38AxpC4AbCe60y=Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2020 16:15, Vincent Guittot wrote:
> On Mon, 27 Jan 2020 at 13:09, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 24/01/2020 16:45, Vincent Guittot wrote:
>>> On Fri, 24 Jan 2020 at 16:37, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 17/01/2020 16:39, Vincent Guittot wrote:
>>>>> On Fri, 17 Jan 2020 at 15:55, Peter Zijlstra <peterz@infradead.org> wrote:
>>>>>>
>>>>>> On Fri, Jan 17, 2020 at 02:22:51PM +0100, Vincent Guittot wrote:
>>>>>>> On Thu, 16 Jan 2020 at 16:15, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> [...]
>>
>>>> The 'now' argument is one thing but why not:
>>>>
>>>> -int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
>>>> +int update_thermal_load_avg(u64 now, struct rq *rq)
>>>>  {
>>>> +       u64 capacity = arch_cpu_thermal_pressure(cpu_of(rq));
>>>> +
>>>>         if (___update_load_sum(now, &rq->avg_thermal,
>>>>
>>>> This would make the call-sites __update_blocked_others() and
>>>> task_tick(_fair)() cleaner.
>>>
>>> I prefer to keep the capacity as argument. This is more aligned with
>>> others that provides the value of the signal to apply
>>>
>>>>
>>>> I guess the argument is not to pollute pelt.c. But it already contains
>>>
>>> you've got it. I don't want to pollute the pelt.c file with things not
>>> related to pelt but thermal as an example.
>>>
>>>> arch_scale_[freq|cpu]_capacity() for irq.
>>
>> But isn't arch_cpu_thermal_pressure() not exactly the same as
>> arch_scale_cpu_capacity() and arch_scale_freq_capacity()?
>>
>> All of them are defined by default within the scheduler code
>> [include/linux/sched/topology.h or kernel/sched/sched.h] and can be
>> overwritten by arch code with a fast implementation (e.g. returning a
>> per-cpu variable).
>>
>> So why is using arch_scale_freq_capacity() and arch_scale_cpu_capacity()
>> in update_irq_load_avg [kernel/sched/pelt.c] and update_rq_clock_pelt()
> 
> As explained previously, update_irq_load_avg is an exception and not
> the example to follow. update_rt/dl_rq_load_avg are the example to
> follow and fixing update_irq_load_avg exception is on my todo list

There is already a v9 but I comment here so the thread stays intact.

I guess this thread leads to nowhere. For me the question is do we
review against existing code or some possible future changes? The
arguments didn't convince me so far.
But we're not talking functional issues here so I won't continue to push
for change on this one here.

>> [kernel/sched/pelt.h] OK but arch_cpu_thermal_pressure() in
>> update_thermal_load_avg() [kernel/sched/pelt.c] not?
>>
>> Shouldn't arch_cpu_thermal_pressure() not be called
>> arch_scale_thermal_capacity() to highlight the fact that those three
> 
> Quoted from cover letter https://lkml.org/lkml/2020/1/14/1164:
> "
> v6->v7:
>        - ...
>         - Renamed arch_scale_thermal_capacity to arch_cpu_thermal_pressure
>           as per review comments from Peter, Dietmar and Ionela.
>        -...
> 
> "

I went back to the v6 review. Peter originally asked for a better name
(or an additional comment) for arch_scale_thermal_capacity() because the
return value is not capacity.

So IMHO arch_scale_thermal_pressure() is a good name for keeping this
aligned w/ the other arch_scale_* functions and to address this review
comment.

arch_scale_cpu_capacity()     - scale capacity by cpu
arch_scale_freq_capacity()    - scale capacity by frequency
arch_scale_thermal_pressure() - scale pressure (1 - capacity) by thermal

[...]
