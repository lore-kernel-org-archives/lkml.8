Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF05C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3B12088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390483AbgFXKgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 06:36:24 -0400
Received: from foss.arm.com ([217.140.110.172]:59922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390441AbgFXKgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:36:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11BEE1FB;
        Wed, 24 Jun 2020 03:36:23 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8129F3F6CF;
        Wed, 24 Jun 2020 03:36:21 -0700 (PDT)
Date:   Wed, 24 Jun 2020 11:36:19 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched/uclamp: Fix initialization of strut
 uclamp_rq
Message-ID: <20200624103618.zkk2unblc265v4mo@e107158-lin.cambridge.arm.com>
References: <20200619172011.5810-1-qais.yousef@arm.com>
 <20200619172011.5810-2-qais.yousef@arm.com>
 <87sgekorfq.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sgekorfq.derkling@matbug.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/20 09:26, Patrick Bellasi wrote:
> 
> Hi Qais,
> 
> On Fri, Jun 19, 2020 at 19:20:10 +0200, Qais Yousef <qais.yousef@arm.com> wrote...
> 
> > struct uclamp_rq was zeroed out entirely in assumption that in the first
> > call to uclamp_rq_inc() they'd be initialized correctly in accordance to
> > default settings.
> >
> > But when next patch introduces a static key to skip
> > uclamp_rq_{inc,dec}() until userspace opts in to use uclamp, schedutil
> > will fail to perform any frequency changes because the
> > rq->uclamp[UCLAMP_MAX].value is zeroed at init and stays as such. Which
> > means all rqs are capped to 0 by default.
> 
> Does not this means the problem is more likely with uclamp_rq_util_with(),
> which should be guarded?

The initialization is wrong and needs to be fixed, no? So I won't say
uclamp_rq_util_with() has any problem.

For RT boosting to work as-is, uclamp_rq_util_with() needs to stay the same,
otherwise we need to add extra logic to deal with that. Which I don't think is
worth it or necessary. The function is called from sugov and
find_energy_efficient_cpu(), both of which aren't a worry to make this call
unconditionally IMO.

Thanks

--
Qais Yousef

> 
> Otherwise, we will also keep doing useless min/max aggregations each
> time schedutil calls that function, thus not completely removing
> uclamp overheads while user-space has not opted in.
> 
> What about dropping this and add the guard in the following patch, along
> with the others?

> 
> > Fix it by making sure we do proper initialization at init without
> 
> >
> > Fix it by making sure we do proper initialization at init without
> > relying on uclamp_rq_inc() doing it later.
> >
> > Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > CC: Patrick Bellasi <patrick.bellasi@matbug.net>
> > Cc: Chris Redpath <chris.redpath@arm.com>
> > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  kernel/sched/core.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a43c84c27c6f..4265861e13e9 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1248,6 +1248,22 @@ static void uclamp_fork(struct task_struct *p)
> >  	}
> >  }
> >  
> > +static void __init init_uclamp_rq(struct rq *rq)
> > +{
> > +	enum uclamp_id clamp_id;
> > +	struct uclamp_rq *uc_rq = rq->uclamp;
> > +
> > +	for_each_clamp_id(clamp_id) {
> > +		memset(uc_rq[clamp_id].bucket,
> > +		       0,
> > +		       sizeof(struct uclamp_bucket)*UCLAMP_BUCKETS);
> > +
> > +		uc_rq[clamp_id].value = uclamp_none(clamp_id);
> > +	}
> > +
> > +	rq->uclamp_flags = 0;
> > +}
> > +
> >  static void __init init_uclamp(void)
> >  {
> >  	struct uclamp_se uc_max = {};
> > @@ -1256,11 +1272,8 @@ static void __init init_uclamp(void)
> >  
> >  	mutex_init(&uclamp_mutex);
> >  
> > -	for_each_possible_cpu(cpu) {
> > -		memset(&cpu_rq(cpu)->uclamp, 0,
> > -				sizeof(struct uclamp_rq)*UCLAMP_CNT);
> > -		cpu_rq(cpu)->uclamp_flags = 0;
> > -	}
> > +	for_each_possible_cpu(cpu)
> > +		init_uclamp_rq(cpu_rq(cpu));
> >  
> >  	for_each_clamp_id(clamp_id) {
> >  		uclamp_se_set(&init_task.uclamp_req[clamp_id],
> 
