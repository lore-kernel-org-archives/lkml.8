Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529FAC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FEF222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="VOKnVSxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbgBUIHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:07:30 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:18036 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731581AbgBUIH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:07:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582272447; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=nvjRB7mZltcPZq0WrAN/lAFEXrIqJHzR18wkCF6HDlU=; b=VOKnVSxS7oHmeKmDt8QisaJUGQQ/ExD76zJ6N+3HCb1c8Tc53BgpHHddJeekoMbrzjx+NBRv
 RQRUSvtA0IRn2KDSYOAG8n7vg3ISIithCDy0TxrWhEXrQfa7wMxRy1SThoszt8NZY6g6MN+h
 xhhfIIPcWybDOfx/6BQSJXIdcRg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4f8fb0.7f824f909500-smtp-out-n02;
 Fri, 21 Feb 2020 08:07:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3C5A6C447AA; Fri, 21 Feb 2020 08:07:11 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 21CB4C4479F;
        Fri, 21 Feb 2020 08:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21CB4C4479F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Fri, 21 Feb 2020 13:37:01 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched/rt: allow pulling unfitting task
Message-ID: <20200221080701.GF28029@codeaurora.org>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-3-qais.yousef@arm.com>
 <20200217091042.GB28029@codeaurora.org>
 <20200219134306.4uvnlh4co3zwohzw@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219134306.4uvnlh4co3zwohzw@e107158-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quais,

On Wed, Feb 19, 2020 at 01:43:08PM +0000, Qais Yousef wrote:

[...]

> > 
> > Here rq is source rq from which the task is being pulled. I can't understand
> > how marking overload condition on source_rq help. Because overload condition
> > gets cleared in the task dequeue path. i.e dec_rt_tasks->dec_rt_migration->
> > update_rt_migration().
> > 
> > Also, the overload condition with nr_running=1 may not work as expected unless
> > we track this overload condition (due to unfit) separately. Because a task
> > can be pushed only when it is NOT running. So a task running on silver will
> > continue to run there until it wakes up next time or another high prio task
> > gets queued here (due to affinity).
> > 
> > btw, Are you testing this path by disabling RT_PUSH_IPI feature? I ask this
> > because, This feature gets turned on by default in our b.L platforms and
> > RT task migrations happens by the busy CPU pushing the tasks. Or are there
> > any cases where we can run into pick_rt_task() even when RT_PUSH_IPI is
> > enabled?
> 
> I changed the approach to set the overload at wake up now. I think I got away
> without having to encode the reason in rq->rt.overload.
> 
> Steve, Pavan, if you can scrutinize this approach I'd be appreciated. It seemed
> to work fine with my testing.
> 

The 1st patch in this series added the support to return an unfit CPU incase
all other BIG CPUs are busy with RT tasks. I believe that change it self
solves the RT tasks spreading problem if we just remove
rt_task_fits_capacity() from pick_rt_task(). In fact rt_task_fits_capacity()
can also be removed from switched_to_rt() and task_woken_rt(). Because
a RT task can be pulled/pushed only if it not currently running. If the
intention is to push/pull a running RT task from an unfit CPU to a BIG CPU,
that won't work as we are not waking any migration/X to carry the migration.

If an CPU has 2 RT tasks (excluding the running RT task), then we have a
choice about which RT task to be pushed based on the destination CPU's
capacity. Are we trying to solve this problem in this patch?

Please see the below comments as well and let me know if we are on the
same page or not.

> 
> 
> When implemented RT Capacity Awareness; the logic was done such that if
> a task was running on a fitting CPU, then it was sticky and we would try
> our best to keep it there.
> 
> But as Steve suggested, to adhere to the strict priority rules of RT
> class; allow pulling an RT task to unfitting CPU to ensure it gets a
> chance to run ASAP.
> 
> To better handle the fact the task is running on unfit CPU, when it
> wakes up mark it as overloaded which will cause it to be pushed to
> a fitting CPU when it becomes available.
> 
> The latter change requires teaching push_rt_task() how to handle pushing
> unfit task.
> 
> If the unfit task is the only pushable task, then we only force the push
> if we find a fitting CPU. Otherwise we bail out.
> 
> Else if the task is higher priorirty than current task, then we
> reschedule.
> 
> Else if the rq has other pushable tasks, then we push the unfitting task
> anyway to reduce the pressure on the rq even if the target CPU is unfit
> too.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/rt.c | 52 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 6d959be4bba0..6d92219d5733 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1658,8 +1658,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>  static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
>  {
>  	if (!task_running(rq, p) &&
> -	    cpumask_test_cpu(cpu, p->cpus_ptr) &&
> -	    rt_task_fits_capacity(p, cpu))
> +	    cpumask_test_cpu(cpu, p->cpus_ptr))
>  		return 1;
>  

