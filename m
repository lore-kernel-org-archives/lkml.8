Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28332C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86572075B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="THtB5AIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgH0BFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgH0BFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:05:45 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDCBC061797
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:05:45 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x69so4526875qkb.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vx3vK6z7068nWwSolZcqRqbNaxoD/OKZuHAXpq7JL4o=;
        b=THtB5AInNMjra8njAqz/vs+P5k664twRLsPYgVfjTGeryiFUn6Oy9I3TXkhBjVVbGY
         mGS7fnAQYKQlttAELxhEM/AqYs3nCPaL+U/0tk9mUVqot2nvJt11I+1zlyhd8TOvrVU6
         kBRrJhDScw7JDeIQVARwFTn55Usf8ILOc50hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vx3vK6z7068nWwSolZcqRqbNaxoD/OKZuHAXpq7JL4o=;
        b=TtZJitUwOrfsgDeiG5IZb/vboA3GjZFwqM9hWmf+Csj82rBt86T0bYHfDOtOp3+fvA
         +rzUL3BRrm9n/fbuidqSXW9xHu/x+Z+VWDPwljtR1KNEmDcSzjk7ADFGLMWH9YllDtJ3
         KC90J3oiLkPvas0CTkKUfi/XmuFvsRqI5UespT/BYzagzP/G7qwfDN9pK/b4ORQKOWAY
         BRfS10wf2a0hnKxY/MK6tV6tk3D37HiqMqFJiJpYSwNj+7vTXtW1T6/jOBbt8aFpHdiI
         mfLuz0GfYDfFAl/IyBoDvR7Bq0OnkQIylaeI0jFpW7ycUvwblhkSMjWCzcLRnZdaweB4
         cl0Q==
X-Gm-Message-State: AOAM531l4koV/H0pEck1UD9JkOqC2/gH8rya+ZXjDFdnFzzldRkvcVw7
        dgSSWV1Xs5h2fF3QDkwLMTbBKA==
X-Google-Smtp-Source: ABdhPJwKYjJSvvfAQJLJyQS12fim5Y3P0uA8jY1WVd1mqr43bVBxWrp9ZQZBSz5dnHukx2THy7Je6A==
X-Received: by 2002:a37:30e:: with SMTP id 14mr16662052qkd.251.1598490344349;
        Wed, 26 Aug 2020 18:05:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id k48sm659103qtk.44.2020.08.26.18.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 18:05:43 -0700 (PDT)
