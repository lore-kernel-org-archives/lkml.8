Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7BFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A84F20809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lnm/XM7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391010AbgFSReq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:34:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31897 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732307AbgFSReq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592588084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FSCXX8Dn6TNSzzYA9q3ZlYEoSdRai2clmlWhOcdNdrI=;
        b=Lnm/XM7D0nU77eahJTS44OuwgtGC+fmw5vddS7mgcwf9b9r19kOJu3ACk0jmtZiXGf/zzP
        XP3fqTanSfZGoArtWGsYCKnS2mIBTHNan8tVUnEQTkT1FAF4rkQACBHdoZBmhtQFxtxONi
        jmCxNkBHa+kWhaEPQFuX6+Q56i5Ho2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-9R5IdaOZOGmaUKDeMk5i2w-1; Fri, 19 Jun 2020 13:34:43 -0400
X-MC-Unique: 9R5IdaOZOGmaUKDeMk5i2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B824E800053;
        Fri, 19 Jun 2020 17:34:41 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-94.phx2.redhat.com [10.3.113.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 178775D9E5;
        Fri, 19 Jun 2020 17:34:37 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:34:36 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] Sched: Add a tracepoint to track rq->nr_running
Message-ID: <20200619173436.GF36031@lorien.usersys.redhat.com>
References: <20200619141120.1476-1-pauld@redhat.com>
 <20200619124641.7f94ad14@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619124641.7f94ad14@oasis.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 12:46:41PM -0400 Steven Rostedt wrote:
> On Fri, 19 Jun 2020 10:11:20 -0400
> Phil Auld <pauld@redhat.com> wrote:
> 
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
> 
> Because of the macro magic, and really try not to have trace events
> defined in any headers. Otherwise, we have weird defines like you are
> doing, and it doesn't fully protect it if a C file adds this header and
> defines CREATE_TRACE_POINTS first.
> 
> 
> >  
> >  #include <linux/nospec.h>
> >  
> > @@ -21,9 +24,6 @@
> >  
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
> Instead of having sched.h define CREATE_TRACE_POINTS, I would have the
> following:
> 
> 	if (trace_sched_update_nr_running_tp_enabled()) {
> 		call_trace_sched_update_nr_runnig(rq, count);
> 	}
> 
> Then in sched/core.c:
> 
> void trace_sched_update_nr_running(struct rq *rq, int count)
> {
> 	trace_sched_update_nr_running_tp(cpu_of(rq), count, rq->nr_running);
> }
> 
> The trace_*_enabled() above uses static branches, where the if turns to
> a nop (pass through) when disabled and a jmp when enabled (same logic
> that trace points use themselves).
> 
> Then you don't need this macro dance, and risk having another C file
> define CREATE_TRACE_POINTS and spend hours debugging why it suddenly
> broke.
>

Awesome, thanks Steve. I was really hoping there was a better way to do
that. I try it this way. 


Cheers,
Phil

> -- Steve
> 

-- 

