Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D6C28CBC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 00:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D33206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 00:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgEDAKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 20:10:50 -0400
Received: from foss.arm.com ([217.140.110.172]:34614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgEDAKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 20:10:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA297101E;
        Sun,  3 May 2020 17:10:49 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64D273F305;
        Sun,  3 May 2020 17:10:48 -0700 (PDT)
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
In-reply-to: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
Date:   Mon, 04 May 2020 01:10:46 +0100
Message-ID: <jhjwo5sd0ft.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 03/05/20 09:34, Peng Liu wrote:
> commit c5afb6a87f23 ("sched/fair: Fix nohz.next_balance update")

I got confused because this has the same topic as your patch, but that's a
genuine commit from 2015. Is this meant to be a "Fixes:" reference?

> During idle load balance, this_cpu(ilb) do load balance for the other
> idle CPUs, also gather the earliest (nohz.)next_balance.
>
> Since commit:
>   'b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")'
>
> We update nohz.next_balance like this:
>
>   _nohz_idle_balance() {
>       for_each_cpu(nohz.idle_cpus_mask) {
>         rebalance_domains() {
>                     update nohz.next_balance <-- compare and update
>         }
>       }
>       rebalance_domains(this_cpu) {
>         update nohz.next_balance <-- compare and update
>       }
>       update nohz.next_balance <-- unconditionally update
>   }
>
> For instance, nohz.idle_cpus_mask spans {cpu2,3,5,8}, and this_cpu is
> cpu5. After the above loop we could gather the earliest *next_balance*
> among {cpu2,3,8}, then rebalance_domains(this_cpu) update
> nohz.next_balance with this_rq->next_balance, but finally overwrite
> nohz.next_balance with the earliest *next_balance* among {cpu2,3,8},
> we may end up with not getting the earliest next_balance.
>

That does look like it, nice catch!

> Since we can gather all the updated rq->next_balance, including this_cpu,
> in _nohz_idle_balance(), it's safe to remove the extra lines in
> rebalance_domains() which are originally intended for this_cpu. And
> finally the updating only happen in _nohz_idle_balance().
>

One added benefit of this is that we get rid of extra writes to
nohz.next_balance, since that special case in rebalance_domains() could be
hit by all NOHZ CPUs, not just the ILB.

With the below comment taken into account:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..1d0cf33fefad 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9943,22 +9943,8 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>        * When the cpu is attached to null domain for ex, it will not be
>        * updated.
>        */
> -	if (likely(update_next_balance)) {
> +	if (likely(update_next_balance))
>               rq->next_balance = next_balance;
> -
> -#ifdef CONFIG_NO_HZ_COMMON
> -		/*
> -		 * If this CPU has been elected to perform the nohz idle
> -		 * balance. Other idle CPUs have already rebalanced with
> -		 * nohz_idle_balance() and nohz.next_balance has been
> -		 * updated accordingly. This CPU is now running the idle load
> -		 * balance for itself and we need to update the
> -		 * nohz.next_balance accordingly.
> -		 */
> -		if ((idle == CPU_IDLE) && time_after(nohz.next_balance, rq->next_balance))
> -			nohz.next_balance = rq->next_balance;
> -#endif
> -	}
>  }
>
>  static inline int on_null_domain(struct rq *rq)
> @@ -10321,9 +10307,15 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>               has_blocked_load |= this_rq->has_blocked_load;
>       }
>
> -	if (flags & NOHZ_BALANCE_KICK)
> +	if (flags & NOHZ_BALANCE_KICK) {
>               rebalance_domains(this_rq, CPU_IDLE);
>
> +		if (time_after(next_balance, this_rq->next_balance)) {
> +			next_balance = this_rq->next_balance;
> +			update_next_balance = 1;
> +		}
> +	}

To align with what we do for the other NOHZ CPUs, shouldn't this update
be outside of the NOHZ_BALANCE_KICK condition? That way we can update
nohz.next_balance with just NOHZ_STATS_KICK, which IMO is the expected
course of action.

> +
>       WRITE_ONCE(nohz.next_blocked,
>               now + msecs_to_jiffies(LOAD_AVG_PERIOD));