Date:   Wed, 26 Aug 2020 21:05:43 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH v2 01/11] lockdep: Use raw_cpu_*() for per-cpu variables
Message-ID: <20200827010543.GA1939707@google.com>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.192346882@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821085348.192346882@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:47:39AM +0200, Peter Zijlstra wrote:
> Sven reported that commit a21ee6055c30 ("lockdep: Change
> hardirq{s_enabled,_context} to per-cpu variables") caused trouble on
> s390 because their this_cpu_*() primitives disable preemption which
> then lands back tracing.
> 
> On the one hand, per-cpu ops should use preempt_*able_notrace() and
> raw_local_irq_*(), on the other hand, we can trivialy use raw_cpu_*()
> ops for this.
> 
> Fixes: a21ee6055c30 ("lockdep: Change hardirq{s_enabled,_context} to per-cpu variables")
> Reported-by: Sven Schnelle <svens@linux.ibm.com>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Marco Elver <elver@google.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/irqflags.h |    6 +++---
>  include/linux/lockdep.h  |   18 +++++++++++++-----
>  kernel/locking/lockdep.c |    4 ++--
>  3 files changed, 18 insertions(+), 10 deletions(-)
> 
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -53,13 +53,13 @@ DECLARE_PER_CPU(int, hardirq_context);
>    extern void trace_hardirqs_off_finish(void);
>    extern void trace_hardirqs_on(void);
>    extern void trace_hardirqs_off(void);
> -# define lockdep_hardirq_context()	(this_cpu_read(hardirq_context))
> +# define lockdep_hardirq_context()	(raw_cpu_read(hardirq_context))
>  # define lockdep_softirq_context(p)	((p)->softirq_context)
>  # define lockdep_hardirqs_enabled()	(this_cpu_read(hardirqs_enabled))
>  # define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
>  # define lockdep_hardirq_enter()			\
>  do {							\
> -	if (this_cpu_inc_return(hardirq_context) == 1)	\
> +	if (__this_cpu_inc_return(hardirq_context) == 1)\
>  		current->hardirq_threaded = 0;		\
>  } while (0)
>  # define lockdep_hardirq_threaded()		\
> @@ -68,7 +68,7 @@ do {						\
>  } while (0)
>  # define lockdep_hardirq_exit()			\
>  do {						\
> -	this_cpu_dec(hardirq_context);		\
> +	__this_cpu_dec(hardirq_context);	\
>  } while (0)
>  # define lockdep_softirq_enter()		\
>  do {						\
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -535,19 +535,27 @@ do {									\
>  DECLARE_PER_CPU(int, hardirqs_enabled);
>  DECLARE_PER_CPU(int, hardirq_context);
>  
> +/*
> + * The below lockdep_assert_*() macros use raw_cpu_read() to access the above
> + * per-cpu variables. This is required because this_cpu_read() will potentially
> + * call into preempt/irq-disable and that obviously isn't right. This is also
> + * correct because when IRQs are enabled, it doesn't matter if we accidentally
> + * read the value from our previous CPU.
> + */
> +
>  #define lockdep_assert_irqs_enabled()					\
>  do {									\
> -	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirqs_enabled));	\
> +	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirqs_enabled));	\
>  } while (0)
>  
>  #define lockdep_assert_irqs_disabled()					\
>  do {									\
> -	WARN_ON_ONCE(debug_locks && this_cpu_read(hardirqs_enabled));	\
> +	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled));	\
>  } while (0)
>  
>  #define lockdep_assert_in_irq()						\
>  do {									\
> -	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirq_context));	\
> +	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirq_context));	\
>  } while (0)
>  
>  #define lockdep_assert_preemption_enabled()				\
> @@ -555,7 +563,7 @@ do {									\
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
>  		     debug_locks			&&		\
>  		     (preempt_count() != 0		||		\
> -		      !this_cpu_read(hardirqs_enabled)));		\
> +		      !raw_cpu_read(hardirqs_enabled)));		\
>  } while (0)
>  
>  #define lockdep_assert_preemption_disabled()				\
> @@ -563,7 +571,7 @@ do {									\
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
>  		     debug_locks			&&		\
>  		     (preempt_count() == 0		&&		\
> -		      this_cpu_read(hardirqs_enabled)));		\
> +		      raw_cpu_read(hardirqs_enabled)));			\
>  } while (0)
>  
>  #else
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3756,7 +3756,7 @@ void noinstr lockdep_hardirqs_on(unsigne
>  
>  skip_checks:
>  	/* we'll do an OFF -> ON transition: */
> -	this_cpu_write(hardirqs_enabled, 1);
> +	__this_cpu_write(hardirqs_enabled, 1);
>  	trace->hardirq_enable_ip = ip;
>  	trace->hardirq_enable_event = ++trace->irq_events;
>  	debug_atomic_inc(hardirqs_on_events);
> @@ -3795,7 +3795,7 @@ void noinstr lockdep_hardirqs_off(unsign
>  		/*
>  		 * We have done an ON -> OFF transition:
>  		 */
> -		this_cpu_write(hardirqs_enabled, 0);
> +		__this_cpu_write(hardirqs_enabled, 0);
>  		trace->hardirq_disable_ip = ip;
>  		trace->hardirq_disable_event = ++trace->irq_events;
>  		debug_atomic_inc(hardirqs_off_events);
> 
> 
