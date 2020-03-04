Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5FAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B9324684
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgCDP20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:28:26 -0500
Received: from foss.arm.com ([217.140.110.172]:35764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgCDP2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:28:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDD714B2;
        Wed,  4 Mar 2020 07:28:24 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B3563F6CF;
        Wed,  4 Mar 2020 07:28:22 -0800 (PST)
Date:   Wed, 4 Mar 2020 15:28:20 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Tao Zhou <t1zhou@aliyun.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, t1zhou@163.com
Subject: Re: [PATCH v3 4/6] sched/rt: Allow pulling unfitting task
Message-ID: <20200304152820.t6kkxvpgoa6444ta@e107158-lin.cambridge.arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
 <20200302132721.8353-5-qais.yousef@arm.com>
 <20200304145219.GA14173@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200304145219.GA14173@geo.homenetwork>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/20 22:52, Tao Zhou wrote:
> Hi Qais,
> 
> On Mon, Mar 02, 2020 at 01:27:19PM +0000, Qais Yousef wrote:
> > When implemented RT Capacity Awareness; the logic was done such that if
> > a task was running on a fitting CPU, then it was sticky and we would try
> > our best to keep it there.
> > 
> > But as Steve suggested, to adhere to the strict priority rules of RT
> > class; allow pulling an RT task to unfitting CPU to ensure it gets a
> > chance to run ASAP.
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
> > LINK: https://lore.kernel.org/lkml/20200203111451.0d1da58f@oasis.local.home/
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> >  kernel/sched/rt.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 3071c8612c03..e79a23ad4a93 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1656,8 +1656,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
> >  static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
> >  {
> >  	if (!task_running(rq, p) &&
> > -	    cpumask_test_cpu(cpu, p->cpus_ptr) &&
> > -	    rt_task_fits_capacity(p, cpu))
> > +	    cpumask_test_cpu(cpu, p->cpus_ptr))
> >  		return 1;
> >  
> >  	return 0;
> > -- 
> > 2.17.1
> > 
> 
> How about using a rt_cap_overloaded(like rt_overloaded) to indicate the
> cpu is overloaded because a RT task is on unfit CPU. And use stop_one_cpu
> to do in this case.

We have explored a variation of this (without using the stop_one_cpu) in v2

https://lore.kernel.org/lkml/20200223184001.14248-6-qais.yousef@arm.com/

I might still consider this in the future. But I think I need to do better
analysis of the cost-benefit here before pushing further for that.

I'm not keen on stopping a running task as well, not yet at least.

> 
> IIRC, HAVE_RT_PUSH_IPI do not select the specific cpu to do the
> push because the complex there. When RT cap join in, i don't know it
> is need to select the specific unfit CPU or rt overloaded CPU in what
> order is a choice.

I'm not sure I understood you completely here.

I think the patch above dealt with the complexity I think you're talking about.

Thanks

--
Qais Yousef
