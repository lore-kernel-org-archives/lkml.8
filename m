Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33BEC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02D02071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgICItb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:49:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:54858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgICItb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:49:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A648AE09;
        Thu,  3 Sep 2020 08:49:30 +0000 (UTC)
Date:   Thu, 3 Sep 2020 09:49:25 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     peterz@infradead.org
Cc:     gengdongjiu <gengdongjiu@huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "thara.gopinath@linaro.org" <thara.gopinath@linaro.org>,
        "pauld@redhat.com" <pauld@redhat.com>,
        "vincent.donnefort@arm.com" <vincent.donnefort@arm.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE???[PATCH] sched: Add trace for task wake up latency and leave
 running time
Message-ID: <20200903084925.GB3117@suse.de>
References: <6995260be2ca4fd18bc773fe9f50f420@huawei.com>
 <20200903074232.GW1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200903074232.GW1362448@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 09:42:32AM +0200, peterz@infradead.org wrote:
> > Maybe I need to explain the reason that why I add two trace point. 
> > when using perf tool or Ftrace sysfs to capture the task wake-up latency and the task leaving running queue time, usually the trace data is too large and the CPU utilization rate is too high in the process due to a lot of disk write. Sometimes even the disk is full, the issue still does not reproduced that above two time exceed a certain threshold.  So I added two trace points, using filter we can only record the abnormal trace that includes wakeup latency and leaving running time larger than an threshold. 
> > Or do you have better solution?
> 
> <SNIP>
> 
> Yes, use ftrace synthetic events, or bpf or really anything other than
> this.
> 

In practice, this is what ends up being required. FYI, perf probe is handy
for creating a tracepoint in an arbitrary location. If BPF is not an option
(e.g. older kernel where BPF cannot do what you want or newer kernel
where BPF has regressed in some way) then systemtap is the other option.

> > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c index
> > > > 8471a0f7eb32..b5a1928dc948 100644
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -2464,6 +2464,8 @@ static void ttwu_do_wakeup(struct rq *rq, struct
> > > > task_struct *p, int wake_flags,  {
> > > >  	check_preempt_curr(rq, p, wake_flags);
> > > >  	p->state = TASK_RUNNING;
> > > > +	p->ts_wakeup = local_clock();
> > > > +	p->wakeup_state = true;
> > > >  	trace_sched_wakeup(p);
> > > >
> > > >  #ifdef CONFIG_SMP
> > > 
> > > NAK, userless overhead.
> > 
> >  When sched switch, we do not know the next task previous state and
> >  wakeup timestamp, so I record the task previous state if it is waken
> >  from sleep.  And then it can calculate the wakeup latency when task
> >  switch.
> 
> I don't care. You're making things slower.

Which sucks on its own. The other problem is that you cannot trace older
kernels that do not have the updated tracepoints so it's worth at least
pointing out what the options are. In general, trying to accumulate
state inside a tracepoint is a curse because changes in the internal
implementation can render the tracepoint redundant, or worse, misleading.
It *can* be an option when developing a patch and you want detailed
trace information to guide development but be prepared to throw away the
tracepoints before submitting.

If state is to be accumulated between multiple tracepoints then the
primary options are BPF, systemtap, trace-cmd for offline analysis or
opening trace_pipe with a script, parsing the events and accumulate the
state that way. This can lead to a concern that the script must be running
from system start to track the data and yes, this is exactly what you
have to do.  It's not that different to having to monitor /proc/vmstat
over time to get some interesting vm stats as the accumulated state since
the system started is often useless.

Online analysis of trace_pipe is the most expensive for a lot of reasons
but it has the advantage of almost always working regardless of kernel
version as long as the script interprets the tracepoints correctly. It
may be too expensive for production but it's useful when figuring out
what tracepoints are needed and how that state should be accumulated.

-- 
Mel Gorman
SUSE Labs
