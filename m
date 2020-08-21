Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284DEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10C520748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QTPkBrQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHUSuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHUSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:50:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36996C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BlI8jNGsUNaPHFnW53NqGJr/Cff6G0RRXtrXQy1PnVA=; b=QTPkBrQeaLyaVP4oGRpB8UYo+g
        4MVlqSxaWBbI4mQxTHkZDP2tj4/tZ921S8DGbP6JT5B3EFes/uMBaSbBkjxJ89P9xWo3ALtYCa15H
        /Xor8hmmkbF+7xvXAijGSsY8J78Nld8nV2OS7/QyO+Qu7Diwa/dv+jM/SaYP6eXBx9GWwSK0oeul2
        u64ciTcAgfTQUng4bOk5QBxnyuPBynilOIU0XtqBQdpyZqR9EVS1wWjeEvuWqfGwigvNZezV5VSJl
        jhjqIm1zFD3qgiyLFGzKbGX/fRKNRPvD5wgJNUHPVrCsPsGwwHvsu+yJZXxec9BN/VFiooFNF1JeU
        u03zPmHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9C6v-0002Sb-Uq; Fri, 21 Aug 2020 18:49:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9006C980DF7; Fri, 21 Aug 2020 20:49:55 +0200 (CEST)
Date:   Fri, 21 Aug 2020 20:49:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        thara.gopinath@linaro.org, pauld@redhat.com,
        vincent.donnefort@arm.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] sched: Add trace for task wake up latency and leave
 running time
Message-ID: <20200821184955.GT3982@worktop.programming.kicks-ass.net>
References: <20200821235928.32727-1-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821235928.32727-1-gengdongjiu@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 93ecd930efd3..edb622c40a90 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1324,6 +1324,13 @@ struct task_struct {
>  	/* CPU-specific state of this task: */
>  	struct thread_struct		thread;
>  
> +	/* Task wake up time stamp */
> +	u64				ts_wakeup;
> +	/* Previous task switch out time stamp */
> +	u64				pre_ts_end;
> +	/* Next task switch in time stamp */
> +	u64				next_ts_start;
> +	bool				wakeup_state;
>  	/*
>  	 * WARNING: on x86, 'thread_struct' contains a variable-sized
>  	 * structure.  It *MUST* be at the end of 'task_struct'.

^^^ did you read that comment?

> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index fec25b9cfbaf..e99c6d573a42 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -183,6 +183,72 @@ TRACE_EVENT(sched_switch,
>  		__entry->next_comm, __entry->next_pid, __entry->next_prio)
>  );
>  
> +DECLARE_EVENT_CLASS(sched_latency_template,
> +
> +	TP_PROTO(bool preempt,
> +		 struct task_struct *prev,
> +		 struct task_struct *next,
> +		 u64 time),
> +
> +	TP_ARGS(preempt, prev, next, time),
> +
> +	TP_STRUCT__entry(
> +		__array(	char,	prev_comm,	TASK_COMM_LEN	)
> +		__field(	pid_t,	prev_pid			)
> +		__field(	int,	prev_prio			)
> +		__field(	long,	prev_state			)
> +		__array(	char,	next_comm,	TASK_COMM_LEN	)
> +		__field(	pid_t,	next_pid			)
> +		__field(	int,	next_prio			)
> +		__field(	u64,	time				)
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
> +		__entry->prev_pid	= prev->pid;
> +		__entry->prev_prio	= prev->prio;
> +		__entry->prev_state	= __trace_sched_switch_state(preempt, prev);
> +		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
> +		__entry->next_pid	= next->pid;
> +		__entry->next_prio	= next->prio;
> +		__entry->time		= time;
> +		/* XXX SCHED_DEADLINE */
> +	),
> +
> +	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d passed time=%llu (ns)",
> +		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
> +
> +		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
> +		  __print_flags(__entry->prev_state & (TASK_REPORT_MAX - 1), "|",
> +				{ TASK_INTERRUPTIBLE, "S" },
> +				{ TASK_UNINTERRUPTIBLE, "D" },
> +				{ __TASK_STOPPED, "T" },
> +				{ __TASK_TRACED, "t" },
> +				{ EXIT_DEAD, "X" },
> +				{ EXIT_ZOMBIE, "Z" },
> +				{ TASK_PARKED, "P" },
> +				{ TASK_DEAD, "I" }) :
> +		  "R",
> +
> +		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
> +		__entry->next_comm, __entry->next_pid, __entry->next_prio,
> +		__entry->time)
> +);

NAK, that tracepoint is already broken, we don't want to proliferate the
broken.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8471a0f7eb32..b5a1928dc948 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2464,6 +2464,8 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
>  {
>  	check_preempt_curr(rq, p, wake_flags);
>  	p->state = TASK_RUNNING;
> +	p->ts_wakeup = local_clock();
> +	p->wakeup_state = true;
>  	trace_sched_wakeup(p);
>  
>  #ifdef CONFIG_SMP

NAK, userless overhead.

> @@ -2846,6 +2848,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  		success = 1;
>  		trace_sched_waking(p);
>  		p->state = TASK_RUNNING;
> +		p->ts_wakeup = local_clock();
> +		p->wakeup_state = true;
>  		trace_sched_wakeup(p);
>  		goto out;
>  	}

idem


> @@ -3355,6 +3362,8 @@ void wake_up_new_task(struct task_struct *p)
>  	post_init_entity_util_avg(p);
>  
>  	activate_task(rq, p, ENQUEUE_NOCLOCK);
> +	p->ts_wakeup = local_clock();
> +	p->wakeup_state = true;
>  	trace_sched_wakeup_new(p);
>  	check_preempt_curr(rq, p, WF_FORK);
>  #ifdef CONFIG_SMP

idem

> @@ -4521,8 +4530,19 @@ static void __sched notrace __schedule(bool preempt)
>  
>  		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
>  
> +		next->next_ts_start = prev->pre_ts_end = local_clock();
> +
>  		trace_sched_switch(preempt, prev, next);
>  
> +		if (next->ts_wakeup && next->wakeup_state) {
> +			trace_sched_wakeup_latency(preempt, prev, next,
> +				next->next_ts_start - next->ts_wakeup);
> +			next->wakeup_state = false;
> +		}
> +
> +		trace_sched_leave_running_time(preempt, prev,
> +			next, next->next_ts_start - next->pre_ts_end);
> +
>  		/* Also unlocks the rq: */
>  		rq = context_switch(rq, prev, next, &rf);
>  	} else {

This really isn't ever going to happen.
