Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34477C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8FF20720
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgFQKub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:50:31 -0400
Received: from foss.arm.com ([217.140.110.172]:55476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQKua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:50:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B38A331B;
        Wed, 17 Jun 2020 03:50:29 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 492583F71F;
        Wed, 17 Jun 2020 03:50:28 -0700 (PDT)
References: <20200616164801.18644-1-peter.puhov@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     peter.puhov@linaro.org
Cc:     linux-kernel@vger.kernel.org, robert.foley@linaro.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] sched/fair: update_pick_idlest() Select group with lowest group_util when idle_cpus are equal
In-reply-to: <20200616164801.18644-1-peter.puhov@linaro.org>
Date:   Wed, 17 Jun 2020 11:50:22 +0100
Message-ID: <jhjo8pidl01.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/06/20 17:48, peter.puhov@linaro.org wrote:
> From: Peter Puhov <peter.puhov@linaro.org>
> We tested this patch with following benchmarks:
>   perf bench -f simple sched pipe -l 4000000
>   perf bench -f simple sched messaging -l 30000
>   perf bench -f simple  mem memset -s 3GB -l 15 -f default
>   perf bench -f simple futex wake -s -t 640 -w 1
>   sysbench cpu --threads=8 --cpu-max-prime=10000 run
>   sysbench memory --memory-access-mode=rnd --threads=8 run
>   sysbench threads --threads=8 run
>   sysbench mutex --mutex-num=1 --threads=8 run
>   hackbench --loops 20000
>   hackbench --pipe --threads --loops 20000
>   hackbench --pipe --threads --loops 20000 --datasize 4096
>
> and found some performance improvements in:
>   sysbench threads
>   sysbench mutex
>   perf bench futex wake
> and no regressions in others.
>

One nitpick for the results of those: condensing them in a table form would
make them more reader-friendly. Perhaps something like:

| Benchmark        | Metric   | Lower is better? | BASELINE | SERIES | DELTA |
|------------------+----------+------------------+----------+--------+-------|
| Sysbench threads | # events | No               |    45526 |  56567 |  +24% |
| Sysbench mutex   | ...      |                  |          |        |       |

If you want to include more stats for each benchmark, you could have one table
per (e.g. see [1]) - it'd still be a more readable form (or so I believe).

[1]: https://lore.kernel.org/lkml/20200206191957.12325-1-valentin.schneider@arm.com/

> ---
>  kernel/sched/fair.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..abcbdf80ee75 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8662,8 +8662,14 @@ static bool update_pick_idlest(struct sched_group *idlest,
>
>       case group_has_spare:
>               /* Select group with most idle CPUs */
> -		if (idlest_sgs->idle_cpus >= sgs->idle_cpus)
> +		if (idlest_sgs->idle_cpus > sgs->idle_cpus)
>                       return false;
> +
> +		/* Select group with lowest group_util */
> +		if (idlest_sgs->idle_cpus == sgs->idle_cpus &&
> +			idlest_sgs->group_util <= sgs->group_util)
> +			return false;
> +
>               break;
>       }

update_sd_pick_busiest() uses the group's nr_running instead. You mention
in the changelog that using nr_running is a possible alternative, did you
try benchmarking that and seeing how it compares to using group_util?

I think it would be nice to keep pick_busiest() and pick_idlest() aligned
wherever possible/sensible.

Also, there can be cases where one group has a few "big" tasks and another
has a handful more "small" tasks. Say something like

  sgs_a->group_util = U
  sgs_a->sum_nr_running = N

  sgs_b->group_util = U*4/3
  sgs_b->sum_nr_running = N*2/3

  (sgs_b has more util per task, i.e. bigger tasks on average)

Given that we're in the 'group_has_spare' case, I would think picking the
group with the lesser amount of running tasks would make sense. Though I
guess you can find pathological cases where the util per task difference is
huge and we should look at util first...
