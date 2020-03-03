Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A88C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D1B20842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgCCPmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:42:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44809 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgCCPmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:42:13 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j99gP-0000fM-Fe; Tue, 03 Mar 2020 16:42:09 +0100
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
        <87a74yrhwy.fsf@linutronix.de>
        <20200303094758.ubylqjqns7zbg6gb@pathway.suse.cz>
Date:   Tue, 03 Mar 2020 16:42:07 +0100
In-Reply-To: <20200303094758.ubylqjqns7zbg6gb@pathway.suse.cz> (Petr Mladek's
        message of "Tue, 3 Mar 2020 10:47:58 +0100")
Message-ID: <87d09tcunk.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-03, Petr Mladek <pmladek@suse.com> wrote:
>>>>>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..796257f226ee
>>>>>> --- /dev/null
>>>>>> +++ b/kernel/printk/printk_ringbuffer.c
>>>>>> +/*
>>>>>> + * Read the record @id and verify that it is committed and has the sequence
>>>>>> + * number @seq. On success, 0 is returned.
>>>>>> + *
>>>>>> + * Error return values:
>>>>>> + * -EINVAL: A committed record @seq does not exist.
>>>>>> + * -ENOENT: The record @seq exists, but its data is not available. This is a
>>>>>> + *          valid record, so readers should continue with the next seq.
>>>>>> + */
>>>>>> +static int desc_read_committed(struct prb_desc_ring *desc_ring,
>>>>>> +			       unsigned long id, u64 seq,
>>>>>> +			       struct prb_desc *desc)
>>>>>> +{
>>>
>>> OK, what about having desc_read_by_seq() instead?
>> 
>> Well, it isn't actually "reading by seq". @seq is there for
>> additional verification. Yes, prb_read() is deriving @id from
>> @seq. But it only does this once and uses that value for both calls.
>
> I do not want to nitpick about words. If I get it properly,
> the "id" is not important here. Any "id" is fine as long as
> "seq" matches. Reading "id" once is just an optimization.

Your statement is incorrect. We are not nitpicking about words. I am
trying to clarify what you are misunderstanding.

@id _is_ very important because that is how descriptors are
read. desc_read() takes @id as an argument and it is @id that identifies
the descriptor. @seq is only meta-data within a descriptor. The only
reason @seq is even checked is because of possible ABA issues with @id
on 32-bit systems.

> I do not resist on the change. It was just an idea how to
> avoid confusion. I was confused more than once. But I might
> be the only one. The more strightforward code looked more
> important to me than the optimization.

I am sorry for the confusion. In preparation for v2 I have changed the
function description to:

/*
 * Get a copy of a specified descriptor and verify that the record is
 * committed and has the sequence number @seq. @seq is checked because
 * of possible ABA issues with @id on 32-bit systems. On success, 0 is
 * returned.
 *
 * Error return values:
 * -EINVAL: A committed record @seq does not exist.
 * -ENOENT: The record @seq exists, but its data is not available. This is a
 *          valid record, so readers should continue with the next seq.
 */

This is using the same language as the description of desc_read() so
that is it is hopefully clear that desc_read_committed() is an extended
version of desc_read().

>>> Also there is a bug in current desc_read_commited().
>>> desc->info.seq might contain a garbage when d_state is desc_miss
>>> or desc_reserved.
>> 
>> It is not a bug. In both of those cases, -EINVAL is the correct return
>> value.
>
> No, it is a bug. If info is not read and contains garbage then the
> following check may pass by chance:
>
> 	if (desc->info.seq != seq)
> 		return -EINVAL;
>
> Then the function would return 0 even when desc_read() returned
> desc_miss or desc_reserved.

0 cannot be returned. The state is checked. Please let us stop this
bug/non-bug discussion. It is distracting us from clarifying this
function and refactoring it to simplify understanding.

>>> I would change it to:
>>>
>>> static enum desc_state
>>> desc_read_by_seq(struct prb_desc_ring *desc_ring,
>>> 		 u64 seq, struct prb_desc *desc)
>>> {
>>> 	struct prb_desc *rdesc = to_desc(desc_ring, seq);
>>> 	atomic_long_t *state_var = &rdesc->state_var;
>>> 	id = DESC_ID(atomic_long_read(state_var));
>> 
>> I think it is error-prone to re-read @state_var here. It is lockless
>> shared data. desc_read_committed() is called twice in prb_read() and
>> it is expected that both calls are using the same @id.
>
> It is not error prone. If "id" changes then "seq" will not match.

@id is set during prb_reserve(). @seq (being mere meta-data) is set
_afterwards_. Your proposed multiple-deriving of @id from @seq would
work because the _state checks_ would catch it, not because @seq would
necessarily change.

But that logic is backwards. @seq is not what is important here. It is
only meta-data. On 64-bit systems the @seq checks could be safely
removed.

You may want to refer back to your private email [0] from last November
where you asked me to move this code out of prb_read() and into a helper
function. That may clarify what we are talking about (although I hope
the new function description is clear enough).

John Ogness

[0] private: 20191122122724.n6wlummg3ap56mn3@pathway.suse.cz
