Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71B1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BCD9206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgHCX71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:59:27 -0400
Received: from foss.arm.com ([217.140.110.172]:35568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbgHCX70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:59:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F6131FB;
        Mon,  3 Aug 2020 16:59:26 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46F193F71F;
        Mon,  3 Aug 2020 16:59:24 -0700 (PDT)
References: <20200729033934.22349-1-alison.wang@nxp.com> <877dumbtoi.fsf@kurt> <20200729094943.lsmhsqlnl7rlnl6f@skbuf> <87mu3ho48v.fsf@kurt> <20200730082228.r24zgdeiofvwxijm@skbuf> <873654m9zi.fsf@kurt> <87lfiwm2bj.fsf@nanos.tec.linutronix.de> <20200803114112.mrcuupz4ir5uqlp6@skbuf> <87d047n4oh.fsf@nanos.tec.linutronix.de> <jhjh7tjivew.mognet@arm.com> <875z9zmt4i.fsf@nanos.tec.linutronix.de>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-reply-to: <875z9zmt4i.fsf@nanos.tec.linutronix.de>
Date:   Tue, 04 Aug 2020 00:59:19 +0100
Message-ID: <jhjft93i8mg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/08/20 20:22, Thomas Gleixner wrote:
> Valentin,
>
> Valentin Schneider <valentin.schneider@arm.com> writes:
>> On 03/08/20 16:13, Thomas Gleixner wrote:
>>> Vladimir Oltean <olteanv@gmail.com> writes:
>>>>>  1) When irq accounting is disabled, RT throttling kicks in as
>>>>>     expected.
>>>>>
>>>>>  2) With irq accounting the RT throttler does not kick in and the RCU
>>>>>     stall/lockups happen.
>>>> What is this telling us?
>>>
>>> It seems that the fine grained irq time accounting affects the runtime
>>> accounting in some way which I haven't figured out yet.
>>>
>>
>> With IRQ_TIME_ACCOUNTING, rq_clock_task() will always be incremented by a
>> lesser-or-equal value than when not having the option; you start with the
>> same delta_exec but slice some for the IRQ accounting, and leave the rest
>> for the rq_clock_task() (+paravirt).
>>
>> IIUC this means that if you spend e.g. 10% of the time in IRQ and 90% of
>> the time running the stress-ng RT tasks, despite having RT tasks hogging
>> the entirety of the "available time" it is still only 90% runtime, which is
>> below the 95% default and the throttling doesn't happen.
>
>    totaltime = irqtime + tasktime
>
> Ignoring irqtime and pretending that totaltime is what the scheduler
> can control and deal with is naive at best.
>

Agreed, however AFAICT rt_time is only incremented by rq_clock_task()
deltas, which don't include IRQ time with IRQ_TIME_ACCOUNTING=y. That would
then be directly compared to the sysctl runtime.

Adding some prints in sched_rt_runtime_exceeded() and running this test
case on my Juno, I get:

  # IRQ_TIME_ACCOUNTING=y
  cpu=2 rt_time=713455220 runtime=950000000 rq->avg_irq.util_avg=265
  (rt_time oscillates between [70.1e7, 75.1e7]; avg_irq between [220, 270])

  # IRQ_TIME_ACCOUNTING=n
  cpu=2 rt_time=963035300 runtime=949951811
  (rt_time oscillates between [94.1e7, 96.1e7];

Throttling happens for IRQ_TIME_ACCOUNTING=n and doesn't for
IRQ_TIME_ACCOUNTING=y - clearly the accounted rt_time isn't high enough for
that to happen, and it does look like what is missing in rt_time (or what
should be subtracted from the available runtime) is there in the avg_irq.

Or is that another case where I shouldn't have been writing emails at this
hour?

> Thanks,
>
>         tglx