Yes. We come here means rq has more than 1 runnable task, so we prefer
spreading.

>  	return 0;
> @@ -1860,6 +1859,7 @@ static int push_rt_task(struct rq *rq)
>  	struct task_struct *next_task;
>  	struct rq *lowest_rq;
>  	int ret = 0;
> +	bool fit;
>  
>  	if (!rq->rt.overloaded)
>  		return 0;
> @@ -1872,12 +1872,21 @@ static int push_rt_task(struct rq *rq)
>  	if (WARN_ON(next_task == rq->curr))
>  		return 0;
>  
> +	/*
> +	 * The rq could be overloaded because it has unfitting task, if that's
> +	 * the case they we need to try harder to find a better fitting CPU.
> +	 */
> +	fit = rt_task_fits_capacity(next_task, cpu_of(rq));
> +
>  	/*
>  	 * It's possible that the next_task slipped in of
>  	 * higher priority than current. If that's the case
>  	 * just reschedule current.
> +	 *
> +	 * Unless next_task doesn't fit in this cpu, then continue with the
> +	 * attempt to push it.
>  	 */
> -	if (unlikely(next_task->prio < rq->curr->prio)) {
> +	if (unlikely(next_task->prio < rq->curr->prio && fit)) {
>  		resched_curr(rq);
>  		return 0;
>  	}
> @@ -1920,6 +1929,33 @@ static int push_rt_task(struct rq *rq)
>  		goto retry;
>  	}
>  
> +	/*
> +	 * Bail out if the task doesn't fit on either CPUs.
> +	 *
> +	 * Unless..
> +	 *
> +	 * * The priority of next_task is higher than current, then we
> +	 *   resched_curr(). We forced skipping this condition above.
> +	 *
> +	 * * The rq has more tasks to push, then we probably should push anyway
> +	 *   reduce the load on this rq.
> +	 */
> +	if (!fit && !rt_task_fits_capacity(next_task, cpu_of(lowest_rq))) {
> +
> +		/* we forced skipping this condition, so re-evaluate it */
> +		if (unlikely(next_task->prio < rq->curr->prio)) {
> +			resched_curr(rq);
> +			goto out_unlock;
> +		}
> +
> +		/*
> +		 * If there are more tasks to push, then the rq is overloaded
> +		 * with more than just this task, so push anyway.
> +		 */
> +		if (has_pushable_tasks(rq))
> +			goto out_unlock;

The next_task is not yet removed from the pushable_tasks list, so this will
always be true and we skip pushing. Even if you add some logic, what happens
if the other task also does not fit? How would the task finally be pushed
to other CPUs?

> +	}
> +
>  	deactivate_task(rq, next_task, 0);
>  	set_task_cpu(next_task, lowest_rq->cpu);
>  	activate_task(lowest_rq, next_task, 0);
> @@ -1927,6 +1963,7 @@ static int push_rt_task(struct rq *rq)
>  
>  	resched_curr(lowest_rq);
>  
> +out_unlock:
>  	double_unlock_balance(rq, lowest_rq);
>  
>  out:
> @@ -2223,7 +2260,14 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
>  			    (rq->curr->nr_cpus_allowed < 2 ||
>  			     rq->curr->prio <= p->prio);
>  
> -	if (need_to_push || !rt_task_fits_capacity(p, cpu_of(rq)))
> +	bool fit = rt_task_fits_capacity(p, cpu_of(rq));
> +
> +	if (!fit && !rq->rt.overloaded) {
> +		rt_set_overload(rq);
> +		rq->rt.overloaded = 1;
> +	}
> +
> +	if (need_to_push || !fit)
>  		push_rt_tasks(rq);
>  }

If this is the only RT task queued on this CPU and current task is not a RT
task, why are we calling push_rt_tasks() in case if unfit scenario. In most
cases, the task is woken on this rq, because there is no other higher capacity
rq that can take this task for whatever reason.

btw, if we set overload condition with just 1 RT task, we keep receiving the
IPI (irq work) to push the task and we can't do that because a running RT
task can't be pushed.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
