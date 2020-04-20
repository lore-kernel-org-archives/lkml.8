Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7974C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0CD20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgDTWcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbgDTWcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:32:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6478520857;
        Mon, 20 Apr 2020 22:32:34 +0000 (UTC)
Date:   Mon, 20 Apr 2020 18:32:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 2/2] sched: Extract the task putting code from
 pick_next_task()
Message-ID: <20200420183232.16b83374@gandalf.local.home>
In-Reply-To: <7c1eab789cb4b53ec5f54644c089ce27ea14088a.1587309963.git.yu.c.chen@intel.com>
References: <cover.1587309963.git.yu.c.chen@intel.com>
        <7c1eab789cb4b53ec5f54644c089ce27ea14088a.1587309963.git.yu.c.chen@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 00:31:52 +0800
Chen Yu <yu.c.chen@intel.com> wrote:

> Introduce a new function finish_prev_task() to do the balance
> when necessary, and then put previous task back to the run queue.
> This function is extracted from pick_next_task() to prepare for
> future usage by other type of task picking logic.
> 
> No functional change.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/core.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3a61a3b8eaa9..bf59a5cf030c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3904,6 +3904,28 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
>  	schedstat_inc(this_rq()->sched_count);
>  }
>  
> +static void finish_prev_task(struct rq *rq, struct task_struct *prev,
> +			     struct rq_flags *rf)
> +{
> +	const struct sched_class *class;
> +#ifdef CONFIG_SMP
> +	/*
> +	 * We must do the balancing pass before put_next_task(), such

I know this is just a cut and paste move, but I'm thinking that this
comment is wrong. Shouldn't this be "put_prev_task()" as we have no
"put_next_task()" function.


> +	 * that when we release the rq->lock the task is in the same
> +	 * state as before we took rq->lock.
> +	 *
> +	 * We can terminate the balance pass as soon as we know there is
> +	 * a runnable task of @class priority or higher.
> +	 */
> +	for_class_range(class, prev->sched_class, &idle_sched_class) {
> +		if (class->balance(rq, prev, rf))
> +			break;
> +	}
> +#endif
> +
> +	put_prev_task(rq, prev);
> +}
> +
>  /*
>   * Pick up the highest-prio task:
>   */
> @@ -3937,22 +3959,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	}
>  
>  restart:
> -#ifdef CONFIG_SMP
> -	/*
> -	 * We must do the balancing pass before put_next_task(), such
> -	 * that when we release the rq->lock the task is in the same
> -	 * state as before we took rq->lock.
> -	 *
> -	 * We can terminate the balance pass as soon as we know there is
> -	 * a runnable task of @class priority or higher.
> -	 */
> -	for_class_range(class, prev->sched_class, &idle_sched_class) {
> -		if (class->balance(rq, prev, rf))
> -			break;
> -	}
> -#endif
> -
> -	put_prev_task(rq, prev);
> +	finish_prev_task(rq, prev, rf);

I'm not sure I like the name of this function. Perhaps
"balance_and_put_prev_task()"? Something more in kind to what the function
does.

-- Steve

>  
>  	for_each_class(class) {
>  		p = class->pick_next_task(rq);

