Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EA2C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35432080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="MMnC+c7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBJTFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:05:21 -0500
Received: from mail.efficios.com ([167.114.26.124]:60056 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJTFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:05:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 26E66245BDF;
        Mon, 10 Feb 2020 14:05:19 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2cc5F7qO5Tv4; Mon, 10 Feb 2020 14:05:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B5F19245F9A;
        Mon, 10 Feb 2020 14:05:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B5F19245F9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581361518;
        bh=+kipQ5NlQVbRyfLk6PdhFdo0Uekn5i8O7ECNRsEs1ZQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=MMnC+c7GSHhb4w1fq8fo0FOE4jIwRZwZzmgaU2DzLIMZMwZLXiNCA+oytB+N4DMoB
         wT9TbPeWNrKbAWFhGQE8+m6wBMzQ2XNthPl4PS6qbrGrbU204Gies//KaURKD75+ib
         pEs1BxwynJ1NScBWXpOwvcArhcssdil/8JRraEfR9HFk9jXqeXghWI6nsykMkS6LKD
         I0dS9v1TMUfbw3gG1Xd6kaAjQraJ07gjBmy7XO10IG+WQ6ng0Gj56fSt2Mo2zM+Xab
         ZLQmicJbyfuVH19qq2w6yPFRuv9OqdtlzyRBRJ30KIVZtO3Yi2kjbDCY4POWKbJkCh
         kMrAweZWaVeyQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id krdPLfvrB7Cq; Mon, 10 Feb 2020 14:05:18 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 9DD80245BD6;
        Mon, 10 Feb 2020 14:05:18 -0500 (EST)
Date:   Mon, 10 Feb 2020 14:05:18 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Message-ID: <1076842217.616862.1581361518556.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200210133045.3beb774e@gandalf.local.home>
References: <20200207205656.61938-1-joel@joelfernandes.org> <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com> <20200210094616.GC14879@hirez.programming.kicks-ass.net> <20200210120552.1a06a7aa@gandalf.local.home> <1966694237.616758.1581355984287.JavaMail.zimbra@efficios.com> <20200210133045.3beb774e@gandalf.local.home>
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: Revert SRCU from tracepoint infrastructure
Thread-Index: czBPNBUds6fkjawJvJ27CuslWNq0Gg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 10, 2020, at 1:30 PM, rostedt rostedt@goodmis.org wrote:

> On Mon, 10 Feb 2020 12:33:04 -0500 (EST)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> The rcu_irq_enter/exit_irqson() does atomic_add_return(), which is even worse
>> than a memory barrier.
> 
> As we discussed on IRC, would something like this work (not even
> compiled tested).

Yes, it's very close to what I have prototyped locally. With one very minor
detail below:

> 
> -- Steve
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
> index dbc6c74defc3..86d3b2eb00cd 100644
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
> +	/* Can not use RCU if rcu is not watching and in NMI */		\
> +	if (!rcu_watching && in_nmi())					\
> +		return;							\
> +									\
> 	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
> 									\
> +	if (!rcu_watching)						\
> +		rcu_irq_enter_irqson();					\

You might want to fold the line above into the first check like this,
considering that doing the rcu_irq_enter_irqson() earlier should not
matter, and I expect it to remove a branch from the probe:

rcu_watching = rcu_is_watching();

if (!rcu_watching) {
        if (in_nmi())
                return;
        rcu_irq_enter_irqson();
}

Thanks!

Mathieu

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
>  /*

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
