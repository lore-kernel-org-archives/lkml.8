Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC6C22522
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCEPZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:25:44 -0500
Received: from foss.arm.com ([217.140.110.172]:50012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgCEPZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:25:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A4B730E;
        Thu,  5 Mar 2020 07:25:43 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E16953F534;
        Thu,  5 Mar 2020 07:25:41 -0800 (PST)
Date:   Thu, 5 Mar 2020 15:25:39 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] sched: fair: Use the earliest break even
Message-ID: <20200305152539.dcgmq5zupnarn4rp@e107158-lin.cambridge.arm.com>
References: <20200304114844.17700-1-daniel.lezcano@linaro.org>
 <20200304150145.agekdwrpvvamttk6@e107158-lin.cambridge.arm.com>
 <33e42f55-c85b-2056-cf2c-8a7ac5bd36f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33e42f55-c85b-2056-cf2c-8a7ac5bd36f4@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/20 17:17, Daniel Lezcano wrote:
> 
> Hi Qais,
> 
> On 04/03/2020 16:01, Qais Yousef wrote:
> > Hi Daniel
> > 
> > Adding Rafael to CC as I think he might be interested in this too.
> > 
> > On 03/04/20 12:48, Daniel Lezcano wrote:
> >> In the idle CPU selection process occuring in the slow path via the
> >> find_idlest_group_cpu() function, we pick up in priority an idle CPU
> >> with the shallowest idle state otherwise we fall back to the least
> >> loaded CPU.
> >>
> >> In order to be more energy efficient but without impacting the
> >> performances, let's use another criteria: the break even deadline.
> > 
> > What is the break even deadline?
> >
> >> At idle time, when we store the idle state the CPU is entering in, we
> >> compute the next deadline where the CPU could be woken up without
> >> spending more energy to sleep.
> > 
> > I think that's its definition, but could do with more explanation.
> > 
> > So the break even deadline is the time window during which we can abort the CPU
> > while entering its shallowest idle state?
> 
> No, it is the moment in absolute time when the min residency is reached.
> 
> From Documentation/devicetree/bindings/arm/idle-states.yaml
> 
> "
> min-residency is defined for a given idle state as the minimum expected
> residency time for a state (inclusive of preparation and entry) after
> which choosing that state become the most energy efficient option. A
> good way to visualise this, is by taking the same graph above and
> comparing some states energy consumptions plots.
> "
> 
> > So if we have 2 cpus entering the shallowest idle state, we pick the one that
> > has a faster abort? And the energy saving comes from the fact we avoided
> > unnecessary sleep-just-to-wakeup-immediately cycle?
> 
> No, actually it is about to choose a CPU where it has a better chance to
> have reach its min residency. Basically, when the CPU enters an idle
> state, that has a cost (cache flush / refill, context saving/restore etc
> ...), so there is a peak of energy and the CPU has to save energy long
> enough to compensate this extra consumption.
> 
> If the scheduler is constantly waking up an idle CPU before it slept
> long enough, we lose energy and performance.
> 
> Example 1, the CPUs are in a state:
>  - CPU0 (power down)
>  - CPU1 (power down)
>  - CPU2 (WFI)
>  - CPU3 (power down)
> 
>  The routine choose CPU2 because it is the shallowest state.
> 
> Example 2, the CPUs are in a state:
>  - CPU0 (power down) (bedl = 1234)
>  - CPU1 (power down) (bedl = 4321)
>  - CPU2 (power down) (bedl = 9876)
>  - CPU3 (power down) (bedl = 3421)
> 
> * bedl = break even deadline
> 
>   The routine choose CPU1 because the bedl is the smallest.

Thanks for the explanation and the reference. The idle-state.yaml has a nice
diagram. I won't insist, but I think including the definition of break even
will help a lot to make the patch more understandable.

[...]

> > Shouldn't you retain the original if condition here? You omitted the 2nd part
> > of this check compared to the original condition
> > 
> > 	(!idle || >>>idle->exit_latency == min_exit_latency<<<)
> 
> It is done on purpose because of the condition right before.

I see it now. If denote the condition as B. If it was false then the OR will
reduce to !idle. But if it was True, then which path you take will depend only
on state of idle too, which you check in both paths.

[...]

> 
> Nope, thanks for spotting it. It should be:
> 
>  void sched_idle_set_state(struct cpuidle_state *idle_state)
>  {
> -       idle_set_state(this_rq(), idle_state);
> +       struct rq *rq = this_rq();
> +       idle_set_state(rq, idle_state);
> +
> +       if (likely(idle_state)) {
> +               ktime_t kt = ktime_add_ns(ktime_get(),
> +                                         idle_state->exit_latency_ns);
> +               idle_set_break_even(rq, ktime_to_ns(kt));
> +       }
>  }
> 
> 
> > Don't you need to reset the break_even value if idle_state is NULL too?
> 
> If the idle_state is NULL, the routine won't use the break_even.

+1

Thanks

--
Qais Yousef
