Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCA5C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3BA20708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kc1luCQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBKAag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:30:36 -0500
Received: from mail.efficios.com ([167.114.26.124]:38718 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgBKAaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:30:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CBF87247E98;
        Mon, 10 Feb 2020 19:30:32 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tdR3hZGN-VZe; Mon, 10 Feb 2020 19:30:32 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4B5B2247A70;
        Mon, 10 Feb 2020 19:30:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4B5B2247A70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581381032;
        bh=L8TN6wP3rwfUjFsuSO2ovYWIIMpiazvkBo4ixStuFd0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=kc1luCQBs1ie75o6pVnPPnpOt9wx5RQFE4Crt7x5I6VQxPc/FPmhzqNEDaj2cUGZ1
         CaJVFJ2T2ly2zIL+8i29IgGw2THDQb3VW0z8mRlbXOJzMSJAhduRpZHOekBOnW3avR
         I+PBzPzm1ZXBWwG6eg8pidjg2LzXN2McuFX9dUbm7KlswYLwmH+9Viq8mwmq/QXMAz
         sewoJ94D3fqsvrEzTbHf8gSisYupPem7VoM5XQWhPGULKKSOwCXdBZ+XWR+c95ZyIg
         6AAQgwaszwfgneOEkRHF6x0O8birgrszaE1Qw6VsDcdOWoNFZTn2Skse3bSWrhAU1U
         PS8ER0kI5s0QA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9BKkQpBl7NCL; Mon, 10 Feb 2020 19:30:32 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 33E26247F89;
        Mon, 10 Feb 2020 19:30:32 -0500 (EST)
Date:   Mon, 10 Feb 2020 19:30:32 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <576504045.617212.1581381032132.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200210170643.3544795d@gandalf.local.home>
References: <20200210170643.3544795d@gandalf.local.home>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: tracing/perf: Move rcu_irq_enter/exit_irqson() to perf trace point hook
Thread-Index: 59JiK/vzl9/cs+amia0Qq23kjfDVyQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 10, 2020, at 5:06 PM, rostedt rostedt@goodmis.org wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Hi Steven,

I agree with the general direction taken by this patch, but I would
like to bring a clarification to the changelog, and I'm worried about
its handling of NMI handlers nesting over rcuidle context.

> 
> Commit e6753f23d961d ("tracepoint: Make rcuidle tracepoint callers use
> SRCU") removed the calls to rcu_irq_enter/exit_irqson() and replaced it with
> srcu callbacks as that much faster for the rcuidle cases. But this caused an
> issue with perf,

so far, so good.

> because perf only uses rcu to synchronize trace points.

That last part seems inaccurate. The tracepoint synchronization is two-fold:
one part is internal to tracepoint.c (see rcu_free_old_probes()), and the other
is only needed if the probes are within modules which can be unloaded (see
tracepoint_synchronize_unregister()). AFAIK, perf never implements probe callbacks
within modules, so the latter is not needed by perf.

The culprit of the problem here is that perf issues "rcu_read_lock()" and
"rcu_read_unlock()" within the probe callbacks it registers to the tracepoints,
including the rcuidle ones. Those require that RCU is "watching", which is
triggering the regression when we remove the calls to rcu_irq_enter/exit_irqson()
from the rcuidle tracepoint instrumentation sites.

> 
> The issue was that if perf traced one of the "rcuidle" paths, that path no
> longer enabled RCU if it was not watching, and this caused lockdep to
> complain when the perf code used rcu_read_lock() and RCU was not "watching".

Yes.

> 
> Commit 865e63b04e9b2 ("tracing: Add back in rcu_irq_enter/exit_irqson() for
> rcuidle tracepoints") added back the rcu_irq_enter/exit_irqson() code, but
> this made the srcu changes no longer applicable.
> 
> As perf is the only callback that needs the heavier weight
> "rcu_irq_enter/exit_irqson()" calls, move it to the perf specific code and
> not bog down those that do not require it.

Yes.

Which brings a question about handling of NMIs: in the proposed patch, if
a NMI nests over rcuidle context, AFAIU it will be in a state
!rcu_is_watching() && in_nmi(), which is handled by this patch with a simple
"return", meaning important NMIs doing hardware event sampling can be
completely lost.

Considering that we cannot use rcu_irq_enter/exit_irqson() from NMI context,
is it at all valid to use rcu_read_lock/unlock() as perf does from NMI handlers,
considering that those can be nested on top of rcuidle context ?

Thanks,

Mathieu


> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> include/linux/tracepoint.h |  8 ++------
> include/trace/perf.h       | 17 +++++++++++++++--
> kernel/rcu/tree.c          |  2 ++
> 3 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 1fb11daa5c53..a83fd076a312 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -179,10 +179,8 @@ static inline struct tracepoint
> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> 		 * For rcuidle callers, use srcu since sched-rcu	\
> 		 * doesn't work from the idle path.			\
> 		 */							\
> -		if (rcuidle) {						\
> +		if (rcuidle)						\
> 			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> -			rcu_irq_enter_irqson();				\
> -		}							\
> 									\
> 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> 									\
> @@ -194,10 +192,8 @@ static inline struct tracepoint
> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> 			} while ((++it_func_ptr)->func);		\
> 		}							\
> 									\
> -		if (rcuidle) {						\
> -			rcu_irq_exit_irqson();				\
> +		if (rcuidle)						\
> 			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
> -		}							\
> 									\
> 		preempt_enable_notrace();				\
> 	} while (0)
> diff --git a/include/trace/perf.h b/include/trace/perf.h
> index dbc6c74defc3..1c94ce0cd4e2 100644
> --- a/include/trace/perf.h
> +++ b/include/trace/perf.h
> @@ -39,17 +39,27 @@ perf_trace_##call(void *__data, proto)					\
> 	u64 __count = 1;						\
> 	struct task_struct *__task = NULL;				\
> 	struct hlist_head *head;					\
> +	bool rcu_watching;						\
> 	int __entry_size;						\
> 	int __data_size;						\
> 	int rctx;							\
> 									\
> +	rcu_watching = rcu_is_watching();				\
> +									\
> 	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
> 									\
> +	if (!rcu_watching) {						\
> +		/* Can not use RCU if rcu is not watching and in NMI */	\
> +		if (in_nmi())						\
> +			return;						\
> +		rcu_irq_enter_irqson();					\
> +	}								\
> +									\
> 	head = this_cpu_ptr(event_call->perf_events);			\
> 	if (!bpf_prog_array_valid(event_call) &&			\
> 	    __builtin_constant_p(!__task) && !__task &&			\
> 	    hlist_empty(head))						\
> -		return;							\
> +		goto out;						\
> 									\
> 	__entry_size = ALIGN(__data_size + sizeof(*entry) + sizeof(u32),\
> 			     sizeof(u64));				\
> @@ -57,7 +67,7 @@ perf_trace_##call(void *__data, proto)					\
> 									\
> 	entry = perf_trace_buf_alloc(__entry_size, &__regs, &rctx);	\
> 	if (!entry)							\
> -		return;							\
> +		goto out;						\
> 									\
> 	perf_fetch_caller_regs(__regs);					\
> 									\
> @@ -68,6 +78,9 @@ perf_trace_##call(void *__data, proto)					\
> 	perf_trace_run_bpf_submit(entry, __entry_size, rctx,		\
> 				  event_call, __count, __regs,		\
> 				  head, __task);			\
> +out:									\
> +	if (!rcu_watching)						\
> +		rcu_irq_exit_irqson();					\
> }
> 
> /*
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1694a6b57ad8..3e6f07b62515 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -719,6 +719,7 @@ void rcu_irq_exit_irqson(void)
> 	rcu_irq_exit();
> 	local_irq_restore(flags);
> }
> +EXPORT_SYMBOL_GPL(rcu_irq_exit_irqson);
> 
> /*
>  * Exit an RCU extended quiescent state, which can be either the
> @@ -890,6 +891,7 @@ void rcu_irq_enter_irqson(void)
> 	rcu_irq_enter();
> 	local_irq_restore(flags);
> }
> +EXPORT_SYMBOL_GPL(rcu_irq_enter_irqson);
> 
> /*
>  * If any sort of urgency was applied to the current CPU (for example,
> --
> 2.20.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
