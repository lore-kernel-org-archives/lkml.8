Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C44C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2129E21741
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgCDPWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:22:35 -0500
Received: from foss.arm.com ([217.140.110.172]:35686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDPWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:22:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D12C54B2;
        Wed,  4 Mar 2020 07:22:34 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C7073F6CF;
        Wed,  4 Mar 2020 07:22:33 -0800 (PST)
References: <20200304114844.17700-1-daniel.lezcano@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list\:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: fair: Use the earliest break even
In-reply-to: <20200304114844.17700-1-daniel.lezcano@linaro.org>
Date:   Wed, 04 Mar 2020 15:22:17 +0000
Message-ID: <jhjimjk16xi.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 04 2020, Daniel Lezcano wrote:
> In the idle CPU selection process occuring in the slow path via the
> find_idlest_group_cpu() function, we pick up in priority an idle CPU
> with the shallowest idle state otherwise we fall back to the least
> loaded CPU.
>
> In order to be more energy efficient but without impacting the
> performances, let's use another criteria: the break even deadline.
>
> At idle time, when we store the idle state the CPU is entering in, we
> compute the next deadline where the CPU could be woken up without
> spending more energy to sleep.
>
> At the selection process, we use the shallowest CPU but in addition we
> choose the one with the minimal break even deadline instead of relying
> on the idle_timestamp. When the CPU is idle, the timestamp has less
> meaning because the CPU could have wake up and sleep again several times
> without exiting the idle loop. In this case the break even deadline is
> more relevant as it increases the probability of choosing a CPU which
> reached its break even.
>

Ok so we still favour smallest exit latency, but if we have to pick
among several CPUs with the same exit latency, we can use the break
even. I'll want to test this on stuff, but I like the overall idea.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fcc968669aea..520c5e822fdd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5793,6 +5793,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>  {
>       unsigned long load, min_load = ULONG_MAX;
>       unsigned int min_exit_latency = UINT_MAX;
> +	s64 min_break_even = S64_MAX;
>       u64 latest_idle_timestamp = 0;
>       int least_loaded_cpu = this_cpu;
>       int shallowest_idle_cpu = -1;
> @@ -5810,6 +5811,8 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>               if (available_idle_cpu(i)) {
>                       struct rq *rq = cpu_rq(i);
>                       struct cpuidle_state *idle = idle_get_state(rq);
> +			s64 break_even = idle_get_break_even(rq);
> +

Nit: there's tabs in that line break.

>                       if (idle && idle->exit_latency < min_exit_latency) {
>                               /*
>                                * We give priority to a CPU whose idle state
> @@ -5817,10 +5820,21 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>                                * of any idle timestamp.
>                                */
>                               min_exit_latency = idle->exit_latency;
> +				min_break_even = break_even;
>                               latest_idle_timestamp = rq->idle_stamp;
>                               shallowest_idle_cpu = i;
> -			} else if ((!idle || idle->exit_latency == min_exit_latency) &&
> -				   rq->idle_stamp > latest_idle_timestamp) {
> +			} else if ((idle && idle->exit_latency == min_exit_latency) &&
> +				   break_even < min_break_even) {
> +				/*
> +				 * We give priority to the shallowest
> +				 * idle states with the minimal break
> +				 * even deadline to decrease the
> +				 * probability to choose a CPU which
> +				 * did not reach its break even yet
> +				 */
> +				min_break_even = break_even;
> +				shallowest_idle_cpu = i;
> +			} else if (!idle && rq->idle_stamp > latest_idle_timestamp) {
>                               /*
>                                * If equal or no active idle state, then
>                                * the most recently idled CPU might have

That comment will need to be changed as well, that condition now only
catters to the !idle case.

With that said, that comment actually raises a valid point: picking
recently idled CPUs might give us warmer cache. So by using the break
even stat, we can end up picking CPUs with colder caches (have been
idling for longer) than the current logic would. I suppose more testing
will tell us where we stand.

> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index b743bf38f08f..189cd51cd474 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -19,7 +19,14 @@ extern char __cpuidle_text_start[], __cpuidle_text_end[];
>   */
>  void sched_idle_set_state(struct cpuidle_state *idle_state)
>  {
> -	idle_set_state(this_rq(), idle_state);
> +	struct rq *rq = this_rq();
> +	ktime_t kt;
> +
> +	if (likely(idle_state)) {

Doesn't this break things? e.g. calling this with NULL?

> +		kt = ktime_add_ns(ktime_get(), idle_state->exit_latency_ns);

ISTR there were objections to using ktime stuff in the scheduler, but I
can't remember anything specific. If we only call into it when actually
entering an idle state (and not when we're exiting one), I suppose that
would be fine?

> +		idle_set_state(rq, idle_state);
> +		idle_set_break_even(rq, ktime_to_ns(kt));
> +	}
>  }
>
>  static int __read_mostly cpu_idle_force_poll;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2a0caf394dd4..abf2d2e73575 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1015,6 +1015,7 @@ struct rq {
>  #ifdef CONFIG_CPU_IDLE
>       /* Must be inspected within a rcu lock section */
>       struct cpuidle_state	*idle_state;
> +	s64			break_even;

Why signed? This should be purely positive, right?

>  #endif
>  };
>
> @@ -1850,6 +1851,16 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
>
>       return rq->idle_state;
>  }
> +
> +static inline void idle_set_break_even(struct rq *rq, s64 break_even)
> +{
> +	rq->break_even = break_even;
> +}
> +
> +static inline s64 idle_get_break_even(struct rq *rq)
> +{
> +	return rq->break_even;
> +}

I'm not super familiar with the callsites for setting idle states,
what's the locking situation there? Do we have any rq lock?

In find_idlest_group_cpu() we're in a read-side RCU section, so the
idle_state is protected (speaking of which, why isn't idle_get_state()
using rcu_dereference()?), but that's doesn't cover the break even.

IIUC at the very least we may want to give them the READ/WRITE_ONCE()
treatment.
