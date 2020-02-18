Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F33C3404C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369812464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgBRVT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:19:57 -0500
Received: from foss.arm.com ([217.140.110.172]:34482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgBRVT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:19:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A43351FB;
        Tue, 18 Feb 2020 13:19:56 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D952D3F68F;
        Tue, 18 Feb 2020 13:19:54 -0800 (PST)
Subject: Re: [PATCH v2 4/5] sched/pelt: Add a new runnable average signal
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, hdanton@sina.com
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-5-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4cda8dc3-f6bb-2896-c899-65eadd5c839d@arm.com>
Date:   Tue, 18 Feb 2020 21:19:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214152729.6059-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2020 15:27, Vincent Guittot wrote:
> Now that runnable_load_avg has been removed, we can replace it by a new
> signal that will highlight the runnable pressure on a cfs_rq. This signal
> track the waiting time of tasks on rq and can help to better define the
> state of rqs.
> 
> At now, only util_avg is used to define the state of a rq:
>   A rq with more that around 80% of utilization and more than 1 tasks is
>   considered as overloaded.
> 
> But the util_avg signal of a rq can become temporaly low after that a task
> migrated onto another rq which can bias the classification of the rq.
> 
> When tasks compete for the same rq, their runnable average signal will be
> higher than util_avg as it will include the waiting time and we can use
> this signal to better classify cfs_rqs.
> 
> The new runnable_avg will track the runnable time of a task which simply
> adds the waiting time to the running time. The runnable _avg of cfs_rq
> will be the /Sum of se's runnable_avg and the runnable_avg of group entity
> will follow the one of the rq similarly to util_avg.
> 

I did a bit of playing around with tracepoints and it seems to be behaving
fine. For instance, if I spawn 12 always runnable tasks (sysbench --test=cpu)
on my Juno (6 CPUs), I get to a system-wide runnable value (\Sum cpu_runnable())
of about 12K. I've only eyeballed them, but migration of the signal values
seem fine too.

I have a slight worry that the rq-wide runnable signal might be too easy to
inflate, since we aggregate for *all* runnable tasks, and that may not play
well with your group_is_overloaded() change (despite having the imbalance_pct
on the "right" side).

In any case I'll need to convince myself of it with some messing around, and
this concerns patch 5 more than patch 4. So FWIW for this one:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

I also have one (two) more nit(s) below.

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> @@ -227,14 +231,14 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
>  	 * Step 1: accumulate *_sum since last_update_time. If we haven't
>  	 * crossed period boundaries, finish.
>  	 */
> -	if (!accumulate_sum(delta, sa, load, running))
> +	if (!accumulate_sum(delta, sa, load, runnable, running))
>  		return 0;
>  
>  	return 1;
>  }
>  
>  static __always_inline void
> -___update_load_avg(struct sched_avg *sa, unsigned long load)
> +___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runnable)
>  {
>  	u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
>  
> @@ -242,6 +246,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
>  	 * Step 2: update *_avg.
>  	 */
>  	sa->load_avg = div_u64(load * sa->load_sum, divider);
> +	sa->runnable_avg =	div _u64(runnable * sa->runnable_sum, divider);
                          ^^^^^^        ^^^^^^^^
                            a)             b)
a) That's a tab

b) The value being passed is always 1, do we really need it to expose it as a
   parameter?
