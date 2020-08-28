Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99371C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765D920DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgH1HV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:21:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgH1HVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:21:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F24A4B7CA;
        Fri, 28 Aug 2020 07:22:21 +0000 (UTC)
Date:   Fri, 28 Aug 2020 09:21:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add
 finalization/extension support
Message-ID: <20200828072148.GC4353@alley>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-6-john.ogness@linutronix.de>
 <87lfi1ls2g.fsf@jogness.linutronix.de>
 <20200826100113.GA8849@jagdpanzerIV.localdomain>
 <87eentlh19.fsf@jogness.linutronix.de>
 <20200826150726.GA4928@alley>
 <87pn7c5s0t.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn7c5s0t.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-08-27 12:04:58, John Ogness wrote:
> On 2020-08-26, Petr Mladek <pmladek@suse.com> wrote:
> >> This series makes a very naive assumption that the previous
> >> descriptor is either in the reserved or committed queried states. The
> >> fact is, it can be in any of the 4 queried states. Adding support for
> >> finalization of all the states then gets quite complex, since any
> >> state transition (cmpxchg) may have to deal with an unexpected FINAL
> >> flag.
> >
> > It has to be done in two steps to avoid race:
> >
> > prb_commit()
> >
> >    + set PRB_COMMIT_MASK
> >    + check if it is still the last descriptor in the array
> >    + set PRB_FINAL_MASK when it is not the last descriptor
> >
> > It should work because prb_reserve() finalizes the previous
> > descriptor after the new one is reserved. As a result:
> >
> >    + prb_reserve() should either see PRB_COMMIT_MASK in the previous
> >      descriptor and be able to finalize it.
> >
> >    + or prb_commit() will see that the head moved and it is not
> >      longer the last reserved one.
> 
> I do not like the idea of relying on descriptors to finalize
> themselves. I worry that there might be some hole there. Failing to
> finalize basically disables printk, so that is pretty serious.
> 
> Below is a patch against this series that adds support for finalizing
> all 4 queried states. It passes all my tests. Note that the code handles
> 2 corner cases:
> 
> 1. When seq is 0, there is no previous descriptor to finalize. This
>    exception is important because we don't want to finalize the -1
>    placeholder. Otherwise, upon the first wrap, a descriptor will be
>    prematurely finalized.
> 
> 2. When a previous descriptor is being reserved for the first time, it
>    might have a state_var value of 0 because the writer is still in
>    prb_reserve() and has not set the initial value yet. I added
>    considerable comments on this special case.
> 
> I am comfortable with adding this new code, although it clearly adds
> complexity.
> 
> John Ogness
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 90d48973ac9e..1ed1e9eb930f 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -860,9 +860,11 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>  	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>  	unsigned long prev_state_val;
>  	unsigned long id_prev_wrap;
> +	unsigned long state_val;
>  	struct prb_desc *desc;
>  	unsigned long head_id;
>  	unsigned long id;
> +	bool is_final;
>  
>  	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(desc_reserve:A) */
>  
> @@ -953,10 +955,17 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>  	 * See "ABA Issues" about why this verification is performed.
>  	 */
>  	prev_state_val = atomic_long_read(&desc->state_var); /* LMM(desc_reserve:E) */
> -	if (prev_state_val &&
> -	    get_desc_state(id_prev_wrap, prev_state_val, NULL) != desc_reusable) {
> -		WARN_ON_ONCE(1);
> -		return false;
> +	if (get_desc_state(id_prev_wrap, prev_state_val, &is_final) != desc_reusable) {
> +		/*
> +		 * If this descriptor has never been used, @prev_state_val
> +		 * will be 0. However, even though it may have never been
> +		 * used, it may have been finalized. So that flag must be
> +		 * ignored.
> +		 */
> +		if ((prev_state_val & ~DESC_FINAL_MASK)) {
> +			WARN_ON_ONCE(1);
> +			return false;
> +		}
>  	}
>  
>  	/*
> @@ -967,10 +976,25 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>  	 * any other changes. A write memory barrier is sufficient for this.
>  	 * This pairs with desc_read:D.
>  	 */
> -	if (!atomic_long_try_cmpxchg(&desc->state_var, &prev_state_val,
> -				     id | 0)) { /* LMM(desc_reserve:F) */
> -		WARN_ON_ONCE(1);
> -		return false;
> +	if (is_final)
> +		state_val = id | 0 | DESC_FINAL_MASK;

The state from the previous wrap always have to have DESC_FINAL_MASK set.
Do I miss something, please?

> +	else
> +		state_val = id | 0;
> +	if (atomic_long_cmpxchg(&desc->state_var, prev_state_val,
> +				state_val) != prev_state_val) { /* LMM(desc_reserve:F) */
> +		/*
> +		 * This reusable descriptor must have been finalized already.
> +		 * Retry with a reusable+final expected value.
> +		 */
> +		prev_state_val |= DESC_FINAL_MASK;
> +		state_val |= DESC_FINAL_MASK;
> +
> +		if (!atomic_long_try_cmpxchg(&desc->state_var, &prev_state_val,
> +					     state_val)) { /* LMM(desc_reserve:FIXME) */
> +
> +			WARN_ON_ONCE(1);
> +			return false;
> +		}
>  	}
>  
>  	/* Now data in @desc can be modified: LMM(desc_reserve:G) */
> @@ -1364,9 +1388,37 @@ static void desc_finalize(struct prb_desc_ring *desc_ring, unsigned long id)
>  	while (!atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val,
>  						prev_state_val | DESC_FINAL_MASK)) {
>  
> -		if (get_desc_state(id, prev_state_val, &is_final) != desc_reserved)
> +		switch (get_desc_state(id, prev_state_val, &is_final)) {
> +		case desc_miss:
> +			/*
> +			 * If the ID is exactly 1 wrap behind the expected, it is
> +			 * in the process of being reserved by another writer and
> +			 * must be considered reserved.
> +			 */
> +			if (get_desc_state(DESC_ID_PREV_WRAP(desc_ring, id),
> +					   prev_state_val, &is_final) != desc_reusable) {
> +				/*
> +				 * If this descriptor has never been used, @prev_state_val
> +				 * will be 0. However, even though it may have never been
> +				 * used, it may have been finalized. So that flag must be
> +				 * ignored.
> +				 */
> +				if ((prev_state_val & ~DESC_FINAL_MASK)) {
> +					WARN_ON_ONCE(1);
> +					return;
> +				}
> +			}
> +			fallthrough;

How is this supposed to work please?

If the ID is exactly one wrap behind, it is being reserved but the new
it was not written yet. In this case, DESC_FINAL_MASK is already set.
The above cmpxchg will not do any change. And prb_reserve() will not
be able to distinguish that it has been finalized.

A solution would be to write the new id here. But then it will be
needed to detect this in prb_reserve().

It is possible that it already works this way. But I do not see it.
I haven't had a coffee yet.


I am really not sure what solution is better. Mine have more barriers.
But this brings many new combinations that need to be checked and
handled. Sigh.

Best Regards,
Petr

> +		case desc_reserved:
> +		case desc_reusable:
> +			/* finalizable, try again */
>  			break;
> +		case desc_committed:
> +			/* already finalized */
> +			return;
> +		}
>  
> +		/* already finalized? */
>  		if (is_final)
>  			break;
>  	}
