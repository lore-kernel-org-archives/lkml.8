Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40951C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F12422B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgCBNns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:43:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41936 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgCBNnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:43:47 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j8lMF-0001qQ-E2; Mon, 02 Mar 2020 14:43:43 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: misc nits Re: [PATCH 1/2] printk: add lockless buffer
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <20200128161948.8524-2-john.ogness@linutronix.de>
        <20200221120557.lxpeoy6xuuqxzu5w@pathway.suse.cz>
        <87r1ybujm5.fsf@linutronix.de>
        <20200302123249.6khdqpneu7t6l35s@pathway.suse.cz>
Date:   Mon, 02 Mar 2020 14:43:41 +0100
In-Reply-To: <20200302123249.6khdqpneu7t6l35s@pathway.suse.cz> (Petr Mladek's
        message of "Mon, 2 Mar 2020 13:32:49 +0100")
Message-ID: <87a74yrhwy.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-02, Petr Mladek <pmladek@suse.com> wrote:
>>>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>>>> new file mode 100644
>>>> index 000000000000..796257f226ee
>>>> --- /dev/null
>>>> +++ b/kernel/printk/printk_ringbuffer.c
>>>> +/*
>>>> + * Read the record @id and verify that it is committed and has the sequence
>>>> + * number @seq. On success, 0 is returned.
>>>> + *
>>>> + * Error return values:
>>>> + * -EINVAL: A committed record @seq does not exist.
>>>> + * -ENOENT: The record @seq exists, but its data is not available. This is a
>>>> + *          valid record, so readers should continue with the next seq.
>>>> + */
>>>> +static int desc_read_committed(struct prb_desc_ring *desc_ring,
>>>> +			       unsigned long id, u64 seq,
>>>> +			       struct prb_desc *desc)
>>>> +{
>
> OK, what about having desc_read_by_seq() instead?

Well, it isn't actually "reading by seq". @seq is there for additional
verification. Yes, prb_read() is deriving @id from @seq. But it only
does this once and uses that value for both calls.

> Also there is a bug in current desc_read_commited().
> desc->info.seq might contain a garbage when d_state is desc_miss
> or desc_reserved.

It is not a bug. In both of those cases, -EINVAL is the correct return
value.

> I would change it to:
>
> static enum desc_state
> desc_read_by_seq(struct prb_desc_ring *desc_ring,
> 		 u64 seq, struct prb_desc *desc)
> {
> 	struct prb_desc *rdesc = to_desc(desc_ring, seq);
> 	atomic_long_t *state_var = &rdesc->state_var;
> 	id = DESC_ID(atomic_long_read(state_var));

I think it is error-prone to re-read @state_var here. It is lockless
shared data. desc_read_committed() is called twice in prb_read() and it
is expected that both calls are using the same @id.

> 	enum desc_state d_state;
>
> 	d_state = desc_read(desc_ring, id, desc);
> 	if (d_state == desc_miss ||
> 	    d_state == desc_reserved ||
> 	    desc->info.seq != seq)
> 		return -EINVAL;
>
> 	if (d_state == desc_reusable)
> 		return -ENOENT;

I can use this refactoring.

>
> 	if (d_state != desc_committed)
> 		return -EINVAL;

I suppose you meant to remove this check and leave in the @blk_lpos
check instead. If we're trying to minimize lines of code, the @blk_lpos
check could be combined with the "== desc_reusable" check as well.

>
> 	return 0;
> }

Thanks.

John Ogness
