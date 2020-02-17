Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B2EC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C592070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgBQLUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:20:40 -0500
Received: from foss.arm.com ([217.140.110.172]:34300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgBQLUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 06:20:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEF2830E;
        Mon, 17 Feb 2020 03:20:39 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F03D3F6CF;
        Mon, 17 Feb 2020 03:20:38 -0800 (PST)
Date:   Mon, 17 Feb 2020 11:20:36 +0000
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
Subject: Re: [PATCH 2/3] sched/rt: allow pulling unfitting task
Message-ID: <20200217112034.54yoockxvfe3fw6y@e107158-lin.cambridge.arm.com>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-3-qais.yousef@arm.com>
 <20200217091042.GB28029@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200217091042.GB28029@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17/20 14:40, Pavan Kondeti wrote:
> Hi Qais,
> 
> On Fri, Feb 14, 2020 at 04:39:48PM +0000, Qais Yousef wrote:
> > When implemented RT Capacity Awareness; the logic was done such that if
> > a task was running on a fitting CPU, then it was sticky and we would try
> > our best to keep it there.
> > 
> > But as Steve suggested, to adhere to the strict priority rules of RT
> > class; allow pulling an RT task to unfitting CPU to ensure it gets a
> > chance to run ASAP. When doing so, mark the queue as overloaded to give
> > the system a chance to push the task to a better fitting CPU when a
> > chance arises.
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> >  kernel/sched/rt.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 4043abe45459..0c8bac134d3a 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1646,10 +1646,20 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
> >  
> >  static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
> >  {
> > -	if (!task_running(rq, p) &&
> > -	    cpumask_test_cpu(cpu, p->cpus_ptr) &&
> > -	    rt_task_fits_capacity(p, cpu))
> > +	if (!task_running(rq, p) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
> > +
> > +		/*
> > +		 * If the CPU doesn't fit the task, allow pulling but mark the
> > +		 * rq as overloaded so that we can push it again to a more
> > +		 * suitable CPU ASAP.
> > +		 */
> > +		if (!rt_task_fits_capacity(p, cpu)) {
> > +			rt_set_overload(rq);
> > +			rq->rt.overloaded = 1;
> > +		}
> > +
> 
> Here rq is source rq from which the task is being pulled. I can't understand
> how marking overload condition on source_rq help. Because overload condition
> gets cleared in the task dequeue path. i.e dec_rt_tasks->dec_rt_migration->
> update_rt_migration().

Err yes indeed I rushed this patch. Let me try again.

Thanks

--
Qais Yousef
