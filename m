Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFACC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F1812072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="Zx4efQN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbgFWSad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733125AbgFWSac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:30:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA5BC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:30:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h10so10229353pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+P5hbPMUmXT8NqVfsDI2sZq2ADL9H7+yExXmEQ06I4g=;
        b=Zx4efQN+JvGv49ozIOlYBL/YRz53C1jVMVwF+yRRA+PhXh2+0m25MW8kygpdXl4Lst
         uM1MCB5x9dtmGL6F8C48EO3RqhLS6p+VZAmYrPqMBz8AK2QAfvzYYxQUPKICIsmtPsEs
         KrPaBqe39FanuercxB44cyNTvC8OIcQWAajgnsabdQ4/kJsfej9hcsKpwk+a5WMp6Hvm
         hTjZWnQPzI+m08yYz2E4MqNM0GD4xe4MRLddgsVoQJBaccsECu4SX/qSukw2kzS4Onyi
         OT3hW42EWz3b4KxW90RrjYL6A++hAohFNKj+sALQpyRSAeInzGEX96zRP7v4svofDoty
         BZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+P5hbPMUmXT8NqVfsDI2sZq2ADL9H7+yExXmEQ06I4g=;
        b=i7fkGDlorSaWsXY+wcp1DIJ5LVjWYTeLQ5ii+u6XPGTxj+NSGEHCdIfWBsDjOUPQup
         kr6tU3OKdyOU3zDhG7/VjtAeG6nOdMx02AHvepxprhUc2udwH/Fyayxhu1N/1nwTPvRo
         sDzNvouqb4u8EXL1Q/m0mTPmVFXLxZUwbYIsqAtJYP40mjqJUKZNBUZ3ej8Gw095HMPW
         fPJDrKjq3R7+pXPvb5U8+TMSx/3cofeN6Qkf3Iw7IOio1ak9vv5CrJTBCi3/yB9kWa6s
         i0ZHgtQDv3RGsvqkn7o5XxSAfIdwDzpNl9muzidNy/u6OR5Ci4RJHKHoqYMIt5Fvt3B6
         ooyA==
X-Gm-Message-State: AOAM533V4Y9KcqQoMjMag9j9PIPKdkQqth0mI/4U8RXWMCNiCU9mHAow
        /FW1HxI3yCVlwZqE7DjpmL9RnQ==
X-Google-Smtp-Source: ABdhPJyFjuH5ETDzacP4EcbBwpnEIedoQXdN0d5gycLMOqHwXq7vcqRG9El9NWxfoeGRBWtUxA7tHw==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr26394294pfd.248.1592937032221;
        Tue, 23 Jun 2020 11:30:32 -0700 (PDT)
Received: from posk-x1c (c-73-202-129-89.hsd1.ca.comcast.net. [73.202.129.89])
        by smtp.gmail.com with ESMTPSA id s194sm14650439pgs.24.2020.06.23.11.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:30:31 -0700 (PDT)
Message-ID: <d29a2ba031ecd96f785a602e703d97e24980ef15.camel@posk.io>
Subject: Re: [RFC PATCH 1/3 v2] futex: introduce FUTEX_SWAP operation
From:   Peter Oskolkov <posk@posk.io>
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Oskolkov <posk@google.com>, avagin@google.com,
        "pjt@google.com" <pjt@google.com>, Ben Segall <bsegall@google.com>
Date:   Tue, 23 Jun 2020 11:30:30 -0700
In-Reply-To: <20200623132507.GA875@aaronlu-desktop>
References: <cf7c83d0b58aa4912b465392ce8e40a974f250bb.camel@posk.io>
         <20200623132507.GA875@aaronlu-desktop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

thanks a lot for your tests and feedback! My comments below.

Thanks,
Peter

