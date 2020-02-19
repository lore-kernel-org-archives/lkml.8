Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFD4C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3910F21D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgBSKqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:46:48 -0500
Received: from foss.arm.com ([217.140.110.172]:46094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgBSKqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:46:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AF1E1FB;
        Wed, 19 Feb 2020 02:46:47 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF8913F6CF;
        Wed, 19 Feb 2020 02:46:45 -0800 (PST)
Date:   Wed, 19 Feb 2020 10:46:43 +0000
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
Message-ID: <20200219104642.nhxmgytcdweqbycd@e107158-lin>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-4-qais.yousef@arm.com>
 <20200217092329.GC28029@codeaurora.org>
 <20200217135306.cjc2225wdlwqiicu@e107158-lin.cambridge.arm.com>
 <20200218041620.GD28029@codeaurora.org>
 <20200218174718.ma6cpr2qwnueertn@e107158-lin.cambridge.arm.com>
 <20200219024608.GE28029@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219024608.GE28029@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/20 08:16, Pavan Kondeti wrote:
> On Tue, Feb 18, 2020 at 05:47:19PM +0000, Qais Yousef wrote:
> > On 02/18/20 09:46, Pavan Kondeti wrote:
> > > The original RT task placement i.e without capacity awareness, places the task
> > > on the previous CPU if the task can preempt the running task. I interpreted it
> > > as that "higher prio RT" task should get better treatment even if it results
> > > in stopping the lower prio RT execution and migrating it to another CPU.
> > > 
> > > Now coming to your patch (merged), we force find_lowest_rq() if the previous
> > > CPU can't fit the task though this task can right away run there. When the
> > > lowest mask returns an unfit CPU (with your new patch), We have two choices,
> > > either to place it on this unfit CPU (may involve migration) or place it on
> > > the previous CPU to avoid the migration. We are selecting the first approach.
> > > 
> > > The task_cpu(p) check in find_lowest_rq() only works when the previous CPU
> > > does not have a RT task. If it is running a lower prio RT task than the
> > > waking task, the lowest_mask may not contain the previous CPU.
> > > 
> > > I don't if any workload hurts due to this change in behavior. So not sure
> > > if we have to restore the original behavior. Something like below will do.
> > 
> > Is this patch equivalent to yours? If yes, then I got you. If not, then I need
> > to re-read this again..
> > 
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index ace9acf9d63c..854a0c9a7be6 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1476,6 +1476,13 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
> >         if (test || !rt_task_fits_capacity(p, cpu)) {
> >                 int target = find_lowest_rq(p);
> > 
> > +               /*
> > +                * Bail out if we were forcing a migration to find a better
> > +                * fitting CPU but our search failed.
> > +                */
> > +               if (!test && !rt_task_fits_capacity(p, target))
> > +                       goto out_unlock;
> > +
> 
> Yes. This is what I was referring to.

Cool. I can't see how this could be a problem too but since as you say it'd
preserve the older behavior, I'll add it to the lot with proper changelog.

Thanks!

--
Qais Yousef
