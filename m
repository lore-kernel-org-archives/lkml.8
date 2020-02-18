Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B298C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2F120801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgBRR1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:27:51 -0500
Received: from foss.arm.com ([217.140.110.172]:56790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgBRR1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:27:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 706AD31B;
        Tue, 18 Feb 2020 09:27:50 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EBD03F703;
        Tue, 18 Feb 2020 09:27:49 -0800 (PST)
Date:   Tue, 18 Feb 2020 17:27:46 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/rt: cpupri_find: implement fallback mechanism
 for !fit case
Message-ID: <20200218172745.hd7fxjqnzqkhfqx3@e107158-lin.cambridge.arm.com>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-2-qais.yousef@arm.com>
 <c0772fca-0a4b-c88d-fdf2-5715fcf8447b@arm.com>
 <20200217234549.rpv3ns7bd7l6twqu@e107158-lin>
 <20200218114658.74236b3c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200218114658.74236b3c@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/20 11:46, Steven Rostedt wrote:
> On Mon, 17 Feb 2020 23:45:49 +0000
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -14,6 +14,8 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
> > 
> >  struct rt_bandwidth def_rt_bandwidth;
> > 
> > +typedef bool (*fitness_fn_t)(struct task_struct *p, int cpu);
> > +
> >  static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
> >  {
> >         struct rt_bandwidth *rt_b =
> > @@ -1708,6 +1710,7 @@ static int find_lowest_rq(struct task_struct *task)
> >         struct cpumask *lowest_mask = this_cpu_cpumask_var_ptr(local_cpu_mask);
> >         int this_cpu = smp_processor_id();
> >         int cpu      = task_cpu(task);
> > +       fitness_fn_t fitness_fn;
> > 
> >         /* Make sure the mask is initialized first */
> >         if (unlikely(!lowest_mask))
> > @@ -1716,8 +1719,17 @@ static int find_lowest_rq(struct task_struct *task)
> >         if (task->nr_cpus_allowed == 1)
> >                 return -1; /* No other targets possible */
> > 
> > +       /*
> > +        * Help cpupri_find avoid the cost of looking for a fitting CPU when
> > +        * not really needed.
> > +        */
> > +       if (static_branch_unlikely(&sched_asym_cpucapacity))
> > +               fitness_fn = rt_task_fits_capacity;
> > +       else
> > +               fitness_fn = NULL;
> > +
> >         if (!cpupri_find(&task_rq(task)->rd->cpupri, task, lowest_mask,
> > -                        rt_task_fits_capacity))
> > +                        fitness_fn))
> >                 return -1; /* No targets found */
> > 
> >         /*
> 
> 
> If we are going to use static branches, then lets just remove the
> parameter totally. That is, make two functions (with helpers), where
> one needs this fitness function the other does not.
> 
> 	if (static_branch_unlikely(&sched_asym_cpu_capacity))
> 		ret = cpupri_find_fitness(...);
> 	else
> 		ret = cpupri_find(...);
> 
> 	if (!ret)
> 		return -1;
> 
> Something like that?

Is there any implication on code generation here?

I like my flavour better tbh. But I don't mind refactoring the function out if
it does make it more readable.

Thanks

--
Qais Yousef
