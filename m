Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FF7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC50D22B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgHEUON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:14:13 -0400
Received: from foss.arm.com ([217.140.110.172]:33034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgHEQX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:23:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 264F913D5;
        Wed,  5 Aug 2020 06:56:56 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B9B13F7BB;
        Wed,  5 Aug 2020 06:56:54 -0700 (PDT)
References: <877dumbtoi.fsf@kurt> <20200729094943.lsmhsqlnl7rlnl6f@skbuf> <87mu3ho48v.fsf@kurt> <20200730082228.r24zgdeiofvwxijm@skbuf> <873654m9zi.fsf@kurt> <87lfiwm2bj.fsf@nanos.tec.linutronix.de> <20200803114112.mrcuupz4ir5uqlp6@skbuf> <87d047n4oh.fsf@nanos.tec.linutronix.de> <jhjh7tjivew.mognet@arm.com> <875z9zmt4i.fsf@nanos.tec.linutronix.de> <20200805134002.GQ2674@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     peterz@infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-reply-to: <20200805134002.GQ2674@hirez.programming.kicks-ass.net>
Date:   Wed, 05 Aug 2020 14:56:49 +0100
Message-ID: <jhja6z9i4bi.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/08/20 14:40, peterz@infradead.org wrote:
> On Mon, Aug 03, 2020 at 09:22:53PM +0200, Thomas Gleixner wrote:
>
>>    totaltime = irqtime + tasktime
>>
>> Ignoring irqtime and pretending that totaltime is what the scheduler
>> can control and deal with is naive at best.
>
> Well no, that's what we call system overhead and is assumed to be
> included in the 'error margin'.
>
> The way things are set up is that we say that, by default, RT tasks can
> consume 95% of cputime and the remaining 5% is sufficient to keep the
> system alive.
>
> Those 5% include all system overhead, IRQs, RCU, !RT workqueues etc..
>
> Obviously IRQ_TIME accounting changes the balance a bit, but that's what
> it is. We can't really do anything better.
>

I'm starting to think that as well. I tried some fugly hack of injecting
avg_irq into sched_rt_runtime_exceeded() with something along the lines of:

  irq_time = (rq->avg_irq.util_avg * sched_rt_period(rt_rq)) >> SCHED_CAPACITY_SHIFT;

It's pretty bad for a few reasons; one is that avg_irq already has its own
period (PELT-based). Another is that it is, as Dietmar pointed out, CPU and
freq invariant, so falls over on big.LITTLE.

Making update_curr_rt() use rq_clock() rather than rq_clock_task() makes it
"work" but goes against all the good reasons there were to introduce
rq_clock_task() in the first place.

> Apparently this SoC has significant IRQ time for some reason. Also,
> relying on RT throttling for 'correct' behaviour is also wrong. What
> needs to be done is find who is using all this RT time and why, that
> isn't right.

I've been tempted to say the test case is a bit bogus, but am not familiar
enough with the RT throttling details to stand that ground. That said, from
both looking at the execution and the stress-ng source code, it seems to
unconditionally spawn 32 FIFO-50 tasks (there's even an option to make
these FIFO-99!!!), which is quite a crowd on monoCPU systems.
