Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25956C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0251D206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgBQNxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:53:11 -0500
Received: from foss.arm.com ([217.140.110.172]:36092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbgBQNxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:53:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC24430E;
        Mon, 17 Feb 2020 05:53:10 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C5903F703;
        Mon, 17 Feb 2020 05:53:09 -0800 (PST)
Date:   Mon, 17 Feb 2020 13:53:07 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched/rt: fix pushing unfit tasks to a better CPU
Message-ID: <20200217135306.cjc2225wdlwqiicu@e107158-lin.cambridge.arm.com>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-4-qais.yousef@arm.com>
 <20200217092329.GC28029@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200217092329.GC28029@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17/20 14:53, Pavan Kondeti wrote:
> Hi Qais,
> 
> On Fri, Feb 14, 2020 at 04:39:49PM +0000, Qais Yousef wrote:
> 
> [...]
> 
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 0c8bac134d3a..5ea235f2cfe8 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1430,7 +1430,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
> >  {
> >  	struct task_struct *curr;
> >  	struct rq *rq;
> > -	bool test;
> > +	bool test, fit;
> >  
> >  	/* For anything but wake ups, just return the task_cpu */
> >  	if (sd_flag != SD_BALANCE_WAKE && sd_flag != SD_BALANCE_FORK)
> > @@ -1471,16 +1471,32 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
> >  	       unlikely(rt_task(curr)) &&
> >  	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
> >  
> > -	if (test || !rt_task_fits_capacity(p, cpu)) {
> > +	fit = rt_task_fits_capacity(p, cpu);
> > +
> > +	if (test || !fit) {
> >  		int target = find_lowest_rq(p);
> >  
> > -		/*
> > -		 * Don't bother moving it if the destination CPU is
> > -		 * not running a lower priority task.
> > -		 */
> > -		if (target != -1 &&
> > -		    p->prio < cpu_rq(target)->rt.highest_prio.curr)
> > -			cpu = target;
> > +		if (target != -1) {
> > +			/*
> > +			 * Don't bother moving it if the destination CPU is
> > +			 * not running a lower priority task.
> > +			 */
> > +			if (p->prio < cpu_rq(target)->rt.highest_prio.curr) {
> > +
> > +				cpu = target;
> > +
> > +			} else if (p->prio == cpu_rq(target)->rt.highest_prio.curr) {
> > +
> > +				/*
> > +				 * If the priority is the same and the new CPU
> > +				 * is a better fit, then move, otherwise don't
> > +				 * bother here either.
> > +				 */
> > +				fit = rt_task_fits_capacity(p, target);
> > +				if (fit)
> > +					cpu = target;
> > +			}
> > +		}
> 
> I understand that we are opting for the migration when priorities are tied but
> the task can fit on the new task. But there is no guarantee that this task
> stay there. Because any CPU that drops RT prio can pull the task. Then why
> not leave it to the balancer?

This patch does help in the 2 RT task test case. Without it I can see a big
delay for the task to migrate from a little CPU to a big one, although the big
is free.

Maybe my test is too short (1 second). The delay I've seen is 0.5-0.7s..

https://imgur.com/a/qKJk4w4

Maybe I missed the real root cause. Let me dig more.

> 
> I notice a case where tasks would migrate for no reason (happens without this
> patch also). Assuming BIG cores are busy with other RT tasks. Now this RT
> task can go to *any* little CPU. There is no bias towards its previous CPU.
> I don't know if it makes any difference but I see RT task placement is too
> keen on reducing the migrations unless it is absolutely needed.

In find_lowest_rq() there's a check if the task_cpu(p) is in the lowest_mask
and prefer it if it is.

But yeah I see it happening too

https://imgur.com/a/FYqLIko

Tasks on CPU 0 and 3 swap. Note that my tasks are periodic but the plots don't
show that.

I shouldn't have changed something to affect this bias. Do you think it's
something I introduced?

It's something maybe worth digging into though. I'll try to have a look.

Thanks

--
Qais Yousef
