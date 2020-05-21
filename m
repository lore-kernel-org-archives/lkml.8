Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A89C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC8A204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgEUKiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 06:38:25 -0400
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:48138 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbgEUKiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 06:38:24 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id 5045DC0BCB
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:38:22 +0100 (IST)
Received: (qmail 19210 invoked from network); 21 May 2020 10:38:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 May 2020 10:38:21 -0000
Date:   Thu, 21 May 2020 11:38:16 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jirka Hladky <jhladky@redhat.com>, Phil Auld <pauld@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>,
        riel@surriel.com
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200521103816.GA7167@techsingularity.net>
References: <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <20200514153122.GE2978@hirez.programming.kicks-ass.net>
 <20200515084740.GJ3758@techsingularity.net>
 <20200515111732.GS2957@hirez.programming.kicks-ass.net>
 <20200515142444.GK3001@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200515142444.GK3001@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 04:24:44PM +0200, Peter Zijlstra wrote:
> On Fri, May 15, 2020 at 01:17:32PM +0200, Peter Zijlstra wrote:
> > On Fri, May 15, 2020 at 09:47:40AM +0100, Mel Gorman wrote:
> > 
> > > However, the wakeups are so rapid that the wakeup
> > > happens while the server is descheduling. That forces the waker to spin
> > > on smp_cond_load_acquire for longer. In this case, it can be cheaper to
> > > add the task to the rq->wake_list even if that potentially requires an IPI.
> > 
> > Right, I think Rik ran into that as well at some point. He wanted to
> > make ->on_cpu do a hand-off, but simply queueing the wakeup on the prev
> > cpu (which is currently in the middle of schedule()) should be an easier
> > proposition.
> > 
> > Maybe something like this untested thing... could explode most mighty,
> > didn't thing too hard.
> > 
> 
> Mel pointed out that that patch got mutilated somewhere (my own .Sent
> copy was fine), let me try again.
> 

Sorry for the slow response. My primary work machine suffered a
catastrophic failure on Sunday night which is a fantastic way to start
a Monday morning so I'm playing catchup.

IIUC, this patch front-loads as much work as possible before checking if
the task is on_rq and then the waker/wakee shares a cache, queue task on
the wake_list and otherwise do a direct wakeup.

The advantage is that spinning is avoided on p->on_rq when p does not
share a cache. The disadvantage is that it may result in tasks being
stacked but this should only happen when the domain is overloaded and
select_task_eq() is unlikely to find an idle CPU. The load balancer would
soon correct the situation anyway.

In terms of netperf for my testing, the benefit is marginal because the
wakeups are primarily between tasks that share cache. It does trigger as
perf indicates that some time is spent in ttwu_queue_remote with this
patch, it's just that the overall time spent spinning on p->on_rq is
very similar. I'm still waiting on other workloads to complete to see
what the impact is.

However, intuitively at least, it makes sense to avoid spinning on p->on_rq
when it's unnecessary and the other changes appear to be safe.  Even if
wake_list should be used in some cases for local wakeups, it would make
sense to put that on top of this patch. Do you want to slap a changelog
around this and update the comments or do you want me to do it? I should
have more results in a few hours even if they are limited to one machine
but ideally Rik would test his workload too.

-- 
Mel Gorman
SUSE Labs
