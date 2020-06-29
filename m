Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CA0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5B32063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbgF2TUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:20:05 -0400
Received: from foss.arm.com ([217.140.110.172]:39572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730507AbgF2TT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:19:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D324D1478;
        Mon, 29 Jun 2020 05:12:44 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EECB93F73C;
        Mon, 29 Jun 2020 05:12:42 -0700 (PDT)
Date:   Mon, 29 Jun 2020 13:12:40 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sched/uclamp: Fix initialization of struct
 uclamp_rq
Message-ID: <20200629121240.pxec7mvoum6xp2z4@e107158-lin.cambridge.arm.com>
References: <20200625154352.24767-1-qais.yousef@arm.com>
 <20200625154352.24767-2-qais.yousef@arm.com>
 <87eeq2nh1k.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87eeq2nh1k.derkling@matbug.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick

On 06/26/20 14:32, Patrick Bellasi wrote:
> 
> On Thu, Jun 25, 2020 at 17:43:51 +0200, Qais Yousef <qais.yousef@arm.com> wrote...
> 
> > struct uclamp_rq was zeroed out entirely in assumption that in the first
> > call to uclamp_rq_inc() they'd be initialized correctly in accordance to
> > default settings.
> 
> Perhaps I was not clear in my previous comment:
> 
>    https://lore.kernel.org/lkml/87sgekorfq.derkling@matbug.net/
> 
> when I did say:
> 
>    Does not this means the problem is more likely with
>    uclamp_rq_util_with(), which should be guarded?
> 
> I did not mean that we have to guard the calls to that function but
> instead that we should just make that function aware of uclamp being
> opted in or not.
> 
> > But when next patch introduces a static key to skip
> > uclamp_rq_{inc,dec}() until userspace opts in to use uclamp, schedutil
> > will fail to perform any frequency changes because the
> > rq->uclamp[UCLAMP_MAX].value is zeroed at init and stays as such. Which
> > means all rqs are capped to 0 by default.
> 
> The initialization you wants to do here it's needed because with the
> current approach you keep calling the same uclamp_rq_util_with() and
> keep doing min/max aggregations even when uclamp is not opted in.
> But this means also that we have min/max aggregation _when not really
> required_.
> 
> > Fix it by making sure we do proper initialization at init without
> > relying on uclamp_rq_inc() doing it later.
> 
> My proposal was as simple as:
> 
> ---8<---
>   static __always_inline
>   unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>   				  struct task_struct *p)
>   {
>   	unsigned long min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
>   	unsigned long max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
>   
> +       if (!static_branch_unlikely(&sched_uclamp_used))
> +               return rt_task(p) ? uclamp_none(UCLAMP_MAX) : util 

This the same mistake I've done.

schedutil_cpu_util() is called by sugov_get_util() passing p as NULL.

292 static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)                                                                                                                                               
293 {                                                                               
294         struct rq *rq = cpu_rq(sg_cpu->cpu);                                    
295         unsigned long util = cpu_util_cfs(rq);                                  
296         unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);               
297                                                                                 
298         sg_cpu->max = max;                                                      
299         sg_cpu->bw_dl = cpu_bw_dl(rq);                                          
300                                                                                 
301         return schedutil_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
302 }

So this will not fix the problem with RT tasks and we have to do the check
at schedutil which is the right abstraction layer anyway. I don't think calling
rq_rt_is_runnable() is right here and is unnecessary duplication since
schedutil will still have to do that anyway.

When p is not NULL then the function will work correctly in regards to
uclamp_eff_get() returning the right value, including the default settings.
Which is important when my patch to introduce sysctl for default RT boosting
comes into play.

The function deserves a comment for sure though so that users are aware that
the function will not be useful if the static key is disabled. There's no
aggregation done at rq level and this can certainly catch people out.

We can add a static key to return util directly too. I might just do this since
it might help with readability.

Please shout if I missed something.

>   
>   	if (p) {
>   		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
>   		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
>   	}
>   
>   	/*
>   	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
>   	 * RUNNABLE tasks with _different_ clamps, we can end up with an
>   	 * inversion. Fix it now when the clamps are applied.
>   	 */
>   	if (unlikely(min_util >= max_util))
>   		return min_util;
>   
>   	return clamp(util, min_util, max_util);
>   }
> ---8<---
> 
> Such small change is more self-contained IMHO and does not remove
> an existing optimizations like this lazy RQ's initialization at first

IMHO this is a bug not an optimization. We have to write to these struct
anyway, so why not write the right value to start with? This already caught me
out and wasted over half a day trying to chase it.

Beside what are we optimizing for here? I think correctness dictates we start
with correct initial values if we can, no? How are you expecting this to slow
down sched_init()?

Thanks

--
Qais Yousef

> usage.
> 
> Moreover, it can folded in the following patch, with all the other
> static keys shortcuts.
> 
