Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D344C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222D02082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LPurnbt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgBKMWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:22:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55024 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgBKMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AOoahJaa0XQu0z17x8QpOsf5GIY7G1WYeDzmVVRXe4s=; b=LPurnbt4hKOaHJYBtMUk8/wcJx
        X8ovDyQARSYDbWUZ2izxu5zCWRpxlH9SJut8b7ZfVoXnlhiHvjswkBNlEPtvKqXFwApn7G3K4SsC4
        86dG6z/4nXGTjgiMEr9JogJ1jqeDxShdmsVHmIDg0xrO0rFbNta5CnNRYdurHGqQO/AIwGDOBE+k5
        KEZ1SsqJ7JehS2hUOAZxbjltuUbKW0Ry6VRGEMZp/MYprPKzKb2FrIZ7Hgni5+nvj+cLk7bsOvn6l
        S00k5P1uO7FzhLMzfQklnBgNy4OXuVPbcd2996wWiqxjWZKsYG4jlukl5FMTQEg+k4VKfDLvyv6is
        oske3OsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1UXb-0002yd-19; Tue, 11 Feb 2020 12:21:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C1FB300446;
        Tue, 11 Feb 2020 13:19:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C91ED2B88D73A; Tue, 11 Feb 2020 13:21:20 +0100 (CET)
Date:   Tue, 11 Feb 2020 13:21:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211122120.GM14914@hirez.programming.kicks-ass.net>
References: <20200210170643.3544795d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210170643.3544795d@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:06:43PM -0500, Steven Rostedt wrote:
> diff --git a/include/trace/perf.h b/include/trace/perf.h
> index dbc6c74defc3..1c94ce0cd4e2 100644
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
>  	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
>  									\
> +	if (!rcu_watching) {						\
> +		/* Can not use RCU if rcu is not watching and in NMI */	\
> +		if (in_nmi())						\
> +			return;						\
> +		rcu_irq_enter_irqson();					\
> +	}								\
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

It is probably okay to move that into perf_tp_event(), then this:

>  /*
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1694a6b57ad8..3e6f07b62515 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -719,6 +719,7 @@ void rcu_irq_exit_irqson(void)
>  	rcu_irq_exit();
>  	local_irq_restore(flags);
>  }
> +EXPORT_SYMBOL_GPL(rcu_irq_exit_irqson);
>  
>  /*
>   * Exit an RCU extended quiescent state, which can be either the
> @@ -890,6 +891,7 @@ void rcu_irq_enter_irqson(void)
>  	rcu_irq_enter();
>  	local_irq_restore(flags);
>  }
> +EXPORT_SYMBOL_GPL(rcu_irq_enter_irqson);
>  
>  /*
>   * If any sort of urgency was applied to the current CPU (for example,

can go too. Those things really should not be exported.
