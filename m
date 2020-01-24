Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4D5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B662071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388539AbgAXPh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:37:28 -0500
Received: from foss.arm.com ([217.140.110.172]:53986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388032AbgAXPh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:37:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07D481FB;
        Fri, 24 Jan 2020 07:37:27 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16B0F3F6C4;
        Fri, 24 Jan 2020 07:37:24 -0800 (PST)
Subject: Re: [Patch v8 4/7] sched/fair: Enable periodic update of average
 thermal pressure
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e0ede843-4cb8-83d8-708b-87d96b6eb1c3@arm.com>
Date:   Fri, 24 Jan 2020 16:37:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAzgNAV5c_sTycSocmi8Y4oGGT5rDNSYmgL3tCjZ1RAQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2020 16:39, Vincent Guittot wrote:
> On Fri, 17 Jan 2020 at 15:55, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Fri, Jan 17, 2020 at 02:22:51PM +0100, Vincent Guittot wrote:
>>> On Thu, 16 Jan 2020 at 16:15, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>>>
>>>> That there indentation trainwreck is a reason to rename the function.
>>>>
>>>>         decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
>>>>                   update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
>>>>                   update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure) |
>>>>                   update_irq_load_avg(rq, 0);
>>>>
>>>> Is much better.
>>>>
>>>> But now that you made me look at that, I noticed it's using a different
>>>> clock -- it is _NOT_ using now/rq_clock_pelt(), which means it'll not be
>>>> in sync with the other averages.
>>>>
>>>> Is there a good reason for that?
>>>
>>> We don't need to apply frequency and cpu capacity invariance on the
>>> thermal capping signal which is  what rq_clock_pelt does
>>
>> Hmm, I suppose that is true, and that really could've done with a
>> comment. Now clock_pelt is sort-of in sync with clock_task, but won't it
>> still give weird artifacts by having it on a slightly different basis?
> 
> No we should not. Weird artifacts happens when we
> add/subtract/propagate signals between each other and then apply pelt
> algorithm on the results. In the case of thermal signal, we only add
> it to others to update cpu_capacity but pelt algo is then not applied
> on it. The error because of some signals being at segment boundaries
> whereas others are not, is limited to 2% and doesn't accumulate over
> time.
> 
>>
>> Anyway, looking at this, would it make sense to remove the @now argument
>> from update_*_load_avg()? All those functions already take @rq, and
>> rq_clock_*() are fairly trivial inlines.
> 
> TBH I was thinking of doing the opposite for update_irq_load_avg which
> hides the clock that is used for irq_avg. This helps to easily
> identify which signals use the exact same clock and can be mixed to
> create a new pelt signal and which can't

The 'now' argument is one thing but why not:

-int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+int update_thermal_load_avg(u64 now, struct rq *rq)
 {
+       u64 capacity = arch_cpu_thermal_pressure(cpu_of(rq));
+
        if (___update_load_sum(now, &rq->avg_thermal,

This would make the call-sites __update_blocked_others() and
task_tick(_fair)() cleaner.

I guess the argument is not to pollute pelt.c. But it already contains
arch_scale_[freq|cpu]_capacity() for irq.


