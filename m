Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FDAC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABA920728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BVuyOZXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgAQNPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:15:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAQNPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=48cCAdKtJJFxG1V9xoyyDVXy7gQ2+nn3VBYqzpk7WZY=; b=BVuyOZXlGmLvG8JXZTJ7AO3lY
        FhsTy9Wpy6pxjC1uvbBoVsf65J/wo+R+fmrjkYQGnIB48Znc2z1eOnKyE8dPU6KiOmo7bkIhM2tB6
        UgtWZ9cAjWoQOIZUFb1q3V8l3UPMrU1BGkI9TzCaMIN1SUcIBWfAloayDtNihphiTkALX4am7qVcA
        RvS7uxDM2CU3/QW0V0utqpsSFGdrwbTmWJUoj9ssp23QNUlhJfDt+xnWdUBTF/4A1kr+suEhABeCw
        MUJQgyvz9TZ3RpnTNOaOK38amifPF+WkvXwwHnEuvtxVo2MN5DA6J5C/xN46PhO3W+FPyi88t9YSY
        BIZZ5L+rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isRSy-0005lh-LG; Fri, 17 Jan 2020 13:15:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F915304A59;
        Fri, 17 Jan 2020 14:13:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A13F2020D908; Fri, 17 Jan 2020 14:15:10 +0100 (CET)
Date:   Fri, 17 Jan 2020 14:15:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 2/3] smp: Add a smp_cond_func_t argument to
 smp_call_function_many()
Message-ID: <20200117131510.GA14914@hirez.programming.kicks-ass.net>
References: <20200117090137.1205765-1-bigeasy@linutronix.de>
 <20200117090137.1205765-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117090137.1205765-3-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:01:36AM +0100, Sebastian Andrzej Siewior wrote:

> @@ -448,7 +435,8 @@ void smp_call_function_many(const struct cpumask *mask,
>  
>  	/* Fastpath: do that cpu by itself. */
>  	if (next_cpu >= nr_cpu_ids) {
> +		if (!cond_func || (cond_func && cond_func(cpu, info)))
> +			smp_call_function_single(cpu, func, info, wait);

Can't we write that like:

		if (!cond_func || cond_func(cpu, info))

>  		return;
>  	}
>  
> @@ -465,6 +453,9 @@ void smp_call_function_many(const struct cpumask *mask,
>  	for_each_cpu(cpu, cfd->cpumask) {
>  		call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
>  
> +		if (cond_func && !cond_func(cpu, info))
> +			continue;
> +
>  		csd_lock(csd);
>  		if (wait)
>  			csd->flags |= CSD_FLAG_SYNCHRONOUS;
> @@ -486,6 +477,26 @@ void smp_call_function_many(const struct cpumask *mask,
>  		}
>  	}
>  }
> +
> +/**
> + * smp_call_function_many(): Run a function on a set of other CPUs.
> + * @mask: The set of cpus to run on (only runs on online subset).
> + * @func: The function to run. This must be fast and non-blocking.
> + * @info: An arbitrary pointer to pass to the function.
> + * @wait: If true, wait (atomically) until function has completed
> + *        on other CPUs.
> + *
> + * If @wait is true, then returns once @func has returned.
> + *
> + * You must not call this function with disabled interrupts or from a
> + * hardware interrupt handler or from a bottom half handler. Preemption
> + * must be disabled when calling this function.
> + */
> +void smp_call_function_many(const struct cpumask *mask,
> +			    smp_call_func_t func, void *info, bool wait)
> +{
> +	smp_call_function_many_cond(mask, func, info, wait, NULL);
> +}
>  EXPORT_SYMBOL(smp_call_function_many);
>  
>  /**
> @@ -684,33 +695,17 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
>  			   void *info, bool wait, gfp_t gfp_flags,
>  			   const struct cpumask *mask)
>  {
> +	int cpu = get_cpu();
>  
> +	smp_call_function_many_cond(mask, func, info, wait, cond_func);
> +	if (cpumask_test_cpu(cpu, mask) && cond_func(cpu, info)) {
> +		unsigned long flags;
>  
> +		local_irq_save(flags);
> +		func(info);
> +		local_irq_restore(flags);
>  	}
> +	put_cpu();
>  }
>  EXPORT_SYMBOL(on_each_cpu_cond_mask);

But yes, over-all this seems like a very nice cleanup.
