Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EEFC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B807E20773
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgCROi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:38:29 -0400
Received: from foss.arm.com ([217.140.110.172]:50832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgCROi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:38:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FF8331B;
        Wed, 18 Mar 2020 07:38:28 -0700 (PDT)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45E2D3F52E;
        Wed, 18 Mar 2020 07:38:26 -0700 (PDT)
Date:   Wed, 18 Mar 2020 15:38:23 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH V2] sched: fair: Use the earliest break even
Message-ID: <20200318143823.GC6103@e123083-lin>
References: <20200311202625.13629-1-daniel.lezcano@linaro.org>
 <CAKfTPtAqeHhVCeSgE1DsaGGkM6nY-9oAvGw_6zWvv1bKyE85JQ@mail.gmail.com>
 <e6e8ff94-64f2-6404-e332-2e030fc7e332@linaro.org>
 <20200317075607.GE10914@e105550-lin.cambridge.arm.com>
 <3520b762-08f5-0db8-30cb-372709188bb9@linaro.org>
 <20200317143053.GF10914@e105550-lin.cambridge.arm.com>
 <7cd04d35-3522-30fb-82e9-82fdf53d0957@linaro.org>
 <20200318082452.GA6103@e123083-lin>
 <798e9bde-a207-3a0e-0f13-0e27d60fd286@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <798e9bde-a207-3a0e-0f13-0e27d60fd286@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 11:17:49AM +0100, Daniel Lezcano wrote:
> On 18/03/2020 09:24, Morten Rasmussen wrote:
> > On Tue, Mar 17, 2020 at 06:07:43PM +0100, Daniel Lezcano wrote:
> >> On 17/03/2020 15:30, Morten Rasmussen wrote:
> >>> On Tue, Mar 17, 2020 at 02:48:51PM +0100, Daniel Lezcano wrote:
> >>>> On 17/03/2020 08:56, Morten Rasmussen wrote:
> >>>>> On Thu, Mar 12, 2020 at 11:04:19AM +0100, Daniel Lezcano wrote:
> >>>>>>>> In order to be more energy efficient but without impacting the
> >>>>>>>> performances, let's use another criteria: the break even deadline.
> >>>>>>>>
> >>>>>>>> At idle time, when we store the idle state the CPU is entering in, we
> >>>>>>>> compute the next deadline where the CPU could be woken up without
> >>>>>>>> spending more energy to sleep.
> >>>>>
> >>>>> I don't follow the argument that sleeping longer should improve energy
> >>>>> consumption. 
> >>>>
> >>>> May be it is not explained correctly.
> >>>>
> >>>> The patch is about selecting a CPU with the smallest break even deadline
> >>>> value. In a group of idle CPUs in the same idle state, we will pick the
> >>>> one with the smallest break even dead line which is the one with the
> >>>> highest probability it already reached its target residency.
> >>>>
> >>>> It is best effort.
> >>>
> >>> Indeed. I get what the patch does, I just don't see how the patch
> >>> improves energy efficiency.
> >>
> >> If the CPU is woken up before it reached the break even, the idle state
> >> cost in energy is greater than the energy it saved.
> >>
> >> Am I misunderstanding your point?
> > 
> > Considering just the waking then yes, it reaches energy break-even.
> > However, considering all the CPUs in the system, it just moves the idle
> > entry/exit energy cost to a different CPU, it doesn't go away.
> > 
> > Whether you have:
> > 
> >                |-BE-|
> >            ____    ____
> > CPU0:  ___/    \__/    \___
> > 
> > CPU1:  ____________________
> > 
> > Or:
> >                |-BE-|
> >            ____
> > CPU0:  ___/    \___________
> >                    ____
> > CPU1:  ___________/    \___
> > 
> > _
> >   = CPU busy = P_{busy}
> > _ = CPU idle = P_{idle}
> > / = CPU idle exit = P_{exit}
> > \ = CPU idle entry = P_{entry}
> > 
> > The sum of areas under the curves is the same, i.e. the total energy is
> > unchanged.
> 
> It is a counter-intuitive comment, now I get it, thanks for the
> clarification. It is a good point.

No problem.

> Taking into consideration the dynamic, in the case #1, the break even is
> not reached, the idle duration is smaller and that leads the governor to
> choose shallower idle states after and consequently CPU0 will be used in
> priority. We end up with CPU0 in a shallow state and CPU1 in a deep state.

Indeed. I was speculating earlier if the opposite could happen too. If
we extended the second case to form a repeating pattern, could we
prevent somehow prevent CPU1 from reaching a deeper state? Could we have
pattern that would keep both CPUs in shallow state where it would have
been more efficient to consolidate the wake-ups on CPU0 and let CPU1
enter deeper states?

> 
> With the case #2, we can have the CPUs in both deep state and the
> governor should be keeping choosing the same idle state.

Ideally yes. However it depends on the break-even times of the deeper
states and when the next wake-ups happen.

> I don't know what is more energy/perf efficient. IMO this is very
> workload dependent. The only way to check is to test. Hopefully I can
> find a platform for that.

Moving the wake-up shouldn't impact energy directly, although it have a
positive latency impact as you are more likely to avoid waking up CPUs
that haven't finished the idle entry sequence. However, changing the
wake-up pattern could have an indirect energy impact, positive or
negative. It isn't clear to me either what outcome to expect.

Morten
