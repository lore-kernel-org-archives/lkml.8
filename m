Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64075C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B44F2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405689AbgFSQqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405684AbgFSQqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:46:45 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B8B20732;
        Fri, 19 Jun 2020 16:46:43 +0000 (UTC)
Date:   Fri, 19 Jun 2020 12:46:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] Sched: Add a tracepoint to track rq->nr_running
Message-ID: <20200619124641.7f94ad14@oasis.local.home>
In-Reply-To: <20200619141120.1476-1-pauld@redhat.com>
References: <20200619141120.1476-1-pauld@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 10:11:20 -0400
Phil Auld <pauld@redhat.com> wrote:

> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index ed168b0e2c53..a6d9fe5a68cf 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -634,6 +634,10 @@ DECLARE_TRACE(sched_overutilized_tp,
>  	TP_PROTO(struct root_domain *rd, bool overutilized),
>  	TP_ARGS(rd, overutilized));
>  
> +DECLARE_TRACE(sched_update_nr_running_tp,
> +	TP_PROTO(int cpu, int change, unsigned int nr_running),
> +	TP_ARGS(cpu, change, nr_running));
> +
>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9a2fbf98fd6f..6f28fdff1d48 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6,7 +6,10 @@
>   *
>   *  Copyright (C) 1991-2002  Linus Torvalds
>   */
> +
> +#define SCHED_CREATE_TRACE_POINTS
>  #include "sched.h"
> +#undef SCHED_CREATE_TRACE_POINTS

Because of the macro magic, and really try not to have trace events
defined in any headers. Otherwise, we have weird defines like you are
doing, and it doesn't fully protect it if a C file adds this header and
defines CREATE_TRACE_POINTS first.


>  
>  #include <linux/nospec.h>
>  
> @@ -21,9 +24,6 @@
>  
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -75,6 +75,15 @@
>  #include "cpupri.h"
>  #include "cpudeadline.h"
>  
> +#ifdef SCHED_CREATE_TRACE_POINTS
> +#define CREATE_TRACE_POINTS
> +#endif
> +#include <trace/events/sched.h>
> +
> +#ifdef SCHED_CREATE_TRACE_POINTS
> +#undef CREATE_TRACE_POINTS
> +#endif
> +
>  #ifdef CONFIG_SCHED_DEBUG
>  # define SCHED_WARN_ON(x)	WARN_ONCE(x, #x)
>  #else
> @@ -1959,6 +1968,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
>  	unsigned prev_nr = rq->nr_running;
>  
>  	rq->nr_running = prev_nr + count;
> +	trace_sched_update_nr_running_tp(cpu_of(rq), count, rq->nr_running);

Instead of having sched.h define CREATE_TRACE_POINTS, I would have the
following:

	if (trace_sched_update_nr_running_tp_enabled()) {
		call_trace_sched_update_nr_runnig(rq, count);
	}

Then in sched/core.c:

void trace_sched_update_nr_running(struct rq *rq, int count)
{
	trace_sched_update_nr_running_tp(cpu_of(rq), count, rq->nr_running);
}

The trace_*_enabled() above uses static branches, where the if turns to
a nop (pass through) when disabled and a jmp when enabled (same logic
that trace points use themselves).

Then you don't need this macro dance, and risk having another C file
define CREATE_TRACE_POINTS and spend hours debugging why it suddenly
broke.

-- Steve
