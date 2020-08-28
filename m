Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF43C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D3A208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DDVfezUc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fg6eGi44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgH1KBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgH1KBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:01:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53CBC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:01:12 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598608870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TxawP7Xvcne27bXzzvxEdOUoxnK/l+1pljs/g64LDS4=;
        b=DDVfezUceiL6fXQ3vB1xkmKCKSjXoAfbxBmdN2F1nVl2a+nov1BQuhyw0FBETQW8XvGx3G
        1yrWayUxke4N3QLnz16VDr0Mwu5rkLQ2GURWAKfcTc0hMJlrqDk9zcBOa/rRF7PzI0l0tz
        tIacKEEn3FzdAxNpK8EayOEhs9L9g4QoUWH3qg0xh2QSOPp+aX+SsUtexkDvf8XgRQmYCQ
        X/IbUAm1mKorZ7kj3TJ5+qsfnBrIznQf9nxGBWXGpH/l9rDF/T8420lp3wJ0GwIVfVWO6e
        xfJoVWnd0TLNFol2i4OyCrK7s0oTvnQvmkyxRTLayA/TBCBH+wmuAS1DavqRCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598608870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TxawP7Xvcne27bXzzvxEdOUoxnK/l+1pljs/g64LDS4=;
        b=Fg6eGi44lIyC5beC0XIEO6hIai0ziCIAC9wQiceP9JElKDZx8NkRtA16iwik97SKisU+lq
        BdcBpemCl2yl4wAQ==
