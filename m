Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D38C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575B12082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgBLOnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgBLOnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:43:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E87720661;
        Wed, 12 Feb 2020 14:43:10 +0000 (UTC)
Date:   Wed, 12 Feb 2020 09:43:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/11] sched/numa: Distinguish between the different
 task_numa_migrate failure cases
Message-ID: <20200212094308.04bcf8a2@gandalf.local.home>
In-Reply-To: <20200212093654.4816-6-mgorman@techsingularity.net>
References: <20200212093654.4816-1-mgorman@techsingularity.net>
        <20200212093654.4816-6-mgorman@techsingularity.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 09:36:48 +0000
Mel Gorman <mgorman@techsingularity.net> wrote:

> sched:sched_stick_numa is meant to fire when a task is unable to migrate
> to the preferred node but from the trace, it's possibile to tell the
> difference between "no CPU found", "migration to idle CPU failed" and
> "tasks could not be swapped". Extend the tracepoint accordingly.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  include/trace/events/sched.h | 51 +++++++++++++++++++++++++++++++++-----------
>  kernel/sched/fair.c          |  6 +++---
>  2 files changed, 42 insertions(+), 15 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 420e80e56e55..3d07c0af4ab8 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -487,7 +487,11 @@ TRACE_EVENT(sched_process_hang,
>  );
>  #endif /* CONFIG_DETECT_HUNG_TASK */
>  
> -DECLARE_EVENT_CLASS(sched_move_task_template,
> +/*
> + * Tracks migration of tasks from one runqueue to another. Can be used to
> + * detect if automatic NUMA balancing is bouncing between nodes
> + */
> +TRACE_EVENT(sched_move_numa,
>  
>  	TP_PROTO(struct task_struct *tsk, int src_cpu, int dst_cpu),
>  
> @@ -519,20 +523,43 @@ DECLARE_EVENT_CLASS(sched_move_task_template,
>  			__entry->dst_cpu, __entry->dst_nid)
>  );
>  
> -/*
> - * Tracks migration of tasks from one runqueue to another. Can be used to
> - * detect if automatic NUMA balancing is bouncing between nodes
> - */
> -DEFINE_EVENT(sched_move_task_template, sched_move_numa,
> -	TP_PROTO(struct task_struct *tsk, int src_cpu, int dst_cpu),
> +TRACE_EVENT(sched_stick_numa,
>  
> -	TP_ARGS(tsk, src_cpu, dst_cpu)
> -);
> +	TP_PROTO(struct task_struct *src_tsk, int src_cpu, struct task_struct *dst_tsk, int dst_cpu),
>  
> -DEFINE_EVENT(sched_move_task_template, sched_stick_numa,
> -	TP_PROTO(struct task_struct *tsk, int src_cpu, int dst_cpu),
> +	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu),
>  
> -	TP_ARGS(tsk, src_cpu, dst_cpu)
> +	TP_STRUCT__entry(
> +		__field( pid_t,	src_pid			)
> +		__field( pid_t,	src_tgid		)
> +		__field( pid_t,	src_ngid		)
> +		__field( int,	src_cpu			)
> +		__field( int,	src_nid			)
> +		__field( pid_t,	dst_pid			)
> +		__field( pid_t,	dst_tgid		)
> +		__field( pid_t,	dst_ngid		)
> +		__field( int,	dst_cpu			)
> +		__field( int,	dst_nid			)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->src_pid	= task_pid_nr(src_tsk);
> +		__entry->src_tgid	= task_tgid_nr(src_tsk);
> +		__entry->src_ngid	= task_numa_group_id(src_tsk);
> +		__entry->src_cpu	= src_cpu;
> +		__entry->src_nid	= cpu_to_node(src_cpu);
> +		__entry->dst_pid	= dst_tsk ? task_pid_nr(dst_tsk) : 0;
> +		__entry->dst_tgid	= dst_tsk ? task_tgid_nr(dst_tsk) : 0;
> +		__entry->dst_ngid	= dst_tsk ? task_numa_group_id(dst_tsk) : 0;
> +		__entry->dst_cpu	= dst_cpu;
> +		__entry->dst_nid	= dst_cpu >= 0 ? cpu_to_node(dst_cpu) : -1;
> +	),
> +
> +	TP_printk("src_pid=%d src_tgid=%d src_ngid=%d src_cpu=%d src_nid=%d dst_pid=%d dst_tgid=%d dst_ngid=%d dst_cpu=%d dst_nid=%d",
> +			__entry->src_pid, __entry->src_tgid, __entry->src_ngid,
> +			__entry->src_cpu, __entry->src_nid,
> +			__entry->dst_pid, __entry->dst_tgid, __entry->dst_ngid,
> +			__entry->dst_cpu, __entry->dst_nid)
>  );
>  

The above looks the same as the below sched_swap_numa. Can you make a
DECLARE_EVENT_CLASS() and merge the two for sched_swap_numa?

Note, most the footprint of a trace event happens in the
DECLARE_EVENT_CLASS() (a TRACE_EVENT() is just a DECLARE_EVENT_CLASS()
and DEFINE_EVENT() put together). The more DECLARE_EVENT_CLASS()s you
can share, the less the footprint is.

-- Steve


>  TRACE_EVENT(sched_swap_numa,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4ab18fba5b82..6005ce28033b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1849,7 +1849,7 @@ static int task_numa_migrate(struct task_struct *p)
>  
>  	/* No better CPU than the current one was found. */
>  	if (env.best_cpu == -1) {
> -		trace_sched_stick_numa(p, env.src_cpu, -1);
> +		trace_sched_stick_numa(p, env.src_cpu, NULL, -1);
>  		return -EAGAIN;
>  	}
>  
> @@ -1858,7 +1858,7 @@ static int task_numa_migrate(struct task_struct *p)
>  		ret = migrate_task_to(p, env.best_cpu);
>  		WRITE_ONCE(best_rq->numa_migrate_on, 0);
>  		if (ret != 0)
> -			trace_sched_stick_numa(p, env.src_cpu, env.best_cpu);
> +			trace_sched_stick_numa(p, env.src_cpu, NULL, env.best_cpu);
>  		return ret;
>  	}
>  
> @@ -1866,7 +1866,7 @@ static int task_numa_migrate(struct task_struct *p)
>  	WRITE_ONCE(best_rq->numa_migrate_on, 0);
>  
>  	if (ret != 0)
> -		trace_sched_stick_numa(p, env.src_cpu, task_cpu(env.best_task));
> +		trace_sched_stick_numa(p, env.src_cpu, env.best_task, env.best_cpu);
>  	put_task_struct(env.best_task);
>  	return ret;
>  }

