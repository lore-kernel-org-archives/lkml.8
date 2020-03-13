Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D570FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2EA206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ltpOjwUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgCMSIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:08:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40338 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMSIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sm9lx4VdUohUXvAjpj0yBSZAySlCfCCdyaJH+g1bYAg=; b=ltpOjwUiVsOu+HlhGfFteJQezK
        wLgqoYGqJ4JNeAPwGPIWz6w2vgbXZGygUIqyT5xp955yAi/Y6Bxh2X9Wds/IoFYEY5mG3JA8dPnY9
        mo/aLNNkfatizxDcYV8bHLm2Q2dIpuXwKJviwQrQ0Y6k/3Jjnj30yZaeKADhOuMoeQM1jPcSZGvN6
        BEcjWfLkhvAT00SnKbaVq4RYYU5ak+/+6kGCBTmCjNHPxU1e9rmS5YE2OvvLqEKfJGi9vDItIMnLl
        LTjQjd70S+u6g54Sw8q59XRWwyuyGiwHyQ3flQDrQKNVsQnymMf2+Ux5Kki3Wolrn8C75gu9WMrG6
        wnACyQ4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCojF-0003YF-RR; Fri, 13 Mar 2020 18:08:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13093300470;
        Fri, 13 Mar 2020 19:08:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF2192BE08CBF; Fri, 13 Mar 2020 19:08:11 +0100 (CET)
Date:   Fri, 13 Mar 2020 19:08:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org,
        rostedt@goodmis.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timer: silenct a lockdep splat with debugobjects
Message-ID: <20200313180811.GD12521@hirez.programming.kicks-ass.net>
References: <20200313154221.1566-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313154221.1566-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 11:42:21AM -0400, Qian Cai wrote:
> psi_enqueue() calls add_timer() with pi->lock and rq->lock held which
> in-turn could allcate with debugobjcets in the locking order,
> 
> pi->lock
>   rq->lock
>     base->lock
>       batched_entropy_u32.lock
> 
> while the random code could always call into the scheduler via
> try_to_wake_up() in the locking order,
> 
> batched_entropy_u32.lock
>   pi->lock
> 
> Thus, it could generate a lockdep splat below right after boot. Ideally,
> psi_enqueue() might be able to be called without either pi->lock or
> rq->lock held, but it is tricky to do.
> 
> Since,
> 
> 1) debugobjects is only used in a debug kernel.
> 2) the chance to trigger a real deadlock is relative low.
> 3) once the splat happened, it will disable lockdep to prevent it from
>    catching any more important issues later.
> 
> just silent the splat by temporarily lettting lockdep ignore lockes
> inside debug_timer_activate() which sounds like a reasonable tradeoff
> for debug kernels.


> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 4820823515e9..27bfb8376d71 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1036,7 +1036,13 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
>  		}
>  	}
>  
> +	/*
> +	 * It will allocate under rq->lock and trigger a lockdep slat with
> +	 * random code. Don't disable lockdep with debugobjects.
> +	 */
> +	lockdep_off();
>  	debug_timer_activate(timer);
> +	lockdep_on();
>  
>  	timer->expires = expires;
>  	/*

You have to be f'ing kidding me. You've just earned yourself a lifetime
membership of 'the tinker crew'.

> 00: [  321.355501] -> #3 (batched_entropy_u32.lock){-.-.}:
> 00: [  321.355523]        lock_acquire+0x212/0x460
> 00: [  321.355536]        _raw_spin_lock_irqsave+0xc4/0xe0
> 00: [  321.355551]        get_random_u32+0x5a/0x138
> 00: [  321.355564]        new_slab+0x188/0x760
> 00: [  321.355576]        ___slab_alloc+0x5d2/0x928
> 00: [  321.355589]        __slab_alloc+0x52/0x88
> 00: [  321.355801]        kmem_cache_alloc+0x34a/0x558
> 00: [  321.355819]        fill_pool+0x29e/0x490
> 00: [  321.355835]        __debug_object_init+0xa0/0x828
> 00: [  321.355848]        debug_object_activate+0x200/0x368
> 00: [  321.355864]        add_timer+0x242/0x538
> 00: [  321.355877]        queue_delayed_work_on+0x13e/0x148
> 00: [  321.355893]        init_mm_internals+0x4c6/0x550
> 00: [  321.355905]        kernel_init_freeable+0x224/0x590
> 00: [  321.355921]        kernel_init+0x22/0x188
> 00: [  321.355933]        ret_from_fork+0x30/0x34

Did you actually look at debug_object_activate() and read?

The only reason that is calling into __debug_object_init() is because it
hadn't been initialized yet when it got activated. That *immediately*
should've been a clue.

You can initialize this stuff early. For instance:

  INIT_DELAYED_WORK()
    __INIT_DELAYED_WORK()
      __init_timer()
        init_timer_key()
	  debug_init()
	    debug_timer_init()
	      debug_object_init()
	        __debug_object_init()

And we're right at where the above callchain goes wrong.

Now, it actually looks like kernel/sched/psi.c actually initializes all
delayed works it uses. This then leaves other random delayed works to
establish the base->lock <- entropy.lock relation.

This just means we need to find and kill all such delayed_work users
that fail to properly initialize their data structure.

I'm not going to do that just now, the kids need attention.
