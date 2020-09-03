Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B43EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B40620786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4CUdFYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgICPTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgICPTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:19:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A5BC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 08:19:41 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id np15so3871148pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dto1zzmuGxD4woapWcxBnM2VgkhlUg1xa1gWJwvbwDQ=;
        b=O4CUdFYjrkV3rfbMvgrjvN4/YsrkT3tfLVsB3sTqA2X1HjgZ/e5oqljcEOk5zazgBp
         xgzWMoYX2UHYjHbfRzerIrp2wTU5Z3uSoRXMK9rc7/dVgsIazySKSFdYSOYl8KIesy9E
         HfUxF6bmwPKt7ycwrslKt5AyGUhddTfU2cAlxEsvMUSG5n9Bj5OM0fDXqwTK7wToJ+Hv
         y/YQUcmxF8JpUJqKMJffTxpOotlv6OuBeRSa8R6AnFF4eM3X3EcbuA4TBmw3lMg/KFyt
         VeQH6Ia6A2RhwmlrSfQnt+CeaDBMOyz6OZHI6lLFwzet1mgGHc8EOt7YWggoq67CWsK7
         z5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dto1zzmuGxD4woapWcxBnM2VgkhlUg1xa1gWJwvbwDQ=;
        b=Z259Qn8EnMqnmNaiYdA+bC/+bA4/6Cc2cptadptZuuDPKc5qYOPHtuxEJuit0uPR+X
         bTZqWcNsU/XohywP7mrhXuSxHxddMIdT4BUpgsmT2kdq+rSm3ctXJzcmsGL5bugYlqFq
         Ww/ZjyVCTf0HwgUAg+q89X19BaIx/0vVNGiKdhDjXzoea7F9pZ0gfTnL6zCKNVIMQFHI
         l+QcJEeVEl4GnNEWE7XWXYSTJHjkbFe3ucL9g6NXziXexclXMMTRjCV1Yvv8qcqY+nd0
         /+gRwzIwJKAEXI5vwtVlzHclTmc8Prek9SJMrlmTEVi9qsL86tDXrYxpjWQEQIOacgQP
         /R0w==
X-Gm-Message-State: AOAM530sE1vh05mdMVxyqf993WyKH0PmtUI4w0QPgepjjR4MZCGKwbIq
        7dEbHXPmabD9TXYUjZwmsLw=
X-Google-Smtp-Source: ABdhPJw9Ngm9+n2WixAFCzD0PIpRU2B/uwaGYL7LBSD9KTgrI6hS006DOUkSNqeTCrmYxoyqtkHyGw==
X-Received: by 2002:a17:90b:617:: with SMTP id gb23mr40989pjb.36.1599146381043;
        Thu, 03 Sep 2020 08:19:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i6sm3192546pgl.25.2020.09.03.08.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:19:40 -0700 (PDT)
Subject: Re: [PATCH v2 11/11] lockdep,trace: Expose tracepoints
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org
References: <20200821084738.508092956@infradead.org>
 <20200821085348.782688941@infradead.org>
 <20200902035146.GA45826@roeck-us.net>
 <20200902085636.GV1362448@hirez.programming.kicks-ass.net>
 <e4999b75-604f-29a3-e78c-508ee6bede88@roeck-us.net>
 <20200903140047.GD1362448@hirez.programming.kicks-ass.net>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <9ea73cb4-262d-d9ba-beac-e9e013f89d6e@roeck-us.net>
