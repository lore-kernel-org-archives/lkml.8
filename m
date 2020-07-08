Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3966C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFEB2078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGHJpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:45:02 -0400
Received: from foss.arm.com ([217.140.110.172]:56600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgGHJpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:45:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F29FC0A;
        Wed,  8 Jul 2020 02:45:01 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 844343F718;
        Wed,  8 Jul 2020 02:44:59 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: handle case of task_h_load() returning 0
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com
References: <20200702144258.19326-1-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4198cf3d-308e-feee-91c3-2edfd1748b4c@arm.com>
Date:   Wed, 8 Jul 2020 11:44:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702144258.19326-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2020 16:42, Vincent Guittot wrote:
> task_h_load() can return 0 in some situations like running stress-ng
> mmapfork, which forks thousands of threads, in a sched group on a 224 cores
> system. The load balance doesn't handle this correctly because

I guess the issue here is that 'cfs_rq->h_load' in 

task_h_load() {
    struct cfs_rq *cfs_rq = task_cfs_rq(p);
    ...   
    return div64_ul(p->se.avg.load_avg * cfs_rq->h_load,
                    cfs_rq_load_avg(cfs_rq) + 1);
}

is still ~0 (or at least pretty small) compared to se.avg.load_avg being
1024 and cfs_rq_load_avg(cfs_rq) n*1024 in these lb occurrences.
 
> env->imbalance never decreases and it will stop pulling tasks only after
> reaching loop_max, which can be equal to the number of running tasks of
> the cfs. Make sure that imbalance will be decreased by at least 1.
> 
> misfit task is the other feature that doesn't handle correctly such
> situation although it's probably more difficult to face the problem
> because of the smaller number of CPUs and running tasks on heterogenous
> system.
> 
> We can't simply ensure that task_h_load() returns at least one because it
> would imply to handle underrun in other places.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6fab1d17c575..62747c24aa9e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4049,7 +4049,13 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>  		return;
>  	}
>  
> -	rq->misfit_task_load = task_h_load(p);
> +	/*
> +	 * Make sure that misfit_task_load will not be null even if
> +	 * task_h_load() returns 0. misfit_task_load is only used to select
> +	 * rq with highest load so adding 1 will not modify the result
> +	 * of the comparison.
> +	 */
> +	rq->misfit_task_load = task_h_load(p) + 1;
>  }
>  
>  #else /* CONFIG_SMP */
> @@ -7664,6 +7670,16 @@ static int detach_tasks(struct lb_env *env)
>  			    env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
>  				goto next;
>  
> +			/*
> +			 * Depending of the number of CPUs and tasks and the
> +			 * cgroup hierarchy, task_h_load() can return a null
> +			 * value. Make sure that env->imbalance decreases
> +			 * otherwise detach_tasks() will stop only after
> +			 * detaching up to loop_max tasks.
> +			 */
> +			if (!load)
> +				load = 1;
> +
>  			env->imbalance -= load;
>  			break;

I assume that this is related to the LKP mail

https://lkml.kernel.org/r/20200421004749.GC26573@shao2-debian ?

I ran the test (5.8.0-rc4 w/o vs. w/ your patch) on 'Intel(R) Xeon(R)
CPU E5-2690 v2 @ 3.00GHz' (2*2*10, 40 CPUs).
I can't see the changes in the magnitude shown in the email above (they
used a 96 CPU system though).
I used only scheduler stressor mmapfork in taskgroup /A/B/C:

 stress-ng --timeout 1 --times --verify --metrics-brief --sequential 40 --class scheduler --exclude (all except mmapfork)

5.8.0-rc4-custom-dieegg01-stress-ng-base

stress-ng: info:  [3720]  stressor      bogo ops real time  usr time  sys time   bogo ops/s   bogo ops/s
stress-ng: info:  [3720]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
stress-ng: info:  [3720]  mmapfork            40      1.98     12.53     71.12        20.21         0.48
stress-ng: info:  [5201]  mmapfork            40      2.50     13.10     98.61        16.01         0.36
stress-ng: info:  [6682]  mmapfork            40      2.58     14.80     98.63        15.88         0.36
stress-ng: info:  [8195]  mmapfork            40      1.79     12.57     61.61        22.31         0.54
stress-ng: info:  [9679]  mmapfork            40      2.20     12.17     82.66        18.20         0.42
stress-ng: info:  [11164] mmapfork            40      2.61     15.09    102.86        16.86         0.37
stress-ng: info:  [12773] mmapfork            40      1.89     12.32     65.09        21.15         0.52
stress-ng: info:  [3883]  mmapfork            40      2.14     12.90     76.73        18.68         0.45
stress-ng: info:  [6845]  mmapfork            40      2.25     11.83     84.06        17.80         0.42
stress-ng: info:  [8326]  mmapfork            40      1.76     12.93     56.65        22.70         0.57

                                                                                Mean: 18.98 (σ: 2.369)
5.8.0-rc4-custom-dieegg01-stress-ng

stress-ng: info:  [3895]  mmapfork            40      2.40     13.56     92.83        16.67         0.38
stress-ng: info:  [5379]  mmapfork            40      2.08     13.65     74.11        19.23         0.46
stress-ng: info:  [6860]  mmapfork            40      2.15     13.72     80.24        18.62         0.43
stress-ng: info:  [8341]  mmapfork            40      2.37     13.74     90.93        16.85         0.38
stress-ng: info:  [9822]  mmapfork            40      2.10     12.48     83.85        19.09         0.42
stress-ng: info:  [13816] mmapfork            40      2.05     12.13     77.64        19.49         0.45
stress-ng: info:  [15297] mmapfork            40      2.53     13.16    100.26        15.84         0.35
stress-ng: info:  [16780] mmapfork            40      2.00     12.10     71.25        20.02         0.48
stress-ng: info:  [18262] mmapfork            40      1.73     12.24     57.69        23.09         0.57
stress-ng: info:  [19743] mmapfork            40      1.78     12.51     57.89        22.48         0.57

                                                                                Mean: 19.14 (σ: 2.239)





