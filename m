Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F281C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D33420848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hrWHTnI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgBKRfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:35:24 -0500
Received: from mail.efficios.com ([167.114.26.124]:39696 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbgBKRfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:35:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 783F824E53B;
        Tue, 11 Feb 2020 12:35:22 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id C82W7pGQFo5I; Tue, 11 Feb 2020 12:35:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 10FC124E53A;
        Tue, 11 Feb 2020 12:35:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 10FC124E53A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581442522;
        bh=/ncu85jy9QYzxOapw3vQN2Z1DasSLYW0wGKkcEnxS+c=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hrWHTnI5wrQ6j4BQunRg4Qujr/vwpYNr8JfhJY2V8hx9xSEi/+O61tRemE7OROyGZ
         dUIWh1dIrSB84agGSdXWCrXkIIm1ocNr2gS+aTyPA4V/DlaIEId7Nt8KRXSvfK44Vy
         ny4hpcDfj1AT7edRgaFq/GdRHH8gURv+9pDk+Hutz7VRnoCMAMWg5zRpR/iewE5S4S
         5XCGxdXUPZ+IuC32oq5RrxDEZKS1C9gy6MzTewmCXWKrLWWlQfw24K2pL3fsCkZlTy
         2FPjxExg390nWOUq9OtAw0s2n9x+/mPNxmUEVRABsVkSXRQ3QyEtusdEqOAPyXqBnh
         qvXwc6xweisbQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id awdzjgBspZS9; Tue, 11 Feb 2020 12:35:21 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id ECE9D24E539;
        Tue, 11 Feb 2020 12:35:21 -0500 (EST)
Date:   Tue, 11 Feb 2020 12:35:21 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <903136616.617885.1581442521855.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200211172952.GY14914@hirez.programming.kicks-ass.net>
References: <20200211095047.58ddf750@gandalf.local.home> <20200211153452.GW14914@hirez.programming.kicks-ass.net> <20200211111828.48058768@gandalf.local.home> <20200211172952.GY14914@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to
 perf trace point hook
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: tracing/perf: Move rcu_irq_enter/exit_irqson() to perf trace point hook
Thread-Index: cTaWISqMAxfaIbpGln6Epeys9Qbhgw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 11, 2020, at 12:29 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Feb 11, 2020 at 11:18:28AM -0500, Steven Rostedt wrote:
>> On Tue, 11 Feb 2020 16:34:52 +0100
>> Peter Zijlstra <peterz@infradead.org> wrote:
>> 
>> > > +		if (unlikely(in_nmi()))
>> > > +			goto out;
>> > 
>> > unless I'm mistaken, we can simply do rcu_nmi_enter() in this case, and
>> > rcu_nmi_exit() on the other end.
>> > 
>> > > +		rcu_irq_enter_irqson();
>> 
>> The thing is, I don't think this can ever happen.
> 
> Per your own argument it should be true in the trace_preempt_off()
> tracepoint from nmi_enter():
> 
>  <idle>
>    // rcu_is_watching() := false
>    <NMI>
>      nmi_enter()
>        preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET)
>	  __preempt_count_add()
>	  // in_nmi() := true
>	  preempt_latency_start()
>	    // .oO -- we'll never hit this tracepoint because idle has
>	    // preempt_count() == 1, so we'll have:
>	    //   preempt_count() != val
> 
>	    // .oO-2 we should be able to this this when the NMI
>	    // hits userspace and we have NOHZ_FULL on.
>	rcu_nmi_enter() // function tracer
> 
> 
> But the point is, if we ever do hit it, rcu_nmi_enter() is the right
> thing to call when '!rcu_is_watching() && in_nmi()', because, as per the
> rcu_nmi_enter() comments, that function fully supports nested NMIs.
> 
> How about something like so? And then you get to use the same in
> __trace_stack() or something, and anywhere else you're doing this dance.
> 
> ---
> 
> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index da0af631ded5..e987236abf95 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -89,4 +89,52 @@ extern void irq_exit(void);
> 		arch_nmi_exit();				\
> 	} while (0)
> 
> +/*
> + * Tracing vs rcu_is_watching()
> + * ----------------------------
> + *
> + * tracepoints and function-tracing can happen when RCU isn't watching (idle,
> + * or early IRQ/NMI entry).
> + *
> + * When it happens during idle or early during IRQ entry, tracing will have
> + * to inform RCU that it ought to pay attention, this is done by calling
> + * rcu_irq_enter_irqon().
> + *
> + * On NMI entry, we must be very careful that tracing only happens after we've
> + * incremented preempt_count(), otherwise we cannot tell we're in NMI and take
> + * the special path.
> + */
> +
> +#define __TR_IRQ	1
> +#define __TR_NMI	2

Minor nits:

Why not make these an enum ?

> +
> +#define trace_rcu_enter()					\
> +({								\
> +	unsigned long state = 0;				\
> +	if (!rcu_is_watching())	{				\
> +		if (in_nmi()) {					\
> +			state = __TR_NMI;			\
> +			rcu_nmi_enter();			\
> +		} else {					\
> +			state = __TR_IRQ;			\
> +			rcu_irq_enter_irqson();			\
> +		}						\
> +	}							\
> +	state;							\
> +})
> +
> +#define trace_rcu_exit(state)					\
> +do {								\
> +	switch (state) {					\
> +	case __TR_IRQ:						\
> +		rcu_irq_exit_irqson();				\
> +		break;						\
> +	case __IRQ_NMI:						\
> +		rcu_nmi_exit();					\
> +		break;						\
> +	default:						\
> +		break;						\
> +	}							\
> +} while (0)

And convert these into static inline functions ?

Thanks,

Mathieu

> +
> #endif /* LINUX_HARDIRQ_H */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e453589da97c..8f34592a1355 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8950,6 +8950,7 @@ void perf_tp_event(u16 event_type, u64 count, void
> *record, int entry_size,
> {
> 	struct perf_sample_data data;
> 	struct perf_event *event;
> +	unsigned long rcu_flags;
> 
> 	struct perf_raw_record raw = {
> 		.frag = {
> @@ -8961,6 +8962,8 @@ void perf_tp_event(u16 event_type, u64 count, void
> *record, int entry_size,
> 	perf_sample_data_init(&data, 0, 0);
> 	data.raw = &raw;
> 
> +	rcu_flags = trace_rcu_enter();
> +
> 	perf_trace_buf_update(record, event_type);
> 
> 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
> @@ -8996,6 +8999,8 @@ void perf_tp_event(u16 event_type, u64 count, void
> *record, int entry_size,
> 	}
> 
> 	perf_swevent_put_recursion_context(rctx);
> +
> +	trace_rcu_exit(rcu_flags);
> }
> EXPORT_SYMBOL_GPL(perf_tp_event);
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 45f79bcc3146..62f87807bbe6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3781,7 +3781,7 @@ static inline void preempt_latency_start(int val)
> 	}
> }
> 
> -void preempt_count_add(int val)
> +void notrace preempt_count_add(int val)
> {
> #ifdef CONFIG_DEBUG_PREEMPT
> 	/*
> @@ -3813,7 +3813,7 @@ static inline void preempt_latency_stop(int val)
> 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
> }
> 
> -void preempt_count_sub(int val)
> +void notrace preempt_count_sub(int val)
> {
> #ifdef CONFIG_DEBUG_PREEMPT
>  	/*

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
