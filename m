Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABABAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86EC72083B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbgFSMvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:51:54 -0400
Received: from foss.arm.com ([217.140.110.172]:56780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgFSMvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:51:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 668032B;
        Fri, 19 Jun 2020 05:51:52 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB1BE3F6CF;
        Fri, 19 Jun 2020 05:51:50 -0700 (PDT)
Date:   Fri, 19 Jun 2020 13:51:48 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200619125148.y4cq3hwllgozbutq@e107158-lin.cambridge.arm.com>
References: <20200618195525.7889-1-qais.yousef@arm.com>
 <20200618195525.7889-3-qais.yousef@arm.com>
 <jhjwo43cpfl.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhjwo43cpfl.mognet@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/20 11:36, Valentin Schneider wrote:
> 
> On 18/06/20 20:55, Qais Yousef wrote:
> > There is a report that when uclamp is enabled, a netperf UDP test
> > regresses compared to a kernel compiled without uclamp.
> >
> > https://lore.kernel.org/lkml/20200529100806.GA3070@suse.de/
> >
> 
> ISTR the perennial form for those is: https://lkml.kernel.org/r/<message-id>

The link is correct permalinnk from lore and contains the message-id as Peter
likes and he has accepted this form before.

If you look closely you'll see that what you suggest is just moving 'lkml' to
replace lore in the dns name and put an /r/. I don't see a need to enforce one
form over the other as the one I used is much easier to get.

If Peter really insists I'll be happy to change.

[...]

> > +	 * This could happen if sched_uclamp_unused was disabled while the
> > +	 * current task was running, hence we could end up with unbalanced call
> > +	 * to uclamp_rq_dec_id().
> > +	 */
> > +	if (unlikely(!bucket->tasks))
> > +		return;
> 
> I'm slightly worried about silent returns for cases like these, can we try
> to cook something up to preserve the previous SCHED_WARN_ON()? Say,
> something like the horrendous below - alternatively might be feasible with
> with some clever p->on_rq flag.

I am really against extra churn and debug code to detect an impossible case
that is not really tricky for reviewers to discern. Outside of enqueue/dequeue
path, it's only used in update_uclamp_active(). It is quite easy to see that
it's impossible, except for the legit case now when we have a static key
changing when a task is running.

I am strongly against extra debug code just to be safe. It ends up with
confusion down the line and extra complexity, and since this is the hot path
maybe potential extra variables to mess with cache behaviors.

Thanks

--
Qais Yousef

> 
> ---
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b62e6aaf28f0..09a7891eb481 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -695,6 +695,9 @@ struct task_struct {
>         struct uclamp_se		uclamp_req[UCLAMP_CNT];
>         /* Effective clamp values used for a scheduling entity */
>         struct uclamp_se		uclamp[UCLAMP_CNT];
> +#ifdef CONFIG_SCHED_DEBUG
> +	int                             uclamp_unused_enqueue;
> +#endif
>  #endif
> 
>  #ifdef CONFIG_PREEMPT_NOTIFIERS
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2a712dcb682b..2a723e9d5219 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1018,8 +1018,10 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>          * current task was running, hence we could end up with unbalanced call
>          * to uclamp_rq_dec_id().
>          */
> -	if (unlikely(!bucket->tasks))
> +	if (unlikely(!bucket->tasks)) {
> +		SCHED_WARN_ON(!p->uclamp_unused_enqueue);
>                 return;
> +	}
> 
>         bucket->tasks--;
>         uc_se->active = false;
> @@ -1049,8 +1051,16 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>  {
>         enum uclamp_id clamp_id;
> 
> -	if (static_branch_likely(&sched_uclamp_unused))
> +#ifdef CONFIG_SCHED_DEBUG
> +	p->uclamp_unused_enqueue = 0;
> +#endif
> +
> +	if (static_branch_likely(&sched_uclamp_unused)) {
> +#ifdef CONFIG_SCHED_DEBUG
> +		p->uclamp_unused_enqueue = 1;
> +#endif
>                 return;
> +	}
> 
>         if (unlikely(!p->sched_class->uclamp_enabled))
>                 return;
> @@ -1075,6 +1085,10 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
> 
>         for_each_clamp_id(clamp_id)
>                 uclamp_rq_dec_id(rq, p, clamp_id);
> +
> +#ifdef CONFIG_SCHED_DEBUG
> +	p->uclamp_unused_enqueue = 0;
> +#endif
>  }
> 
>  static inline void
> ---