Date:   Thu, 3 Sep 2020 08:19:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903140047.GD1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/20 7:00 AM, peterz@infradead.org wrote:
> On Wed, Sep 02, 2020 at 06:57:36AM -0700, Guenter Roeck wrote:
>> On 9/2/20 1:56 AM, peterz@infradead.org wrote:
>>> On Tue, Sep 01, 2020 at 08:51:46PM -0700, Guenter Roeck wrote:
>>>
>>>> [   27.056457] include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage!
>>>
>>>> [   27.057006] Hardware name: Generic OMAP3-GP (Flattened Device Tree)
>>>> [   27.057098] [<c03125b4>] (unwind_backtrace) from [<c030c32c>] (show_stack+0x10/0x14)
>>>> [   27.057189] [<c030c32c>] (show_stack) from [<c08e7a4c>] (dump_stack+0xd8/0xf8)
>>>> [   27.057312] [<c08e7a4c>] (dump_stack) from [<c03b04bc>] (lock_acquire+0x4d8/0x4dc)
>>>> [   27.057464] [<c03b04bc>] (lock_acquire) from [<c12457e8>] (_raw_spin_lock_irqsave+0x58/0x74)
>>>> [   27.057617] [<c12457e8>] (_raw_spin_lock_irqsave) from [<c0338198>] (pwrdm_lock+0x10/0x18)
>>>> [   27.057739] [<c0338198>] (pwrdm_lock) from [<c033a214>] (clkdm_deny_idle+0x10/0x24)
>>>> [   27.057891] [<c033a214>] (clkdm_deny_idle) from [<c0332e10>] (omap3_enter_idle_bm+0xd4/0x1b8)
>>>> [   27.058044] [<c0332e10>] (omap3_enter_idle_bm) from [<c0f740d4>] (cpuidle_enter_state+0x16c/0x620)
>>>
>>> ARM cpuidle is a trainwreck :/
>>>
>>> So it looks like we have:
>>>
>>>  - clkdm_
>>>  - pwrdm_
>>>  - cpu_pm_
>>>  - pm_runtime_
>>>
>>> In that approximate order, and then there's the coupled idle muck.
>>> Sometimes cpuidle core calls cpu_pm_*(), but mostly it's sprinkled
>>> around in drivers.
>>>
>>> How about we unconditionally kill tracing when RCU is idle? Yes this is
>>> a hack, and we really should turn it into a WARN in due time.
>>>
>>> The thing is, we're shutting down clock/power domains and god knows
>>> what, the CPU is in a crap state, we'll not take interrupts, but tracing
>>> must happen! Hell no.
>>>
>>> Let's make the rule that if you want something traced, you get to pull
>>> it out of the cpuidle driver and stick it in the generic code with a
>>> CPUIDLE_FLAG, before rcu_idle_enter().
>>>
>>> Totally untested patch below..
>>>
>>
>> Unfortunately, that patch does not make a difference; I still see the
>> same tracebacks with it applied.
> 
> I stuck a tracepoint in intel_idle and had a rummage around. The below
> seems to work for me now.
> 
> ---
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 7d9c1c0e149c..878bac893e41 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -27,17 +27,20 @@
>   *         SOFTIRQ_MASK:	0x0000ff00
>   *         HARDIRQ_MASK:	0x000f0000
>   *             NMI_MASK:	0x00f00000
> + *         RCUIDLE_MASK:	0x01000000
>   * PREEMPT_NEED_RESCHED:	0x80000000
>   */
>  #define PREEMPT_BITS	8
>  #define SOFTIRQ_BITS	8
>  #define HARDIRQ_BITS	4
>  #define NMI_BITS	4
> +#define RCUIDLE_BITS	1
>  
>  #define PREEMPT_SHIFT	0
>  #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
>  #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
>  #define NMI_SHIFT	(HARDIRQ_SHIFT + HARDIRQ_BITS)
> +#define RCUIDLE_SHIFT	(NMI_SHIFT     + NMI_BITS)
>  
>  #define __IRQ_MASK(x)	((1UL << (x))-1)
>  
> @@ -45,11 +48,13 @@
>  #define SOFTIRQ_MASK	(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
>  #define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
>  #define NMI_MASK	(__IRQ_MASK(NMI_BITS)     << NMI_SHIFT)
> +#define RCUIDLE_MASK	(__IRQ_MASK(RCUIDLE_BITS) << RCUIDLE_SHIFT)
>  
>  #define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
>  #define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
>  #define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
>  #define NMI_OFFSET	(1UL << NMI_SHIFT)
> +#define RCUIDLE_OFFSET	(1UL << RCUIDLE_SHIFT)
>  
>  #define SOFTIRQ_DISABLE_OFFSET	(2 * SOFTIRQ_OFFSET)
>  
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 3722a10fc46d..5bc45f6750f5 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -172,12 +172,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		int __maybe_unused __idx = 0;				\
>  		void *__data;						\
>  									\
> -		if (!(cond))						\
> +		if (!(cond) || (preempt_count() & RCUIDLE_MASK))	\
>  			return;						\
>  									\
>  		/* srcu can't be used from NMI */			\
>  		WARN_ON_ONCE(rcuidle && in_nmi());			\
>  									\
> +		if (IS_ENABLED(CONFIG_LOCKDEP) && !(rcuidle)) {		\
> +			rcu_read_lock_sched_notrace();			\
> +			rcu_dereference_sched(__tracepoint_##name.funcs);\

This doesn't compile for me - there is no "name" parameter in __DO_TRACE().

Error log:
In file included from ./include/linux/rculist.h:11,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from ./include/linux/sched/numa_balancing.h:10,
                 from ./include/trace/events/sched.h:8,
                 from kernel/sched/core.c:10:
./include/trace/events/sched.h: In function 'trace_sched_kthread_stop':
./include/linux/tracepoint.h:175:26: error: '__tracepoint_name' undeclared

I applied your patch on top of v5.9-rc3-75-gfc3abb53250a. Are you using
a different branch ?

Guenter

> +			rcu_read_unlock_sched_notrace();		\
> +		}							\
> +									\
>  		/* keep srcu and sched-rcu usage consistent */		\
>  		preempt_disable_notrace();				\
>  									\
> @@ -242,11 +248,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  				TP_PROTO(data_proto),			\
>  				TP_ARGS(data_args),			\
>  				TP_CONDITION(cond), 0);			\
> -		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> -			rcu_read_lock_sched_notrace();			\
> -			rcu_dereference_sched(__tracepoint_##name.funcs);\
> -			rcu_read_unlock_sched_notrace();		\
> -		}							\
>  	}								\
>  	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
>  		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args))	\
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8ce77d9ac716..ad9fb4f12c63 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -269,6 +269,8 @@ static noinstr void rcu_dynticks_eqs_enter(void)
>  	/* Better not have special action (TLB flush) pending! */
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
>  		     (seq & RCU_DYNTICK_CTRL_MASK));
> +
> +	__preempt_count_add(RCUIDLE_OFFSET);
>  }
>  
>  /*
> @@ -281,6 +283,8 @@ static noinstr void rcu_dynticks_eqs_exit(void)
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  	int seq;
>  
> +	__preempt_count_sub(RCUIDLE_OFFSET);
> +
>  	/*
>  	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
>  	 * and we also must force ordering with the next RCU read-side
> 

