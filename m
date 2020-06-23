Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79775C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412F32098B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D00/AUam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbgFWTih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:38:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32896 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733248AbgFWTig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592941114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xo814WUw9pinCEJ10ExNpY4kpMNan9cV6ZqLN4Hjd0I=;
        b=D00/AUamm9XcmNhVG9bP97Mki4vsq4mGlO8sOniXw2Tla9pVeNCNlH47xVKHNsrgBLZ4G1
        ZMlVMT1BiB0Yq63AuR7qDWoeyMR6Aiu81pcfKpeIET8T8ooV+Rh6GEMLodPj6ok9b5I/+i
        w7HrcEqBztowVZgjWrEdL3xsoS6Ht34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-df7unb-wOnWZmIriWZpf8g-1; Tue, 23 Jun 2020 15:38:26 -0400
X-MC-Unique: df7unb-wOnWZmIriWZpf8g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AC91107ACF6;
        Tue, 23 Jun 2020 19:38:24 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-109.phx2.redhat.com [10.3.113.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D86A75C296;
        Tue, 23 Jun 2020 19:38:20 +0000 (UTC)
Date:   Tue, 23 Jun 2020 15:38:19 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] Sched: Add a tracepoint to track rq->nr_running
Message-ID: <20200623193819.GG83220@lorien.usersys.redhat.com>
References: <20200619141120.1476-1-pauld@redhat.com>
 <20200622121746.b43ziyjq2eqsseym@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622121746.b43ziyjq2eqsseym@e107158-lin.cambridge.arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Mon, Jun 22, 2020 at 01:17:47PM +0100 Qais Yousef wrote:
