Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DB4C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B889B2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zU7l9OeI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8TyZlRJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgH0Ocv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgH0O2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:28:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49232C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:28:19 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598538496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QUkjUZIetQ4VnxhPs9H9hlGULoSt3tzmmoExfa4oflo=;
        b=zU7l9OeIVr2fD+maE8oB/+xreO2XDhrf1HU8/dtemiJ4XCTsX18hW20lc9a1N+5dNY+gwz
        QAsUdFrb6gaTUQGODYdmsmJ/2ksuymmNsSNU5/sFmfKtlI1JlLJH868wVfHALXYs+6nXxM
        P9HlR8eXObRhpaXBkboF9+Zb7RH0rIgkgIBHBF2K9TBxaxBsOewY12GhajYKjtwKWcnc/L
        klYCeEDGLN9uaCzeZOWzM62Y8t8tCL4IHEaRP4xLqA6Tixn1or0xAROyzXdI9EjHZyRbDJ
        bYcQS5F6G9efpkwaiCtpK/ykkJywzW4nESfzweYNCdQAiIRQhgKv0QjF5PAUbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598538496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QUkjUZIetQ4VnxhPs9H9hlGULoSt3tzmmoExfa4oflo=;
        b=8TyZlRJJKZw+lOBwRMwzAicH50atcHRjfqHhz8Lw0KRyRn77xrSzpA+rKQjdQMYY56z3Rt
        KZOWlkU4xIAYVKCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add finalization/extension support
In-Reply-To: <20200827125047.GB4353@alley>
References: <20200824103538.31446-1-john.ogness@linutronix.de> <20200824103538.31446-6-john.ogness@linutronix.de> <20200827125047.GB4353@alley>
Date:   Thu, 27 Aug 2020 16:34:16 +0206
Message-ID: <87mu2g5fjz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

Thanks for the review. Most of your suggested changes are fine and I'll
integrate them for the next version. Here a few comments on some open
issues.

On 2020-08-27, Petr Mladek <pmladek@suse.com> wrote:
>> +static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
>> +					 unsigned long *id_out)
>> +{
>> +	unsigned long prev_state_val;
>> +	struct prb_desc *d;
>> +	unsigned long id;
>> +
>> +	id = atomic_long_read(&desc_ring->head_id);
>> +
>> +	d = to_desc(desc_ring, id);
>> +
>> +	prev_state_val = id | DESC_COMMIT_MASK;
>> +	if (!atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val, id | 0))
>> +		return NULL;
>
> This might deserve a comment why any barrier is not needed here.
> I guess that you did not add it because the reader API allows
> to read data only when DESC_FINAL_MASK is set.
>
> But this assumption looks dangerous to me. As I already wrote above.
> We might later need to add an API to read the already committed
> parts of a continuous lines.

Supporting such an API will require more than just a memory barrier
here. When a record is re-opened, it actually transitions back to a
reserved state. At that point there is no difference between a record
being extended and one that is reserved for the first time.

Perhaps my idea of chaining blocks [0] might be more appropriate. Then
there are discrete committed pieces that can be read if needed.

Either way, such a partial-read feature will require a new memory
barrier pair so a reader would see the state change before any data was
modified. As the code is now (without such a feature), a memory barrier
is not needed.

>> +static void desc_finalize(struct prb_desc_ring *desc_ring, unsigned long id)
>> +{
>> +	unsigned long prev_state_val = id | DESC_COMMIT_MASK;
>> +	struct prb_desc *d = to_desc(desc_ring, id);
>> +	bool is_final;
>> +
>> +	while (!atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val,
>> +						prev_state_val | DESC_FINAL_MASK)) {
>> +
>> +		if (get_desc_state(id, prev_state_val, &is_final) != desc_reserved)
>> +			break;
>> +
>> +		if (is_final)
>> +			break;
>> +	}
>
> Do we need the cycle and check if it succeeded?

The initial cmpxchg() is assuming the previous descriptor is in the
commit+!final state (common case). But, for example, if it was in the
reserve+final state, the cmpxhg() would fail and the finalization is
already successful.

> When could the cmpxchg fail?
>
>     + It is still reserved or reserved again => it should get
>       finalized by the one who reserved it. This is related to
>       the problem reported/discussed in the other thread,
>       see https://lore.kernel.org/r/87lfi1ls2g.fsf@jogness.linutronix.de
>
>     + It is already in the final (committed) state => success
>
>     + It is in reusable state => already done in the past
>
>     + It is already reused => already done in the past

  + It is being reserved but is still uninitialized (state_var = 0).

  + It is being reserved but is not yet set (id is one wrap behind).