To:     Petr Mladek <pmladek@suse.com>
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
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add finalization/extension support
In-Reply-To: <20200828072148.GC4353@alley>
References: <20200824103538.31446-1-john.ogness@linutronix.de> <20200824103538.31446-6-john.ogness@linutronix.de> <87lfi1ls2g.fsf@jogness.linutronix.de> <20200826100113.GA8849@jagdpanzerIV.localdomain> <87eentlh19.fsf@jogness.linutronix.de> <20200826150726.GA4928@alley> <87pn7c5s0t.fsf@jogness.linutronix.de> <20200828072148.GC4353@alley>
Date:   Fri, 28 Aug 2020 12:07:09 +0206
Message-ID: <873647144a.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-28, Petr Mladek <pmladek@suse.com> wrote:
>> Below is a patch against this series that adds support for finalizing
>> all 4 queried states. It passes all my tests. Note that the code handles
>> 2 corner cases:
>> 
>> 1. When seq is 0, there is no previous descriptor to finalize. This
>>    exception is important because we don't want to finalize the -1
>>    placeholder. Otherwise, upon the first wrap, a descriptor will be
>>    prematurely finalized.
>> 
>> 2. When a previous descriptor is being reserved for the first time, it
>>    might have a state_var value of 0 because the writer is still in
>>    prb_reserve() and has not set the initial value yet. I added
>>    considerable comments on this special case.
>> 
>> I am comfortable with adding this new code, although it clearly adds
>> complexity.
>> 
>> John Ogness
>> 
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> index 90d48973ac9e..1ed1e9eb930f 100644
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -860,9 +860,11 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>>  	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>>  	unsigned long prev_state_val;
>>  	unsigned long id_prev_wrap;
>> +	unsigned long state_val;
>>  	struct prb_desc *desc;
>>  	unsigned long head_id;
>>  	unsigned long id;
>> +	bool is_final;
>>  
>>  	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(desc_reserve:A) */
>>  
>> @@ -953,10 +955,17 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>>  	 * See "ABA Issues" about why this verification is performed.
>>  	 */
>>  	prev_state_val = atomic_long_read(&desc->state_var); /* LMM(desc_reserve:E) */
>> -	if (prev_state_val &&
>> -	    get_desc_state(id_prev_wrap, prev_state_val, NULL) != desc_reusable) {
>> -		WARN_ON_ONCE(1);
>> -		return false;
>> +	if (get_desc_state(id_prev_wrap, prev_state_val, &is_final) != desc_reusable) {
>> +		/*
>> +		 * If this descriptor has never been used, @prev_state_val
>> +		 * will be 0. However, even though it may have never been
>> +		 * used, it may have been finalized. So that flag must be
>> +		 * ignored.
>> +		 */
>> +		if ((prev_state_val & ~DESC_FINAL_MASK)) {
>> +			WARN_ON_ONCE(1);
>> +			return false;
>> +		}
>>  	}
>>  
>>  	/*
>> @@ -967,10 +976,25 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>>  	 * any other changes. A write memory barrier is sufficient for this.
>>  	 * This pairs with desc_read:D.
>>  	 */
>> -	if (!atomic_long_try_cmpxchg(&desc->state_var, &prev_state_val,
>> -				     id | 0)) { /* LMM(desc_reserve:F) */
>> -		WARN_ON_ONCE(1);
>> -		return false;
>> +	if (is_final)
>> +		state_val = id | 0 | DESC_FINAL_MASK;
>
> The state from the previous wrap always have to have DESC_FINAL_MASK set.
> Do I miss something, please?

Important: FINAL is not a _state_. It is a _flag_ that marks a
descriptor as non-reopenable. This was a simple change because it does
not affect any state logic. The number of states and possible
transitions have not changed.

When a descriptor transitions to reusable, the FINAL flag is cleared. It
has reached the end of its lifecycle. See desc_make_reusable().

(In order to have transitioned to reusable, the FINAL and COMMIT flags
must have been set.)

In the case of desc_reserve(), a reusable descriptor is transitioning to
reserved. When this transition happens, there may already be a later
descriptor that has been reserved and finalized this descriptor. If the
FINAL flag is set here, it means that the FINAL flag is set for the
_new_ descriptor being reserved.

In summary, the FINAL flag can be set in _any_ state. Once set, it is
preserved for all further state transitions. And it is cleared when that
descriptor becomes reusable.

>> +	else
>> +		state_val = id | 0;
>> +	if (atomic_long_cmpxchg(&desc->state_var, prev_state_val,
>> +				state_val) != prev_state_val) { /* LMM(desc_reserve:F) */
>> +		/*
>> +		 * This reusable descriptor must have been finalized already.
>> +		 * Retry with a reusable+final expected value.
>> +		 */
>> +		prev_state_val |= DESC_FINAL_MASK;
>> +		state_val |= DESC_FINAL_MASK;
>> +
>> +		if (!atomic_long_try_cmpxchg(&desc->state_var, &prev_state_val,
>> +					     state_val)) { /* LMM(desc_reserve:FIXME) */
>> +
>> +			WARN_ON_ONCE(1);
>> +			return false;
>> +		}
>>  	}
>>  
>>  	/* Now data in @desc can be modified: LMM(desc_reserve:G) */
>> @@ -1364,9 +1388,37 @@ static void desc_finalize(struct prb_desc_ring *desc_ring, unsigned long id)
>>  	while (!atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val,
>>  						prev_state_val | DESC_FINAL_MASK)) {
>>  
>> -		if (get_desc_state(id, prev_state_val, &is_final) != desc_reserved)
>> +		switch (get_desc_state(id, prev_state_val, &is_final)) {
>> +		case desc_miss:
>> +			/*
>> +			 * If the ID is exactly 1 wrap behind the expected, it is
>> +			 * in the process of being reserved by another writer and
>> +			 * must be considered reserved.
>> +			 */
>> +			if (get_desc_state(DESC_ID_PREV_WRAP(desc_ring, id),
>> +					   prev_state_val, &is_final) != desc_reusable) {
>> +				/*
>> +				 * If this descriptor has never been used, @prev_state_val
>> +				 * will be 0. However, even though it may have never been
>> +				 * used, it may have been finalized. So that flag must be
>> +				 * ignored.
>> +				 */
>> +				if ((prev_state_val & ~DESC_FINAL_MASK)) {
>> +					WARN_ON_ONCE(1);
>> +					return;
>> +				}
>> +			}
>> +			fallthrough;
>
> How is this supposed to work please?
>
> If the ID is exactly one wrap behind, it is being reserved but the new
> id was not written yet. In this case, DESC_FINAL_MASK is already set.

No. If it is exactly one wrap behind, it is still in the reusable
state. The FINAL flag will not be set because it is cleared when
transitioning to reusable.

> The above cmpxchg will not do any change. And prb_reserve() will not
> be able to distinguish that it has been finalized.

The cmpxchg() will try again using the newly updated @prev_state_val and
try to set it to "prev_state_val | FINAL".

Now, theoretically, a writer could commit and reopen the descriptor with
such timing that this cmpxchg() will always fail. A kind of cat and
mouse, always trying to set the FINAL flag for the last @state_var
value.

That game could be avoided if the descriptor noticed that it is no
longer the head ID and set its own FINAL flag. I like the idea of a
guaranteed finalizing of the previous descriptor and the ability for a
descriptor to finalize itself.

(Although really, if we start talking about timed cmpxchg() attacks,
almost any cmpxchg loop can become near-infinite.)

> I am really not sure what solution is better. Mine have more barriers.
> But this brings many new combinations that need to be checked and
> handled.

I am putting together a fully functional version of your solution with
the appropriate memory barriers and correct handling of the special
cases so that we can get a better look at the difference.

John Ogness