> On 06/19/20 10:11, Phil Auld wrote:
> > Add a bare tracepoint trace_sched_update_nr_running_tp which tracks
> > ->nr_running CPU's rq. This is used to accurately trace this data and
> > provide a visualization of scheduler imbalances in, for example, the
> > form of a heat map.  The tracepoint is accessed by loading an external
> > kernel module. An example module (forked from Qais' module and including
> > the pelt related tracepoints) can be found at:
> > 
> >   https://github.com/auldp/tracepoints-helpers.git
> > 
> > A script to turn the trace-cmd report output into a heatmap plot can be
> > found at:
> > 
> >   https://github.com/jirvoz/plot-nr-running
> > 
> > The tracepoints are added to add_nr_running() and sub_nr_running() which
> > are in kernel/sched/sched.h. Since sched.h includes trace/events/tlb.h
> > via mmu_context.h we had to limit when CREATE_TRACE_POINTS is defined.
> > 
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > CC: Qais Yousef <qais.yousef@arm.com>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Peter Zijlstra <peterz@infradead.org>
> > CC: Vincent Guittot <vincent.guittot@linaro.org>
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  include/trace/events/sched.h |  4 ++++
> >  kernel/sched/core.c          |  9 ++++-----
> >  kernel/sched/fair.c          |  2 --
> >  kernel/sched/pelt.c          |  2 --
> >  kernel/sched/sched.h         | 12 ++++++++++++
> >  5 files changed, 20 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index ed168b0e2c53..a6d9fe5a68cf 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -634,6 +634,10 @@ DECLARE_TRACE(sched_overutilized_tp,
> >  	TP_PROTO(struct root_domain *rd, bool overutilized),
> >  	TP_ARGS(rd, overutilized));
> >  
> > +DECLARE_TRACE(sched_update_nr_running_tp,
> > +	TP_PROTO(int cpu, int change, unsigned int nr_running),
> > +	TP_ARGS(cpu, change, nr_running));
> > +
> >  #endif /* _TRACE_SCHED_H */
> >  
> >  /* This part must be outside protection */
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9a2fbf98fd6f..6f28fdff1d48 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6,7 +6,10 @@
> >   *
> >   *  Copyright (C) 1991-2002  Linus Torvalds
> >   */
> > +
> > +#define SCHED_CREATE_TRACE_POINTS
> >  #include "sched.h"
> > +#undef SCHED_CREATE_TRACE_POINTS
> >  
> >  #include <linux/nospec.h>
> >  
> > @@ -21,9 +24,6 @@
> >  
> >  #include "pelt.h"
> >  
> > -#define CREATE_TRACE_POINTS
> > -#include <trace/events/sched.h>
> > -
> >  /*
> >   * Export tracepoints that act as a bare tracehook (ie: have no trace event
> >   * associated with them) to allow external modules to probe them.
> > @@ -34,6 +34,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
> >  
> >  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> >  
> > @@ -7969,5 +7970,3 @@ const u32 sched_prio_to_wmult[40] = {
> >   /*  10 */  39045157,  49367440,  61356676,  76695844,  95443717,
> >   /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
> >  };
> > -
> > -#undef CREATE_TRACE_POINTS
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index da3e5b54715b..fe5d9b6db8f7 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -22,8 +22,6 @@
> >   */
> >  #include "sched.h"
> >  
> > -#include <trace/events/sched.h>
> > -
> >  /*
> >   * Targeted preemption latency for CPU-bound tasks:
> >   *
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > index b647d04d9c8b..bb69a0ae8d6c 100644
> > --- a/kernel/sched/pelt.c
> > +++ b/kernel/sched/pelt.c
> > @@ -28,8 +28,6 @@
> >  #include "sched.h"
> >  #include "pelt.h"
> >  
> > -#include <trace/events/sched.h>
> > -
> >  /*
> >   * Approximate:
> >   *   val * y^n,    where y^32 ~= 0.5 (~1 scheduling period)
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index db3a57675ccf..6ae96679c169 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -75,6 +75,15 @@
> >  #include "cpupri.h"
> >  #include "cpudeadline.h"
> >  
> > +#ifdef SCHED_CREATE_TRACE_POINTS
> > +#define CREATE_TRACE_POINTS
> > +#endif
> > +#include <trace/events/sched.h>
> > +
> > +#ifdef SCHED_CREATE_TRACE_POINTS
> > +#undef CREATE_TRACE_POINTS
> > +#endif
> > +
> >  #ifdef CONFIG_SCHED_DEBUG
> >  # define SCHED_WARN_ON(x)	WARN_ONCE(x, #x)
> >  #else
> > @@ -1959,6 +1968,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
> >  	unsigned prev_nr = rq->nr_running;
> >  
> >  	rq->nr_running = prev_nr + count;
> > +	trace_sched_update_nr_running_tp(cpu_of(rq), count, rq->nr_running);
> 
> This is a very specific call site, so I guess it looks fine to pass very
> specific info too.
> 
> But I think we can do better by just passing struct rq and add a new helper
> sched_trace_rq_nr_running() (see the bottom of fair.c for a similar helper
> functions for tracepoints).
> 
> This will allow the user to extract, cpu, nr_running and potentially other info
> while only pass a single argument to the tracepoint. Potentially extending its
> future usefulness.

I can certainly add a sched_trace_rq_nr_running helper and pass the *rq if
you think that is really important. 

I'd prefer to keep the count field though as that is the only way to tell
if this is an add_nr_running or sub_nr_running from looking at a single
trace event.

I could make it two different tracepoints.  Would that be better? To me that
seemed more complicated though. The tooling would need to look at it
different events and there would be more kernel change.

Thanks,
Phil

> 
> The count can be inferred by storing the last nr_running and taking the diff
> when a new call happens.
> 
> 	...
> 
> 	cpu = sched_trace_rq_cpu(rq);
> 	nr_running = sched_trace_rq_nr_running(rq);
> 	count = last_nr_running[cpu] - nr_running;
> 	last_nr_running[cpu] = nr_running;
> 
> 	...
> 
> I haven't looked at BTF, but it could potentially allow us to access members of
> unexported structs reliably without having to export all these helper
> functions. It's been something I wanted to look into but no time yet.
> 
> Thanks
> 
> --
> Qais Yousef
> 
> >  
> >  #ifdef CONFIG_SMP
> >  	if (prev_nr < 2 && rq->nr_running >= 2) {
> > @@ -1973,6 +1983,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
> >  static inline void sub_nr_running(struct rq *rq, unsigned count)
> >  {
> >  	rq->nr_running -= count;
> > +	trace_sched_update_nr_running_tp(cpu_of(rq), -count, rq->nr_running);
> > +
> >  	/* Check if we still need preemption */
> >  	sched_update_tick_dependency(rq);
> >  }
> > -- 
> > 2.18.0
> > 
> 

-- 

