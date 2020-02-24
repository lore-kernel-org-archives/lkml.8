Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A216C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE8720732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgBXMb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:31:28 -0500
Received: from foss.arm.com ([217.140.110.172]:36500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgBXMb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:31:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82CCD1063;
        Mon, 24 Feb 2020 04:31:27 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30FA53F534;
        Mon, 24 Feb 2020 04:31:26 -0800 (PST)
Date:   Mon, 24 Feb 2020 12:31:23 +0000
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
Subject: Re: [PATCH v2 6/6] sched/rt: Remove unnecessary assignment in
 inc/dec_rt_migration
Message-ID: <20200224123123.gbox3tcqcist7bbg@e107158-lin.cambridge.arm.com>
References: <20200223184001.14248-1-qais.yousef@arm.com>
 <20200223184001.14248-7-qais.yousef@arm.com>
 <a000f6b4-7548-1964-ba30-e8396c727d31@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a000f6b4-7548-1964-ba30-e8396c727d31@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24/20 00:16, Dietmar Eggemann wrote:
> On 23.02.20 19:40, Qais Yousef wrote:
> > The statement
> > 
> > 	rt_rq = &rq_of_rt_rq(rt_rq)->rt
> > 
> > Was just dereferencing rt_rq to get a pointer to itself. Which is a NOP.
> > Remove it.
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> >  kernel/sched/rt.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index b35e49cdafcc..520e84993fe7 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -343,7 +343,6 @@ static void inc_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
> >  		return;
> >  
> >  	p = rt_task_of(rt_se);
> > -	rt_rq = &rq_of_rt_rq(rt_rq)->rt;
> 
> IMHO, this is here to get the root rt_rq from any rt_rq (task_groups).
> Looks like that e.g rt_nr_total is only maintained on root rt_rq's.
> 
> Similar to CFS' &rq_of(cfs_rq)->cfs (cfs_rq_util_change()) to get root
> cfs_rq.
> 
> Not sure where CONFIG_RT_GROUP_SCHED=y is used but it's part of the rt
> class implementation.

Ah I see. That was obvious.. How about the below comment?

This code is executed only if rt_entity_is_task(), I don't think this grantees
that the rt_rq isn't for a group?

I need to go and unravel the layers maybe.

Thanks!

--
Qais Yousef

-->8--

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b35e49cdafcc..f929867215c4 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -343,6 +343,8 @@ static void inc_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
                return;

        p = rt_task_of(rt_se);
+
+       /* get the root rt_rq if this is the rt_rq of a group */
        rt_rq = &rq_of_rt_rq(rt_rq)->rt;

        rt_rq->rt_nr_total++;
@@ -368,6 +370,8 @@ static void dec_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
                return;

        p = rt_task_of(rt_se);
+
+       /* get the root rt_rq if this is the rt_rq of a group */
        rt_rq = &rq_of_rt_rq(rt_rq)->rt;

        rt_rq->rt_nr_total--;

