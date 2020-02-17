Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66AFC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99145214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgBQRHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:07:47 -0500
Received: from foss.arm.com ([217.140.110.172]:38866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbgBQRHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:07:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC9981FB;
        Mon, 17 Feb 2020 09:07:45 -0800 (PST)
Received: from [10.1.195.59] (ifrit.cambridge.arm.com [10.1.195.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52CCB3F68F;
        Mon, 17 Feb 2020 09:07:44 -0800 (PST)
Subject: Re: [PATCH 1/3] sched/rt: cpupri_find: implement fallback mechanism
 for !fit case
To:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-2-qais.yousef@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <3feb31bb-3412-b38c-07a3-136433c87e66@arm.com>
Date:   Mon, 17 Feb 2020 17:07:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214163949.27850-2-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/20 4:39 PM, Qais Yousef wrote:
> When searching for the best lowest_mask with a fitness_fn passed, make
> sure we record the lowest_level that returns a valid lowest_mask so that
> we can use that as a fallback in case we fail to find a fitting CPU at
> all levels.
> 
> The intention in the original patch was not to allow a down migration to
> unfitting CPU. But this missed the case where we are already running on
> unfitting one.
> 
> With this change now RT tasks can still move between unfitting CPUs when
> they're already running on such CPU.
> 
> And as Steve suggested; to adhere to the strict priority rules of RT, if
> a task is already running on a fitting CPU but due to priority it can't
> run on it, allow it to downmigrate to unfitting CPU so it can run.
> 
> Reported-by: Pavan Kondeti <pkondeti@codeaurora.org>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/cpupri.c | 157 +++++++++++++++++++++++++++---------------
>  1 file changed, 101 insertions(+), 56 deletions(-)
> 
> diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> index 1a2719e1350a..1bcfa1995550 100644
> --- a/kernel/sched/cpupri.c
> +++ b/kernel/sched/cpupri.c
> @@ -41,6 +41,59 @@ static int convert_prio(int prio)
>  	return cpupri;
>  }
>  
> +static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
> +				struct cpumask *lowest_mask, int idx)
> +{
> +	struct cpupri_vec *vec  = &cp->pri_to_cpu[idx];
> +	int skip = 0;
> +
> +	if (!atomic_read(&(vec)->count))
> +		skip = 1;
> +	/*
> +	 * When looking at the vector, we need to read the counter,
> +	 * do a memory barrier, then read the mask.
> +	 *
> +	 * Note: This is still all racey, but we can deal with it.
> +	 *  Ideally, we only want to look at masks that are set.
> +	 *
> +	 *  If a mask is not set, then the only thing wrong is that we
> +	 *  did a little more work than necessary.
> +	 *
> +	 *  If we read a zero count but the mask is set, because of the
> +	 *  memory barriers, that can only happen when the highest prio
> +	 *  task for a run queue has left the run queue, in which case,
> +	 *  it will be followed by a pull. If the task we are processing
> +	 *  fails to find a proper place to go, that pull request will
> +	 *  pull this task if the run queue is running at a lower
> +	 *  priority.
> +	 */
> +	smp_rmb();
> +
> +	/* Need to do the rmb for every iteration */
> +	if (skip)
> +		return 0;
> +
> +	if (cpumask_any_and(p->cpus_ptr, vec->mask) >= nr_cpu_ids)
> +		return 0;
> +
> +	if (lowest_mask) {
> +		cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
> +
> +		/*
> +		 * We have to ensure that we have at least one bit
> +		 * still set in the array, since the map could have
> +		 * been concurrently emptied between the first and
> +		 * second reads of vec->mask.  If we hit this
> +		 * condition, simply act as though we never hit this
> +		 * priority level and continue on.
> +		 */
> +		if (cpumask_empty(lowest_mask))
> +			return 0;
> +	}
> +
> +	return 1;
> +}
> +

Just a drive-by comment; could you split that code move into its own patch?
It'd make the history a bit easier to read IMO.
