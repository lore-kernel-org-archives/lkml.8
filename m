Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB26C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC60206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCFRvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:51:17 -0500
Received: from foss.arm.com ([217.140.110.172]:37088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgCFRvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:51:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC28230E;
        Fri,  6 Mar 2020 09:51:16 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BE3F3F6C4;
        Fri,  6 Mar 2020 09:51:15 -0800 (PST)
Date:   Fri, 6 Mar 2020 17:51:13 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] sched/rt: Fix pushing unfit tasks to a better CPU
Message-ID: <20200306175112.vkpeouec2c47yujl@e107158-lin.cambridge.arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
 <20200302132721.8353-7-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200302132721.8353-7-qais.yousef@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan

On 03/02/20 13:27, Qais Yousef wrote:
> If a task was running on unfit CPU we could ignore migrating if the
> priority level of the new fitting CPU is the *same* as the unfit one.
> 
> Add an extra check to select_task_rq_rt() to allow the push in case:
> 
> 	* p->prio == new_cpu.highest_priority
> 	* task_fits(p, new_cpu)
> 
> Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---

Can you please confirm if you have any objection to this patch? Without it
I see large delays in the 2 tasks test like I outlined in [1]. It wasn't clear
from [2] whether you are in agreement now or not.

[1] https://lore.kernel.org/lkml/20200217135306.cjc2225wdlwqiicu@e107158-lin.cambridge.arm.com/
[2] https://lore.kernel.org/lkml/20200227033608.GN28029@codeaurora.org/

Thanks

--
Qais Yousef

>  kernel/sched/rt.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index ce230bec6847..8aaa442e4867 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1474,20 +1474,35 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
>  	if (test || !rt_task_fits_capacity(p, cpu)) {
>  		int target = find_lowest_rq(p);
>  
> -		/*
> -		 * Bail out if we were forcing a migration to find a better
> -		 * fitting CPU but our search failed.
> -		 */
> -		if (!test && target != -1 && !rt_task_fits_capacity(p, target))
> -			goto out_unlock;
> +		if (target != -1) {
> +			bool fit_target = rt_task_fits_capacity(p, target);
>  
> -		/*
> -		 * Don't bother moving it if the destination CPU is
> -		 * not running a lower priority task.
> -		 */
> -		if (target != -1 &&
> -		    p->prio < cpu_rq(target)->rt.highest_prio.curr)
> -			cpu = target;
> +			/*
> +			 * Bail out if we were forcing a migration to find a
> +			 * better fitting CPU but our search failed.
> +			 */
> +			if (!test && !fit_target)
> +				goto out_unlock;
> +
> +			/*
> +			 * Don't bother moving it if the destination CPU is
> +			 * not running a lower priority task.
> +			 */
> +			if (p->prio < cpu_rq(target)->rt.highest_prio.curr) {
> +
> +				cpu = target;
> +
> +			} else if (p->prio == cpu_rq(target)->rt.highest_prio.curr) {
> +
> +				/*
> +				 * If the priority is the same and the new CPU
> +				 * is a better fit, then move, otherwise don't
> +				 * bother here either.
> +				 */
> +				if (fit_target)
> +					cpu = target;
> +			}
> +		}
>  	}
>  
>  out_unlock:
> -- 
> 2.17.1
> 