> IMHO, the following simple call should be enough.
>
> 	atomic_long_try_cmpxchg_relaxed(&d->state_var,	&prev_state_val,
> 					prev_state_val | DESC_FINAL_MASK);

This works if we define that the FINAL flag can only be set when the
COMMIT flag is set. (More on this below.)

> Well, I am not sure about the "relaxed" variant again. I would feel
> more comfortable when it is full barrier especially because it
> might be done by another CPU than what did the commit. And
> we need to avoid the race when nobody finalize the record.

The FINAL flag has nothing to do with whether or not the data is
consistent. It's only use is to prevent a writer from transitioning a
descriptor back to reserved via cmpxchg(). What would a memory barrier
here be pairing with?

>> +static void _prb_commit(struct prb_reserved_entry *e, unsigned long final_mask)
>>  {
>>  	struct prb_desc_ring *desc_ring = &e->rb->desc_ring;
>>  	struct prb_desc *d = to_desc(desc_ring, e->id);
>>  	unsigned long prev_state_val = e->id | 0;
>>  
>> -	/* Now the writer has finished all writing: LMM(prb_commit:A) */
>> +	/* Now the writer has finished all writing: LMM(_prb_commit:A) */
>>  
>>  	/*
>>  	 * Set the descriptor as committed. See "ABA Issues" about why
>> @@ -1244,14 +1518,66 @@ void prb_commit(struct prb_reserved_entry *e)
>>  	 * this. This pairs with desc_read:B.
>>  	 */
>>  	if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
>> -				     e->id | DESC_COMMIT_MASK)) { /* LMM(prb_commit:B) */
>> -		WARN_ON_ONCE(1);
>> +				     e->id | DESC_COMMIT_MASK |
>> +					     final_mask)) { /* LMM(_prb_commit:B) */
>> +		/*
>> +		 * This reserved descriptor must have been finalized already.
>> +		 * Retry with a reserved+final expected value.
>> +		 */
>> +		prev_state_val = e->id | 0 | DESC_FINAL_MASK;
>
> This does not make sense to me. The state "e->id | 0 | DESC_FINAL_MASK"
> must never happen. It would mean that someone finalized
> record that is still being modified.

Correct. Setting the FINAL flag means the descriptor cannot be
_reopened_. It has nothing to do with the current state of the
descriptor. Once the FINAL flag is set, it remains set for the remaining
lifetime of that record.

> Or we both have different understanding of the logic.

Yes.

> Well, there are actually two approaches:
>
>    + I originally expected that FINAL bit could be set only when
>      COMMIT bit is set. But this brings the problems that prb_commit()
>      would need to set FINAL when it is not longer the last descriptor.

My first attempt was to implement this. It turned out complex because it
involves descriptors finalizing themselves _and_ descriptors finalizing
their predecessor. This required two new memory barrier pairs:

  - between a writer committing and re-checking the head_id that another
    writer may have modified

  - between a writer setting the state and another writer checking that
    state

After re-evaluating the purpose of the FINAL flag, I decided that it
would be simpler to implement the 2nd approach (below) and would not
require any new memory barrier pairs.

>    + Another approach is that FINAL bit could be set even when the
>      COMMIT is not set. It would always be set by the next
>      prb_reserve(). But it causes that there are more possible
>      combinations of COMMIT and FINAL bits. As a result, the caller
>      would  need try more variants of the cmpxchg() calls. And
>      it creates another races/cycles, ...

It does not cause more races. And I don't see where it will cause more
cmpxchg() calls. It probably _does_ lead to more cmpxchg() _code_. But
those are fallbacks for when the common case fails.

> I guess that you wanted to implement the 2nd approach and ended in
> many troubles. I wonder if the 1st approach might be easier.

Well, the "many troubles" were due to my naive assumption about the
previous descriptor state. Once I realized that, the missing piece was
obvious.

I will reconsider the first approach. Perhaps adding memory barriers is
preferable if it reduces lines of code.

And we will need to clarify partial continuous line reading because
right now that will not work.

John Ogness

[0] https://lkml.kernel.org/r/875z9nvvl2.fsf@jogness.linutronix.de
