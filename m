Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEADC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBA020838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EpGB/s/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJTxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:53:05 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46370 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgBJTxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:53:04 -0500
Received: by mail-qv1-f67.google.com with SMTP id y2so3771411qvu.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 11:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qx67WSnxMK2b4urgVmJBAnqk+WBgfwD97s2JNRy7wi0=;
        b=EpGB/s/Ui1toSw+Kw2yB7uR3CPJktOCyQWvTbk9NhCgtglVWe5NdzFHYGE4M2ytKXy
         y/zdbi6xtV4PZ0OMflJDjzA9NrqYZD7ap4AKSngMMIytChU67TzbYrD58MncWG65Svoz
         tBxHrdFlU5DuS+9tt+hj1yKHEZDMF0Jpo3UI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qx67WSnxMK2b4urgVmJBAnqk+WBgfwD97s2JNRy7wi0=;
        b=dm4v/9abBo8I0Zmp2cudY+0TX7Tl2TRPVWLFrl649IE2k8te0edrHfPAXu7FzbdEcX
         Av2eNiXmjAJY4vLLu8BRV9h1/ODm8M4ASejeP88nSG5fwc+xiTsgdGcS964autCIP6jb
         uz8rGIZh3nXP9oIv/wHrmobZ6Xc7U8BV41YpFyKl9CH3PIDaJDVsOAQ5fEA2TAy8nEl3
         cVoi4HfoSdqYAcGEe7RW5024B0GWAZalaJy1bcD/aa90rTmyz52mZY8zH4of3gOOk9Ow
         eiHwye6C0OS/nPLaqTKOBaTJbh40wPf52ZxnUCv/ho5Cc7u8vjrky/P39djXwGTSt0Nj
         zCxw==
X-Gm-Message-State: APjAAAVjeWvro59/YE7tIaymdfZuSCES6EgonFNpQYacfe+lXeHr5SBN
        30QI4QXVty9bNP5yFXsLej592g==
X-Google-Smtp-Source: APXvYqywRQuFCBaAbL4cAQ87glTzixlrenQD/aUiEaseyGuXRhF3uy4g/LL9DS2tmWFoNP0kct356A==
X-Received: by 2002:a0c:e4cc:: with SMTP id g12mr11547912qvm.237.1581364383194;
        Mon, 10 Feb 2020 11:53:03 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a13sm8404qkh.123.2020.02.10.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:53:02 -0800 (PST)
Date:   Mon, 10 Feb 2020 14:53:02 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
Message-ID: <20200210195302.GA231192@google.com>
References: <20200207205656.61938-1-joel@joelfernandes.org>
 <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
 <20200210094616.GC14879@hirez.programming.kicks-ass.net>
 <20200210120552.1a06a7aa@gandalf.local.home>
 <1966694237.616758.1581355984287.JavaMail.zimbra@efficios.com>
 <20200210133045.3beb774e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210133045.3beb774e@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 01:30:45PM -0500, Steven Rostedt wrote:
> On Mon, 10 Feb 2020 12:33:04 -0500 (EST)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > The rcu_irq_enter/exit_irqson() does atomic_add_return(), which is even worse
> > than a memory barrier.
> 
> As we discussed on IRC, would something like this work (not even
> compiled tested).
> 
> -- Steve
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 1fb11daa5c53..a83fd076a312 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		 * For rcuidle callers, use srcu since sched-rcu	\
>  		 * doesn't work from the idle path.			\
>  		 */							\
> -		if (rcuidle) {						\
> +		if (rcuidle)						\
>  			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> -			rcu_irq_enter_irqson();				\
> -		}							\

This would still break out-of-tree modules or future code that does
rcu_read_lock() right in a tracepoint callback right?

Or are we saying that rcu_read_lock() in a tracepoint callback is not
allowed? I believe this should then at least be documented somewhere.  Also,
what about code in tracepoint callback that calls rcu_read_lock() indirectly
through a path in the kernel, and also code that may expect RCU readers when
doing preempt_disable()?

So basically we are saying with this patch:
1. Don't call in a callback: rcu_read_lock() or preempt_disable() and expect RCU to do
anything for you.
2. Don't call code that does anything that 1. needs.

Is that intended? thanks,

 - Joel


>  									\
>  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
>  									\
> @@ -194,10 +192,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  			} while ((++it_func_ptr)->func);		\
>  		}							\
>  									\
> -		if (rcuidle) {						\
> -			rcu_irq_exit_irqson();				\
> +		if (rcuidle)						\
>  			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
> -		}							\
>  									\
>  		preempt_enable_notrace();				\
>  	} while (0)
> diff --git a/include/trace/perf.h b/include/trace/perf.h
> index dbc6c74defc3..86d3b2eb00cd 100644
> --- a/include/trace/perf.h
> +++ b/include/trace/perf.h
> @@ -39,17 +39,27 @@ perf_trace_##call(void *__data, proto)					\
>  	u64 __count = 1;						\
>  	struct task_struct *__task = NULL;				\
>  	struct hlist_head *head;					\
> +	bool rcu_watching;						\
>  	int __entry_size;						\
>  	int __data_size;						\
>  	int rctx;							\
>  									\
> +	rcu_watching = rcu_is_watching();				\
> +									\
> +	/* Can not use RCU if rcu is not watching and in NMI */		\
> +	if (!rcu_watching && in_nmi())					\
> +		return;							\
> +									\
>  	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
>  									\
> +	if (!rcu_watching)						\
> +		rcu_irq_enter_irqson();					\
> +									\
>  	head = this_cpu_ptr(event_call->perf_events);			\
>  	if (!bpf_prog_array_valid(event_call) &&			\
>  	    __builtin_constant_p(!__task) && !__task &&			\
>  	    hlist_empty(head))						\
> -		return;							\
> +		goto out;						\
>  									\
>  	__entry_size = ALIGN(__data_size + sizeof(*entry) + sizeof(u32),\
>  			     sizeof(u64));				\
> @@ -57,7 +67,7 @@ perf_trace_##call(void *__data, proto)					\
>  									\
>  	entry = perf_trace_buf_alloc(__entry_size, &__regs, &rctx);	\
>  	if (!entry)							\
> -		return;							\
> +		goto out;						\
>  									\
>  	perf_fetch_caller_regs(__regs);					\
>  									\
> @@ -68,6 +78,9 @@ perf_trace_##call(void *__data, proto)					\
>  	perf_trace_run_bpf_submit(entry, __entry_size, rctx,		\
>  				  event_call, __count, __regs,		\
>  				  head, __task);			\
> +out:									\
> +	if (!rcu_watching)						\
> +		rcu_irq_exit_irqson();					\
>  }
>  
>  /*