On Tue, 2020-06-23 at 21:25 +0800, Aaron Lu wrote:
> On Tue, Jun 16, 2020 at 10:22:26AM -0700, Peter Oskolkov wrote:
> >  static void futex_wait_queue_me(struct futex_hash_bucket *hb,
> > struct futex_q *q,
> > -				struct hrtimer_sleeper *timeout)
> > +				struct hrtimer_sleeper *timeout,
> > +				struct task_struct *next)
> >  {
> >  	/*
> >  	 * The task state is guaranteed to be set before another task
> > can
> > @@ -2627,10 +2644,27 @@ static void futex_wait_queue_me(struct
> > futex_hash_bucket *hb, struct futex_q *q,
> >  		 * flagged for rescheduling. Only call schedule if
> > there
> >  		 * is no timeout, or if it has yet to expire.
> >  		 */
> > -		if (!timeout || timeout->task)
> > +		if (!timeout || timeout->task) {
> > +			if (next) {
> > +				/*
> > +				 * wake_up_process() below will be
> > replaced
> > +				 * in the next patch with
> > +				 *
> > wake_up_process_prefer_current_cpu().
> > +				 */
> > +				wake_up_process(next);
> > +				put_task_struct(next);
> > +				next = NULL;
> > +			}
> 
> So in futex_swap case, the wake up occurs in futex_wait_queue_me(). I
> personally think it's more natural to do the wakeup in futex_swap()
> instead.

I chose to do it the way I did so that
wake_up_process_prefer_current_cpu() is called only
when we are reasonably sure that the current task is
going to block/wait, as otherwise it makes no sense
to migrate the wakee/next to the current CPU. In addition, future
optimizations may include actually doing a context switch into
the wakee/next if the current task is going to block instead of
just calling schedule(), which also points to benefits of
having the waking/context-switching code
reside here rather than in futex_swap.

These reasons are somewhat hand-wavy, though, and I agree
that logically it seems that waking in futex_swap() is
easier to think through. Let's see what the maintainers say.

> 
> >  			freezable_schedule();
> > +		}
> >  	}
> >  	__set_current_state(TASK_RUNNING);
> > +
> > +	if (next) {
> > +		/* Maybe call wake_up_process_prefer_current_cpu()? */
> > +		wake_up_process(next);
> > +		put_task_struct(next);
> > +	}
> >  }
> > 
> >  /**
> > +static int futex_swap(u32 __user *uaddr, unsigned int flags, u32
> > val,
> > +		      ktime_t *abs_time, u32 __user *uaddr2)
> > +{
> > +	u32 bitset = FUTEX_BITSET_MATCH_ANY;
> > +	struct task_struct *next = NULL;
> > +	DEFINE_WAKE_Q(wake_q);
> > +	int ret;
> > +
> > +	ret = prepare_wake_q(uaddr2, flags, 1, bitset, &wake_q);
> > +	if (!wake_q_empty(&wake_q)) {
> > +		/* Pull the first wakee out of the queue to swap into.
> > */
> > +		next = container_of(wake_q.first, struct task_struct,
> > wake_q);
> > +		wake_q.first = wake_q.first->next;
> > +		next->wake_q.next = NULL;
> > +		/*
> > +		 * Note that wake_up_q does not touch wake_q.last, so
> > we
> > +		 * do not bother with it here.
> > +		 */
> > +		wake_up_q(&wake_q);
> 
> wake_up_q() doesn't seem to serve any purpose in that the above
> assignment of wake_q.first shall make it an empty queue now?
> Also, I don't see a need to touch wake_q.first either so I think we
> can
> get rid of wake_q altogether here.

The futex at uaddr2 may have more than one waiter, so we cannot assume
that wake_q will be empty when we remove the first element.

