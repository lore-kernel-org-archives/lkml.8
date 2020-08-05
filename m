Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4EEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6F82177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgHEIue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:50:34 -0400
Received: from foss.arm.com ([217.140.110.172]:56100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgHEIud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:50:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14D5CD6E;
        Wed,  5 Aug 2020 01:50:33 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDF223F6CF;
        Wed,  5 Aug 2020 01:50:30 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ
 time accounting
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200729033934.22349-1-alison.wang@nxp.com> <877dumbtoi.fsf@kurt>
 <20200729094943.lsmhsqlnl7rlnl6f@skbuf> <87mu3ho48v.fsf@kurt>
 <20200730082228.r24zgdeiofvwxijm@skbuf> <873654m9zi.fsf@kurt>
 <87lfiwm2bj.fsf@nanos.tec.linutronix.de>
 <20200803114112.mrcuupz4ir5uqlp6@skbuf>
 <87d047n4oh.fsf@nanos.tec.linutronix.de> <jhjh7tjivew.mognet@arm.com>
 <875z9zmt4i.fsf@nanos.tec.linutronix.de> <jhjft93i8mg.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <02195130-3d9a-a206-d931-fab7dc606061@arm.com>
Date:   Wed, 5 Aug 2020 10:50:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <jhjft93i8mg.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2020 01:59, Valentin Schneider wrote:
> 
> On 03/08/20 20:22, Thomas Gleixner wrote:
>> Valentin,
>>
>> Valentin Schneider <valentin.schneider@arm.com> writes:
>>> On 03/08/20 16:13, Thomas Gleixner wrote:
>>>> Vladimir Oltean <olteanv@gmail.com> writes:
>>>>>>  1) When irq accounting is disabled, RT throttling kicks in as
>>>>>>     expected.
>>>>>>
>>>>>>  2) With irq accounting the RT throttler does not kick in and the RCU
>>>>>>     stall/lockups happen.
>>>>> What is this telling us?
>>>>
>>>> It seems that the fine grained irq time accounting affects the runtime
>>>> accounting in some way which I haven't figured out yet.
>>>>
>>>
>>> With IRQ_TIME_ACCOUNTING, rq_clock_task() will always be incremented by a
>>> lesser-or-equal value than when not having the option; you start with the
>>> same delta_exec but slice some for the IRQ accounting, and leave the rest
>>> for the rq_clock_task() (+paravirt).
>>>
>>> IIUC this means that if you spend e.g. 10% of the time in IRQ and 90% of
>>> the time running the stress-ng RT tasks, despite having RT tasks hogging
>>> the entirety of the "available time" it is still only 90% runtime, which is
>>> below the 95% default and the throttling doesn't happen.
>>
>>    totaltime = irqtime + tasktime
>>
>> Ignoring irqtime and pretending that totaltime is what the scheduler
>> can control and deal with is naive at best.
>>
> 
> Agreed, however AFAICT rt_time is only incremented by rq_clock_task()
> deltas, which don't include IRQ time with IRQ_TIME_ACCOUNTING=y. That would
> then be directly compared to the sysctl runtime.
> 
> Adding some prints in sched_rt_runtime_exceeded() and running this test
> case on my Juno, I get:
>   # IRQ_TIME_ACCOUNTING=y
>   cpu=2 rt_time=713455220 runtime=950000000 rq->avg_irq.util_avg=265
>   (rt_time oscillates between [70.1e7, 75.1e7]; avg_irq between [220, 270])
> 
>   # IRQ_TIME_ACCOUNTING=n
>   cpu=2 rt_time=963035300 runtime=949951811
>   (rt_time oscillates between [94.1e7, 96.1e7];
> 
> Throttling happens for IRQ_TIME_ACCOUNTING=n and doesn't for
> IRQ_TIME_ACCOUNTING=y - clearly the accounted rt_time isn't high enough for
> that to happen, and it does look like what is missing in rt_time (or what
> should be subtracted from the available runtime) is there in the avg_irq.

I agree that w/ IRQ_TIME_ACCOUNTING=y rt_rq->rt_time isn't high enough
in this testcase.

stress-ng-hrtim-1655 [001] 462.897733: bprint: update_curr_rt:
rt_rq->rt_time=416716900 rt_rq->rt_runtime=950000000
rt_b->rt_runtime=950000000

The 5% reservation (1 - sched_rt_runtime_us/sched_rt_period_us) for CFS
is massively eclipsed by irqtime.

It's true that avg_irq tracks 'irq_delta + steal' time but it is meant
to potentially reduce cpu capacity. It's also cpu and frequency
invariant (your CPU2 is a big CPU so no issue here).

Could a rq_clock(rq) derived rt_rq signal been used to compare against
rt_runtime?

BTW, DL already influences rt_rq->rt_time.

[...]
