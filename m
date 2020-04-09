Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E30C2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84E220771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgDINAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:00:23 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:48186 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgDINAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:00:23 -0400
Received: from [151.41.75.232] (account l.abeni@santannapisa.it HELO sweethome)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 147267237; Thu, 09 Apr 2020 15:00:21 +0200
Date:   Thu, 9 Apr 2020 15:00:10 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sched/deadline: Implement fallback mechanism for
 !fit case
Message-ID: <20200409150010.468951df@sweethome>
In-Reply-To: <20200409102557.h4humnsa5dlwvlym@e107158-lin.cambridge.arm.com>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
        <20200408095012.3819-5-dietmar.eggemann@arm.com>
        <20200409102557.h4humnsa5dlwvlym@e107158-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 9 Apr 2020 11:25:58 +0100
Qais Yousef <qais.yousef@arm.com> wrote:

> On 04/08/20 11:50, Dietmar Eggemann wrote:
> > From: Luca Abeni <luca.abeni@santannapisa.it>
> > 
> > When a task has a runtime that cannot be served within the
> > scheduling deadline by any of the idle CPU (later_mask) the task is
> > doomed to miss its deadline.
> > 
> > This can happen since the SCHED_DEADLINE admission control
> > guarantees only bounded tardiness and not the hard respect of all
> > deadlines. In this case try to select the idle CPU with the largest
> > CPU capacity to minimize tardiness.
> > 
> > Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > ---  
> 
> Outside of the scope of this series. But does it make sense to make
> sched_setattr() fail to create a new deadline task if the system will
> be overcommitted, hence causing some dl tasks to miss their deadlines?

The problem is that with multiple processors/cores it is not easy to
know in advance if any task will miss a deadline (see section 3.3 of
Documentation/scheduler/sched-deadline.rst).

The admission control we are currently using should prevent
SCHED_DEADLINE tasks from overloading the system (starving non-deadline
tasks); proving hard deadline guarantees with global EDF scheduling is
much more difficult (and could be probably done in user-space, I think).


> If some overcommitting is fine (some deadlines are soft and are okay
> to fail every once in a while), does it make sense for this to be a
> tunable of how much the system can be overcommitted before
> disallowing new DL tasks to be created?

There is already a tunable for the SCHED_DEADLINE admission test
(/proc/sys/kernel/sched_rt_{runtime,period}_us, if I understand well
what you are suggesting). The problem is that it is not easy to find a
value for this tunable that guarantees the hard respect of all
deadlines.


But IMHO if someone really wants hard deadline guarantees it is better
to use partitioned scheduling (see Section 5 of the SCHED_DEADLINE
documentation).



			Luca

> 
> Just thinking out loudly. This fallback is fine, but it made me think
> why did we have to end up in a situation that we can fail in the
> first place since the same info is available when a new DL task is
> created, and being preventative might be a better approach..
> 
> Thanks
> 
> --
> Qais Yousef
> 
> >  kernel/sched/cpudeadline.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> > index 8630f2a40a3f..8525d73e3de4 100644
> > --- a/kernel/sched/cpudeadline.c
> > +++ b/kernel/sched/cpudeadline.c
> > @@ -121,19 +121,30 @@ int cpudl_find(struct cpudl *cp, struct
> > task_struct *p, 
> >  	if (later_mask &&
> >  	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr)) {
> > -		int cpu;
> > +		unsigned long cap, max_cap = 0;
> > +		int cpu, max_cpu = -1;
> >  
> >  		if
> > (!static_branch_unlikely(&sched_asym_cpucapacity)) return 1;
> >  
> >  		/* Ensure the capacity of the CPUs fits the task.
> > */ for_each_cpu(cpu, later_mask) {
> > -			if (!dl_task_fits_capacity(p, cpu))
> > +			if (!dl_task_fits_capacity(p, cpu)) {
> >  				cpumask_clear_cpu(cpu, later_mask);
> > +
> > +				cap = arch_scale_cpu_capacity(cpu);
> > +
> > +				if (cap > max_cap) {
> > +					max_cap = cap;
> > +					max_cpu = cpu;
> > +				}
> > +			}
> >  		}
> >  
> > -		if (!cpumask_empty(later_mask))
> > -			return 1;
> > +		if (cpumask_empty(later_mask))
> > +			cpumask_set_cpu(max_cpu, later_mask);
> > +
> > +		return 1;
> >  	} else {
> >  		int best_cpu = cpudl_maximum(cp);
> >  
> > -- 
> > 2.17.1
> >   

