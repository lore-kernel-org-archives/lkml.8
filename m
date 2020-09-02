Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1421EC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D687B205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BJGrkzCI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hStFlkuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgIBLUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIBLUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:20:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBD0C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 04:20:21 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599045615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DCQ3b2t3eXHvVcCRtHo6kZhPk5R9gaWPV2zn6KafEao=;
        b=BJGrkzCI53li6hLaXzAGqjXl6v43DulBI60iLPoGIP+XHLgLiMB06W7KGR4rDrUcCI4PlQ
        5Nzj9EVtyVcMGJuKfKHv/kir3ZaH03RKmJe+NcjT396kwHpyab6E+7IgO45/M8mzwGL+fB
        RQ4REjz3dBqoIGAbA/ATBHP6r8GnQ5XRu8eISCcVCKZINTp2lSUAfB4XXatFuL0tq5uVOc
        XonxXz76ADTOdDLl8mUvOK12CASx4K2LEiKlutdhb7BGxHIrXtsj3WIgP+Kirkuymz3MmO
        eOzm834U3kcnVu0okiQSKVEi4xWGUCSmilPY48Q7gJtlm5m3WF3nodWgY62LQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599045615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DCQ3b2t3eXHvVcCRtHo6kZhPk5R9gaWPV2zn6KafEao=;
        b=hStFlkuRHeDa2oVUAyQu10XoyiEX28Wpw7+foFiIx67BUyGKX9PKXgjBSpvkEJXOBnhzNl
        E91YIrrCRdbZG9Dg==
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
Subject: Re: state names: vas: Re: [PATCH next v3 6/8] printk: ringbuffer: add finalization/extension support
In-Reply-To: <20200902105250.GA15764@alley>
References: <20200831011058.6286-1-john.ogness@linutronix.de> <20200831011058.6286-7-john.ogness@linutronix.de> <20200902105250.GA15764@alley>
Date:   Wed, 02 Sep 2020 13:26:14 +0206
Message-ID: <87r1rkctn5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-02, Petr Mladek <pmladek@suse.com> wrote:
>> +static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
>> +					 u32 caller_id, unsigned long *id_out)
>> +{
>> +	unsigned long prev_state_val;
>> +	enum desc_state d_state;
>> +	struct prb_desc desc;
>> +	struct prb_desc *d;
>> +	unsigned long id;
>> +
>> +	id = atomic_long_read(&desc_ring->head_id);
>> +
>> +	/*
>> +	 * To minimize unnecessarily reopening a descriptor, first check the
>> +	 * descriptor is in the correct state and has a matching caller ID.
>> +	 */
>> +	d_state = desc_read(desc_ring, id, &desc);
>> +	if (d_state != desc_reserved ||
>> +	    !(atomic_long_read(&desc.state_var) & DESC_COMMIT_MASK) ||
>
> This looks like a hack. And similar extra check of the bit is needed
> also in desc_read(), see
> https://lore.kernel.org/r/878sdvq8kd.fsf@jogness.linutronix.de

Agreed.

> I has been actually getting less and less happy with the inconsistency
> between names of the bits and states.
>
> ...
>
> First, define 5 desc_states, something like:
>
> enum desc_state {
> 	desc_miss = -1,		/* ID mismatch */
> 	desc_modified =	 0x0,	/* reserved, being modified by writer */

I prefer the "desc_reserved" name. It may or may not have be modified yet.

> 	desc_committed = 0x1,	/* committed by writer, could get reopened */
> 	desc_finalized = 0x2,	/* committed, could not longer get modified */
> 	desc_reusable =	 0x3,	/* free, not yet used by any writer */
> };
>
> Second, only 4 variants of the 3 state bits are currently used.
> It means that two bits are enough and they might use exactly
> the above names:
>
> I mean to do something like:
>
> #define DESC_SV_BITS		(sizeof(unsigned long) * 8)
> #define DESC_SV(desc_state)	((unsigned long)desc_state << (DESC_SV_BITS - 2))
> #define DESC_ST(state_val)	((unsigned long)state_val >> (DESC_SV_BITS - 2))

This makes sense and will get us back the bit we lost because of
finalization.

> I am sorry that I did not came up with this earlier. I know how
> painful it is to rework bigger patchsets. But it affects format
> of the ring buffer, so we should do it early.

Agreed.

I am wondering if VMCOREINFO should include a DESC_FLAGS_MASK so that
crash tools could at least successfully iterate the ID's, even if they
didn't know what all the flag values mean (in the case that more bits
are added later).

> PS: I am still middle of review. It looks good so far. I wanted to
> send this early and separately because it is a bigger change.

Thanks for the heads up.

John Ogness
