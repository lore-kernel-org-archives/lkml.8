Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C7BC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A081020663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgCQH4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:56:12 -0400
Received: from foss.arm.com ([217.140.110.172]:33460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQH4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 03:56:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33E0E1FB;
        Tue, 17 Mar 2020 00:56:11 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC0853F52E;
        Tue, 17 Mar 2020 00:56:09 -0700 (PDT)
Date:   Tue, 17 Mar 2020 07:56:07 +0000
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
Message-ID: <20200317075607.GE10914@e105550-lin.cambridge.arm.com>
References: <20200311202625.13629-1-daniel.lezcano@linaro.org>
 <CAKfTPtAqeHhVCeSgE1DsaGGkM6nY-9oAvGw_6zWvv1bKyE85JQ@mail.gmail.com>
 <e6e8ff94-64f2-6404-e332-2e030fc7e332@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6e8ff94-64f2-6404-e332-2e030fc7e332@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

First, I think letting the scheduler know about desired minimum idle
times is an interesting optimization if the overhead can be kept at a
minimum. I do have a few comments about the patch though.

On Thu, Mar 12, 2020 at 11:04:19AM +0100, Daniel Lezcano wrote:
> On 12/03/2020 09:36, Vincent Guittot wrote:
> > Hi Daniel,
> > 
> > On Wed, 11 Mar 2020 at 21:28, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> In the idle CPU selection process occuring in the slow path via the
> >> find_idlest_group_cpu() function, we pick up in priority an idle CPU
> >> with the shallowest idle state otherwise we fall back to the least
> >> loaded CPU.
> > 
> > The idea makes sense but this path is only used by fork and exec so
> > I'm not sure about the real impact
> 
> I agree the fork / exec path is called much less often than the wake
> path but it makes more sense for the decision.

Looking at the flow in find_idlest_cpu(), AFAICT,
find_idlest_group_cpu() is not actually making the final choice of CPU,
so going through a lot of trouble there looking at idle states is
pointless. Is there something I don't see?

We fellow sd->child until groups == CPUs which which means that
find_idlest_group() actually makes the final choice as the final group
passed to find_idlest_group_cpu() is single-CPU group. The flow has been
like that for years. Even before you added the initial idle-state
awareness.

I agree with Vincent, if this should really make a difference it should
include wake-ups existing tasks too. Although I'm aware it would be a
more invasive change. As said from the beginning, the idea is fine, but
the current implementation should not make any measurable difference?

> 
> >> In order to be more energy efficient but without impacting the
> >> performances, let's use another criteria: the break even deadline.
> >>
> >> At idle time, when we store the idle state the CPU is entering in, we
> >> compute the next deadline where the CPU could be woken up without
> >> spending more energy to sleep.

I don't follow the argument that sleeping longer should improve energy
consumption. The patch doesn't affect the number of idle state
enter/exit cycles, so you spend the amount of energy on those
transitions. The main change is that idle time get spread out, so CPUs
are less likely to be in the process of entering an idle state when they
are asked to wake back up again.

Isn't it fair to say that we expect the total number of wake-ups remains
unchanged? Total busy and idle times across all CPUs should remain the
same too? Unless chosen idle-state is changed, which I don't think we
expect either, there should be no net effect on energy? The main benefit
is reduced wake-up latency I think.

Regarding chosen idle state, I'm wondering how this patch affects the
cpuidle governor's idle state selection. Could the spreading of wake-ups
trick governor to pick a shallower idle-state for some idle CPUs because
we actively spread wake-ups rather than consolidating them? Just a
thought.

> >>
> >> At the selection process, we use the shallowest CPU but in addition we
> >> choose the one with the minimal break even deadline instead of relying
> >> on the idle_timestamp. When the CPU is idle, the timestamp has less
> >> meaning because the CPU could have wake up and sleep again several times
> >> without exiting the idle loop. In this case the break even deadline is
> >> more relevant as it increases the probability of choosing a CPU which
> >> reached its break even.

I guess you could improve the idle time stamping without adding the
break-even time, they don't have to go together?

> >>
> >> Tested on:
> >>  - a synquacer 24 cores, 6 sched domains
> >>  - a hikey960 HMP 8 cores, 2 sched domains, with the EAS and energy probe
> >>
> >> sched/perf and messaging does not show a performance regression. Ran
> >> 50 times schbench, adrestia and forkbench.
> >>
> >> The tools described at https://lwn.net/Articles/724935/
> >>
> >>  --------------------------------------------------------------
> >> | Synquacer             | With break even | Without break even |
> >>  --------------------------------------------------------------
> >> | schbench *99.0th      |      14844.8    |         15017.6    |
> >> | adrestia / periodic   |        57.95    |              57    |
> >> | adrestia / single     |         49.3    |            55.4    |
> >>  --------------------------------------------------------------
> > 
> > Have you got some figures or cpuidle statistics for the syncquacer ?
> 
> No, and we just noticed the syncquacer has a bug in the firmware and
> does not actually go to the idle states.

I would also like some statistics to help understanding what actually
changes.

I did some measurements on TX2, which only has one idle-state. I don't
see the same trends as you do. adrestia single seems to be most affected
by the patch, but _increases_ with the break_even patch rather than
decrease. I don't trust adrestia too much though as the time resolution
is low on TX2.

TX2			tip		break_even
----------------------------------------------------
adrestia / single	5.21		5.51
adrestia / periodic	5.75		5.67
schbench 99.0th		45465.6		45376.0
hackbench		27.9851		27.9775

Notes:
adrestia: Avg of 100 runs: adrestia -l 25000
schbench: Avg of 10 runs: schbench -m16 -t64
hackbench: Avg of 10 runs: hackbench -g 20 -T 256 -l 100000

Morten