> 
> > +	}
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return futex_wait(uaddr, flags, val, abs_time, bitset, next);
> > +}
> 
> I've cooked the below diff, on top of your patchset. It survived your
> self test and schbench. Feel free to ignore it if you don't like it,
> or
> merge it into your patchset if you think it looks better.
> 
> do wake up in futex_swap()
> 
> ---
>  kernel/futex.c | 43 +++++++++++--------------------------------
>  1 file changed, 11 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index a426671e4bbb..995bc881059c 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -2618,8 +2618,7 @@ static int fixup_owner(u32 __user *uaddr,
> struct futex_q *q, int locked)
>   *		prefer to execute it locally.
>   */
>  static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct
> futex_q *q,
> -				struct hrtimer_sleeper *timeout,
> -				struct task_struct *next)
> +				struct hrtimer_sleeper *timeout)
>  {
>  	/*
>  	 * The task state is guaranteed to be set before another task
> can
> @@ -2644,22 +2643,11 @@ static void futex_wait_queue_me(struct
> futex_hash_bucket *hb, struct futex_q *q,
>  		 * flagged for rescheduling. Only call schedule if
> there
>  		 * is no timeout, or if it has yet to expire.
>  		 */
> -		if (!timeout || timeout->task) {
> -			if (next) {
> -				wake_up_process_prefer_current_cpu(next
> );
> -				put_task_struct(next);
> -				next = NULL;
> -			}
> +		if (!timeout || timeout->task)
>  			freezable_schedule();
> -		}
>  	}
> -	__set_current_state(TASK_RUNNING);
>  
> -	if (next) {
> -		/* Maybe call wake_up_process_prefer_current_cpu()? */
> -		wake_up_process(next);
> -		put_task_struct(next);
> -	}
> +	__set_current_state(TASK_RUNNING);
>  }
>  
>  /**
> @@ -2739,7 +2727,7 @@ static int futex_wait_setup(u32 __user *uaddr,
> u32 val, unsigned int flags,
>  }
>  
>  static int futex_wait(u32 __user *uaddr, unsigned int flags, u32
> val,
> -		      ktime_t *abs_time, u32 bitset, struct task_struct
> *next)
> +		      ktime_t *abs_time, u32 bitset)
>  {
>  	struct hrtimer_sleeper timeout, *to;
>  	struct restart_block *restart;
> @@ -2763,8 +2751,7 @@ static int futex_wait(u32 __user *uaddr,
> unsigned int flags, u32 val,
>  		goto out;
>  
>  	/* queue_me and wait for wakeup, timeout, or a signal. */
> -	futex_wait_queue_me(hb, &q, to, next);
> -	next = NULL;
> +	futex_wait_queue_me(hb, &q, to);
>  
>  	/* If we were woken (and unqueued), we succeeded, whatever. */
>  	ret = 0;
> @@ -2797,10 +2784,6 @@ static int futex_wait(u32 __user *uaddr,
> unsigned int flags, u32 val,
>  	ret = -ERESTART_RESTARTBLOCK;
>  
>  out:
> -	if (next) {
> -		wake_up_process(next);
> -		put_task_struct(next);
> -	}
>  	if (to) {
>  		hrtimer_cancel(&to->timer);
>  		destroy_hrtimer_on_stack(&to->timer);
> @@ -2820,7 +2803,7 @@ static long futex_wait_restart(struct
> restart_block *restart)
>  	restart->fn = do_no_restart_syscall;
>  
>  	return (long)futex_wait(uaddr, restart->futex.flags, restart-
> >futex.val,
> -				tp, restart->futex.bitset, NULL);
> +				tp, restart->futex.bitset);
>  }
>  
>  static int futex_swap(u32 __user *uaddr, unsigned int flags, u32
> val,
> @@ -2835,18 +2818,14 @@ static int futex_swap(u32 __user *uaddr,
> unsigned int flags, u32 val,
>  	if (!wake_q_empty(&wake_q)) {
>  		/* Pull the first wakee out of the queue to swap into.
> */
>  		next = container_of(wake_q.first, struct task_struct,
> wake_q);
> -		wake_q.first = wake_q.first->next;
>  		next->wake_q.next = NULL;
> -		/*
> -		 * Note that wake_up_q does not touch wake_q.last, so
> we
> -		 * do not bother with it here.
> -		 */
> -		wake_up_q(&wake_q);
> +		wake_up_process_prefer_current_cpu(next);
> +		put_task_struct(next);
>  	}
>  	if (ret < 0)
>  		return ret;
>  
> -	return futex_wait(uaddr, flags, val, abs_time, bitset, next);
> +	return futex_wait(uaddr, flags, val, abs_time, bitset);
>  }
>  
>  /*
> @@ -3333,7 +3312,7 @@ static int futex_wait_requeue_pi(u32 __user
> *uaddr, unsigned int flags,
>  	}
>  
>  	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
> -	futex_wait_queue_me(hb, &q, to, NULL);
> +	futex_wait_queue_me(hb, &q, to);
>  
>  	spin_lock(&hb->lock);
>  	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
> @@ -3863,7 +3842,7 @@ long do_futex(u32 __user *uaddr, int op, u32
> val, ktime_t *timeout,
>  		val3 = FUTEX_BITSET_MATCH_ANY;
>  		/* fall through */
>  	case FUTEX_WAIT_BITSET:
> -		return futex_wait(uaddr, flags, val, timeout, val3,
> NULL);
> +		return futex_wait(uaddr, flags, val, timeout, val3);
>  	case FUTEX_WAKE:
>  		val3 = FUTEX_BITSET_MATCH_ANY;
>  		/* fall through */

