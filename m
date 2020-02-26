Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81588C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F44720637
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgBZLeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:34:24 -0500
Received: from foss.arm.com ([217.140.110.172]:34422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbgBZLeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:34:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 500221FB;
        Wed, 26 Feb 2020 03:34:23 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCEF63FA00;
        Wed, 26 Feb 2020 03:34:21 -0800 (PST)
Date:   Wed, 26 Feb 2020 11:34:19 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] sched/rt: Re-instate old behavior in
 select_task_rq_rt
Message-ID: <20200226113419.ikhxz3xp27ohxu3b@e107158-lin.cambridge.arm.com>
References: <20200223184001.14248-1-qais.yousef@arm.com>
 <20200223184001.14248-3-qais.yousef@arm.com>
 <01313581-0c60-8b4c-ceb3-e23554a600ed@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01313581-0c60-8b4c-ceb3-e23554a600ed@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/20 15:21, Dietmar Eggemann wrote:
> On 23.02.20 18:39, Qais Yousef wrote:
> 
> [...]
> 
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 4043abe45459..2c3fae637cef 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1474,6 +1474,13 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
> >  	if (test || !rt_task_fits_capacity(p, cpu)) {
> >  		int target = find_lowest_rq(p);
> >  
> > +		/*
> > +		 * Bail out if we were forcing a migration to find a better
> > +		 * fitting CPU but our search failed.
> > +		 */
> > +		if (!test && !rt_task_fits_capacity(p, target))
> > +			goto out_unlock;
> 
> Didn't you loose the 'target != -1' condition from
> https://lore.kernel.org/r/20200218041620.GD28029@codeaurora.org ?
> 
> A call to rt_task_fits_capacity(p, -1) would cause issues on a
> heterogeneous system.

Good catch! Right you are. I'll fix this and send v3, once it is clear what
would be right way forward to handle the wakeup-path.

Thanks!

--
Qais Yousef

> 
> I tried to provoke this but wasn't able to do so. find_lowest_rq()
> returns -1 in 4 places. (1) lowest_mask should be there (2) if
> 'task->nr_cpus_allowed == 1' select_task_rq_rt() wouldn't have been
> called but maybe (3) or (4) can still return -1.
> 
> [...]
